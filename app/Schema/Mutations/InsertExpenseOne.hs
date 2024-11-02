{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertExpense_one where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

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
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertExpenseOneInsert_expenses_one where
  parseJSON =
    withObject "InsertExpenseOneInsert_expenses_one" (\v -> InsertExpenseOneInsert_expenses_one <$> v .: "id")

data InsertExpenseOneArgs = InsertExpenseOneArgs
  { object :: expenses_insert_input,
    on_conflict :: Maybe expenses_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertExpenseOneArgs where
  toJSON ( InsertExpenseOneArgs insertExpenseOneArgsObject insertExpenseOneArgsOn_conflict ) =
    omitNulls
      [ "object" .= insertExpenseOneArgsObject,
        "on_conflict" .= insertExpenseOneArgsOn_conflict
      ]
