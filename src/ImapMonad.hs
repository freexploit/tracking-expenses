{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeSynonymInstances #-}

module ImapMonad (ImapMonad (..)) where

import App
import Config (ImapCredentials, password, username)
import Control.Exception (try)
import Control.Monad (forM_)
import Control.Monad.IO.Class (MonadIO (..))
import Data.ByteString
import Flow
import GHC.IO.Exception (IOException)
import Network.HaskellNet.IMAP.Connection (IMAPConnection)
import Network.HaskellNet.IMAP.SSL
import Network.HaskellNet.IMAP.Types (MailboxName, UID)
import Network.HaskellNet.SSL (defaultSettingsWithPort)
import Network.Socket

class (Monad m, MonadIO m) => ImapMonad m where
  connectServerM :: String -> PortNumber -> m IMAPConnection
  loginM :: IMAPConnection -> ImapCredentials -> m ()
  logoutM :: IMAPConnection -> m ()
  fetchM :: IMAPConnection -> UID -> m ByteString
  selectM :: IMAPConnection -> MailboxName -> m ()
  searchM :: IMAPConnection -> [SearchQuery] -> m [UID]
  moveMails :: IMAPConnection -> String -> [UID] -> m ()

instance ImapMonad AppM where
  connectServerM url' port =
    AppM <| liftIO <| do
      connectIMAPSSLWithSettings url' cfg
    where
      cfg =
        (defaultSettingsWithPort port)
          { sslMaxLineLength = 100000,
            sslDisableCertificateValidation = True
          }
  loginM c creds = AppM <| liftIO <| Network.HaskellNet.IMAP.SSL.login c creds.username creds.password
  logoutM c = AppM <| liftIO <| Network.HaskellNet.IMAP.SSL.logout c
  fetchM c uid = AppM <| liftIO <| Network.HaskellNet.IMAP.SSL.fetch c uid
  selectM c name = AppM <| liftIO <| Network.HaskellNet.IMAP.SSL.select c name
  searchM c queries = AppM <| liftIO <| Network.HaskellNet.IMAP.SSL.search c queries
  moveMails c mailboxname uids =
    AppM <| liftIO <| do
      mailbox <- try <| Network.HaskellNet.IMAP.SSL.status c mailboxname [MESSAGES]
      case mailbox of
        Left (_err :: IOException) ->
          Network.HaskellNet.IMAP.SSL.create c mailboxname >> print ("mailbox: " ++ mailboxname ++ " doesn't exist, creating it")
        Right _ ->
          return ()

      forM_ uids \msg' -> do
        Network.HaskellNet.IMAP.SSL.copy c msg' mailboxname
        Network.HaskellNet.IMAP.SSL.store c msg' <| PlusFlags [Deleted]
        Network.HaskellNet.IMAP.SSL.expunge c
