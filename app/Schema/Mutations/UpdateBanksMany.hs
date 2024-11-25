{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateBanksMany where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema

instance RequestType UpdateBanksMany where
  type RequestArgs UpdateBanksMany = UpdateBanksManyArgs
  __name _ = "UpdateBanksMany"
  __query _ = "mutation UpdateBanksMany($updates: [banks_updates!]!) {\n  update_banks_many(updates: $updates) {\n    affected_rows\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateBanksMany = UpdateBanksMany
  { update_banks_many :: Maybe [Maybe UpdateBanksManyUpdate_banks_many]
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBanksMany where
  parseJSON =
    withObject "UpdateBanksMany" (\v -> UpdateBanksMany <$> v .:? "update_banks_many")

newtype UpdateBanksManyUpdate_banks_many = UpdateBanksManyUpdate_banks_many
  { affected_rows :: Int
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBanksManyUpdate_banks_many where
  parseJSON =
    withObject "UpdateBanksManyUpdate_banks_many" (\v -> UpdateBanksManyUpdate_banks_many <$> v .: "affected_rows")

newtype UpdateBanksManyArgs = UpdateBanksManyArgs
  { updates :: [Banks_updates]
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateBanksManyArgs where
  toJSON (UpdateBanksManyArgs updateBanksManyArgsUpdates) =
    omitNulls
      [ "updates" .= updateBanksManyArgsUpdates
      ]
