{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Schema where

import Data.Morpheus.Client.CodeGen.Internal
import Types 
import Data.UUID.V7 (UUID)
import Data.Time (UTCTime)
import Data.Geospatial (GeospatialGeometry)

data String_comparison_exp = String_comparison_exp
  { _eq :: Maybe String,
    _gt :: Maybe String,
    _gte :: Maybe String,
    _ilike :: Maybe String,
    _in :: Maybe [String],
    _iregex :: Maybe String,
    _is_null :: Maybe Bool,
    _like :: Maybe String,
    _lt :: Maybe String,
    _lte :: Maybe String,
    _neq :: Maybe String,
    _nilike :: Maybe String,
    _nin :: Maybe [String],
    _niregex :: Maybe String,
    _nlike :: Maybe String,
    _nregex :: Maybe String,
    _nsimilar :: Maybe String,
    _regex :: Maybe String,
    _similar :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON String_comparison_exp where
  toJSON ( String_comparison_exp string_comparison_exp_eq string_comparison_exp_gt string_comparison_exp_gte string_comparison_exp_ilike string_comparison_exp_in string_comparison_exp_iregex string_comparison_exp_is_null string_comparison_exp_like string_comparison_exp_lt string_comparison_exp_lte string_comparison_exp_neq string_comparison_exp_nilike string_comparison_exp_nin string_comparison_exp_niregex string_comparison_exp_nlike string_comparison_exp_nregex string_comparison_exp_nsimilar string_comparison_exp_regex string_comparison_exp_similar ) =
    omitNulls
      [ "_eq" .= string_comparison_exp_eq,
        "_gt" .= string_comparison_exp_gt,
        "_gte" .= string_comparison_exp_gte,
        "_ilike" .= string_comparison_exp_ilike,
        "_in" .= string_comparison_exp_in,
        "_iregex" .= string_comparison_exp_iregex,
        "_is_null" .= string_comparison_exp_is_null,
        "_like" .= string_comparison_exp_like,
        "_lt" .= string_comparison_exp_lt,
        "_lte" .= string_comparison_exp_lte,
        "_neq" .= string_comparison_exp_neq,
        "_nilike" .= string_comparison_exp_nilike,
        "_nin" .= string_comparison_exp_nin,
        "_niregex" .= string_comparison_exp_niregex,
        "_nlike" .= string_comparison_exp_nlike,
        "_nregex" .= string_comparison_exp_nregex,
        "_nsimilar" .= string_comparison_exp_nsimilar,
        "_regex" .= string_comparison_exp_regex,
        "_similar" .= string_comparison_exp_similar
      ]

data Banks_bool_exp = Banks_bool_exp
  { _and :: Maybe [Banks_bool_exp],
    _not :: Maybe Banks_bool_exp,
    _or :: Maybe [Banks_bool_exp],
    id :: Maybe Uuid_comparison_exp,
    location :: Maybe Geography_comparison_exp,
    name :: Maybe String_comparison_exp,
    notification_email :: Maybe String_comparison_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_bool_exp where
  toJSON ( Banks_bool_exp banks_bool_exp_and banks_bool_exp_not banks_bool_exp_or banks_bool_expId banks_bool_expLocation banks_bool_expName banks_bool_expNotification_email ) =
    omitNulls
      [ "_and" .= banks_bool_exp_and,
        "_not" .= banks_bool_exp_not,
        "_or" .= banks_bool_exp_or,
        "id" .= banks_bool_expId,
        "location" .= banks_bool_expLocation,
        "name" .= banks_bool_expName,
        "notification_email" .= banks_bool_expNotification_email
      ]

data Banks_constraint
  = Banks_constraintBanks_notification_email_key
  | Banks_constraintBanks_pkey
  deriving (Generic, Show, Eq)

instance FromJSON Banks_constraint where
  parseJSON = \case
    "banks_notification_email_key" -> pure Banks_constraintBanks_notification_email_key
    "banks_pkey" -> pure Banks_constraintBanks_pkey
    v -> invalidConstructorError v

instance ToJSON Banks_constraint where
  toJSON = \case
    Banks_constraintBanks_notification_email_key -> "banks_notification_email_key"
    Banks_constraintBanks_pkey -> "banks_pkey"

data Banks_insert_input = Banks_insert_input
  { id :: Maybe UUID,
    location :: Maybe Geography,
    name :: Maybe String,
    notification_email :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_insert_input where
  toJSON ( Banks_insert_input banks_insert_inputId banks_insert_inputLocation banks_insert_inputName banks_insert_inputNotification_email ) =
    omitNulls
      [ "id" .= banks_insert_inputId,
        "location" .= banks_insert_inputLocation,
        "name" .= banks_insert_inputName,
        "notification_email" .= banks_insert_inputNotification_email
      ]

data Banks_on_conflict = Banks_on_conflict
  { constraint :: Banks_constraint,
    update_columns :: [Banks_update_column],
    _where :: Maybe Banks_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_on_conflict where
  toJSON ( Banks_on_conflict banks_on_conflictConstraint banks_on_conflictUpdate_columns banks_on_conflictWhere ) =
    omitNulls
      [ "constraint" .= banks_on_conflictConstraint,
        "update_columns" .= banks_on_conflictUpdate_columns,
        "where" .= banks_on_conflictWhere
      ]

data Banks_order_by = Banks_order_by
  { id :: Maybe Order_by,
    location :: Maybe Order_by,
    name :: Maybe Order_by,
    notification_email :: Maybe Order_by
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_order_by where
  toJSON ( Banks_order_by banks_order_byId banks_order_byLocation banks_order_byName banks_order_byNotification_email ) =
    omitNulls
      [ "id" .= banks_order_byId,
        "location" .= banks_order_byLocation,
        "name" .= banks_order_byName,
        "notification_email" .= banks_order_byNotification_email
      ]

newtype Banks_pk_columns_input = Banks_pk_columns_input
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_pk_columns_input where
  toJSON (Banks_pk_columns_input banks_pk_columns_inputId) =
    omitNulls
      [ "id" .= banks_pk_columns_inputId
      ]

data Banks_select_column
  = Banks_select_columnId
  | Banks_select_columnLocation
  | Banks_select_columnName
  | Banks_select_columnNotification_email
  deriving (Generic, Show, Eq)

instance FromJSON Banks_select_column where
  parseJSON = \case
    "id" -> pure Banks_select_columnId
    "location" -> pure Banks_select_columnLocation
    "name" -> pure Banks_select_columnName
    "notification_email" -> pure Banks_select_columnNotification_email
    v -> invalidConstructorError v

instance ToJSON Banks_select_column where
  toJSON = \case
    Banks_select_columnId -> "id"
    Banks_select_columnLocation -> "location"
    Banks_select_columnName -> "name"
    Banks_select_columnNotification_email -> "notification_email"

data Banks_set_input = Banks_set_input
  { id :: Maybe UUID,
    location :: Maybe Geography,
    name :: Maybe String,
    notification_email :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_set_input where
  toJSON ( Banks_set_input banks_set_inputId banks_set_inputLocation banks_set_inputName banks_set_inputNotification_email ) =
    omitNulls
      [ "id" .= banks_set_inputId,
        "location" .= banks_set_inputLocation,
        "name" .= banks_set_inputName,
        "notification_email" .= banks_set_inputNotification_email
      ]

data Banks_stream_cursor_input = Banks_stream_cursor_input
  { initial_value :: Banks_stream_cursor_value_input,
    ordering :: Maybe Cursor_ordering
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_stream_cursor_input where
  toJSON ( Banks_stream_cursor_input banks_stream_cursor_inputInitial_value banks_stream_cursor_inputOrdering ) =
    omitNulls
      [ "initial_value" .= banks_stream_cursor_inputInitial_value,
        "ordering" .= banks_stream_cursor_inputOrdering
      ]

data Banks_stream_cursor_value_input = Banks_stream_cursor_value_input
  { id :: Maybe UUID,
    location :: Maybe Geography,
    name :: Maybe String,
    notification_email :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_stream_cursor_value_input where
  toJSON ( Banks_stream_cursor_value_input banks_stream_cursor_value_inputId banks_stream_cursor_value_inputLocation banks_stream_cursor_value_inputName banks_stream_cursor_value_inputNotification_email ) =
    omitNulls
      [ "id" .= banks_stream_cursor_value_inputId,
        "location" .= banks_stream_cursor_value_inputLocation,
        "name" .= banks_stream_cursor_value_inputName,
        "notification_email" .= banks_stream_cursor_value_inputNotification_email
      ]

data Banks_update_column
  = Banks_update_columnId
  | Banks_update_columnLocation
  | Banks_update_columnName
  | Banks_update_columnNotification_email
  deriving (Generic, Show, Eq)

instance FromJSON Banks_update_column where
  parseJSON = \case
    "id" -> pure Banks_update_columnId
    "location" -> pure Banks_update_columnLocation
    "name" -> pure Banks_update_columnName
    "notification_email" -> pure Banks_update_columnNotification_email
    v -> invalidConstructorError v

instance ToJSON Banks_update_column where
  toJSON = \case
    Banks_update_columnId -> "id"
    Banks_update_columnLocation -> "location"
    Banks_update_columnName -> "name"
    Banks_update_columnNotification_email -> "notification_email"

data Banks_updates = Banks_updates
  { _set :: Maybe Banks_set_input,
    _where :: Banks_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Banks_updates where
  toJSON (Banks_updates banks_updates_set banks_updatesWhere) =
    omitNulls
      [ "_set" .= banks_updates_set,
        "where" .= banks_updatesWhere
      ]

data Card_type_comparison_exp = Card_type_comparison_exp
  { _eq :: Maybe CardType,
    _gt :: Maybe CardType,
    _gte :: Maybe CardType,
    _in :: Maybe [CardType],
    _is_null :: Maybe Bool,
    _lt :: Maybe CardType,
    _lte :: Maybe CardType,
    _neq :: Maybe CardType,
    _nin :: Maybe [CardType]
  }
  deriving (Generic, Show, Eq)

instance ToJSON Card_type_comparison_exp where
  toJSON ( Card_type_comparison_exp card_type_comparison_exp_eq card_type_comparison_exp_gt card_type_comparison_exp_gte card_type_comparison_exp_in card_type_comparison_exp_is_null card_type_comparison_exp_lt card_type_comparison_exp_lte card_type_comparison_exp_neq card_type_comparison_exp_nin ) =
    omitNulls
      [ "_eq" .= card_type_comparison_exp_eq,
        "_gt" .= card_type_comparison_exp_gt,
        "_gte" .= card_type_comparison_exp_gte,
        "_in" .= card_type_comparison_exp_in,
        "_is_null" .= card_type_comparison_exp_is_null,
        "_lt" .= card_type_comparison_exp_lt,
        "_lte" .= card_type_comparison_exp_lte,
        "_neq" .= card_type_comparison_exp_neq,
        "_nin" .= card_type_comparison_exp_nin
      ]

data Commerces_bool_exp = Commerces_bool_exp
  { _and :: Maybe [Commerces_bool_exp],
    _not :: Maybe Commerces_bool_exp,
    _or :: Maybe [Commerces_bool_exp],
    id :: Maybe Uuid_comparison_exp,
    location :: Maybe Geography_comparison_exp,
    name :: Maybe String_comparison_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_bool_exp where
  toJSON ( Commerces_bool_exp commerces_bool_exp_and commerces_bool_exp_not commerces_bool_exp_or commerces_bool_expId commerces_bool_expLocation commerces_bool_expName ) =
    omitNulls
      [ "_and" .= commerces_bool_exp_and,
        "_not" .= commerces_bool_exp_not,
        "_or" .= commerces_bool_exp_or,
        "id" .= commerces_bool_expId,
        "location" .= commerces_bool_expLocation,
        "name" .= commerces_bool_expName
      ]

data Commerces_constraint = Commerces_constraintCommerces_pkey
  deriving (Generic, Show, Eq)

instance FromJSON Commerces_constraint where
  parseJSON = \case
    "commerces_pkey" -> pure Commerces_constraintCommerces_pkey
    v -> invalidConstructorError v

instance ToJSON Commerces_constraint where
  toJSON = \case
    Commerces_constraintCommerces_pkey -> "commerces_pkey"

data Commerces_insert_input = Commerces_insert_input
  { id :: Maybe UUID,
    location :: Maybe Geography,
    name :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_insert_input where
  toJSON ( Commerces_insert_input commerces_insert_inputId commerces_insert_inputLocation commerces_insert_inputName ) =
    omitNulls
      [ "id" .= commerces_insert_inputId,
        "location" .= commerces_insert_inputLocation,
        "name" .= commerces_insert_inputName
      ]

data Commerces_on_conflict = Commerces_on_conflict
  { constraint :: Commerces_constraint,
    update_columns :: [Commerces_update_column],
    _where :: Maybe Commerces_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_on_conflict where
  toJSON ( Commerces_on_conflict commerces_on_conflictConstraint commerces_on_conflictUpdate_columns commerces_on_conflictWhere ) =
    omitNulls
      [ "constraint" .= commerces_on_conflictConstraint,
        "update_columns" .= commerces_on_conflictUpdate_columns,
        "where" .= commerces_on_conflictWhere
      ]

data Commerces_order_by = Commerces_order_by
  { id :: Maybe Order_by,
    location :: Maybe Order_by,
    name :: Maybe Order_by
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_order_by where
  toJSON ( Commerces_order_by commerces_order_byId commerces_order_byLocation commerces_order_byName ) =
    omitNulls
      [ "id" .= commerces_order_byId,
        "location" .= commerces_order_byLocation,
        "name" .= commerces_order_byName
      ]

newtype Commerces_pk_columns_input = Commerces_pk_columns_input
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_pk_columns_input where
  toJSON (Commerces_pk_columns_input commerces_pk_columns_inputId) =
    omitNulls
      [ "id" .= commerces_pk_columns_inputId
      ]

data Commerces_select_column
  = Commerces_select_columnId
  | Commerces_select_columnLocation
  | Commerces_select_columnName
  deriving (Generic, Show, Eq)

instance FromJSON Commerces_select_column where
  parseJSON = \case
    "id" -> pure Commerces_select_columnId
    "location" -> pure Commerces_select_columnLocation
    "name" -> pure Commerces_select_columnName
    v -> invalidConstructorError v

instance ToJSON Commerces_select_column where
  toJSON = \case
    Commerces_select_columnId -> "id"
    Commerces_select_columnLocation -> "location"
    Commerces_select_columnName -> "name"

data Commerces_set_input = Commerces_set_input
  { id :: Maybe UUID,
    location :: Maybe Geography,
    name :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_set_input where
  toJSON ( Commerces_set_input commerces_set_inputId commerces_set_inputLocation commerces_set_inputName ) =
    omitNulls
      [ "id" .= commerces_set_inputId,
        "location" .= commerces_set_inputLocation,
        "name" .= commerces_set_inputName
      ]

data Commerces_stream_cursor_input = Commerces_stream_cursor_input
  { initial_value :: Commerces_stream_cursor_value_input,
    ordering :: Maybe Cursor_ordering
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_stream_cursor_input where
  toJSON ( Commerces_stream_cursor_input commerces_stream_cursor_inputInitial_value commerces_stream_cursor_inputOrdering ) =
    omitNulls
      [ "initial_value" .= commerces_stream_cursor_inputInitial_value,
        "ordering" .= commerces_stream_cursor_inputOrdering
      ]

data Commerces_stream_cursor_value_input = Commerces_stream_cursor_value_input
  { id :: Maybe UUID,
    location :: Maybe Geography,
    name :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_stream_cursor_value_input where
  toJSON ( Commerces_stream_cursor_value_input commerces_stream_cursor_value_inputId commerces_stream_cursor_value_inputLocation commerces_stream_cursor_value_inputName ) =
    omitNulls
      [ "id" .= commerces_stream_cursor_value_inputId,
        "location" .= commerces_stream_cursor_value_inputLocation,
        "name" .= commerces_stream_cursor_value_inputName
      ]

data Commerces_update_column
  = Commerces_update_columnId
  | Commerces_update_columnLocation
  | Commerces_update_columnName
  deriving (Generic, Show, Eq)

instance FromJSON Commerces_update_column where
  parseJSON = \case
    "id" -> pure Commerces_update_columnId
    "location" -> pure Commerces_update_columnLocation
    "name" -> pure Commerces_update_columnName
    v -> invalidConstructorError v

instance ToJSON Commerces_update_column where
  toJSON = \case
    Commerces_update_columnId -> "id"
    Commerces_update_columnLocation -> "location"
    Commerces_update_columnName -> "name"

data Commerces_updates = Commerces_updates
  { _set :: Maybe Commerces_set_input,
    _where :: Commerces_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Commerces_updates where
  toJSON (Commerces_updates commerces_updates_set commerces_updatesWhere) =
    omitNulls
      [ "_set" .= commerces_updates_set,
        "where" .= commerces_updatesWhere
      ]

data Cursor_ordering
  = Cursor_orderingASC
  | Cursor_orderingDESC
  deriving (Generic, Show, Eq)

instance FromJSON Cursor_ordering where
  parseJSON = \case
    "ASC" -> pure Cursor_orderingASC
    "DESC" -> pure Cursor_orderingDESC
    v -> invalidConstructorError v

instance ToJSON Cursor_ordering where
  toJSON = \case
    Cursor_orderingASC -> "ASC"
    Cursor_orderingDESC -> "DESC"

data Date_comparison_exp = Date_comparison_exp
  { _eq :: Maybe UTCTime,
    _gt :: Maybe UTCTime,
    _gte :: Maybe UTCTime,
    _in :: Maybe [UTCTime],
    _is_null :: Maybe Bool,
    _lt :: Maybe UTCTime,
    _lte :: Maybe UTCTime,
    _neq :: Maybe UTCTime,
    _nin :: Maybe [UTCTime]
  }
  deriving (Generic, Show, Eq)

instance ToJSON Date_comparison_exp where
  toJSON ( Date_comparison_exp date_comparison_exp_eq date_comparison_exp_gt date_comparison_exp_gte date_comparison_exp_in date_comparison_exp_is_null date_comparison_exp_lt date_comparison_exp_lte date_comparison_exp_neq date_comparison_exp_nin ) =
    omitNulls
      [ "_eq" .= date_comparison_exp_eq,
        "_gt" .= date_comparison_exp_gt,
        "_gte" .= date_comparison_exp_gte,
        "_in" .= date_comparison_exp_in,
        "_is_null" .= date_comparison_exp_is_null,
        "_lt" .= date_comparison_exp_lt,
        "_lte" .= date_comparison_exp_lte,
        "_neq" .= date_comparison_exp_neq,
        "_nin" .= date_comparison_exp_nin
      ]

data Expenses_bool_exp = Expenses_bool_exp
  { _and :: Maybe [Expenses_bool_exp],
    _not :: Maybe Expenses_bool_exp,
    _or :: Maybe [Expenses_bool_exp],
    amount :: Maybe Money_comparison_exp,
    bank_id :: Maybe Uuid_comparison_exp,
    card_number :: Maybe String_comparison_exp,
    card_type :: Maybe Card_type_comparison_exp,
    commerce_id :: Maybe Uuid_comparison_exp,
    currency :: Maybe String_comparison_exp,
    id :: Maybe Uuid_comparison_exp,
    purchase_date :: Maybe Date_comparison_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bool_exp where
  toJSON ( Expenses_bool_exp expenses_bool_exp_and expenses_bool_exp_not expenses_bool_exp_or expenses_bool_expAmount expenses_bool_expBank_id expenses_bool_expCard_number expenses_bool_expCard_type expenses_bool_expCommerce_id expenses_bool_expCurrency expenses_bool_expId expenses_bool_expPurchase_date ) =
    omitNulls
      [ "_and" .= expenses_bool_exp_and,
        "_not" .= expenses_bool_exp_not,
        "_or" .= expenses_bool_exp_or,
        "amount" .= expenses_bool_expAmount,
        "bank_id" .= expenses_bool_expBank_id,
        "card_number" .= expenses_bool_expCard_number,
        "card_type" .= expenses_bool_expCard_type,
        "commerce_id" .= expenses_bool_expCommerce_id,
        "currency" .= expenses_bool_expCurrency,
        "id" .= expenses_bool_expId,
        "purchase_date" .= expenses_bool_expPurchase_date
      ]

data Expenses_constraint = Expenses_constraintExpenses_pkey
  deriving (Generic, Show, Eq)

instance FromJSON Expenses_constraint where
  parseJSON = \case
    "expenses_pkey" -> pure Expenses_constraintExpenses_pkey
    v -> invalidConstructorError v

instance ToJSON Expenses_constraint where
  toJSON = \case
    Expenses_constraintExpenses_pkey -> "expenses_pkey"

newtype Expenses_inc_input = Expenses_inc_input
  { amount :: Maybe Money
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_inc_input where
  toJSON (Expenses_inc_input expenses_inc_inputAmount) =
    omitNulls
      [ "amount" .= expenses_inc_inputAmount
      ]

data Expenses_insert_input = Expenses_insert_input
  { amount :: Maybe Money,
    bank_id :: Maybe UUID,
    card_number :: Maybe String,
    card_type :: Maybe CardType,
    commerce_id :: Maybe UUID,
    currency :: Maybe String,
    id :: Maybe UUID,
    purchase_date :: Maybe UTCTime
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_insert_input where
  toJSON ( Expenses_insert_input expenses_insert_inputAmount expenses_insert_inputBank_id expenses_insert_inputCard_number expenses_insert_inputCard_type expenses_insert_inputCommerce_id expenses_insert_inputCurrency expenses_insert_inputId expenses_insert_inputPurchase_date ) =
    omitNulls
      [ "amount" .= expenses_insert_inputAmount,
        "bank_id" .= expenses_insert_inputBank_id,
        "card_number" .= expenses_insert_inputCard_number,
        "card_type" .= expenses_insert_inputCard_type,
        "commerce_id" .= expenses_insert_inputCommerce_id,
        "currency" .= expenses_insert_inputCurrency,
        "id" .= expenses_insert_inputId,
        "purchase_date" .= expenses_insert_inputPurchase_date
      ]

data Expenses_on_conflict = Expenses_on_conflict
  { constraint :: Expenses_constraint,
    update_columns :: [Expenses_update_column],
    _where :: Maybe Expenses_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_on_conflict where
  toJSON ( Expenses_on_conflict expenses_on_conflictConstraint expenses_on_conflictUpdate_columns expenses_on_conflictWhere ) =
    omitNulls
      [ "constraint" .= expenses_on_conflictConstraint,
        "update_columns" .= expenses_on_conflictUpdate_columns,
        "where" .= expenses_on_conflictWhere
      ]

data Expenses_order_by = Expenses_order_by
  { amount :: Maybe Order_by,
    bank_id :: Maybe Order_by,
    card_number :: Maybe Order_by,
    card_type :: Maybe Order_by,
    commerce_id :: Maybe Order_by,
    currency :: Maybe Order_by,
    id :: Maybe Order_by,
    purchase_date :: Maybe Order_by
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_order_by where
  toJSON ( Expenses_order_by expenses_order_byAmount expenses_order_byBank_id expenses_order_byCard_number expenses_order_byCard_type expenses_order_byCommerce_id expenses_order_byCurrency expenses_order_byId expenses_order_byPurchase_date ) =
    omitNulls
      [ "amount" .= expenses_order_byAmount,
        "bank_id" .= expenses_order_byBank_id,
        "card_number" .= expenses_order_byCard_number,
        "card_type" .= expenses_order_byCard_type,
        "commerce_id" .= expenses_order_byCommerce_id,
        "currency" .= expenses_order_byCurrency,
        "id" .= expenses_order_byId,
        "purchase_date" .= expenses_order_byPurchase_date
      ]

newtype Expenses_pk_columns_input = Expenses_pk_columns_input
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_pk_columns_input where
  toJSON (Expenses_pk_columns_input expenses_pk_columns_inputId) =
    omitNulls
      [ "id" .= expenses_pk_columns_inputId
      ]

data Expenses_select_column
  = Expenses_select_columnAmount
  | Expenses_select_columnBank_id
  | Expenses_select_columnCard_number
  | Expenses_select_columnCard_type
  | Expenses_select_columnCommerce_id
  | Expenses_select_columnCurrency
  | Expenses_select_columnId
  | Expenses_select_columnPurchase_date
  deriving (Generic, Show, Eq)

instance FromJSON Expenses_select_column where
  parseJSON = \case
    "amount" -> pure Expenses_select_columnAmount
    "bank_id" -> pure Expenses_select_columnBank_id
    "card_number" -> pure Expenses_select_columnCard_number
    "card_type" -> pure Expenses_select_columnCard_type
    "commerce_id" -> pure Expenses_select_columnCommerce_id
    "currency" -> pure Expenses_select_columnCurrency
    "id" -> pure Expenses_select_columnId
    "purchase_date" -> pure Expenses_select_columnPurchase_date
    v -> invalidConstructorError v

instance ToJSON Expenses_select_column where
  toJSON = \case
    Expenses_select_columnAmount -> "amount"
    Expenses_select_columnBank_id -> "bank_id"
    Expenses_select_columnCard_number -> "card_number"
    Expenses_select_columnCard_type -> "card_type"
    Expenses_select_columnCommerce_id -> "commerce_id"
    Expenses_select_columnCurrency -> "currency"
    Expenses_select_columnId -> "id"
    Expenses_select_columnPurchase_date -> "purchase_date"

data Expenses_set_input = Expenses_set_input
  { amount :: Maybe Money,
    bank_id :: Maybe UUID,
    card_number :: Maybe String,
    card_type :: Maybe CardType,
    commerce_id :: Maybe UUID,
    currency :: Maybe String,
    id :: Maybe UUID,
    purchase_date :: Maybe UTCTime
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_set_input where
  toJSON ( Expenses_set_input expenses_set_inputAmount expenses_set_inputBank_id expenses_set_inputCard_number expenses_set_inputCard_type expenses_set_inputCommerce_id expenses_set_inputCurrency expenses_set_inputId expenses_set_inputPurchase_date ) =
    omitNulls
      [ "amount" .= expenses_set_inputAmount,
        "bank_id" .= expenses_set_inputBank_id,
        "card_number" .= expenses_set_inputCard_number,
        "card_type" .= expenses_set_inputCard_type,
        "commerce_id" .= expenses_set_inputCommerce_id,
        "currency" .= expenses_set_inputCurrency,
        "id" .= expenses_set_inputId,
        "purchase_date" .= expenses_set_inputPurchase_date
      ]

data Expenses_stream_cursor_input = Expenses_stream_cursor_input
  { initial_value :: Expenses_stream_cursor_value_input,
    ordering :: Maybe Cursor_ordering
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_stream_cursor_input where
  toJSON ( Expenses_stream_cursor_input expenses_stream_cursor_inputInitial_value expenses_stream_cursor_inputOrdering ) =
    omitNulls
      [ "initial_value" .= expenses_stream_cursor_inputInitial_value,
        "ordering" .= expenses_stream_cursor_inputOrdering
      ]

data Expenses_stream_cursor_value_input = Expenses_stream_cursor_value_input
  { amount :: Maybe Money,
    bank_id :: Maybe UUID,
    card_number :: Maybe String,
    card_type :: Maybe CardType,
    commerce_id :: Maybe UUID,
    currency :: Maybe String,
    id :: Maybe UUID,
    purchase_date :: Maybe UTCTime
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_stream_cursor_value_input where
  toJSON ( Expenses_stream_cursor_value_input expenses_stream_cursor_value_inputAmount expenses_stream_cursor_value_inputBank_id expenses_stream_cursor_value_inputCard_number expenses_stream_cursor_value_inputCard_type expenses_stream_cursor_value_inputCommerce_id expenses_stream_cursor_value_inputCurrency expenses_stream_cursor_value_inputId expenses_stream_cursor_value_inputPurchase_date ) =
    omitNulls
      [ "amount" .= expenses_stream_cursor_value_inputAmount,
        "bank_id" .= expenses_stream_cursor_value_inputBank_id,
        "card_number" .= expenses_stream_cursor_value_inputCard_number,
        "card_type" .= expenses_stream_cursor_value_inputCard_type,
        "commerce_id" .= expenses_stream_cursor_value_inputCommerce_id,
        "currency" .= expenses_stream_cursor_value_inputCurrency,
        "id" .= expenses_stream_cursor_value_inputId,
        "purchase_date" .= expenses_stream_cursor_value_inputPurchase_date
      ]

data Expenses_update_column
  = Expenses_update_columnAmount
  | Expenses_update_columnBank_id
  | Expenses_update_columnCard_number
  | Expenses_update_columnCard_type
  | Expenses_update_columnCommerce_id
  | Expenses_update_columnCurrency
  | Expenses_update_columnId
  | Expenses_update_columnPurchase_date
  deriving (Generic, Show, Eq)

instance FromJSON Expenses_update_column where
  parseJSON = \case
    "amount" -> pure Expenses_update_columnAmount
    "bank_id" -> pure Expenses_update_columnBank_id
    "card_number" -> pure Expenses_update_columnCard_number
    "card_type" -> pure Expenses_update_columnCard_type
    "commerce_id" -> pure Expenses_update_columnCommerce_id
    "currency" -> pure Expenses_update_columnCurrency
    "id" -> pure Expenses_update_columnId
    "purchase_date" -> pure Expenses_update_columnPurchase_date
    v -> invalidConstructorError v

instance ToJSON Expenses_update_column where
  toJSON = \case
    Expenses_update_columnAmount -> "amount"
    Expenses_update_columnBank_id -> "bank_id"
    Expenses_update_columnCard_number -> "card_number"
    Expenses_update_columnCard_type -> "card_type"
    Expenses_update_columnCommerce_id -> "commerce_id"
    Expenses_update_columnCurrency -> "currency"
    Expenses_update_columnId -> "id"
    Expenses_update_columnPurchase_date -> "purchase_date"

data Expenses_updates = Expenses_updates
  { _inc :: Maybe Expenses_inc_input,
    _set :: Maybe Expenses_set_input,
    _where :: Expenses_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_updates where
  toJSON ( Expenses_updates expenses_updates_inc expenses_updates_set expenses_updatesWhere ) =
    omitNulls
      [ "_inc" .= expenses_updates_inc,
        "_set" .= expenses_updates_set,
        "where" .= expenses_updatesWhere
      ]

newtype Geography_cast_exp = Geography_cast_exp
  { geometry :: Maybe Geometry_comparison_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Geography_cast_exp where
  toJSON (Geography_cast_exp geography_cast_expGeometry) =
    omitNulls
      [ "geometry" .= geography_cast_expGeometry
      ]

data Geography_comparison_exp = Geography_comparison_exp
  { _cast :: Maybe Geography_cast_exp,
    _eq :: Maybe Geography,
    _gt :: Maybe Geography,
    _gte :: Maybe Geography,
    _in :: Maybe [Geography],
    _is_null :: Maybe Bool,
    _lt :: Maybe Geography,
    _lte :: Maybe Geography,
    _neq :: Maybe Geography,
    _nin :: Maybe [Geography],
    _st_d_within :: Maybe St_d_within_geography_input,
    _st_intersects :: Maybe Geography
  }
  deriving (Generic, Show, Eq)

instance ToJSON Geography_comparison_exp where
  toJSON ( Geography_comparison_exp geography_comparison_exp_cast geography_comparison_exp_eq geography_comparison_exp_gt geography_comparison_exp_gte geography_comparison_exp_in geography_comparison_exp_is_null geography_comparison_exp_lt geography_comparison_exp_lte geography_comparison_exp_neq geography_comparison_exp_nin geography_comparison_exp_st_d_within geography_comparison_exp_st_intersects ) =
    omitNulls
      [ "_cast" .= geography_comparison_exp_cast,
        "_eq" .= geography_comparison_exp_eq,
        "_gt" .= geography_comparison_exp_gt,
        "_gte" .= geography_comparison_exp_gte,
        "_in" .= geography_comparison_exp_in,
        "_is_null" .= geography_comparison_exp_is_null,
        "_lt" .= geography_comparison_exp_lt,
        "_lte" .= geography_comparison_exp_lte,
        "_neq" .= geography_comparison_exp_neq,
        "_nin" .= geography_comparison_exp_nin,
        "_st_d_within" .= geography_comparison_exp_st_d_within,
        "_st_intersects" .= geography_comparison_exp_st_intersects
      ]

newtype Geometry_cast_exp = Geometry_cast_exp
  { geography :: Maybe Geography_comparison_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Geometry_cast_exp where
  toJSON (Geometry_cast_exp geometry_cast_expGeography) =
    omitNulls
      [ "geography" .= geometry_cast_expGeography
      ]

data Geometry_comparison_exp = Geometry_comparison_exp
  { _cast :: Maybe Geometry_cast_exp,
    _eq :: Maybe GeospatialGeometry,
    _gt :: Maybe GeospatialGeometry,
    _gte :: Maybe GeospatialGeometry,
    _in :: Maybe [GeospatialGeometry],
    _is_null :: Maybe Bool,
    _lt :: Maybe GeospatialGeometry,
    _lte :: Maybe GeospatialGeometry,
    _neq :: Maybe GeospatialGeometry,
    _nin :: Maybe [GeospatialGeometry],
    _st_3d_d_within :: Maybe St_d_within_input,
    _st_3d_intersects :: Maybe GeospatialGeometry,
    _st_contains :: Maybe GeospatialGeometry,
    _st_crosses :: Maybe GeospatialGeometry,
    _st_d_within :: Maybe St_d_within_input,
    _st_equals :: Maybe GeospatialGeometry,
    _st_intersects :: Maybe GeospatialGeometry,
    _st_overlaps :: Maybe GeospatialGeometry,
    _st_touches :: Maybe GeospatialGeometry,
    _st_within :: Maybe GeospatialGeometry
  }
  deriving (Generic, Show, Eq)

instance ToJSON Geometry_comparison_exp where
  toJSON ( Geometry_comparison_exp geometry_comparison_exp_cast geometry_comparison_exp_eq geometry_comparison_exp_gt geometry_comparison_exp_gte geometry_comparison_exp_in geometry_comparison_exp_is_null geometry_comparison_exp_lt geometry_comparison_exp_lte geometry_comparison_exp_neq geometry_comparison_exp_nin geometry_comparison_exp_st_3d_d_within geometry_comparison_exp_st_3d_intersects geometry_comparison_exp_st_contains geometry_comparison_exp_st_crosses geometry_comparison_exp_st_d_within geometry_comparison_exp_st_equals geometry_comparison_exp_st_intersects geometry_comparison_exp_st_overlaps geometry_comparison_exp_st_touches geometry_comparison_exp_st_within ) =
    omitNulls
      [ "_cast" .= geometry_comparison_exp_cast,
        "_eq" .= geometry_comparison_exp_eq,
        "_gt" .= geometry_comparison_exp_gt,
        "_gte" .= geometry_comparison_exp_gte,
        "_in" .= geometry_comparison_exp_in,
        "_is_null" .= geometry_comparison_exp_is_null,
        "_lt" .= geometry_comparison_exp_lt,
        "_lte" .= geometry_comparison_exp_lte,
        "_neq" .= geometry_comparison_exp_neq,
        "_nin" .= geometry_comparison_exp_nin,
        "_st_3d_d_within" .= geometry_comparison_exp_st_3d_d_within,
        "_st_3d_intersects" .= geometry_comparison_exp_st_3d_intersects,
        "_st_contains" .= geometry_comparison_exp_st_contains,
        "_st_crosses" .= geometry_comparison_exp_st_crosses,
        "_st_d_within" .= geometry_comparison_exp_st_d_within,
        "_st_equals" .= geometry_comparison_exp_st_equals,
        "_st_intersects" .= geometry_comparison_exp_st_intersects,
        "_st_overlaps" .= geometry_comparison_exp_st_overlaps,
        "_st_touches" .= geometry_comparison_exp_st_touches,
        "_st_within" .= geometry_comparison_exp_st_within
      ]

data Money_comparison_exp = Money_comparison_exp
  { _eq :: Maybe Money,
    _gt :: Maybe Money,
    _gte :: Maybe Money,
    _in :: Maybe [Money],
    _is_null :: Maybe Bool,
    _lt :: Maybe Money,
    _lte :: Maybe Money,
    _neq :: Maybe Money,
    _nin :: Maybe [Money]
  }
  deriving (Generic, Show, Eq)

instance ToJSON Money_comparison_exp where
  toJSON ( Money_comparison_exp money_comparison_exp_eq money_comparison_exp_gt money_comparison_exp_gte money_comparison_exp_in money_comparison_exp_is_null money_comparison_exp_lt money_comparison_exp_lte money_comparison_exp_neq money_comparison_exp_nin ) =
    omitNulls
      [ "_eq" .= money_comparison_exp_eq,
        "_gt" .= money_comparison_exp_gt,
        "_gte" .= money_comparison_exp_gte,
        "_in" .= money_comparison_exp_in,
        "_is_null" .= money_comparison_exp_is_null,
        "_lt" .= money_comparison_exp_lt,
        "_lte" .= money_comparison_exp_lte,
        "_neq" .= money_comparison_exp_neq,
        "_nin" .= money_comparison_exp_nin
      ]

data Order_by
  = Order_byAsc
  | Order_byAsc_nulls_first
  | Order_byAsc_nulls_last
  | Order_byDesc
  | Order_byDesc_nulls_first
  | Order_byDesc_nulls_last
  deriving (Generic, Show, Eq)

instance FromJSON Order_by where
  parseJSON = \case
    "asc" -> pure Order_byAsc
    "asc_nulls_first" -> pure Order_byAsc_nulls_first
    "asc_nulls_last" -> pure Order_byAsc_nulls_last
    "desc" -> pure Order_byDesc
    "desc_nulls_first" -> pure Order_byDesc_nulls_first
    "desc_nulls_last" -> pure Order_byDesc_nulls_last
    v -> invalidConstructorError v

instance ToJSON Order_by where
  toJSON = \case
    Order_byAsc -> "asc"
    Order_byAsc_nulls_first -> "asc_nulls_first"
    Order_byAsc_nulls_last -> "asc_nulls_last"
    Order_byDesc -> "desc"
    Order_byDesc_nulls_first -> "desc_nulls_first"
    Order_byDesc_nulls_last -> "desc_nulls_last"

data St_d_within_geography_input = St_d_within_geography_input
  { distance :: Float,
    from :: Geography,
    use_spheroid :: Maybe Bool
  }
  deriving (Generic, Show, Eq)

instance ToJSON St_d_within_geography_input where
  toJSON ( St_d_within_geography_input st_d_within_geography_inputDistance st_d_within_geography_inputFrom st_d_within_geography_inputUse_spheroid ) =
    omitNulls
      [ "distance" .= st_d_within_geography_inputDistance,
        "from" .= st_d_within_geography_inputFrom,
        "use_spheroid" .= st_d_within_geography_inputUse_spheroid
      ]

data St_d_within_input = St_d_within_input
  { distance :: Float,
    from :: GeospatialGeometry
  }
  deriving (Generic, Show, Eq)

instance ToJSON St_d_within_input where
  toJSON (St_d_within_input st_d_within_inputDistance st_d_within_inputFrom) =
    omitNulls
      [ "distance" .= st_d_within_inputDistance,
        "from" .= st_d_within_inputFrom
      ]

data Uuid_comparison_exp = Uuid_comparison_exp
  { _eq :: Maybe UUID,
    _gt :: Maybe UUID,
    _gte :: Maybe UUID,
    _in :: Maybe [UUID],
    _is_null :: Maybe Bool,
    _lt :: Maybe UUID,
    _lte :: Maybe UUID,
    _neq :: Maybe UUID,
    _nin :: Maybe [UUID]
  }
  deriving (Generic, Show, Eq)

instance ToJSON Uuid_comparison_exp where
  toJSON ( Uuid_comparison_exp uuid_comparison_exp_eq uuid_comparison_exp_gt uuid_comparison_exp_gte uuid_comparison_exp_in uuid_comparison_exp_is_null uuid_comparison_exp_lt uuid_comparison_exp_lte uuid_comparison_exp_neq uuid_comparison_exp_nin ) =
    omitNulls
      [ "_eq" .= uuid_comparison_exp_eq,
        "_gt" .= uuid_comparison_exp_gt,
        "_gte" .= uuid_comparison_exp_gte,
        "_in" .= uuid_comparison_exp_in,
        "_is_null" .= uuid_comparison_exp_is_null,
        "_lt" .= uuid_comparison_exp_lt,
        "_lte" .= uuid_comparison_exp_lte,
        "_neq" .= uuid_comparison_exp_neq,
        "_nin" .= uuid_comparison_exp_nin
      ]
