module SceneProtos.$0.GameComponents.$1.Export exposing (initGC)

{-| GameComponent Export

Write a description here for how to use your gamecomponent.

@docs initGC

-}

import Canvas exposing (Renderable)
import Lib.Env.Env exposing (Env)
import SceneProtos.$0.GameComponent.Base exposing (GameComponentInitData(..), DatawithID, GameComponentMsg, GameComponentTarget, addID)
import SceneProtos.$0.GameComponents.GameComponentSettings exposing (GameComponentT, GameComponentType(..), $1Data, null$1Data)
import SceneProtos.$0.GameComponents.$1.Model exposing (initModel, updateModel, updateModelRec, viewModel)
import SceneProtos.$0.LayerBase exposing (CommonData)


{-| datatoGCT
-}
datatoGCT : $1Data -> GameComponentType
datatoGCT dt =
    GC$1Data dt


{-| gcttoData
-}
gcttoData : GameComponentType -> $1Data
gcttoData ct =
    case ct of
        GC$1Data x ->
            x

        _ ->
            null$1Data


initGC : Env () -> GameComponentInitData -> GameComponentT
initGC e i =
    let
        ( id, ni ) =
            case i of
                GCIdData n ii ->
                    ( n, ii )

                _ ->
                    ( 0, i )

        dt =
            addID id <| datatoGCT <| initModel e ni

        upd : Env CommonData -> DatawithID GameComponentType -> ( DatawithID GameComponentType, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
        upd env dtid =
            let
                ( rldt, newmsg, newenv ) =
                    updateModel env <| gcttoData dtid.otherdata
            in
            ( addID dtid.uid <| datatoGCT rldt, newmsg, newenv )

        updrec : Env CommonData -> GameComponentMsg -> DatawithID GameComponentType -> ( DatawithID GameComponentType, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
        updrec env cm dtid =
            let
                ( rldt, newmsg, newenv ) =
                    updateModelRec env cm <| gcttoData dtid.otherdata
            in
            ( addID dtid.uid <| datatoGCT rldt, newmsg, newenv )

        v : Env CommonData -> DatawithID GameComponentType -> List ( Renderable, Int )
        v env dtid =
            viewModel env <| gcttoData dtid.otherdata
    in
    { name = "$1"
    , data = dt
    , update = upd
    , updaterec = updrec
    , view = v
    }
