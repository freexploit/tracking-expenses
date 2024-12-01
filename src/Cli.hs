{-# LANGUAGE OverloadedStrings #-}

module Cli (Args, argParser, from, daysSentAgo, mailbox) where

import Options.Applicative

data Args = Args
  { from :: String,
    daysSentAgo :: Int,
    mailbox :: String
  }

argParser :: Parser Args
argParser =
  Args
    <$> strOption
      (long "from" <> metavar "EMAIL_FROM" <> help "Bank sender email")
    <*> option
      auto
      ( long "days_ago"
          <> metavar "DAYS_FROM"
          <> help "Days since the email was sent"
      )
    <*> strOption
      (long "mailbox" <> metavar "MAILBOX_TO" <> help "Mailbox to move processed emails")
