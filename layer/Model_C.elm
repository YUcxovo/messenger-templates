module Scenes.$0.$1.Model exposing
    ( initModel
    , updateModel, updateModelRec
    , viewModel
    )

{-| Model module

@docs initModel
@docs updateModel, updateModelRec
@docs viewModel

-}

import Base exposing (ObjectTarget(..))
import Canvas exposing (Renderable)
import Lib.Component.Base exposing (ComponentMsg, ComponentTarget)
import Lib.Component.ComponentHandler exposing (updateComponents, updateComponentswithTarget, viewComponent)
import Lib.Env.Env exposing (noCommonData, addCommonData)
import Lib.Layer.Base exposing (LayerMsg, LayerTarget(..))
import Lib.Scene.Base exposing (MsgBase(..))
import Scenes.$0.$1.Common exposing (Env, Model)
import Scenes.$0.SceneInit exposing ($0Init)


{-| initModel
Add components here
-}
initModel : Env -> $0Init -> Model
initModel _ _ =
    { components = []
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
Distribute the msgs that you want to send to all components

Add your logic here.

-}
distributorComponents : Env -> Model -> ( Model, ( List ( LayerTarget, LayerMsg ), List ( ComponentTarget, ComponentMsg ) ), Env )
distributorComponents env model =
    ( model, ( [], [] ), env )

    
{-| 
Handle component messages (that are sent to this layer).

Note that the comonent messanges with SOMMsg type will be directly sent to the scene.

Add your logic here.

-}
handleComponentMsg : Env -> ComponentMsg -> Model -> ( Model, List ( LayerTarget, LayerMsg ), Env )
handleComponentMsg env msg model =
    case msg of
        SOMMsg sommsg ->
            ( model, [ ( Layer Parent, SOMMsg sommsg ) ], env )

        _ ->
            ( model, [], env )


{-| updateModel
Default update function

Basically you don't need to modify this funtion

-}
updateModel : Env -> Model -> ( Model, List ( LayerTarget, LayerMsg ), Env )
updateModel env model =
    let
        ( nm1, nlmsg1, nenv1 ) =
            updateBasic env model

        ( ncoms1, ncmsg1, nenvwoc1 ) =
            updateComponents (noCommonData nenv1) nm1.components

        nenv2 =
            addCommonData nenv1.commonData nenvwoc1

        nm2 =
            { nm1 | components = ncoms1 }

        ( nm3, ( nlmsg2, ntocmsg ), nenv3 ) =
            distributorComponents nenv2 nm2

        ( ncoms2, ncmsg2, nenvwoc2 ) =
            updateComponentswithTarget (noCommonData nenv3) ntocmsg nm3.components

        nenv4 =
            addCommonData nenv3.commonData nenvwoc2
    in
    List.foldl
        (\cTMsg ( m, cmsg, cenv ) ->
            let
                ( nm, nmsg, nenv ) =
                    handleComponentMsg cenv cTMsg m
            in
            ( nm, nmsg ++ cmsg, nenv )
        )
        ( { nm3 | components = ncoms2 }, nlmsg1 ++ nlmsg2, nenv4 )
        (ncmsg1 ++ ncmsg2)


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
    viewComponent (noCommonData env) model.components
