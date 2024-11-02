{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateBanks where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema

instance RequestType UpdateBanks where
  type RequestArgs UpdateBanks = UpdateBanksArgs
  __name _ = "UpdateBanks"
  __query _ = "mutation UpdateBanks($where: banks_bool_exp!, $_set: banks_set_input) {\n  update_banks(where: $where, _set: $_set) {\n    affected_rows\n    returning {\n      id\n    }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateBanks = UpdateBanks
  { update_banks :: Maybe UpdateBanksUpdate_banks
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBanks where
  parseJSON =
    withObject "UpdateBanks" (\v -> UpdateBanks <$> v .:? "update_banks")

data UpdateBanksUpdate_banks = UpdateBanksUpdate_banks
  { affected_rows :: Int,
    returning :: [UpdateBanksUpdate_banksReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBanksUpdate_banks where
  parseJSON =
    withObject "UpdateBanksUpdate_banks" (\v -> UpdateBanksUpdate_banks <$> v .: "affected_rows" <*> v .: "returning")

newtype UpdateBanksUpdate_banksReturning = UpdateBanksUpdate_banksReturning
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBanksUpdate_banksReturning where
  parseJSON =
    withObject "UpdateBanksUpdate_banksReturning" (\v -> UpdateBanksUpdate_banksReturning <$> v .: "id")

data UpdateBanksArgs = UpdateBanksArgs
  { _where :: banks_bool_exp,
    _set :: Maybe banks_set_input
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateBanksArgs where
  toJSON (UpdateBanksArgs updateBanksArgsWhere updateBanksArgs_set) =
    omitNulls
      [ "where" .= updateBanksArgsWhere,
        "_set" .= updateBanksArgs_set
      ]
