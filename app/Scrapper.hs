{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GADTs #-}

module Scrapper (proccesHtml) where

import Text.HTML.TagSoup
import qualified Data.ByteString.Char8 as B
import Text.StringLike (toString)
import Data.List
import Data.Time



data CardType = VISA
    | MASTERCARD
    | AMEX
    | ATM
    deriving(Show)


data Expense where
  Expense :: {amount :: Double,
                card :: CardType,
                date :: Maybe UTCTime,
                card_number :: B.ByteString,
                commerce :: B.ByteString,
                currency :: B.ByteString,
                location :: B.ByteString}
               -> Expense
  deriving (Show)



containsSubstring :: String -> [String] -> Bool
containsSubstring sub = any (sub `isInfixOf`)


parseRow :: [Tag String] -> [String]
parseRow = map (innerText . takeWhile (~/= ("</td>":: [Char]))) . sections (~== ("<td>"::[Char]))

--compose :: [[String] -> Bool] -> ([String] -> Bool)
--compose fs xs = all (\f -> f xs) fs

createCompose :: [String] -> [ [String] -> Bool ]
createCompose = map containsSubstring  

filterer :: [[String] -> Bool]
filterer = createCompose ["Comercio"::String, "Ciudad"::String, "Monto"::String, "AMEX"::String, "VISA"::String, "MASTER"::String ]

proccesHtml :: B.ByteString -> IO ()
proccesHtml s = do
        --let tags =   take 1 . dropWhile ( ~/=  ("</p>":: [Char]) ) $ parseTags s
        let tags = parseTags $ toString s
        let dd = map ( parseRow . takeWhile (~/= ("</tr>"::[Char]))) . sections (~== ("<tr>"::[Char]))  $ tags
        let expenses = map (\fun -> filter fun dd) filterer
        print $ show expenses
        return ()
    where
        show2 [] = "[]"
        show2 xs = "[" ++ concat (intersperseNotBroken "\n," $ map show xs) ++ "\n]\n"

intersperseNotBroken :: a -> [a] -> [a]
intersperseNotBroken _ [] = []
intersperseNotBroken sep (x:xs) = x : is xs
    where
        is [] = []
        is (y:ys) = sep : y : is ys



    




