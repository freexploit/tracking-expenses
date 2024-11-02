{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateExpenses where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType UpdateExpenses where
  type RequestArgs UpdateExpenses = UpdateExpensesArgs
  __name _ = "UpdateExpenses"
  __query _ = "mutation UpdateExpenses(\n  $where: expenses_bool_exp!\n  $_set: expenses_set_input\n  $_inc: expenses_inc_input\n) {\n  update_expenses(where: $where, _set: $_set, _inc: $_inc) {\n    affected_rows\n    returning {\n      id\n    }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateExpenses = UpdateExpenses
  { update_expenses :: Maybe UpdateExpensesUpdate_expenses
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpenses where
  parseJSON =
    withObject "UpdateExpenses" (\v -> UpdateExpenses <$> v .:? "update_expenses")

data UpdateExpensesUpdate_expenses = UpdateExpensesUpdate_expenses
  { affected_rows :: Int,
    returning :: [UpdateExpensesUpdate_expensesReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpensesUpdate_expenses where
  parseJSON =
    withObject "UpdateExpensesUpdate_expenses" (\v -> UpdateExpensesUpdate_expenses <$> v .: "affected_rows" <*> v .: "returning")

newtype UpdateExpensesUpdate_expensesReturning = UpdateExpensesUpdate_expensesReturning
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpensesUpdate_expensesReturning where
  parseJSON =
    withObject "UpdateExpensesUpdate_expensesReturning" (\v -> UpdateExpensesUpdate_expensesReturning <$> v .: "id")

data UpdateExpensesArgs = UpdateExpensesArgs
  { where :: expenses_bool_exp,
    _set :: Maybe expenses_set_input,
    _inc :: Maybe expenses_inc_input
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateExpensesArgs where
  toJSON ( UpdateExpensesArgs updateExpensesArgsWhere updateExpensesArgs_set updateExpensesArgs_inc ) =
    omitNulls
      [ "where" .= updateExpensesArgsWhere,
        "_set" .= updateExpensesArgs_set,
        "_inc" .= updateExpensesArgs_inc
      ]
