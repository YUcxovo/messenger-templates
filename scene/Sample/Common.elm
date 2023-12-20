module Scenes.$0.Common exposing (Model, nullModel, initModel)

{-| Common module

This module is generated by Messenger, don't modify this.

@docs Model, nullModel, initModel

-}

import Lib.Env.Env exposing (Env, addCommonData)
import Lib.Scene.Base exposing (LayerPacker, SceneInitData(..))
import Scenes.$0.LayerBase exposing (CommonData, nullCommonData)
import Scenes.$0.LayerSettings exposing (LayerT)
import Scenes.$0.SceneInit exposing (initCommonData, null$0Init)
$1


{-| Model
-}
type alias Model =
    LayerPacker CommonData LayerT


{-| nullModel
-}
nullModel : Model
nullModel =
    { commonData = nullCommonData
    , layers = []
    }


{-| Initialize the model
-}
initModel : Env () -> SceneInitData -> Model
initModel env init =
    let
        layerInitData =
            case init of
                $0InitData x ->
                    x

                _ ->
                    null$0Init
    in
    { commonData = initCommonData env layerInitData
    , layers =
        [
          $2
        ]
    }
