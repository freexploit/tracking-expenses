{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertBankOne where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema
import Data.UUID.V7 (UUID)

instance RequestType InsertBankOne where
  type RequestArgs InsertBankOne = InsertBankOneArgs
  __name _ = "InsertBankOne"
  __query _ = "# Insert a single bank\nmutation InsertBankOne($object: banks_insert_input!, $on_conflict: banks_on_conflict) {\n  insert_banks_one(object: $object, on_conflict: $on_conflict) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype InsertBankOne = InsertBankOne
  { insert_banks_one :: Maybe InsertBankOneInsert_banks_one
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertBankOne where
  parseJSON =
    withObject "InsertBankOne" (\v -> InsertBankOne <$> v .:? "insert_banks_one")

newtype InsertBankOneInsert_banks_one = InsertBankOneInsert_banks_one
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertBankOneInsert_banks_one where
  parseJSON =
    withObject "InsertBankOneInsert_banks_one" (\v -> InsertBankOneInsert_banks_one <$> v .: "id")

data InsertBankOneArgs = InsertBankOneArgs
  { object :: Banks_insert_input,
    on_conflict :: Maybe Banks_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertBankOneArgs where
  toJSON ( InsertBankOneArgs insertBankOneArgsObject insertBankOneArgsOn_conflict ) =
    omitNulls
      [ "object" .= insertBankOneArgsObject,
        "on_conflict" .= insertBankOneArgsOn_conflict
      ]
