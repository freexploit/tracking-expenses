{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.DeleteExpenses where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType DeleteExpenses where
  type RequestArgs DeleteExpenses = DeleteExpensesArgs
  __name _ = "DeleteExpenses"
  __query _ = "# Delete multiple expenses based on a condition\nmutation DeleteExpenses($where: expenses_bool_exp!) {\n  delete_expenses(where: $where) {\n    affected_rows\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype DeleteExpenses = DeleteExpenses
  { delete_expenses :: Maybe DeleteExpensesDelete_expenses
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteExpenses where
  parseJSON =
    withObject "DeleteExpenses" (\v -> DeleteExpenses <$> v .:? "delete_expenses")

newtype DeleteExpensesDelete_expenses = DeleteExpensesDelete_expenses
  { affected_rows :: Int
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteExpensesDelete_expenses where
  parseJSON =
    withObject "DeleteExpensesDelete_expenses" (\v -> DeleteExpensesDelete_expenses <$> v .: "affected_rows")

newtype DeleteExpensesArgs = DeleteExpensesArgs
  { where :: expenses_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON DeleteExpensesArgs where
  toJSON (DeleteExpensesArgs deleteExpensesArgsWhere) =
    omitNulls
      [ "where" .= deleteExpensesArgsWhere
      ]
