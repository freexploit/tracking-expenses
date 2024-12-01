{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.DeleteBankById where

import Data.Morpheus.Client.CodeGen.Internal
import Data.UUID.V7 (UUID)

instance RequestType DeleteBankById where
  type RequestArgs DeleteBankById = DeleteBankByIdArgs
  __name _ = "DeleteBankById"
  __query _ = "mutation DeleteBankById($id: uuid!) {\n  delete_banks_by_pk(id: $id) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype DeleteBankById = DeleteBankById
  { delete_banks_by_pk :: Maybe DeleteBankByIdDelete_banks_by_pk
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteBankById where
  parseJSON =
    withObject "DeleteBankById" (\v -> DeleteBankById <$> v .:? "delete_banks_by_pk")

newtype DeleteBankByIdDelete_banks_by_pk = DeleteBankByIdDelete_banks_by_pk
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteBankByIdDelete_banks_by_pk where
  parseJSON =
    withObject "DeleteBankByIdDelete_banks_by_pk" (\v -> DeleteBankByIdDelete_banks_by_pk <$> v .: "id")

newtype DeleteBankByIdArgs = DeleteBankByIdArgs
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance ToJSON DeleteBankByIdArgs where
  toJSON (DeleteBankByIdArgs deleteBankByIdArgsId) =
    omitNulls
      [ "id" .= deleteBankByIdArgsId
      ]
