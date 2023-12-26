{-# LANGUAGE OverloadedStrings #-}


module Graphql(insertExpenses) where

import Control.Lens
import Data.Morpheus.Client
  ( GQLClient,
    ResponseStream,
    request, withHeaders,
  )
import Schema.Schema
import Schema.Mutation
import Scrapper

import qualified Scrapper as Sc
import qualified Data.ByteString.UTF8 as U
import qualified Data.Text as T

import Env
import Data.Maybe
import Data.String (fromString)

authToken :: Env String
authToken = env "GRAPHQL_AUTH_TOKEN"

hasuraURL :: Env String
hasuraURL = env "GRAPHQL_URL"

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
    env_uri <- getterEnv hasuraURL
    env_token <- getterEnv authToken
    let client = (fromString (fromJust env_uri) ::GQLClient) `withHeaders` [("x-hasura-admin-secret", T.pack (fromJust env_token ))]
    let ss = map fromExpense expenses
    request  client InsertExpensesArgs { _data = ss }
