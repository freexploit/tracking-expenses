{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedLabels #-}


module Types  where
import GHC.Generics
import Data.Aeson
import Control.Lens (makeLenses)
import qualified Data.ByteString.Char8 as B
import Data.Generics.Labels ()
import Data.Time

type Money = Double

data Geography = Geography
      { geoType      :: String    -- This represents the "type" field
      , coordinates  :: [Double]  -- This represents the "coordinates" field
      } deriving (Show, Generic, Eq)

instance FromJSON Geography
instance ToJSON Geography

data CardType = VISA
    | MASTERCARD
    | AMEX
    | ATM
    | TX
    deriving(Show, Generic, Eq)

instance FromJSON CardType
instance ToJSON CardType

fromStringCardType :: String -> Maybe CardType
fromStringCardType s = case s of
  "VISA" -> Just VISA
  "MASTER" -> Just MASTERCARD
  "AMEX" -> Just AMEX
  "ATM" -> Just ATM
  "TX" -> Just ATM
  _ -> Nothing


data Bank = Bank
  { _bank_name :: Maybe String,
    _bank_location :: Maybe String,
    _bank_email :: Maybe String
  }
  deriving (Show, Generic, Eq)

data Commerce = Commerce
  { _commerce_name :: Maybe String,
    _commerce_location :: Maybe String
  }
  deriving (Show, Generic, Eq)

data Expense = Expense
  { _commerce :: Maybe Commerce,
    _bank :: Maybe Bank,
    _currency :: Maybe B.ByteString,
    _amount :: Maybe Double,
    _card :: Maybe CardType,
    _card_number :: Maybe B.ByteString,
    _date :: Maybe UTCTime
  }
  deriving (Show, Generic, Eq)

makeLenses ''Expense
makeLenses ''Bank
makeLenses ''Commerce
