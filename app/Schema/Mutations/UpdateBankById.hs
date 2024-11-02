{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateBank_by_id where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType UpdateBankById where
  type RequestArgs UpdateBankById = UpdateBankByIdArgs
  __name _ = "UpdateBankById"
  __query _ = "mutation UpdateBankById(\n  $pk_columns: banks_pk_columns_input!\n  $_set: banks_set_input\n) {\n  update_banks_by_pk(pk_columns: $pk_columns, _set: $_set) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateBankById = UpdateBankById
  { update_banks_by_pk :: Maybe UpdateBankByIdUpdate_banks_by_pk
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBankById where
  parseJSON =
    withObject "UpdateBankById" (\v -> UpdateBankById <$> v .:? "update_banks_by_pk")

newtype UpdateBankByIdUpdate_banks_by_pk = UpdateBankByIdUpdate_banks_by_pk
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateBankByIdUpdate_banks_by_pk where
  parseJSON =
    withObject "UpdateBankByIdUpdate_banks_by_pk" (\v -> UpdateBankByIdUpdate_banks_by_pk <$> v .: "id")

data UpdateBankByIdArgs = UpdateBankByIdArgs
  { pk_columns :: banks_pk_columns_input,
    _set :: Maybe banks_set_input
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateBankByIdArgs where
  toJSON ( UpdateBankByIdArgs updateBankByIdArgsPk_columns updateBankByIdArgs_set ) =
    omitNulls
      [ "pk_columns" .= updateBankByIdArgsPk_columns,
        "_set" .= updateBankByIdArgs_set
      ]
