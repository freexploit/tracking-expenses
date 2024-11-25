{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstrainedClassMethods #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE DuplicateRecordFields #-}


module Graphql(insertExpenses) where

import Flow
import Control.Lens ((^.))
import Data.Morpheus.Client
  ( GQLClient,
    ResponseStream,
    request, withHeaders,
  )
import Schema.Schema
import Schema.Mutations.InsertExpenses
import Scrapper

import qualified Scrapper as Sc
import qualified Data.ByteString.UTF8 as U
import qualified Data.Text as T
import Data.String (fromString)

import App (AppM (AppM))
import Config (GraphqlConfig,url, token, grab)
import Control.Monad.IO.Class (MonadIO (..))
import Data.UUID.V7 ( UUID, genUUID )
import Schema.Mutations.InsertBankOne (InsertBankOne (InsertBankOne), object, InsertBankOneArgs (InsertBankOneArgs))

class (Monad m, MonadIO m) => GraphQLMonad m where
    insertExpenses :: [Expense] -> m (ResponseStream InsertExpenses)
    fromExpense :: Sc.Expense -> m Expenses_insert_input
    --upsertBank :: Sc.Bank -> m (ResponseStream InsertBankOne)

class (Monad m, MonadIO m, GraphQLMonad m) => MonadUUID m where
    generateM :: m UUID

instance MonadUUID AppM where
    generateM = AppM <| liftIO <| genUUID

--fromCommerce :: Sc.Commerce -> Commerces_insert_input
--fromCommerce com' =
    --Commerces_insert_input  (com' ^. Sc.commerce_id) (com' ^. Sc.commerce_location) (com' ^. Sc.commerce_name)


instance GraphQLMonad AppM where

    --fromExpense :: Sc.Expense -> AppM Expenses_insert_input
    fromExpense exp' = do
        uuid <- generateM
        return <| Expenses_insert_input (exp' ^. Sc.amount)
            Nothing
            (U.toString <$> exp' ^. Sc.card_number)
            (exp' ^. Sc.card )
            Nothing
            (U.toString <$> exp' ^. Sc.currency )
            (Just uuid)
            (exp' ^. Sc.date )

    insertExpenses expenses' = do
        gqlConfig <- grab @GraphqlConfig
        let client = (fromString gqlConfig.url::GQLClient) `withHeaders` [("x-hasura-admin-secret", T.pack   gqlConfig.token )]
        ss <- mapM fromExpense  expenses'
        request client InsertExpensesArgs { objects = ss , on_conflict = Just (Expenses_on_conflict {
                constraint = Expenses_constraintExpenses_pkey,
                update_columns = [ Expenses_update_columnAmount , Expenses_update_columnBank_id , Expenses_update_columnCard_number , Expenses_update_columnCard_type , Expenses_update_columnCommerce_id , Expenses_update_columnCurrency , Expenses_update_columnId , Expenses_update_columnPurchase_date], _where = Nothing
            })
        }

    --upsertBank bank' = do
        --gqlConfig <- grab @GraphqlConfig
        --let client = (fromString gqlConfig.url::GQLClient) `withHeaders` [("x-hasura-admin-secret", T.pack   gqlConfig.token )]

        --ss <- mapM fromExpense  expenses'
        --request client InsertBankOneArgs { object = bank' }

        

