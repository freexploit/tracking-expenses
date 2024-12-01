{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE RecordWildCards #-}

module ScrapperBuilder where

import GHC.Generics


data (Show a) => Scrapper a b = Scrapper 
    { scrapperSource :: a 
    , scrapperParser :: a -> Maybe b
    }

mkScrapper :: (Show a) => a -> (a -> Maybe b ) -> Scrapper a b
mkScrapper input parser = Scrapper {scrapperSource = input, scrapperParser= parser}

runScrapper :: (Show a) => Scrapper a b -> Maybe b
runScrapper Scrapper{..} = scrapperParser scrapperSource
