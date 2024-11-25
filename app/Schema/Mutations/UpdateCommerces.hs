{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.UpdateCommerces where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema
import Data.UUID.V7 (UUID)

instance RequestType UpdateCommerces where
  type RequestArgs UpdateCommerces = UpdateCommercesArgs
  __name _ = "UpdateCommerces"
  __query _ = "mutation UpdateCommerces(\n  $where: commerces_bool_exp!\n  $_set: commerces_set_input\n) {\n  update_commerces(where: $where, _set: $_set) {\n    affected_rows\n    returning {\n      id\n    }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype UpdateCommerces = UpdateCommerces
  { update_commerces :: Maybe UpdateCommercesUpdate_commerces
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommerces where
  parseJSON =
    withObject "UpdateCommerces" (\v -> UpdateCommerces <$> v .:? "update_commerces")

data UpdateCommercesUpdate_commerces = UpdateCommercesUpdate_commerces
  { affected_rows :: Int,
    returning :: [UpdateCommercesUpdate_commercesReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommercesUpdate_commerces where
  parseJSON =
    withObject "UpdateCommercesUpdate_commerces" (\v -> UpdateCommercesUpdate_commerces <$> v .: "affected_rows" <*> v .: "returning")

newtype UpdateCommercesUpdate_commercesReturning = UpdateCommercesUpdate_commercesReturning
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance FromJSON UpdateCommercesUpdate_commercesReturning where
  parseJSON =
    withObject "UpdateCommercesUpdate_commercesReturning" (\v -> UpdateCommercesUpdate_commercesReturning <$> v .: "id")

data UpdateCommercesArgs = UpdateCommercesArgs
  { _where :: Commerces_bool_exp,
    _set :: Maybe Commerces_set_input
  }
  deriving (Generic, Show, Eq)

instance ToJSON UpdateCommercesArgs where
  toJSON ( UpdateCommercesArgs updateCommercesArgsWhere updateCommercesArgs_set ) =
    omitNulls
      [ "where" .= updateCommercesArgsWhere,
        "_set" .= updateCommercesArgs_set
      ]
