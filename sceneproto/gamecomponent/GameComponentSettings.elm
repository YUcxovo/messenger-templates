module SceneProtos.$0.GameComponents.GameComponentSettings exposing
    ( GameComponentType(..)
    , GameComponentT
    )

{-| This module stores the data type of all the gamecomponents in this scene,
modify the data type of gamecomponents here.

@docs GameComponentType
@docs GameComponentT

-}

import SceneProtos.$0.GameComponent.Base exposing (GameComponent)


type GameComponentType
    = NullGameComponentData


type alias GameComponentT =
    GameComponent GameComponentType
