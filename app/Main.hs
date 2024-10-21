{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE AllowAmbiguousTypes  #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedRecordDot #-}


import Scrapper (proccesHtml, parseExpense)
import Flow
import Network.HaskellNet.IMAP
import qualified Data.ByteString.Char8 as B
import Control.Monad ( forM_, forM )
import Data.IMF ( body, message, parse, HasHeaders )
import Data.MIME (mime, MIMEMessage, contentType, matchContentType, entities)
import Control.Lens (view, filtered)
import Control.Lens.Combinators (firstOf)
import qualified Data.String as B
import Data.Maybe (fromJust)
import Graphql
import Data.Morpheus.Client (single)
import MonadTime
import Control.Monad.IO.Class (MonadIO (liftIO))
import Config
import App
import ImapMonad






parseMail :: B.ByteString -> Either String MIMEMessage
parseMail = parse (message mime)

isHtml :: HasHeaders s => s -> Bool
isHtml = matchContentType "text" (Just "html") . view contentType

say :: String -> AppM ()
say = liftIO . print

proccessEmails :: AppM ()
proccessEmails =  do
        imapCreds <- grab @ImapCredentials
        c <- connectServerM  <| imapCreds.server
        loginM c imapCreds
        day <- daysAgo 30 
        say imapCreds.username
        ---- TODO: Better errors
        --let _ = list c
        selectM c "INBOX"
        msgs <- searchM c [FROMs "notificacion@notificacionesbaccr.com", SENTSINCEs day]
        --let firstMsg = head msgs
            --expunge c
        mails <- forM msgs \msg -> do
                  liftIO <| print msg
                  msgContent <- fetchM c msg
                  let p' =  firstOf (entities <. filtered isHtml <. body) <$> parseMail msgContent
                  return p'


        expenses <- forM mails \m -> do
                case m of
                  Right t  -> do
                      let stuff = proccesHtml <$> t
                      liftIO <| print stuff
                      let expense = fromJust <| parseExpense <$> stuff
                      liftIO <| print expense
                      return expense

                  Left err -> do
                      liftIO <| B.putStrLn "Error bro"
                      liftIO <| B.putStrLn <| B.fromString err
                      return Nothing

        let expenses' = sequence expenses

        case expenses' of
            Just exps' -> do
                --print exps'
                liftIO <| insertExpenses exps' >>= single >>= print
                return ()
            Nothing -> liftIO <| print ("Nothing to procces" :: String)

        forM_ msgs \msg' -> do
            liftIO <| Network.HaskellNet.IMAP.copy c msg' "BAC"
            liftIO <| store c msg'  <| PlusFlags [Deleted]

        logoutM c



main :: IO ()
main = do
    let config = Config
            { imapCredentials = ImapCredentials "christopher@valerio.guru" "pass" "localhost"
            , graphqlConfig = GraphqlConfig "https://api.graphql.com" "token123"
            }
    runApp config proccessEmails
    putStrLn "run"

