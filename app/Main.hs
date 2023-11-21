{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}

import Scrapper (proccesHtml, parseExpense)
import Env (Env, getterEnv, env)

import Flow
import Network.HaskellNet.IMAP (
      fetch,
      list,
      login,
      logout,
      search,
      select,
      SearchQuery(..))

import Network.HaskellNet.IMAP.SSL
    (
      connectIMAPSSLWithSettings,
      defaultSettingsIMAPSSL,
      Settings(sslMaxLineLength), connectIMAP)

import qualified Data.ByteString.Char8 as B
import Control.Monad ( forM_, forM )
import Data.IMF ( body, message, parse, HasHeaders )
import Data.MIME (mime, MIMEMessage, contentType, matchContentType, entities)
import Control.Lens (view, filtered)
import Control.Lens.Combinators (firstOf)
import qualified Data.String as B
import System.Time
import Data.Maybe (fromJust)

username :: Env String
username = env "EMAIL"
password :: Env String
password = env "IMAP_PASSWORD"


getCurrentDay :: IO CalendarTime
getCurrentDay = do
    clockTime <- getClockTime
    toCalendarTime clockTime

-- Negate a TimeDiff
negateTimeDiff :: TimeDiff -> TimeDiff
negateTimeDiff td = TimeDiff { tdYear = -(tdYear td), tdMonth = -(tdMonth td), tdDay = -(tdDay td), tdHour = -(tdHour td), tdMin = -(tdMin td), tdSec = -(tdSec td), tdPicosec = -(tdPicosec td) }

--toUTCTime' :: ClockTime -> IO CalendarTime
--toUTCTime' = toCalendarTime True

daysAgo :: IO CalendarTime
daysAgo  = do
    now <- getClockTime

    -- Convert to CalendarTime
    --let calendarTimeNow = toUTCTime' now

    -- Create a TimeDiff for 2 days
    let twoDays = noTimeDiff { tdDay = 1 }

    -- Get the time for 2 days ago
    let twoDaysAgoClock = addToClockTime (negateTimeDiff twoDays) now
    toCalendarTime twoDaysAgoClock


parseMail :: B.ByteString -> Either String MIMEMessage
parseMail = parse (message mime)

isHtml :: HasHeaders s => s -> Bool
isHtml = matchContentType "text" (Just "html") . view contentType

connectServer :: IO ()
connectServer = do

    u <- getterEnv username 
    p <- getterEnv password 
    day <- daysAgo
    c <- connectIMAPSSLWithSettings "imap.kolabnow.com" cfg
    login c (fromJust u) (fromJust p)
    _ <- list c
    select c "INBOX"
    msgs <- search c [FROMs "notificacion@notificacionesbaccr.com", SINCEs day]
    --let firstMsg = head msgs

    mails <- forM msgs \msg -> do
              msgContent <- fetch c msg
              let p =  firstOf (entities <. filtered isHtml <. body) <$> parseMail msgContent
              return p

    forM_ mails \m -> do
            case m of
              Right t  -> do
                  let stuff = proccesHtml <$> t
                  print stuff
                  let expenses =  parseExpense <$> stuff 
                  print expenses

              Left err -> do
                  B.putStrLn "Error bro"
                  B.putStrLn <| B.fromString err

    logout c
  where
  cfg = defaultSettingsIMAPSSL { sslMaxLineLength = 100000 }


main :: IO ()
main = connectServer
