-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Expenses.ScalarCodecs exposing (..)

import Expenses.Scalar exposing (defaultCodecs)
import Json.Decode as Decode exposing (Decoder)


type alias Date =
    Expenses.Scalar.Date


type alias Numeric =
    Expenses.Scalar.Numeric


type alias Uuid =
    Expenses.Scalar.Uuid


codecs : Expenses.Scalar.Codecs Date Numeric Uuid
codecs =
    Expenses.Scalar.defineCodecs
        { codecDate = defaultCodecs.codecDate
        , codecNumeric = defaultCodecs.codecNumeric
        , codecUuid = defaultCodecs.codecUuid
        }
