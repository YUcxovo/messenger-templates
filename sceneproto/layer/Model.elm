module SceneProtos.$0.$1.Model exposing
    ( initModel
    , updateModel, updateModelRec
    , viewModel
    )

{-| Model module

@docs initModel
@docs updateModel, updateModelRec
@docs viewModel

-}

import Canvas exposing (Renderable, empty)
import Lib.Layer.Base exposing (LayerMsg, LayerTarget(..))
import SceneProtos.$0.GameComponent.Base exposing (GameComponentMsg, GameComponentTarget)
import SceneProtos.$0.GameComponent.Handler exposing (updateGC, updateGCwithTarget, viewGC)
import SceneProtos.$0.$1.Common exposing (Env, Model)
import SceneProtos.$0.SceneInit exposing ($0Init)


{-| initModel
Add components here
-}
initModel : Env -> $0Init -> Model
initModel _ _ =
    { gamecomponents = [] 
    }


{-| 
Update the layer itself.

Deal with the normal msgs by using env.msg

Add your logic here.

-}
updateBasic : Env -> Model -> ( Model, List ( LayerTarget, LayerMsg ), Env )
updateBasic env model =
    ( model, [], env )


{-| 
Distribute the msgs that you want to send to all gamecomponents

Add your logic here.

-}
distributorGC : Env -> Model -> ( Model, ( List ( LayerTarget, LayerMsg ), List ( GameComponentTarget, GameComponentMsg ) ), Env )
distributorGC env model =
    ( model, ( [], [] ), env )


{-| 
Handle gamecomponent messages (that are sent to this layer).

Add your logic here.

-}
handleGCMsg : Env -> GameComponentMsg -> Model -> ( Model, List ( LayerTarget, LayerMsg ), Env )
handleGCMsg env msg model =
    ( model, [], env )


{-| updateModel
Default update function

Add your logic to handle Msg here

-}
updateModel : Env -> Model -> ( Model, List ( LayerTarget, LayerMsg ), Env )
updateModel env model =
    let
        ( nm1, nlmsg1, nenv1 ) =
            updateBasic env model

        ( ngcs1, ngcmsg1, nenv2 ) =
            updateGC nenv1 nm1.gamecomponents

        nm2 =
            { nm1 | gamecomponents = ngcs1 }

        ( nm3, ( nlmsg2, ntogcmsg ), nenv3 ) =
            distributorGC nenv2 nm2

        ( ngcs2, ngcmsg2, nenv4 ) =
            updateGCwithTarget nenv3 ntogcmsg nm3.gamecomponents
    in
    List.foldl
        (\cTMsg ( m, cmsg, cenv ) ->
            let
                ( nm, nmsg, nenv ) =
                    handleGCMsg cenv cTMsg m
            in
            ( nm, nmsg ++ cmsg, nenv )
        )
        ( { nm3 | gamecomponents = ngcs2 }, nlmsg1 ++ nlmsg2, nenv4 )
        (ngcmsg1 ++ ngcmsg2)



{-| updateModelRec
Default update function

Add your logic to handle LayerMsg here

-}
updateModelRec : Env -> LayerMsg -> Model -> ( Model, List ( LayerTarget, LayerMsg ), Env )
updateModelRec env _ model =
    ( model, [], env )


{-| viewModel
Default view function

If you don't have components, remove viewComponent.

If you have other elements than components, add them after viewComponent.

-}
viewModel : Env -> Model -> Renderable
viewModel env model =
    viewGC env model.gamecomponents

