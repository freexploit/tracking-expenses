{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.DeleteCommerce_by_id where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType DeleteCommerceById where
  type RequestArgs DeleteCommerceById = DeleteCommerceByIdArgs
  __name _ = "DeleteCommerceById"
  __query _ = "# Delete a commerce by primary key\nmutation DeleteCommerceById($id: uuid!) {\n  delete_commerces_by_pk(id: $id) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype DeleteCommerceById = DeleteCommerceById
  { delete_commerces_by_pk :: Maybe DeleteCommerceByIdDelete_commerces_by_pk
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteCommerceById where
  parseJSON =
    withObject "DeleteCommerceById" (\v -> DeleteCommerceById <$> v .:? "delete_commerces_by_pk")

newtype DeleteCommerceByIdDelete_commerces_by_pk = DeleteCommerceByIdDelete_commerces_by_pk
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteCommerceByIdDelete_commerces_by_pk where
  parseJSON =
    withObject "DeleteCommerceByIdDelete_commerces_by_pk" (\v -> DeleteCommerceByIdDelete_commerces_by_pk <$> v .: "id")

newtype DeleteCommerceByIdArgs = DeleteCommerceByIdArgs
  { id :: uuid
  }
  deriving (Generic, Show, Eq)

instance ToJSON DeleteCommerceByIdArgs where
  toJSON (DeleteCommerceByIdArgs deleteCommerceByIdArgsId) =
    omitNulls
      [ "id" .= deleteCommerceByIdArgsId
      ]
