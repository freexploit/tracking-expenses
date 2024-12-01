{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertCommerceOne where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema
import Data.UUID.V7 (UUID)

instance RequestType InsertCommerceOne where
  type RequestArgs InsertCommerceOne = InsertCommerceOneArgs
  __name _ = "InsertCommerceOne"
  __query _ = "# Insert a single commerce\nmutation InsertCommerceOne($object: commerces_insert_input!, $on_conflict: commerces_on_conflict) {\n  insert_commerces_one(object: $object, on_conflict: $on_conflict) {\n    id\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype InsertCommerceOne = InsertCommerceOne
  { insert_commerces_one :: Maybe InsertCommerceOneInsert_commerces_one
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertCommerceOne where
  parseJSON =
    withObject "InsertCommerceOne" (\v -> InsertCommerceOne <$> v .:? "insert_commerces_one")

newtype InsertCommerceOneInsert_commerces_one = InsertCommerceOneInsert_commerces_one
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertCommerceOneInsert_commerces_one where
  parseJSON =
    withObject "InsertCommerceOneInsert_commerces_one" (\v -> InsertCommerceOneInsert_commerces_one <$> v .: "id")

data InsertCommerceOneArgs = InsertCommerceOneArgs
  { object :: Commerces_insert_input,
    on_conflict :: Maybe Commerces_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertCommerceOneArgs where
  toJSON ( InsertCommerceOneArgs insertCommerceOneArgsObject insertCommerceOneArgsOn_conflict ) =
    omitNulls
      [ "object" .= insertCommerceOneArgsObject,
        "on_conflict" .= insertCommerceOneArgsOn_conflict
      ]
