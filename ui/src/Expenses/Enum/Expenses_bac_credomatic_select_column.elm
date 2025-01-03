-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Expenses.Enum.Expenses_bac_credomatic_select_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| select columns of table "expenses\_bac\_credomatic"

  - Amount - column name
  - Card\_number - column name
  - Card\_type - column name
  - Commerce - column name
  - Currency - column name
  - Date - column name
  - Id - column name
  - Location - column name

-}
type Expenses_bac_credomatic_select_column
    = Amount
    | Card_number
    | Card_type
    | Commerce
    | Currency
    | Date
    | Id
    | Location


list : List Expenses_bac_credomatic_select_column
list =
    [ Amount, Card_number, Card_type, Commerce, Currency, Date, Id, Location ]


decoder : Decoder Expenses_bac_credomatic_select_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "amount" ->
                        Decode.succeed Amount

                    "card_number" ->
                        Decode.succeed Card_number

                    "card_type" ->
                        Decode.succeed Card_type

                    "commerce" ->
                        Decode.succeed Commerce

                    "currency" ->
                        Decode.succeed Currency

                    "date" ->
                        Decode.succeed Date

                    "id" ->
                        Decode.succeed Id

                    "location" ->
                        Decode.succeed Location

                    _ ->
                        Decode.fail ("Invalid Expenses_bac_credomatic_select_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representing the Enum to a string that the GraphQL server will recognize.
-}
toString : Expenses_bac_credomatic_select_column -> String
toString enum____ =
    case enum____ of
        Amount ->
            "amount"

        Card_number ->
            "card_number"

        Card_type ->
            "card_type"

        Commerce ->
            "commerce"

        Currency ->
            "currency"

        Date ->
            "date"

        Id ->
            "id"

        Location ->
            "location"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Expenses_bac_credomatic_select_column
fromString enumString____ =
    case enumString____ of
        "amount" ->
            Just Amount

        "card_number" ->
            Just Card_number

        "card_type" ->
            Just Card_type

        "commerce" ->
            Just Commerce

        "currency" ->
            Just Currency

        "date" ->
            Just Date

        "id" ->
            Just Id

        "location" ->
            Just Location

        _ ->
            Nothing
