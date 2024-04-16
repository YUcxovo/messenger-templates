module SceneProtos.$0.GameComponents.$1.Export exposing (initGC)

import Lib.Env.Env exposing (Env)
import SceneProtos.$0.GameComponent.Base exposing (GameComponentInitData(..), DatawithID, GameComponentMsg, GameComponentTarget, addID)
import SceneProtos.$0.GameComponents.GameComponentSettings exposing (GameComponentT, GameComponentType(..), $1Data, null$1Data)
import SceneProtos.$0.GameComponents.$1.Model exposing (initModel, updateModel, updateModelRec, viewModel)
import SceneProtos.$0.LayerBase exposing (CommonData)


{-| datatoCT
-}
datatoCT : $1Data -> GameComponentType
datatoCT dt =
    GC$1Data dt


{-| cttoData
-}
cttoData : GameComponentType -> $1Data
cttoData ct =
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
                    updateModel env <| cttoData dtid.otherdata
            in
            ( addID dtid.uid <| datatoGCT rldt, newmsg, newenv )

        updrec : Env CommonData -> GameComponentMsg -> DatawithID GameComponentType -> ( DatawithID GameComponentType, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
        updrec env cm dtid =
            let
                ( rldt, newmsg, newenv ) =
                    updateModelRec env cm <| cttoData dtid.otherdata
            in
            ( addID dtid.uid <| datatoGCT rldt, newmsg, newenv )

        v : Env CommonData -> DatawithID GameComponentType -> List ( Renderable, Int )
        v env dtid =
            viewModel env <| cttoData dtid.otherdata
    in
    { name = "$1"
    , data = dt
    , update = upd
    , updaterec = updrec
    , view = v
    }
