{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.DeleteCommerces where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema_generate

instance RequestType DeleteCommerces where
  type RequestArgs DeleteCommerces = DeleteCommercesArgs
  __name _ = "DeleteCommerces"
  __query _ = "# Delete multiple commerces based on a condition\nmutation DeleteCommerces($where: commerces_bool_exp!) {\n  delete_commerces(where: $where) {\n    affected_rows\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype DeleteCommerces = DeleteCommerces
  { delete_commerces :: Maybe DeleteCommercesDelete_commerces
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteCommerces where
  parseJSON =
    withObject "DeleteCommerces" (\v -> DeleteCommerces <$> v .:? "delete_commerces")

newtype DeleteCommercesDelete_commerces = DeleteCommercesDelete_commerces
  { affected_rows :: Int
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteCommercesDelete_commerces where
  parseJSON =
    withObject "DeleteCommercesDelete_commerces" (\v -> DeleteCommercesDelete_commerces <$> v .: "affected_rows")

newtype DeleteCommercesArgs = DeleteCommercesArgs
  { where :: commerces_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON DeleteCommercesArgs where
  toJSON (DeleteCommercesArgs deleteCommercesArgsWhere) =
    omitNulls
      [ "where" .= deleteCommercesArgsWhere
      ]
