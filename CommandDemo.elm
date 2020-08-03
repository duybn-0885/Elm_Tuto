import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http

main =
    Html.program
        {
            init = init,
            view = view,
            update = update,
            subscriptions = subscriptions
        }

type alias Model =
    {
        heading: String,
        factText: String,
        input: String
    }

init : (Model, Cmd Msg)
init =
    (
        Model "NumbersAPI" "NoFacts" "42",
        Cmd.none
    )

type Msg =
    ShowFacts
    | Input String
    | NewFactArrived (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Input newInput -> (Model "NumberApi typing" "" newInput, Cmd.none)
        ShowFacts -> (model, getRandomNumberFromAPI model.input)
        NewFactArrived (Ok newFact) -> (Model "DataArrived" newFact "", Cmd.none)
        NewFactArrived (Err _) -> (model, Cmd.none)

view : Model -> Html Msg
view model =
   div []
        [ h2 [] [text model.heading]
        ,input [onInput Input, value model.input] []
        , button [ onClick ShowFacts ] [ text "show facts" ]
        , br [] []
        , h3 [][text model.factText]
        ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

getRandomNumberFromAPI : String->Cmd Msg
getRandomNumberFromAPI newNo =
    let
        url =
        "http://numbersapi.com/"++newNo
    in
        Http.send NewFactArrived (Http.getString url)
