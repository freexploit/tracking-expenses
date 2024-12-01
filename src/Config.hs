{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Config(Config(..),Has(..), ImapCredentials(..), GraphqlConfig(..), grab) where
import Data.Kind
import Control.Monad.Reader
import Network.Socket

data ImapCredentials = ImapCredentials
    { username :: String
    , password:: String
    , host :: String
    , port :: PortNumber
    }

data GraphqlConfig = GraphqlConfig
    { url :: String
    , token:: String
    }

data Config (m :: Type -> Type) = Config
    { imapCredentials :: !ImapCredentials
    , graphqlConfig :: !GraphqlConfig
    }

class Has field env where
    obtain :: env -> field

instance Has ImapCredentials                (Config m) where obtain = imapCredentials
instance Has GraphqlConfig              (Config m) where obtain = graphqlConfig

grab :: forall field env m . (MonadReader env m, Has field env) => m field
grab = asks $ obtain @field
{-# INLINE grab #-}
