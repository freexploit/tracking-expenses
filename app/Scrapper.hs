{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TemplateHaskell  #-}
{-# LANGUAGE DeriveGeneric #-}



module Scrapper  where

import Flow
import Text.HTML.TagSoup
import           Control.Lens(makeLenses)
import           Data.Generics.Labels    ()
import qualified Data.ByteString.Char8 as B
import Text.StringLike (toString)
import Data.List
import Data.Time
import Text.Read (readMaybe)
import Text.Regex.TDFA
import GHC.Generics
import Data.Maybe (fromMaybe)
import Data.Char (isDigit)


data CardType = VISA
    | MASTERCARD
    | AMEX
    | ATM
    deriving(Show, Generic)

fromStringCardType :: String -> Maybe CardType
fromStringCardType s = case s of
  "VISA" -> Just VISA
  "MASTER" -> Just MASTERCARD
  "AMEX" -> Just AMEX
  "ATM" -> Just ATM
  _ -> Nothing

data Expense = Expense
    {   _commerce :: Maybe  B.ByteString,
        _location :: Maybe B.ByteString,
        _currency ::Maybe  B.ByteString,
        _amount :: Maybe  Double,
        _card :: Maybe CardType,
        _card_number :: Maybe B.ByteString,
        _date :: Maybe UTCTime
    }
  deriving (Show,Generic)

makeLenses ''Expense

containsSubstring :: String -> [String] -> Bool
containsSubstring sub = any (sub `isInfixOf`)


parseRow :: [Tag String] -> [String]
parseRow = map (innerText . takeWhile (~/= ("</td>":: [Char]))) . sections (~== ("<td>"::[Char]))

createCompose :: [String] -> [ [String] -> Bool ]
createCompose = map containsSubstring

filterer :: [[String] -> Bool]
filterer = createCompose ["Comercio"::String, "Ciudad"::String, "Monto"::String, "Fecha":: String, "AMEX"::String, "VISA"::String, "MASTER"::String, "ATM"::String]
remover :: [[[Char]]] -> [[[Char]]]
remover = map (map (filter (`notElem` ("\r\n"::[Char])) ))

proccesHtml :: B.ByteString -> [[String]]
proccesHtml s =
        toString s |> parseTags
        |> map ( parseRow <. takeWhile (~/= ("</tr>"::[Char]))) <. sections (~== ("<tr>"::[Char]))
        |> remover
        |> flip filter
        |> flip map filterer
        |> filter (not . null)
        |> map head


parseDate :: String -> Maybe UTCTime
parseDate input = do
    utcDate <- parseTimeM True defaultTimeLocale "%b %d, %Y, %H:%M" input
    let sixHours = 6 * 60 * 60
    return $ addUTCTime sixHours utcDate

parseExpense :: [[String]] -> Maybe Expense
parseExpense xs = do
  let commerce' = head <. tail <$> find ((== "Comercio:") <. head ) xs
  let location' = concat <. tail <$> find ((=~ ("Ciudad.*"::String) ) <. head ) xs
  fecha <- head <. tail <$> find ((== "Fecha:") <. head ) xs
  monto <- head <. tail <$> find ((== "Monto:") <. head ) xs
  let cardType = findCardType
  let currency' = B.pack <| takeWhile (/= ' ') monto
  let amountStr= filter (/= ' ') <|  dropWhile (/= ' ') monto
  let amount' = Just <| fromMaybe 0.0 <| readMaybe <| filter (/= ',') amountStr :: Maybe Double
  card' <- fromStringCardType <$> cardType
  let card_number' =  head <. tail <$> find (\x ->  head (tail x) =~ ("\\*+[[:digit:]]+"::String):: Bool)  xs
  return <| Expense (B.pack <$> commerce') (B.pack <$> location') (Just currency') amount' card' (B.pack <$> card_number') (parseDate  fecha)
  where
    findCardType  = head <$> find (\x -> head x == "MASTER" || head x == "VISA" || head x == "AMEX" || head x == "ATM") xs


--[[["Comercio:","GITHUB"]],[["Ciudad y pa\237s:","+18774484820, Pais no Definido"]],[["Monto:","USD 3.67"]],[["MASTER","************3785"]]
--"************3785"
