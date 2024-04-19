module Scenes.$0.$1.Common exposing
    ( Model, nullModel, Env
    )

{-| Common module

@docs Model, nullModel, Env

-}

import Components.ComponentSettings exposing (ComponentT)
import Lib.Env.Env as Env
import Scenes.$0.LayerBase exposing (CommonData)


{-| Model
Add your own data here.
-}
type alias Model =
    { components : List ComponentT
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

