{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateExpenses_many where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType UpdateExpensesMany where
  type RequestArgs UpdateExpensesMany = UpdateExpensesManyArgs
  __name _ = "UpdateExpensesMany"
  __query _ = "# Update multiple expenses with different updates\nmutation UpdateExpensesMany($updates: [expenses_updates!]!) {\n  update_expenses_many(updates: $updates) {\n    affected_rows\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateExpensesMany = UpdateExpensesMany
  { update_expenses_many :: Maybe [Maybe UpdateExpensesManyUpdate_expenses_many]
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpensesMany where
  parseJSON =
    withObject "UpdateExpensesMany" (\v -> UpdateExpensesMany <$> v .:? "update_expenses_many")

newtype UpdateExpensesManyUpdate_expenses_many = UpdateExpensesManyUpdate_expenses_many
  { affected_rows :: Int
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateExpensesManyUpdate_expenses_many where
  parseJSON =
    withObject "UpdateExpensesManyUpdate_expenses_many" (\v -> UpdateExpensesManyUpdate_expenses_many <$> v .: "affected_rows")

newtype UpdateExpensesManyArgs = UpdateExpensesManyArgs
  { updates :: [expenses_updates]
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateExpensesManyArgs where
  toJSON (UpdateExpensesManyArgs updateExpensesManyArgsUpdates) =
    omitNulls
      [ "updates" .= updateExpensesManyArgsUpdates
      ]
