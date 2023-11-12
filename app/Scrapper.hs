{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}

module Scrapper (proccesHtml, parseExpense) where

import Flow 
import Text.HTML.TagSoup
import qualified Data.ByteString.Char8 as B
import Text.StringLike (toString)
import Data.List
import Data.Time
import Text.Read (readMaybe)
import Text.Regex.TDFA
import Data.Maybe (fromJust, fromMaybe)


data CardType = VISA
    | MASTERCARD
    | AMEX
    | ATM
    deriving(Show)

fromStringCardType :: String -> Maybe CardType
fromStringCardType s = case s of
  "VISA" -> Just VISA
  "MASTER" -> Just MASTERCARD
  "AMEX" -> Just AMEX
  "ATM" -> Just ATM
  _ -> Nothing

data Expense = Expense 
    {   commerce :: Maybe  B.ByteString,
        location :: Maybe B.ByteString,
        currency ::Maybe  B.ByteString,
        amount :: Maybe  Double,
        card :: Maybe CardType,
        card_number :: Maybe B.ByteString,
        date :: Maybe UTCTime
    }
  deriving (Show)


containsSubstring :: String -> [String] -> Bool
containsSubstring sub = any (sub `isInfixOf`)


parseRow :: [Tag String] -> [String]
parseRow = map (innerText <. takeWhile (~/= ("</td>":: [Char]))) <. sections (~== ("<td>"::[Char]))

--compose :: [[String] -> Bool] -> ([String] -> Bool)
--compose fs xs = all (\f -> f xs) fs

createCompose :: [String] -> [ [String] -> Bool ]
createCompose = map containsSubstring  

filterer :: [[String] -> Bool]
filterer = createCompose ["Comercio"::String, "Ciudad"::String, "Monto"::String, "AMEX"::String, "VISA"::String, "MASTER"::String, "ATM"::String  ]

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


parseExpense :: [[String]] -> Maybe Expense
parseExpense xs = do
  let commerce' = head <. tail <$> find ((== "Comercio:") <. head ) xs
  let location' = concat .tail <$> find ((=~ ("Ciudad.*"::String) ) <. head ) xs
  monto <- head <. tail <$> find ((== "Monto:") <. head ) xs
  let cardType = findCardType
  let currency' = B.pack <| takeWhile (/= ' ') monto
  let amountStr= filter (/= ' ') <|  dropWhile (/= ' ') monto 
  let amount' = readMaybe amountStr :: Maybe Double
  card' <- fromStringCardType <$> cardType
  let card_number' =  head <. tail <$> find (\x ->  head (tail x) =~ ("\\*+[[:digit:]]+"::String):: Bool)  xs
  return <| Expense (B.pack <$> commerce') (B.pack <$> location') (Just currency') amount' card' (B.pack <$> card_number') Nothing
  where
    findCardType  = head <$> find (\x -> head x == "MASTER" || head x == "VISA" || head x == "AMEX" || head x == "ATM") xs
    

--[[["Comercio:","GITHUB"]],[["Ciudad y pa\237s:","+18774484820, Pais no Definido"]],[["Monto:","USD 3.67"]],[["MASTER","************3785"]]
--"************3785"
