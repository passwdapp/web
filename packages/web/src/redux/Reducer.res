open Actions

type store = {loading: bool}

let initialState: store = {
  loading: false,
}

let reducer = (_: store, action: actionType) => {
  Js.log("Diaptch recv")

  switch action {
  | SetLoading({loading}) => {
      loading: loading,
    }
  }
}

module Context = {
  include ReactContext.Make({
    type context = (store, actionType => unit)
    let defaultValue = (initialState, _ => ())
  })
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (state, dispatch) = React.useReducer(reducer, initialState)

    <Context.Provider value=(state, dispatch)> children </Context.Provider>
  }
}
