module Components.ComponentSettings exposing
    ( ComponentType(..)
    , ComponentT
    )

{-| This module stores the data type of all the components, modify the data type of components here.

@docs ComponentType
@docs ComponentT

-}

import Lib.Component.Base exposing (Component)


{-| Defined Types for Component
-}
type ComponentType
    = NullComponentData


type alias ComponentT =
    Component ComponentType

