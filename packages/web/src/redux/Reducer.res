open Actions
open ReduxTypes

let reducer = (state: store, action: actionType) => {
  switch action {
  | SetLoading({loading}) => {
      let newState = {
        ...state,
        loading: loading,
      }

      Logger.Redux.action(`SetLoading({loading: ${loading->string_of_bool}})`, state, newState)

      newState
    }
  | InitializeVault(initVault) => VaultReducer.initializeVaultReducer(state, initVault)
  | FinishVaultSetup => VaultReducer.finishSetupReducer(state)
  | OpenVault(openVault) => VaultReducer.openVaultReducer(state, openVault)
  | SetVaultKey(setVaultKey) => VaultReducer.setVaultKeyReducer(state, setVaultKey)
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
