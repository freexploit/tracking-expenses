{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}

import Scrapper (proccesHtml)

import Network.HaskellNet.IMAP.SSL
    ( fetch,
      list,
      login,
      logout,
      search,
      select,
      connectIMAPSSLWithSettings,
      defaultSettingsIMAPSSL,
      SearchQuery(..),
      Settings(sslMaxLineLength))

import qualified Data.ByteString.Char8 as B
import Control.Monad ( forM_, forM )
import Data.IMF ( body, message, parse, HasHeaders )
import Data.MIME (mime, MIMEMessage, contentType, matchContentType, entities)
import Control.Lens (view, filtered)
import Control.Lens.Combinators (firstOf)
import qualified Data.String as B
import System.Time

username :: [Char]
username = "test@test.com"
password :: [Char]
password = "@$%kW4CuDfpTQqY8wbN7NPhY"


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
    let twoDays = noTimeDiff { tdDay = 2 }

    -- Get the time for 2 days ago
    let twoDaysAgoClock = addToClockTime (negateTimeDiff twoDays) now
    toCalendarTime twoDaysAgoClock


parseMail :: B.ByteString -> Either String MIMEMessage
parseMail = parse (message mime)

isHtml :: HasHeaders s => s -> Bool
isHtml = matchContentType "text" (Just "html") . view contentType

connectServer :: IO ()
connectServer = do

    day <- daysAgo
    c <- connectIMAPSSLWithSettings "imap.kolabnow.com" cfg
    login c username password
    _ <- list c
    select c "INBOX"
    msgs <- search c [FROMs "notificacion@notificacionesbaccr.com", SINCEs day]
    --let firstMsg = head msgs

    mails <- forM msgs \msg -> do
              msgContent <- fetch c msg
              let p =  firstOf (entities . filtered isHtml . body) <$> parseMail msgContent
              return p

    forM_ mails \m -> do
            case m of
              Right t  -> do
                  mapM_ proccesHtml t 
              Left err -> do
                  B.putStrLn "Error bro"
                  B.putStrLn $ B.fromString err

    logout c
  where
  cfg = defaultSettingsIMAPSSL { sslMaxLineLength = 100000 }


main :: IO ()
main = connectServer 
