module SceneProtos.$0.GameComponents.$1.Model exposing (initModel, updateModel, updateModelRec, viewModel)

{-|


# Model for this GameComponent

@docs initModel, updateModel, updateModelRec, viewModel

-}
import Canvas exposing (Renderable)
import Lib.Env.Env exposing (Env)
import SceneProtos.$0.GameComponent.Base exposing (GameComponentInitData(..), GameComponentMsg, GameComponentTarget(..))
import SceneProtos.$0.GameComponents.GameComponentSettings exposing ($1Data, null$1Data)
import SceneProtos.$0.LayerBase exposing (CommonData)


{-| Data
-}
type alias Data =
    $1Data


{-| NullData
-}
nullData : Data
nullData =
    null$1Data


{-| initModel

Initialize the model. It should update the id.

-}
initModel : Env () -> GameComponentInitData -> Data
initModel _ initData =
    case initData of
        GC$1InitData _ ->
            -- Change this to initialize your GC
            nullData

        _ ->
            nullData


{-| updateModel

Add your component logic here.

-}
updateModel : Env CommonData -> Data -> ( Data, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
updateModel env d =
    ( d, [], env )


{-| updateModelRec

Add your component logic here.

-}
updateModelRec : Env CommonData -> GameComponentMsg -> Data -> ( Data, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
updateModelRec env _ d =
    ( d, [], env )


{-| viewModel

Change this to your own component view function.

-}
viewModel : Env CommonData -> Data -> List ( Renderable, Int )
viewModel _ _ =
    []
