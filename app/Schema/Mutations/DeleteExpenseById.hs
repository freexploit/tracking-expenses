{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.DeleteExpense_by_id where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType DeleteExpenseById where
  type RequestArgs DeleteExpenseById = DeleteExpenseByIdArgs
  __name _ = "DeleteExpenseById"
  __query _ = "# Delete an expense by primary key\nmutation DeleteExpenseById($id: uuid!) {\n  delete_expenses_by_pk(id: $id) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype DeleteExpenseById = DeleteExpenseById
  { delete_expenses_by_pk :: Maybe DeleteExpenseByIdDelete_expenses_by_pk
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteExpenseById where
  parseJSON =
    withObject "DeleteExpenseById" (\v -> DeleteExpenseById <$> v .:? "delete_expenses_by_pk")

newtype DeleteExpenseByIdDelete_expenses_by_pk = DeleteExpenseByIdDelete_expenses_by_pk
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteExpenseByIdDelete_expenses_by_pk where
  parseJSON =
    withObject "DeleteExpenseByIdDelete_expenses_by_pk" (\v -> DeleteExpenseByIdDelete_expenses_by_pk <$> v .: "id")

newtype DeleteExpenseByIdArgs = DeleteExpenseByIdArgs
  { id :: uuid
  }
  deriving (Generic, Show, Eq)

instance ToJSON DeleteExpenseByIdArgs where
  toJSON (DeleteExpenseByIdArgs deleteExpenseByIdArgsId) =
    omitNulls
      [ "id" .= deleteExpenseByIdArgsId
      ]
