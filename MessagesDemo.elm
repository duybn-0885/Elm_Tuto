import Html exposing (..)
import Html.Events exposing(onClick)

model = 0

view model =
    h1[]
    [
        div[] [text "Counter App"],
        button[onClick Subtract] [text "-"],
        div[] [text (toString model)],
        button[onClick Add] [text "+"]
    ]

type Message = Add | Subtract

update msg model =
    case msg of
        Add -> model + 1
        Subtract -> model - 1

main =
    beginnerProgram
   {
      model=model
      ,view=view
      ,update=update
   }
