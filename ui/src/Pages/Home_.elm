module Pages.Home_ exposing (view)

import Array
import GraphQLClient exposing (makeGraphQLQuery)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import TrackingExpenses.Enum.Order_by exposing (Order_by(..))
import TrackingExpenses.InputObject
    exposing
        ( Expenses_bac_credomatic_bool_exp
        , Expenses_bac_credomatic_order_by
        , buildExpenses_bac_credomatic_bool_exp
        , buildExpenses_bac_credomatic_order_by
        )   
import TrackingExpenses.Object
import TrackingExpenses.Object.Expenses_bac_credomatic as Expenses
import TrackingExpenses.Query as Query exposing (ExpensesBacCredomaticOptionalArguments)




import Element exposing(..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import View exposing (View)
import TrackingExpenses.Scalar
import TrackingExpenses.Enum.Expenses_bac_credomatic_select_column exposing (Expenses_bac_credomatic_select_column(..))



orderByAmount : Order_by -> OptionalArgument (List Expenses_bac_credomatic_order_by)
orderByAmount order =
    Present <| [ buildExpenses_bac_credomatic_order_by (\args -> { args | amount = OptionalArgument.Present order }) ]

orderByDate : Order_by -> OptionalArgument (List Expenses_bac_credomatic_order_by)
orderByDate order =
    Present <| [ buildExpenses_bac_credomatic_order_by (\args -> { args | date = OptionalArgument.Present order }) ]


expensesListOptionalArgument: ExpensesBacCredomaticOptionalArguments -> ExpensesBacCredomaticOptionalArguments
expensesListOptionalArgument optionalArgs =
    {optionalArgs | order_by = orderByDate Desc }


type alias Gasto =
    { amount: TrackingExpenses.Scalar.Float8
    , currency: String
    , commerce: String
    }


selectExpense: SelectionSet Gasto TrackingExpenses.Object.Expenses_bac_credomatic
selectExpense =
    SelectionSet.map3 Gasto
        Expenses.amount
        Expenses.commerce
        Expenses.currency


fetchQuery: SelectionSet (List Gasto) RootQuery
fetchQuery =
    Query.expenses_bac_credomatic expensesListOptionalArgument selectExpense


header : Element msg
header =
    row [ width fill, padding 20, spacing 20 ]
        [ el [ alignRight ] <| text "Services"
        , el [ alignRight ] <| text "About"
        , el [ alignRight ] <| text "Contact"
        ]


content : Element msg
content =
    List.range 2 16
        |> List.map
            (\i ->
                el [ centerX, Font.size 64, Font.color <| rgb255 (i * 20) (i * 20) (i * 20) ] <|
                    text "Scrollable site content"
            )
        |> column [ width fill, padding 50 ]


footer : Element msg
footer =
    row
        [ width fill
        , padding 10
        , Background.color color.lightBlue
        , Border.widthEach { top = 1, bottom = 0, left = 0, right = 0 }
        , Border.color color.blue
        ]
        [ logo
        , column [ alignRight, spacing 10 ]
            [ el [ alignRight ] <| text "Services"
            , el [ alignRight ] <| text "About"
            , el [ alignRight ] <| text "Contact"
            ]
        ]


logo : Element msg
logo =
    el
        [ width <| px 80
        , height <| px 40
        , Border.width 2
        , Border.rounded 6
        , Border.color color.blue
        ]
        none


color : { blue : Color, darkCharcoal : Color, lightBlue : Color, lightGrey : Color, white : Color }
color =
    { blue = rgb255 0x72 0x9F 0xCF
    , darkCharcoal = rgb255 0x2E 0x34 0x36
    , lightBlue = rgb255 0xC5 0xE8 0xF7
    , lightGrey = rgb255 0xE0 0xE0 0xE0
    , white = rgb255 0xFF 0xFF 0xFF
    }
    



view : View msg
view =
    { title = "Homepage"
    , element = column [ width fill ]
            [ header
            , content
            , footer
            ]
    }

