{-# LANGUAGE OverloadedStrings #-}


module Graphql(insertExpenses) where

import Control.Lens
import Data.Morpheus.Client
  ( GQLClient,
    ResponseStream,
    request,
  )
import Schema.Schema
import Schema.Mutation
import Scrapper 

import qualified Scrapper as Sc
import qualified Data.ByteString.UTF8 as U


client :: GQLClient
client = "http://localhost:8080/v1/graphql" 

fromExpense :: Sc.Expense -> Expenses_bac_credomatic_insert_input
fromExpense exp' =
    Expenses_bac_credomatic_insert_input
        (exp' ^. Sc.amount)
        (U.toString <$> exp' ^. Sc.card_number)
        (show <$> exp' ^. Sc.card )
        (U.toString <$> exp' ^. Sc.commerce )
        (U.toString <$> exp' ^. Sc.currency )
        (exp' ^. Sc.date )
        Nothing
        (U.toString <$> exp' ^. Sc.location )

insertExpenses :: [Expense] -> IO (ResponseStream InsertExpenses)
insertExpenses expenses = do
    print expenses
    let ss = map fromExpense expenses
    print ss
    request client  InsertExpensesArgs { _data = ss }

