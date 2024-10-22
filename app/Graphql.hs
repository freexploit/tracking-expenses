{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstrainedClassMethods #-}
{-# LANGUAGE OverloadedRecordDot #-}


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
import Data.String (fromString)

import App (AppM)
import Config (GraphqlConfig,url, token, grab)
import Control.Monad.IO.Class (MonadIO)

class (Monad m, MonadIO m) => GraphQLMonad m where
    insertExpenses :: [Expense] -> m (ResponseStream InsertExpenses)


--authToken :: AppEnv String
--authToken = env "GRAPHQL_AUTH_TOKEN"

--hasuraURL :: AppEnv String
--hasuraURL = env "GRAPHQL_URL"

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

instance GraphQLMonad AppM where
    insertExpenses expenses = do
        gqlConfig <- grab @GraphqlConfig
        -- Should be on a reader
        let client = (fromString gqlConfig.url::GQLClient) `withHeaders` [("x-hasura-admin-secret", T.pack   gqlConfig.token )]
        let ss  = map fromExpense  expenses
        request client InsertExpensesArgs { _data = ss }

