{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Mutations.DeleteBanks where

import Data.Morpheus.Client.CodeGen.Internal
import Schema.Schema
import Data.UUID.V7 (UUID)
import Types

instance RequestType DeleteBanks where
  type RequestArgs DeleteBanks = DeleteBanksArgs
  __name _ = "DeleteBanks"
  __query _ = "# Delete multiple banks based on a condition\nmutation DeleteBanks($where: banks_bool_exp!) {\n  delete_banks(where: $where) {\n    affected_rows\n        returning {\n          id\n          location\n          name\n          notification_email\n        }\n  }\n}\n"
  __type _ = OPERATION_MUTATION

newtype DeleteBanks = DeleteBanks
  { delete_banks :: Maybe DeleteBanksDelete_banks
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteBanks where
  parseJSON =
    withObject "DeleteBanks" (\v -> DeleteBanks <$> v .:? "delete_banks")

data DeleteBanksDelete_banks = DeleteBanksDelete_banks
  { affected_rows :: Int,
    returning :: [DeleteBanksDelete_banksReturning]
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteBanksDelete_banks where
  parseJSON =
    withObject "DeleteBanksDelete_banks" (\v -> DeleteBanksDelete_banks <$> v .: "affected_rows" <*> v .: "returning")

data DeleteBanksDelete_banksReturning = DeleteBanksDelete_banksReturning
  { id :: UUID,
    location :: Maybe Geography,
    name :: String,
    notification_email :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance FromJSON DeleteBanksDelete_banksReturning where
  parseJSON =
    withObject "DeleteBanksDelete_banksReturning" (\v -> DeleteBanksDelete_banksReturning <$> v .: "id" <*> v .:? "location" <*> v .: "name" <*> v .:? "notification_email")

newtype DeleteBanksArgs = DeleteBanksArgs
  { _where :: Banks_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON DeleteBanksArgs where
  toJSON (DeleteBanksArgs deleteBanksArgsWhere) =
    omitNulls
      [ "where" .= deleteBanksArgsWhere
      ]
