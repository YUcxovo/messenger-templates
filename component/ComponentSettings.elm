module Components.ComponentSettings exposing
    ( ComponentType(..)
    , ComponentT
    $0
    )

{-| This module stores the data type of all the components, modify the data type of components here.

@docs ComponentType
@docs ComponentT
$1

-}

import Lib.Component.Base exposing (Component)


{-| Defined Types for Component
-}
type ComponentType
    = $2
    | NullComponentData


type alias ComponentT =
    Component ComponentType



--- ConsoleData ---


type alias ConsoleData =
    {}


nullConsoleData : ConsoleData
nullConsoleData =
    {}
