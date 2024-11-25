{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertExpenseOne where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema
import Data.UUID.V7 (UUID)

instance RequestType InsertExpenseOne where
  type RequestArgs InsertExpenseOne = InsertExpenseOneArgs
  __name _ = "InsertExpenseOne"
  __query _ = "# Insert a single expense\nmutation InsertExpenseOne($object: expenses_insert_input!, $on_conflict: expenses_on_conflict) {\n  insert_expenses_one(object: $object, on_conflict: $on_conflict) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype InsertExpenseOne = InsertExpenseOne
  { insert_expenses_one :: Maybe InsertExpenseOneInsert_expenses_one
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpenseOne where
  parseJSON =
    withObject "InsertExpenseOne" (\v -> InsertExpenseOne <$> v .:? "insert_expenses_one")

newtype InsertExpenseOneInsert_expenses_one = InsertExpenseOneInsert_expenses_one
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpenseOneInsert_expenses_one where
  parseJSON =
    withObject "InsertExpenseOneInsert_expenses_one" (\v -> InsertExpenseOneInsert_expenses_one <$> v .: "id")

data InsertExpenseOneArgs = InsertExpenseOneArgs
  { object :: Expenses_insert_input,
    on_conflict :: Maybe Expenses_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertExpenseOneArgs where
  toJSON ( InsertExpenseOneArgs insertExpenseOneArgsObject insertExpenseOneArgsOn_conflict ) =
    omitNulls
      [ "object" .= insertExpenseOneArgsObject,
        "on_conflict" .= insertExpenseOneArgsOn_conflict
      ]
