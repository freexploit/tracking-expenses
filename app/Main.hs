{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}

import Scrapper (proccesHtml, parseExpense)
import Env (Env, getterEnv, env)

import Flow
import Network.HaskellNet.IMAP 
import Network.HaskellNet.IMAP.SSL
import qualified Data.ByteString.Char8 as B
import Control.Monad ( forM_, forM )
import Data.IMF ( body, message, parse, HasHeaders )
import Data.MIME (mime, MIMEMessage, contentType, matchContentType, entities)
import Control.Lens (view, filtered)
import Control.Lens.Combinators (firstOf)
import qualified Data.String as B
import System.Time
import Data.Maybe (fromJust)
import Graphql
import Data.Morpheus.Client (single)

username :: Env String
username = env "EMAIL"
password :: Env String
password = env "IMAP_PASSWORD"
imapServer :: Env String
imapServer = env "IMAP_SERVER"


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
    let twoDays = noTimeDiff { tdDay = 30 }

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
    s <- getterEnv imapServer

    day <- daysAgo
    c <- connectIMAPSSLWithSettings (fromJust s) cfg
    login c (fromJust u) (fromJust p)
    _ <- list c
    select c "INBOX"
    msgs <- search c [FROMs "notificacion@notificacionesbaccr.com", SINCEs day]
    --let firstMsg = head msgs
        --expunge c


    mails <- forM msgs \msg -> do
              msgContent <- fetch c msg
              let p' =  firstOf (entities <. filtered isHtml <. body) <$> parseMail msgContent
              return p'


    expenses <- forM mails \m -> do
            case m of
              Right t  -> do
                  let stuff = proccesHtml <$> t
                  --print stuff
                  let expense = fromJust <| parseExpense <$> stuff
                  --print expense
                  return expense

              Left err -> do
                  B.putStrLn "Error bro"
                  B.putStrLn <| B.fromString err
                  return Nothing

    let expenses' = sequence expenses

    case expenses' of
        Just exps' -> do
            --print exps'
            insertExpenses exps' >>= single >>= print 
            return ()
        Nothing -> print ("Nothing to procces" :: String)

    forM_ msgs \msg' -> do
        copy c msg' "BAC"
        store c msg'  <| PlusFlags [Deleted]


    logout c
  where
  cfg = defaultSettingsIMAPSSL { sslMaxLineLength = 100000 }


main :: IO ()
main = connectServer
