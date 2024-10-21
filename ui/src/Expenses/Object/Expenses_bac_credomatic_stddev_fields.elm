-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Expenses.Object.Expenses_bac_credomatic_stddev_fields exposing (..)

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


amount : SelectionSet (Maybe Float) Expenses.Object.Expenses_bac_credomatic_stddev_fields
amount =
    Object.selectionForField "(Maybe Float)" "amount" [] (Decode.float |> Decode.nullable)
