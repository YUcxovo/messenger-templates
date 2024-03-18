module Scenes.$0.$1.Common exposing
    ( Model, nullModel, Env
    )

{-| Common module

@docs Model, nullModel, Env

-}

import Lib.Component.Base exposing (Component, ComponentMsg)
import Lib.Component.ComponentHandler exposing (updateComponents)
import Lib.Env.Env as Env
import Lib.Layer.Base exposing (LayerMsg, LayerTarget)
import Scenes.$0.LayerBase exposing (CommonData)


{-| Model
Add your own data here.
-}
type alias Model =
    { components : List Component
    }


{-| nullModel
-}
nullModel : Model
nullModel =
    { components = []
    }


{-| Convenient type alias for the environment
-}
type alias Env =
    Env.Env CommonData

