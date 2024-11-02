{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertExpenses where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType InsertExpenses where
  type RequestArgs InsertExpenses = InsertExpensesArgs
  __name _ = "InsertExpenses"
  __query _ = "# Insert multiple expenses\nmutation InsertExpenses($objects: [expenses_insert_input!]!, $on_conflict: expenses_on_conflict) {\n  insert_expenses(objects: $objects, on_conflict: $on_conflict) {\n    affected_rows\n    returning {\n      id\n    }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype InsertExpenses = InsertExpenses
  { insert_expenses :: Maybe InsertExpensesInsert_expenses
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpenses where
  parseJSON =
    withObject "InsertExpenses" (\v -> InsertExpenses <$> v .:? "insert_expenses")

data InsertExpensesInsert_expenses = InsertExpensesInsert_expenses
  { affected_rows :: Int,
    returning :: [InsertExpensesInsert_expensesReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpensesInsert_expenses where
  parseJSON =
    withObject "InsertExpensesInsert_expenses" (\v -> InsertExpensesInsert_expenses <$> v .: "affected_rows" <*> v .: "returning")

newtype InsertExpensesInsert_expensesReturning = InsertExpensesInsert_expensesReturning
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpensesInsert_expensesReturning where
  parseJSON =
    withObject "InsertExpensesInsert_expensesReturning" (\v -> InsertExpensesInsert_expensesReturning <$> v .: "id")

data InsertExpensesArgs = InsertExpensesArgs
  { objects :: [expenses_insert_input],
    on_conflict :: Maybe expenses_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertExpensesArgs where
  toJSON ( InsertExpensesArgs insertExpensesArgsObjects insertExpensesArgsOn_conflict ) =
    omitNulls
      [ "objects" .= insertExpensesArgsObjects,
        "on_conflict" .= insertExpensesArgsOn_conflict
      ]
