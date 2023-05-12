module Scenes.SceneSettings exposing
    ( SceneDataTypes(..)
    , SceneT
    , nullSceneT
    )

{-| This module is generated by Messenger, don't modify this.

@docs SceneDataTypes
@docs SceneT
@docs nullSceneT

-}

import Canvas exposing (empty)
import Lib.Scene.Base exposing (Scene)
$0



--- Set Scenes


{-| SceneDataTypes

All the scene data types should be listed here.

-}
type SceneDataTypes
    = $1
    | NullSceneData


{-| SceneT

SceneT is a Scene with datatypes.

-}
type alias SceneT =
    Scene SceneDataTypes


{-| nullSceneT
-}
nullSceneT : SceneT
nullSceneT =
    { init = \_ _ -> NullSceneData
    , update = \env m -> ( m, [], env )
    , view = \_ _ -> empty
    }
