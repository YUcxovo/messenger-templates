module SceneProtos.$0.GameComponent.Handler exposing
    ( update, updaterec, match, super, recBody
    , updateGC, updateGCwithTarget
    , viewGC
    )

{-| Handler to update game components

@docs update, updaterec, match, super, recBody
@docs updateGC, updateGCwithTarget
@docs viewGC

-}

import Base exposing (ObjectTarget(..))
import Canvas exposing (Renderable, group)
import Lib.Env.Env exposing (Env, cleanEnv, patchEnv)
import Messenger.GeneralModel exposing (viewModelList)
import Messenger.Recursion exposing (RecBody)
import Messenger.RecursionList exposing (updateObjects, updateObjectsWithTarget)
import SceneProtos.$0.GameComponent.Base exposing (GameComponent, GameComponentMsg(..), GameComponentTarget(..))
import SceneProtos.$0.LayerBase exposing (CommonData)


{-| RecUpdater
-}
updaterec : GameComponent a -> Env CommonData -> GameComponentMsg -> ( GameComponent a, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
updaterec gc env msg =
    let
        ( newGC, newMsg, newEnv ) =
            gc.updaterec env msg gc.data
    in
    ( { gc | data = newGC }, newMsg, newEnv )


{-| Updater
-}
update : GameComponent a -> Env CommonData -> ( GameComponent a, List ( GameComponentTarget, GameComponentMsg ), Env CommonData )
update gc env =
    let
        ( newGC, newMsg, newEnv ) =
            gc.update env gc.data
    in
    ( { gc | data = newGC }, newMsg, newEnv )


{-| Matcher
-}
match : GameComponent a -> GameComponentTarget -> Bool
match gc tar =
    case tar of
        GameComponent Parent ->
            False

        GameComponent (ID x) ->
            x == gc.data.uid

        GameComponent (Name x) ->
            x == gc.name


{-| Super
-}
super : GameComponentTarget -> Bool
super tar =
    case tar of
        GameComponent Parent ->
            True

        GameComponent _ ->
            False


{-| Rec body for the component
-}
recBody : RecBody (GameComponent a) GameComponentMsg (Env CommonData) GameComponentTarget
recBody =
    { update = update
    , updaterec = updaterec
    , match = match
    , super = super
    , clean = cleanEnv
    , patch = patchEnv
    }


{-| Update all the gamecomponents in an array and recursively update the gamecomponents which have messenges sent.

Return a list of messages sent to the parentlayer.

-}
updateGC : Env CommonData -> List (GameComponent a) -> ( List (GameComponent a), List GameComponentMsg, Env CommonData )
updateGC env xs =
    updateObjects recBody env


{-| Update all the gamecomponents in a list with some tuples of target and msg, then recursively update the gamecomponents which have messenges sent.

Return a list of messages sent to the parentlayer.

-}
updateGCwithTarget : Env CommonData -> List ( GameComponentTarget, GameComponentMsg ) -> List (GameComponent a) -> ( List (GameComponent a), List GameComponentMsg, Env CommonData )
updateGCwithTarget env msg =
    updateObjectsWithTarget recBody env msg


{-| Generate the view of the components
-}
viewGC : Env CommonData -> List (GameComponent a) -> Renderable
viewGC env xs =
    group [] <|
        List.map (\( a, _ ) -> a) <|
            List.sortBy (\( _, a ) -> a) <|
                List.concat <|
                    viewModelList env xs
