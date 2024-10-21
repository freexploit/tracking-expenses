{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module AppEnv (AppEnv, getterAppEnv, env) where

import Control.Applicative
import Control.Monad.Trans.Maybe
import Control.Monad.IO.Class
import System.Environment

newtype AppEnv a = AppEnv { unAppEnv :: MaybeT IO a }
    deriving (Functor, Applicative, Monad, MonadIO, Alternative)

getterAppEnv :: AppEnv a -> IO (Maybe a)
getterAppEnv env' = runMaybeT (unAppEnv env')

env :: String -> AppEnv String
env key = AppEnv (MaybeT (lookupEnv key))
