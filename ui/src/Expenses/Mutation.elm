-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Expenses.Mutation exposing (..)

import Expenses.InputObject
import Expenses.Interface
import Expenses.Object
import Expenses.Scalar
import Expenses.ScalarCodecs
import Expenses.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


type alias DeleteExpensesBacCredomaticRequiredArguments =
    { where_ : Expenses.InputObject.Expenses_bac_credomatic_bool_exp }


{-| delete data from the table: "expenses\_bac\_credomatic"

  - where\_ - filter the rows which have to be deleted

-}
delete_expenses_bac_credomatic :
    DeleteExpensesBacCredomaticRequiredArguments
    -> SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic_mutation_response
    -> SelectionSet (Maybe decodesTo) RootMutation
delete_expenses_bac_credomatic requiredArgs____ object____ =
    Object.selectionForCompositeField "delete_expenses_bac_credomatic" [ Argument.required "where" requiredArgs____.where_ Expenses.InputObject.encodeExpenses_bac_credomatic_bool_exp ] object____ (Basics.identity >> Decode.nullable)


type alias DeleteExpensesBacCredomaticByPkRequiredArguments =
    { id : Expenses.ScalarCodecs.Uuid }


{-| delete single row from the table: "expenses\_bac\_credomatic"
-}
delete_expenses_bac_credomatic_by_pk :
    DeleteExpensesBacCredomaticByPkRequiredArguments
    -> SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic
    -> SelectionSet (Maybe decodesTo) RootMutation
delete_expenses_bac_credomatic_by_pk requiredArgs____ object____ =
    Object.selectionForCompositeField "delete_expenses_bac_credomatic_by_pk" [ Argument.required "id" requiredArgs____.id (Expenses.ScalarCodecs.codecs |> Expenses.Scalar.unwrapEncoder .codecUuid) ] object____ (Basics.identity >> Decode.nullable)


type alias InsertExpensesBacCredomaticOptionalArguments =
    { on_conflict : OptionalArgument Expenses.InputObject.Expenses_bac_credomatic_on_conflict }


type alias InsertExpensesBacCredomaticRequiredArguments =
    { objects : List Expenses.InputObject.Expenses_bac_credomatic_insert_input }


{-| insert data into the table: "expenses\_bac\_credomatic"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
insert_expenses_bac_credomatic :
    (InsertExpensesBacCredomaticOptionalArguments -> InsertExpensesBacCredomaticOptionalArguments)
    -> InsertExpensesBacCredomaticRequiredArguments
    -> SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic_mutation_response
    -> SelectionSet (Maybe decodesTo) RootMutation
insert_expenses_bac_credomatic fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { on_conflict = Absent }

        optionalArgs____ =
            [ Argument.optional "on_conflict" filledInOptionals____.on_conflict Expenses.InputObject.encodeExpenses_bac_credomatic_on_conflict ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "insert_expenses_bac_credomatic" (optionalArgs____ ++ [ Argument.required "objects" requiredArgs____.objects (Expenses.InputObject.encodeExpenses_bac_credomatic_insert_input |> Encode.list) ]) object____ (Basics.identity >> Decode.nullable)


type alias InsertExpensesBacCredomaticOneOptionalArguments =
    { on_conflict : OptionalArgument Expenses.InputObject.Expenses_bac_credomatic_on_conflict }


type alias InsertExpensesBacCredomaticOneRequiredArguments =
    { object : Expenses.InputObject.Expenses_bac_credomatic_insert_input }


{-| insert a single row into the table: "expenses\_bac\_credomatic"

  - object - the row to be inserted
  - on\_conflict - on conflict condition

-}
insert_expenses_bac_credomatic_one :
    (InsertExpensesBacCredomaticOneOptionalArguments -> InsertExpensesBacCredomaticOneOptionalArguments)
    -> InsertExpensesBacCredomaticOneRequiredArguments
    -> SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic
    -> SelectionSet (Maybe decodesTo) RootMutation
insert_expenses_bac_credomatic_one fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { on_conflict = Absent }

        optionalArgs____ =
            [ Argument.optional "on_conflict" filledInOptionals____.on_conflict Expenses.InputObject.encodeExpenses_bac_credomatic_on_conflict ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "insert_expenses_bac_credomatic_one" (optionalArgs____ ++ [ Argument.required "object" requiredArgs____.object Expenses.InputObject.encodeExpenses_bac_credomatic_insert_input ]) object____ (Basics.identity >> Decode.nullable)


type alias UpdateExpensesBacCredomaticOptionalArguments =
    { inc_ : OptionalArgument Expenses.InputObject.Expenses_bac_credomatic_inc_input
    , set_ : OptionalArgument Expenses.InputObject.Expenses_bac_credomatic_set_input
    }


type alias UpdateExpensesBacCredomaticRequiredArguments =
    { where_ : Expenses.InputObject.Expenses_bac_credomatic_bool_exp }


{-| update data of the table: "expenses\_bac\_credomatic"

  - inc\_ - increments the numeric columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_expenses_bac_credomatic :
    (UpdateExpensesBacCredomaticOptionalArguments -> UpdateExpensesBacCredomaticOptionalArguments)
    -> UpdateExpensesBacCredomaticRequiredArguments
    -> SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic_mutation_response
    -> SelectionSet (Maybe decodesTo) RootMutation
update_expenses_bac_credomatic fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { inc_ = Absent, set_ = Absent }

        optionalArgs____ =
            [ Argument.optional "_inc" filledInOptionals____.inc_ Expenses.InputObject.encodeExpenses_bac_credomatic_inc_input, Argument.optional "_set" filledInOptionals____.set_ Expenses.InputObject.encodeExpenses_bac_credomatic_set_input ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "update_expenses_bac_credomatic" (optionalArgs____ ++ [ Argument.required "where" requiredArgs____.where_ Expenses.InputObject.encodeExpenses_bac_credomatic_bool_exp ]) object____ (Basics.identity >> Decode.nullable)


type alias UpdateExpensesBacCredomaticByPkOptionalArguments =
    { inc_ : OptionalArgument Expenses.InputObject.Expenses_bac_credomatic_inc_input
    , set_ : OptionalArgument Expenses.InputObject.Expenses_bac_credomatic_set_input
    }


type alias UpdateExpensesBacCredomaticByPkRequiredArguments =
    { pk_columns : Expenses.InputObject.Expenses_bac_credomatic_pk_columns_input }


{-| update single row of the table: "expenses\_bac\_credomatic"

  - inc\_ - increments the numeric columns with given value of the filtered values
  - set\_ - sets the columns of the filtered rows to the given values

-}
update_expenses_bac_credomatic_by_pk :
    (UpdateExpensesBacCredomaticByPkOptionalArguments -> UpdateExpensesBacCredomaticByPkOptionalArguments)
    -> UpdateExpensesBacCredomaticByPkRequiredArguments
    -> SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic
    -> SelectionSet (Maybe decodesTo) RootMutation
update_expenses_bac_credomatic_by_pk fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { inc_ = Absent, set_ = Absent }

        optionalArgs____ =
            [ Argument.optional "_inc" filledInOptionals____.inc_ Expenses.InputObject.encodeExpenses_bac_credomatic_inc_input, Argument.optional "_set" filledInOptionals____.set_ Expenses.InputObject.encodeExpenses_bac_credomatic_set_input ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "update_expenses_bac_credomatic_by_pk" (optionalArgs____ ++ [ Argument.required "pk_columns" requiredArgs____.pk_columns Expenses.InputObject.encodeExpenses_bac_credomatic_pk_columns_input ]) object____ (Basics.identity >> Decode.nullable)