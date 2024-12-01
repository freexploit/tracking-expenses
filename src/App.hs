{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE AllowAmbiguousTypes  #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE ScopedTypeVariables #-}

module App(AppM(..),runApp,AppConfig) where

import Config (Config)

import Control.Monad.Reader (MonadReader)
import Control.Monad.Trans.Reader
import Control.Monad.IO.Class (MonadIO)

type AppConfig = Config AppM

newtype AppM a =  AppM
    { unAppM :: ReaderT AppConfig IO a
    } deriving (Functor, Applicative, Monad, MonadIO, MonadReader AppConfig, MonadFail)


runApp :: AppConfig -> AppM a -> IO a
runApp config (AppM app) = runReaderT app config
