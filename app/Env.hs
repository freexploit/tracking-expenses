{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Env (Env, getterEnv, env) where

import Control.Applicative
import Control.Monad.Trans.Maybe
import Control.Monad.IO.Class
import System.Environment

newtype Env a = Env { unEnv :: MaybeT IO a }
    deriving (Functor, Applicative, Monad, MonadIO, Alternative)

getterEnv :: Env a -> IO (Maybe a)
getterEnv env' = runMaybeT (unEnv env')

env :: String -> Env String
env key = Env (MaybeT (lookupEnv key))
