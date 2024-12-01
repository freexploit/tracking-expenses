{-# LANGUAGE DeriveGeneric #-}


module Types (Geography, CardType,fromStringCardType, Money) where
import GHC.Generics
import Data.Aeson

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
    deriving(Show, Generic,Eq)

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

