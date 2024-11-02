{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.InsertCommerces where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType InsertCommerces where
  type RequestArgs InsertCommerces = InsertCommercesArgs
  __name _ = "InsertCommerces"
  __query _ = "# Insert multiple commerces\nmutation InsertCommerces($objects: [commerces_insert_input!]!, $on_conflict: commerces_on_conflict) {\n  insert_commerces(objects: $objects, on_conflict: $on_conflict) {\n    affected_rows\n    returning {\n      id\n    }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype InsertCommerces = InsertCommerces
  { insert_commerces :: Maybe InsertCommercesInsert_commerces
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertCommerces where
  parseJSON =
    withObject "InsertCommerces" (\v -> InsertCommerces <$> v .:? "insert_commerces")

data InsertCommercesInsert_commerces = InsertCommercesInsert_commerces
  { affected_rows :: Int,
    returning :: [InsertCommercesInsert_commercesReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertCommercesInsert_commerces where
  parseJSON =
    withObject "InsertCommercesInsert_commerces" (\v -> InsertCommercesInsert_commerces <$> v .: "affected_rows" <*> v .: "returning")

newtype InsertCommercesInsert_commercesReturning = InsertCommercesInsert_commercesReturning
  { id :: Uuid
  }
  deriving (Generic, Show, Eq)

instance FromJSON InsertCommercesInsert_commercesReturning where
  parseJSON =
    withObject "InsertCommercesInsert_commercesReturning" (\v -> InsertCommercesInsert_commercesReturning <$> v .: "id")

data InsertCommercesArgs = InsertCommercesArgs
  { objects :: [commerces_insert_input],
    on_conflict :: Maybe commerces_on_conflict
  }
  deriving (Generic, Show, Eq)

instance ToJSON InsertCommercesArgs where
  toJSON ( InsertCommercesArgs insertCommercesArgsObjects insertCommercesArgsOn_conflict ) =
    omitNulls
      [ "objects" .= insertCommercesArgsObjects,
        "on_conflict" .= insertCommercesArgsOn_conflict
      ]
