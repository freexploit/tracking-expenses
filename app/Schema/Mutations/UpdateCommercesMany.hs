{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateCommerces_many where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType UpdateCommercesMany where
  type RequestArgs UpdateCommercesMany = UpdateCommercesManyArgs
  __name _ = "UpdateCommercesMany"
  __query _ = "mutation UpdateCommercesMany($updates: [commerces_updates!]!) {\n  update_commerces_many(updates: $updates) {\n    affected_rows\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateCommercesMany = UpdateCommercesMany
  { update_commerces_many :: Maybe [ Maybe UpdateCommercesManyUpdate_commerces_many ]
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommercesMany where
  parseJSON =
    withObject "UpdateCommercesMany" (\v -> UpdateCommercesMany <$> v .:? "update_commerces_many")

newtype UpdateCommercesManyUpdate_commerces_many = UpdateCommercesManyUpdate_commerces_many
  { affected_rows :: Int
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommercesManyUpdate_commerces_many where
  parseJSON =
    withObject "UpdateCommercesManyUpdate_commerces_many" (\v -> UpdateCommercesManyUpdate_commerces_many <$> v .: "affected_rows")

newtype UpdateCommercesManyArgs = UpdateCommercesManyArgs
  { updates :: [commerces_updates]
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateCommercesManyArgs where
  toJSON (UpdateCommercesManyArgs updateCommercesManyArgsUpdates) =
    omitNulls
      [ "updates" .= updateCommercesManyArgsUpdates
      ]
