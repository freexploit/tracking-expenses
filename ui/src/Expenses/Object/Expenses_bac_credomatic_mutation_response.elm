-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Expenses.Object.Expenses_bac_credomatic_mutation_response exposing (..)

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
import Json.Decode as Decode


{-| number of rows affected by the mutation
-}
affected_rows : SelectionSet Int Expenses.Object.Expenses_bac_credomatic_mutation_response
affected_rows =
    Object.selectionForField "Int" "affected_rows" [] Decode.int


{-| data from the rows affected by the mutation
-}
returning :
    SelectionSet decodesTo Expenses.Object.Expenses_bac_credomatic
    -> SelectionSet (List decodesTo) Expenses.Object.Expenses_bac_credomatic_mutation_response
returning object____ =
    Object.selectionForCompositeField "returning" [] object____ (Basics.identity >> Decode.list)
