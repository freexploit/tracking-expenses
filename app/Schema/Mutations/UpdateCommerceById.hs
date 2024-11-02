{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateCommerce_by_id where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType UpdateCommerceById where
  type RequestArgs UpdateCommerceById = UpdateCommerceByIdArgs
  __name _ = "UpdateCommerceById"
  __query _ = "mutation UpdateCommerceById(\n  $pk_columns: commerces_pk_columns_input!\n  $_set: commerces_set_input\n) {\n  update_commerces_by_pk(pk_columns: $pk_columns, _set: $_set) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateCommerceById = UpdateCommerceById
  { update_commerces_by_pk :: Maybe UpdateCommerceByIdUpdate_commerces_by_pk
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommerceById where
  parseJSON =
    withObject "UpdateCommerceById" (\v -> UpdateCommerceById <$> v .:? "update_commerces_by_pk")

newtype UpdateCommerceByIdUpdate_commerces_by_pk = UpdateCommerceByIdUpdate_commerces_by_pk
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommerceByIdUpdate_commerces_by_pk where
  parseJSON =
    withObject "UpdateCommerceByIdUpdate_commerces_by_pk" (\v -> UpdateCommerceByIdUpdate_commerces_by_pk <$> v .: "id")

data UpdateCommerceByIdArgs = UpdateCommerceByIdArgs
  { pk_columns :: commerces_pk_columns_input,
    _set :: Maybe commerces_set_input
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateCommerceByIdArgs where
  toJSON ( UpdateCommerceByIdArgs updateCommerceByIdArgsPk_columns updateCommerceByIdArgs_set ) =
    omitNulls
      [ "pk_columns" .= updateCommerceByIdArgsPk_columns,
        "_set" .= updateCommerceByIdArgs_set
      ]
