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
import Control.Monad ( forM )
import Data.IMF ( body, message, parse, HasHeaders )
import Data.MIME (mime, MIMEMessage, contentType, matchContentType, entities)
import Control.Lens (view, filtered)
import Control.Lens.Combinators (firstOf)
import qualified Data.String as B
import Data.Maybe (fromJust, fromMaybe)
import Graphql
import Data.Morpheus.Client (single)
import MonadTime
import Control.Monad.IO.Class (MonadIO (liftIO))
import Config
import App
import ImapMonad
import Network.Socket (PortNumber)
import Options.Applicative
import Cli
import AppEnv

parseMail :: B.ByteString -> Either String MIMEMessage
parseMail = parse (message mime)

isHtml :: HasHeaders s => s -> Bool
isHtml = matchContentType "text" (Just "html") . view contentType

say :: String -> AppM ()
say = liftIO . print



proccessEmails :: String -> Int -> String -> AppM ()
proccessEmails mail days mailboxname =  do
        imapCreds <- grab @ImapCredentials
        c <- connectServerM  imapCreds.host imapCreds.port
        loginM c imapCreds
        day <- daysAgo days
        say imapCreds.username
        ---- TODO: Better errors
        --let _ = list c
        selectM c "INBOX"
        msgs <- searchM c [FROMs mail, SENTSINCEs day]
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
                whatevs <- insertExpenses exps' >>= single 
                liftIO <| print whatevs
                moveMails c mailboxname msgs
            Nothing -> liftIO <| print ("Nothing to procces" :: String)


        logoutM c

configFromEnv :: IO (Maybe AppConfig) 
configFromEnv = do
    port' <- getterAppEnv <| env "IMAP_PORT"
    host' <- getterAppEnv <| env "IMAP_SERVER"
    username' <- getterAppEnv <| env "EMAIL"
    pass' <- getterAppEnv <| env "IMAP_PASSWORD"
    auth_token <- getterAppEnv <| env "GRAPHQL_AUTH_TOKEN"
    url' <- getterAppEnv <| env "GRAPHQL_URL"
    let v = fromMaybe (993::PortNumber) (port' >>= \p' -> Just (read p' :: PortNumber))
    let imap  = ImapCredentials <$> username' <*> pass' <*> host' <*>  Just v
    let graph = GraphqlConfig <$> url' <*> auth_token
    return <| Config <$> imap <*> graph

main :: IO ()
main = do
    args <- execParser opts
    config <- configFromEnv
    runApp (fromJust config) (proccessEmails args.from args.daysSentAgo args.mailbox)
    where
      opts = info (argParser <**> helper )
        ( fullDesc
        <> progDesc "Expense Tracker"
        <> header "Tool to parse html emails from banks to track my personal expenses")
