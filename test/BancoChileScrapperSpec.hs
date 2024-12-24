{-# LANGUAGE OverloadedStrings #-}

module BancoChileScrapperSpec (spec) where

import BancoChileScrapper
import qualified Data.ByteString as BS
import Test.Hspec
import Types

readEmailText ::  IO BS.ByteString
readEmailText = do
    BS.readFile "test/email.txt"

    

spec :: Spec
spec = do
  describe "Banco de Chile text scrapping" $ do

    it "Scrape text mail into Expense" $ do
      email <- readEmailText
      print email
      parseExpense email `shouldBe` Just (Expense (Just  (Commerce (Just "SHOPEE CL") (Just "Chile"))) Nothing (Just "CLP") (Just 33560.0) (Just TX) (Just "****7209") Nothing)
