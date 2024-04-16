module SceneProtos.CoreEngine.GameComponents.GameComponentSettings exposing
    ( GameComponentType(..)
    , GameComponentT
    $0
    )

{-| This module stores the data type of all the gamecomponents in this scene,
modify the data type of gamecomponents here.

@docs GameComponentType
@docs GameComponentT
$1

-}

import SceneProtos.CoreEngine.GameComponent.Base exposing (GameComponent)


type GameComponentType
    = $2
    | NullGameComponentData


type alias GameComponentT =
    GameComponent GameComponentType



--- ManData ---


type alias ManData =
    { alive : Bool}


nullManData : ManData
nullManData =
    { alive = True}