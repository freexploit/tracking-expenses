{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Schema.Schema where

import Data.Morpheus.Client.CodeGen.Internal
import Data.Time (UTCTime)
import Data.UUID.Types (UUID)

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

data Expenses_bac_credomatic_bool_exp = Expenses_bac_credomatic_bool_exp
  { _and :: Maybe [Expenses_bac_credomatic_bool_exp],
    _not :: Maybe Expenses_bac_credomatic_bool_exp,
    _or :: Maybe [Expenses_bac_credomatic_bool_exp],
    amount :: Maybe Float8_comparison_exp,
    card_number :: Maybe String_comparison_exp,
    card_type :: Maybe String_comparison_exp,
    commerce :: Maybe String_comparison_exp,
    currency :: Maybe String_comparison_exp,
    date :: Maybe Date_comparison_exp,
    id :: Maybe Uuid_comparison_exp,
    location :: Maybe String_comparison_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_bool_exp where
  toJSON ( Expenses_bac_credomatic_bool_exp expenses_bac_credomatic_bool_exp_and expenses_bac_credomatic_bool_exp_not expenses_bac_credomatic_bool_exp_or expenses_bac_credomatic_bool_expAmount expenses_bac_credomatic_bool_expCard_number expenses_bac_credomatic_bool_expCard_type expenses_bac_credomatic_bool_expCommerce expenses_bac_credomatic_bool_expCurrency expenses_bac_credomatic_bool_expDate expenses_bac_credomatic_bool_expId expenses_bac_credomatic_bool_expLocation ) =
    omitNulls
      [ "_and" .= expenses_bac_credomatic_bool_exp_and,
        "_not" .= expenses_bac_credomatic_bool_exp_not,
        "_or" .= expenses_bac_credomatic_bool_exp_or,
        "amount" .= expenses_bac_credomatic_bool_expAmount,
        "card_number" .= expenses_bac_credomatic_bool_expCard_number,
        "card_type" .= expenses_bac_credomatic_bool_expCard_type,
        "commerce" .= expenses_bac_credomatic_bool_expCommerce,
        "currency" .= expenses_bac_credomatic_bool_expCurrency,
        "date" .= expenses_bac_credomatic_bool_expDate,
        "id" .= expenses_bac_credomatic_bool_expId,
        "location" .= expenses_bac_credomatic_bool_expLocation
      ]

data Expenses_bac_credomatic_constraint = Expenses_bac_credomatic_constraintBac_credomatic_pkey
  deriving (Generic, Show, Eq)

instance FromJSON Expenses_bac_credomatic_constraint where
  parseJSON = \case
    "bac_credomatic_pkey" -> pure Expenses_bac_credomatic_constraintBac_credomatic_pkey
    v -> invalidConstructorError v

instance ToJSON Expenses_bac_credomatic_constraint where
  toJSON = \case
    Expenses_bac_credomatic_constraintBac_credomatic_pkey -> "bac_credomatic_pkey"

newtype Expenses_bac_credomatic_inc_input = Expenses_bac_credomatic_inc_input
  { amount :: Maybe Float
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_inc_input where
  toJSON ( Expenses_bac_credomatic_inc_input expenses_bac_credomatic_inc_inputAmount ) =
    omitNulls
      [ "amount" .= expenses_bac_credomatic_inc_inputAmount
      ]

data Expenses_bac_credomatic_insert_input = Expenses_bac_credomatic_insert_input
  { amount :: Maybe Double,
    card_number :: Maybe String,
    card_type :: Maybe String,
    commerce :: Maybe String,
    currency :: Maybe String,
    date :: Maybe UTCTime,
    id :: Maybe UUID,
    location :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_insert_input where
  toJSON ( Expenses_bac_credomatic_insert_input expenses_bac_credomatic_insert_inputAmount expenses_bac_credomatic_insert_inputCard_number expenses_bac_credomatic_insert_inputCard_type expenses_bac_credomatic_insert_inputCommerce expenses_bac_credomatic_insert_inputCurrency expenses_bac_credomatic_insert_inputDate expenses_bac_credomatic_insert_inputId expenses_bac_credomatic_insert_inputLocation ) =
    omitNulls
      [ "amount" .= expenses_bac_credomatic_insert_inputAmount,
        "card_number" .= expenses_bac_credomatic_insert_inputCard_number,
        "card_type" .= expenses_bac_credomatic_insert_inputCard_type,
        "commerce" .= expenses_bac_credomatic_insert_inputCommerce,
        "currency" .= expenses_bac_credomatic_insert_inputCurrency,
        "date" .= expenses_bac_credomatic_insert_inputDate,
        "id" .= expenses_bac_credomatic_insert_inputId,
        "location" .= expenses_bac_credomatic_insert_inputLocation
      ]

data Expenses_bac_credomatic_on_conflict = Expenses_bac_credomatic_on_conflict
  { constraint :: Expenses_bac_credomatic_constraint,
    update_columns :: [Expenses_bac_credomatic_update_column],
    _where :: Maybe Expenses_bac_credomatic_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_on_conflict where
  toJSON ( Expenses_bac_credomatic_on_conflict expenses_bac_credomatic_on_conflictConstraint expenses_bac_credomatic_on_conflictUpdate_columns expenses_bac_credomatic_on_conflictWhere ) =
    omitNulls
      [ "constraint" .= expenses_bac_credomatic_on_conflictConstraint,
        "update_columns" .= expenses_bac_credomatic_on_conflictUpdate_columns,
        "_where" .= expenses_bac_credomatic_on_conflictWhere
      ]

data Expenses_bac_credomatic_order_by = Expenses_bac_credomatic_order_by
  { amount :: Maybe Order_by,
    card_number :: Maybe Order_by,
    card_type :: Maybe Order_by,
    commerce :: Maybe Order_by,
    currency :: Maybe Order_by,
    date :: Maybe Order_by,
    id :: Maybe Order_by,
    location :: Maybe Order_by
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_order_by where
  toJSON ( Expenses_bac_credomatic_order_by expenses_bac_credomatic_order_byAmount expenses_bac_credomatic_order_byCard_number expenses_bac_credomatic_order_byCard_type expenses_bac_credomatic_order_byCommerce expenses_bac_credomatic_order_byCurrency expenses_bac_credomatic_order_byDate expenses_bac_credomatic_order_byId expenses_bac_credomatic_order_byLocation ) =
    omitNulls
      [ "amount" .= expenses_bac_credomatic_order_byAmount,
        "card_number" .= expenses_bac_credomatic_order_byCard_number,
        "card_type" .= expenses_bac_credomatic_order_byCard_type,
        "commerce" .= expenses_bac_credomatic_order_byCommerce,
        "currency" .= expenses_bac_credomatic_order_byCurrency,
        "date" .= expenses_bac_credomatic_order_byDate,
        "id" .= expenses_bac_credomatic_order_byId,
        "location" .= expenses_bac_credomatic_order_byLocation
      ]

newtype Expenses_bac_credomatic_pk_columns_input = Expenses_bac_credomatic_pk_columns_input
  { id :: UUID
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_pk_columns_input where
  toJSON ( Expenses_bac_credomatic_pk_columns_input expenses_bac_credomatic_pk_columns_inputId ) =
    omitNulls
      [ "id" .= expenses_bac_credomatic_pk_columns_inputId
      ]

data Expenses_bac_credomatic_select_column
  = Expenses_bac_credomatic_select_columnAmount
  | Expenses_bac_credomatic_select_columnCard_number
  | Expenses_bac_credomatic_select_columnCard_type
  | Expenses_bac_credomatic_select_columnCommerce
  | Expenses_bac_credomatic_select_columnCurrency
  | Expenses_bac_credomatic_select_columnDate
  | Expenses_bac_credomatic_select_columnId
  | Expenses_bac_credomatic_select_columnLocation
  deriving (Generic, Show, Eq)

instance FromJSON Expenses_bac_credomatic_select_column where
  parseJSON = \case
    "amount" -> pure Expenses_bac_credomatic_select_columnAmount
    "card_number" -> pure Expenses_bac_credomatic_select_columnCard_number
    "card_type" -> pure Expenses_bac_credomatic_select_columnCard_type
    "commerce" -> pure Expenses_bac_credomatic_select_columnCommerce
    "currency" -> pure Expenses_bac_credomatic_select_columnCurrency
    "date" -> pure Expenses_bac_credomatic_select_columnDate
    "id" -> pure Expenses_bac_credomatic_select_columnId
    "location" -> pure Expenses_bac_credomatic_select_columnLocation
    v -> invalidConstructorError v

instance ToJSON Expenses_bac_credomatic_select_column where
  toJSON = \case
    Expenses_bac_credomatic_select_columnAmount -> "amount"
    Expenses_bac_credomatic_select_columnCard_number -> "card_number"
    Expenses_bac_credomatic_select_columnCard_type -> "card_type"
    Expenses_bac_credomatic_select_columnCommerce -> "commerce"
    Expenses_bac_credomatic_select_columnCurrency -> "currency"
    Expenses_bac_credomatic_select_columnDate -> "date"
    Expenses_bac_credomatic_select_columnId -> "id"
    Expenses_bac_credomatic_select_columnLocation -> "location"

data Expenses_bac_credomatic_set_input = Expenses_bac_credomatic_set_input
  { amount :: Maybe Float,
    card_number :: Maybe String,
    card_type :: Maybe String,
    commerce :: Maybe String,
    currency :: Maybe String,
    date :: Maybe UTCTime,
    id :: Maybe UUID,
    location :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_set_input where
  toJSON ( Expenses_bac_credomatic_set_input expenses_bac_credomatic_set_inputAmount expenses_bac_credomatic_set_inputCard_number expenses_bac_credomatic_set_inputCard_type expenses_bac_credomatic_set_inputCommerce expenses_bac_credomatic_set_inputCurrency expenses_bac_credomatic_set_inputDate expenses_bac_credomatic_set_inputId expenses_bac_credomatic_set_inputLocation ) =
    omitNulls
      [ "amount" .= expenses_bac_credomatic_set_inputAmount,
        "card_number" .= expenses_bac_credomatic_set_inputCard_number,
        "card_type" .= expenses_bac_credomatic_set_inputCard_type,
        "commerce" .= expenses_bac_credomatic_set_inputCommerce,
        "currency" .= expenses_bac_credomatic_set_inputCurrency,
        "date" .= expenses_bac_credomatic_set_inputDate,
        "id" .= expenses_bac_credomatic_set_inputId,
        "location" .= expenses_bac_credomatic_set_inputLocation
      ]

data Expenses_bac_credomatic_stream_cursor_input = Expenses_bac_credomatic_stream_cursor_input
  { initial_value :: Expenses_bac_credomatic_stream_cursor_value_input,
    ordering :: Maybe Cursor_ordering
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_stream_cursor_input where
  toJSON ( Expenses_bac_credomatic_stream_cursor_input expenses_bac_credomatic_stream_cursor_inputInitial_value expenses_bac_credomatic_stream_cursor_inputOrdering ) =
    omitNulls
      [ "initial_value" .= expenses_bac_credomatic_stream_cursor_inputInitial_value,
        "ordering" .= expenses_bac_credomatic_stream_cursor_inputOrdering
      ]

data Expenses_bac_credomatic_stream_cursor_value_input = Expenses_bac_credomatic_stream_cursor_value_input
  { amount :: Maybe Float,
    card_number :: Maybe String,
    card_type :: Maybe String,
    commerce :: Maybe String,
    currency :: Maybe String,
    date :: Maybe UTCTime,
    id :: Maybe UUID,
    location :: Maybe String
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_stream_cursor_value_input where
  toJSON ( Expenses_bac_credomatic_stream_cursor_value_input expenses_bac_credomatic_stream_cursor_value_inputAmount expenses_bac_credomatic_stream_cursor_value_inputCard_number expenses_bac_credomatic_stream_cursor_value_inputCard_type expenses_bac_credomatic_stream_cursor_value_inputCommerce expenses_bac_credomatic_stream_cursor_value_inputCurrency expenses_bac_credomatic_stream_cursor_value_inputDate expenses_bac_credomatic_stream_cursor_value_inputId expenses_bac_credomatic_stream_cursor_value_inputLocation ) =
    omitNulls
      [ "amount" .= expenses_bac_credomatic_stream_cursor_value_inputAmount,
        "card_number" .= expenses_bac_credomatic_stream_cursor_value_inputCard_number,
        "card_type" .= expenses_bac_credomatic_stream_cursor_value_inputCard_type,
        "commerce" .= expenses_bac_credomatic_stream_cursor_value_inputCommerce,
        "currency" .= expenses_bac_credomatic_stream_cursor_value_inputCurrency,
        "date" .= expenses_bac_credomatic_stream_cursor_value_inputDate,
        "id" .= expenses_bac_credomatic_stream_cursor_value_inputId,
        "location" .= expenses_bac_credomatic_stream_cursor_value_inputLocation
      ]

data Expenses_bac_credomatic_update_column
  = Expenses_bac_credomatic_update_columnAmount
  | Expenses_bac_credomatic_update_columnCard_number
  | Expenses_bac_credomatic_update_columnCard_type
  | Expenses_bac_credomatic_update_columnCommerce
  | Expenses_bac_credomatic_update_columnCurrency
  | Expenses_bac_credomatic_update_columnDate
  | Expenses_bac_credomatic_update_columnId
  | Expenses_bac_credomatic_update_columnLocation
  deriving (Generic, Show, Eq)

instance FromJSON Expenses_bac_credomatic_update_column where
  parseJSON = \case
    "amount" -> pure Expenses_bac_credomatic_update_columnAmount
    "card_number" -> pure Expenses_bac_credomatic_update_columnCard_number
    "card_type" -> pure Expenses_bac_credomatic_update_columnCard_type
    "commerce" -> pure Expenses_bac_credomatic_update_columnCommerce
    "currency" -> pure Expenses_bac_credomatic_update_columnCurrency
    "date" -> pure Expenses_bac_credomatic_update_columnDate
    "id" -> pure Expenses_bac_credomatic_update_columnId
    "location" -> pure Expenses_bac_credomatic_update_columnLocation
    v -> invalidConstructorError v

instance ToJSON Expenses_bac_credomatic_update_column where
  toJSON = \case
    Expenses_bac_credomatic_update_columnAmount -> "amount"
    Expenses_bac_credomatic_update_columnCard_number -> "card_number"
    Expenses_bac_credomatic_update_columnCard_type -> "card_type"
    Expenses_bac_credomatic_update_columnCommerce -> "commerce"
    Expenses_bac_credomatic_update_columnCurrency -> "currency"
    Expenses_bac_credomatic_update_columnDate -> "date"
    Expenses_bac_credomatic_update_columnId -> "id"
    Expenses_bac_credomatic_update_columnLocation -> "location"

data Expenses_bac_credomatic_updates = Expenses_bac_credomatic_updates
  { _inc :: Maybe Expenses_bac_credomatic_inc_input,
    _set :: Maybe Expenses_bac_credomatic_set_input,
    _where :: Expenses_bac_credomatic_bool_exp
  }
  deriving (Generic, Show, Eq)

instance ToJSON Expenses_bac_credomatic_updates where
  toJSON ( Expenses_bac_credomatic_updates expenses_bac_credomatic_updates_inc expenses_bac_credomatic_updates_set expenses_bac_credomatic_updatesWhere ) =
    omitNulls
      [ "_inc" .= expenses_bac_credomatic_updates_inc,
        "_set" .= expenses_bac_credomatic_updates_set,
        "_where" .= expenses_bac_credomatic_updatesWhere
      ]

data Float8_comparison_exp = Float8_comparison_exp
  { _eq :: Maybe Float,
    _gt :: Maybe Float,
    _gte :: Maybe Float,
    _in :: Maybe [Float],
    _is_null :: Maybe Bool,
    _lt :: Maybe Float,
    _lte :: Maybe Float,
    _neq :: Maybe Float,
    _nin :: Maybe [Float]
  }
  deriving (Generic, Show, Eq)

instance ToJSON Float8_comparison_exp where
  toJSON ( Float8_comparison_exp float8_comparison_exp_eq float8_comparison_exp_gt float8_comparison_exp_gte float8_comparison_exp_in float8_comparison_exp_is_null float8_comparison_exp_lt float8_comparison_exp_lte float8_comparison_exp_neq float8_comparison_exp_nin ) =
    omitNulls
      [ "_eq" .= float8_comparison_exp_eq,
        "_gt" .= float8_comparison_exp_gt,
        "_gte" .= float8_comparison_exp_gte,
        "_in" .= float8_comparison_exp_in,
        "_is_null" .= float8_comparison_exp_is_null,
        "_lt" .= float8_comparison_exp_lt,
        "_lte" .= float8_comparison_exp_lte,
        "_neq" .= float8_comparison_exp_neq,
        "_nin" .= float8_comparison_exp_nin
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
