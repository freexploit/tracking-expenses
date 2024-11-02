{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertBanks where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType InsertBanks where
  type RequestArgs InsertBanks = InsertBanksArgs
  __name _ = "InsertBanks"
  __query _ = "\n# Insert multiple banks\nmutation InsertBanks($objects: [banks_insert_input!]!, $on_conflict: banks_on_conflict) {\n  insert_banks(objects: $objects, on_conflict: $on_conflict) {\n    affected_rows\n    returning {\n      id\n    }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype InsertBanks = InsertBanks
  { insert_banks :: Maybe InsertBanksInsert_banks
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertBanks where
  parseJSON =
    withObject "InsertBanks" (\v -> InsertBanks <$> v .:? "insert_banks")

data InsertBanksInsert_banks = InsertBanksInsert_banks
  { affected_rows :: Int,
    returning :: [InsertBanksInsert_banksReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertBanksInsert_banks where
  parseJSON =
    withObject "InsertBanksInsert_banks" (\v -> InsertBanksInsert_banks <$> v .: "affected_rows" <*> v .: "returning")

newtype InsertBanksInsert_banksReturning = InsertBanksInsert_banksReturning
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertBanksInsert_banksReturning where
  parseJSON =
    withObject "InsertBanksInsert_banksReturning" (\v -> InsertBanksInsert_banksReturning <$> v .: "id")

data InsertBanksArgs = InsertBanksArgs
  { objects :: [banks_insert_input],
    on_conflict :: Maybe banks_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertBanksArgs where
  toJSON (InsertBanksArgs insertBanksArgsObjects insertBanksArgsOn_conflict) =
    omitNulls
      [ "objects" .= insertBanksArgsObjects,
        "on_conflict" .= insertBanksArgsOn_conflict
      ]
