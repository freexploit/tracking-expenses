{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateExpenseById where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema
import Data.UUID.V7 (UUID)

instance RequestType UpdateExpenseById where
  type RequestArgs UpdateExpenseById = UpdateExpenseByIdArgs
  __name _ = "UpdateExpenseById"
  __query _ = "# Update a single expense by primary key\nmutation UpdateExpenseById(\n  $pk_columns: expenses_pk_columns_input!\n  $_set: expenses_set_input\n  $_inc: expenses_inc_input\n) {\n  update_expenses_by_pk(pk_columns: $pk_columns, _set: $_set, _inc: $_inc) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateExpenseById = UpdateExpenseById
  { update_expenses_by_pk :: Maybe UpdateExpenseByIdUpdate_expenses_by_pk
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpenseById where
  parseJSON =
    withObject "UpdateExpenseById" (\v -> UpdateExpenseById <$> v .:? "update_expenses_by_pk")

newtype UpdateExpenseByIdUpdate_expenses_by_pk = UpdateExpenseByIdUpdate_expenses_by_pk
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpenseByIdUpdate_expenses_by_pk where
  parseJSON =
    withObject "UpdateExpenseByIdUpdate_expenses_by_pk" (\v -> UpdateExpenseByIdUpdate_expenses_by_pk <$> v .: "id")

data UpdateExpenseByIdArgs = UpdateExpenseByIdArgs
  { pk_columns :: Expenses_pk_columns_input,
    _set :: Maybe Expenses_set_input,
    _inc :: Maybe Expenses_inc_input
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateExpenseByIdArgs where
  toJSON ( UpdateExpenseByIdArgs updateExpenseByIdArgsPk_columns updateExpenseByIdArgs_set updateExpenseByIdArgs_inc ) =
    omitNulls
      [ "pk_columns" .= updateExpenseByIdArgsPk_columns,
        "_set" .= updateExpenseByIdArgs_set,
        "_inc" .= updateExpenseByIdArgs_inc
      ]
