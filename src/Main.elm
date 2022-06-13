module Main exposing (..)

import Browser
import Dict exposing (..)
import Html exposing (Html, br, button, div, li, text, ul)
import Html.Events exposing (onClick)
import Json.Encode as E
import Maybe exposing (..)
import Ports exposing (..)



-- Types


type Msg k v
    = Increment
    | Decrement
    | ClearMessages
    | InvokeFunction String (Dict k v)
    | GetMessage String


type alias Model =
    { value : Int, messages : List String }


type alias Flags =
    { initialValue : Int }


type alias Document msg =
    { title : String, body : List (Html msg) }



-- Functions


toArgs : List ( String, String ) -> E.Value
toArgs list =
    let
        args =
            List.map
                (\item ->
                    ( Tuple.first item
                    , E.string (Tuple.second item)
                    )
                )
                list
    in
    E.object <| args


update : Msg String String -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment ->
            ( { model
                | value = model.value + 1
                , messages = model.messages
              }
            , Cmd.none
            )

        Decrement ->
            ( { model
                | value = model.value - 1
                , messages = model.messages
              }
            , Cmd.none
            )

        InvokeFunction functionName functionArgs ->
            ( model
            , invokeFunction
                { name = functionName
                , args = toArgs (Dict.toList functionArgs)
                }
            )

        ClearMessages ->
            ( { model
                | value = model.value
                , messages = []
              }
            , Cmd.none
            )

        GetMessage str ->
            ( { model
                | value = model.value
                , messages = model.messages ++ [ str ]
              }
            , Cmd.none
            )


subscriptions : Model -> Sub (Msg k v)
subscriptions _ =
    addMessage GetMessage


init : Flags -> ( Model, Cmd msg )
init flags =
    ( { value = flags.initialValue, messages = [] }, Cmd.none )


view : Model -> Document (Msg k v)
view model =
    { title = ""
    , body =
        [ div []
            [ div []
                [ button [ onClick Increment ] [ text "+" ]
                , text (String.fromInt model.value)
                , button [ onClick Decrement ] [ text "-" ]
                ]
            , br [] []
            , button
                [ onClick (InvokeFunction "info" Dict.empty) ]
                [ text "Get info from Rust" ]
            , button
                [ onClick ClearMessages ]
                [ text "Clear messages" ]
            , br [] []
            , div
                []
                (List.map (\message -> ul [] [ li [] [ text message ] ]) model.messages)
            ]
        ]
    }


main : Program Flags Model (Msg String String)
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
