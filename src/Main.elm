module Main exposing (main)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)


textStyles : Style
textStyles =
    Css.batch
        [ color (rgb 0 0 0)
        , fontFamily Css.sansSerif
        , textAlign center
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1
            [ css
                [ textStyles
                ]
            ]
            [ text "Kanto Pokedex" ]
        , div
            [ css
                [ displayFlex
                , justifyContent spaceAround
                ]
            ]
            (List.map (viewThumbnail model.selectedPokemon) model.pokemon)
        ]


viewThumbnail : Int -> Pokemon -> Html Msg
viewThumbnail selectedPokemon pokemon =
    let
        isSelected =
            selectedPokemon == pokemon.id

        applySelected : Style -> Style -> Style
        applySelected trueStyle falseStyle =
            if isSelected then
                trueStyle

            else
                falseStyle
    in
    button
        [ onClick (SelectPokemon pokemon.id)
        , css
            [ backgroundColor (hex "#ffffff")
            , padding (rem 2)
            , boxShadow5 (px 0) (px 4) (px 6) (px -1) (rgba 0 0 0 0.06)
            , cursor pointer
            , borderWidth (px 0)
            , borderRadius (px 8)
            , applySelected (backgroundColor (hex "fceb26")) (backgroundColor (hex "f03d37"))
            , focus
                [ outlineColor (hex "eeeeee")
                ]
            ]
        ]
        [ img
            [ src pokemon.imageUrl
            , alt pokemon.name
            ]
            []
        , p
            [ css
                [ textStyles
                , applySelected (color (hex "000000")) (color (hex "ffffff"))
                , fontSize (rem 2)
                ]
            ]
            [ text pokemon.name ]
        ]


main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view >> toUnstyled
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectPokemon id ->
            { model | selectedPokemon = id }


type Msg
    = SelectPokemon Int


type alias Pokemon =
    { id : Int
    , imageUrl : String
    , name : String
    }


type alias Model =
    { pokemon : List Pokemon
    , selectedPokemon : Int
    }


initialModel : Model
initialModel =
    { pokemon =
        [ { id = 1, imageUrl = "https://cdn.bulbagarden.net/upload/thumb/2/21/001Bulbasaur.png/250px-001Bulbasaur.png", name = "Bulbasaur" }
        , { id = 2, imageUrl = "https://cdn.bulbagarden.net/upload/thumb/7/73/004Charmander.png/250px-004Charmander.png", name = "Charmander" }
        , { id = 3, imageUrl = "https://cdn.bulbagarden.net/upload/thumb/3/39/007Squirtle.png/250px-007Squirtle.png", name = "Squirtle" }
        ]
    , selectedPokemon = 1
    }
