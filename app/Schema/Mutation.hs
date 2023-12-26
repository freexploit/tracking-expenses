{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutation where

import Data.Morpheus.Client.CodeGen.Internal
import Data.UUID.Types
import Schema.Schema


instance RequestType InsertExpenses where
  type RequestArgs InsertExpenses = InsertExpensesArgs
  __name _ = "InsertExpenses"
  __query _ = "mutation InsertExpenses($_data: [expenses_bac_credomatic_insert_input!]!) {\n  insert_expenses_bac_credomatic(objects: $_data) {\n    returning {\n      id\n    }\n  }\n}\n\n"
  __type _ = OPERATION_MUTATION

newtype InsertExpenses = InsertExpenses
  { insert_expenses_bac_credomatic :: Maybe InsertExpensesInsert_expenses_bac_credomatic
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpenses where
  parseJSON =
    withObject "InsertExpenses" (\v -> InsertExpenses <$> v .:? "insert_expenses_bac_credomatic")

newtype InsertExpensesInsert_expenses_bac_credomatic = InsertExpensesInsert_expenses_bac_credomatic
  { returning :: [InsertExpensesInsert_expenses_bac_credomaticReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpensesInsert_expenses_bac_credomatic where
  parseJSON =
    withObject "InsertExpensesInsert_expenses_bac_credomatic" (\v -> InsertExpensesInsert_expenses_bac_credomatic <$> v .: "returning")

newtype InsertExpensesInsert_expenses_bac_credomaticReturning = InsertExpensesInsert_expenses_bac_credomaticReturning
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpensesInsert_expenses_bac_credomaticReturning where
  parseJSON =
    withObject "InsertExpensesInsert_expenses_bac_credomaticReturning" (\v -> InsertExpensesInsert_expenses_bac_credomaticReturning <$> v .: "id")

newtype InsertExpensesArgs = InsertExpensesArgs
  { _data :: [Expenses_bac_credomatic_insert_input]
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertExpensesArgs where
  toJSON (InsertExpensesArgs insertExpensesArgsData) =
    omitNulls
      [ "_data" .= insertExpensesArgsData
      ]
