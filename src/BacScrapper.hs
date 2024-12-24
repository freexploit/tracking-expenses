{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module BacScrapper where

import Control.Lens (makeLenses)
import qualified Data.ByteString.Char8 as B
import Data.Generics.Labels ()
import Data.List (find, isInfixOf)
import Data.Maybe (fromMaybe)
import Data.Time
import Data.UUID.V7 (UUID)
import Flow
import GHC.Generics
import Text.HTML.TagSoup
import Text.Read (readMaybe)
import Text.Regex.TDFA
import Text.StringLike (toString)
import Types

containsSubstring :: String -> [String] -> Bool
containsSubstring sub = any (sub `isInfixOf`)

parseRow :: [Tag String] -> [String]
parseRow = map (innerText . takeWhile (~/= ("</td>" :: [Char]))) . sections (~== ("<td>" :: [Char]))

createCompose :: [String] -> [[String] -> Bool]
createCompose = map containsSubstring

filterer :: [[String] -> Bool]
filterer = createCompose ["Comercio" :: String, "Ciudad" :: String, "Monto" :: String, "Fecha" :: String, "AMEX" :: String, "VISA" :: String, "MASTER" :: String, "ATM" :: String]

remover :: [[[Char]]] -> [[[Char]]]
remover = map (map (Prelude.filter (`notElem` ("\r\n" :: [Char]))))

proccesHtml :: B.ByteString -> [[String]]
proccesHtml s =
  Text.StringLike.toString s
    |> parseTags
    |> map (parseRow <. takeWhile (~/= ("</tr>" :: [Char])))
    <. sections (~== ("<tr>" :: [Char]))
    |> remover
    |> flip Prelude.filter
    |> flip map filterer
    |> Prelude.filter (not . Prelude.null)
    |> map head

parseDate :: String -> Maybe UTCTime
parseDate input = do
  utcDate <- parseTimeM True defaultTimeLocale "%b %d, %Y, %H:%M" input
  let sixHours = 6 * 60 * 60
  return $ addUTCTime sixHours utcDate

parseCommerce :: Maybe String -> Maybe String -> Maybe Commerce
parseCommerce name' loc' = Just (Commerce name' loc')

parseExpense :: [[String]] -> Maybe Expense
parseExpense xs = do
  let commerce' = head <. tail <$> find ((== "Comercio:") <. head) xs
  let location' = concat <. tail <$> find ((=~ ("Ciudad.*" :: String)) <. head) xs
  fecha <- head <. tail <$> find ((== "Fecha:") <. head) xs
  monto <- head <. tail <$> find ((== "Monto:") <. head) xs
  let cardType = findCardType
  let currency' = B.pack <| takeWhile (/= ' ') monto
  let amountStr = Prelude.filter (/= ' ') <| dropWhile (/= ' ') monto
  let amount' = Just <| fromMaybe 0.0 <| readMaybe <| Prelude.filter (/= ',') amountStr :: Maybe Double
  card' <- fromStringCardType <$> cardType
  let card_number' = head <. tail <$> find (\x -> head (tail x) =~ ("\\*+[[:digit:]]+" :: String) :: Bool) xs
  return <| Expense (parseCommerce commerce' location') Nothing (Just currency') amount' card' (B.pack <$> card_number') (parseDate fecha)
  where
    findCardType = head <$> find (\x -> head x == "MASTER" || head x == "VISA" || head x == "AMEX" || head x == "ATM" || head x == "TX") xs



-- [[["Comercio:","GITHUB"]],[["Ciudad y pa\237s:","+18774484820, Pais no Definido"]],[["Monto:","USD 3.67"]],[["MASTER","************3785"]]
-- "************3785"
