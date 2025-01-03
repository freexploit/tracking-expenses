module Tailwind.Breakpoints exposing (..)

import Css
import Css.Media


lg : List Css.Style -> Css.Style
lg =
    Css.Media.withMediaQuery [ "(min-width: 1024px)" ]


md : List Css.Style -> Css.Style
md =
    Css.Media.withMediaQuery [ "(min-width: 768px)" ]


sm : List Css.Style -> Css.Style
sm =
    Css.Media.withMediaQuery [ "(min-width: 640px)" ]


xl : List Css.Style -> Css.Style
xl =
    Css.Media.withMediaQuery [ "(min-width: 1280px)" ]


xsm : List Css.Style -> Css.Style
xsm =
    Css.Media.withMediaQuery [ "(min-width: 425px)" ]


xxl : List Css.Style -> Css.Style
xxl =
    Css.Media.withMediaQuery [ "(min-width: 1536px)" ]


xxsm : List Css.Style -> Css.Style
xxsm =
    Css.Media.withMediaQuery [ "(min-width: 375px)" ]


xxxl : List Css.Style -> Css.Style
xxxl =
    Css.Media.withMediaQuery [ "(min-width: 2000px)" ]
