open Belt

@val external group: string => unit = "console.group"
@val external groupEnd: unit => unit = "console.groupEnd"

let logPrefix = "[Passwd] "

let info = (msg: string) => Js.log(logPrefix ++ "[INFO] " ++ msg)

module Redux = {
  // Thanks https://github.com/Zaelot-Inc/use-reducer-logger/blob/master/srhfl.js
  let getCurrentTimeFormatted = () => {
    let date = Js.Date.make()

    let hours = Float.toString(Js.Date.getHours(date))
    let minutes = Float.toString(Js.Date.getMinutes(date))
    let seconds = Float.toString(Js.Date.getSeconds(date))
    let milliseconds = Float.toString(Js.Date.getMilliseconds(date))

    `${hours}:${minutes}:${seconds}.${milliseconds}`
  }

  let buildActionType = (msg: string) => {
    Js.String2.replaceByRe(msg, %re("/{.*}/"), "")
  }

  let action = (actionMsg: string, oldState: ReduxTypes.store, newState: ReduxTypes.store) => {
    group(`Action ${buildActionType(actionMsg)} at ${getCurrentTimeFormatted()}`)

    Js.Console.log3("%cPrevious State:", "color: #f01840; font-weight: 700;", oldState)
    Js.Console.log3("%cAction:", "color: #00a7f7; font-weight: 700;", actionMsg)
    Js.Console.log3("%cNext State:", "color: #47b04b; font-weight: 700;", newState)

    groupEnd()
  }
}
