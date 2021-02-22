open Actions
open ReduxTypes

let reducer = (state: store, action: actionType) => {
  switch action {
  | SetLoading({loading}) => {
      ...state,
      loading: loading,
    }
  | InitializeVault(initVault) => VaultReducer.reducer(state, initVault)
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
