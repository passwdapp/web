open Const
open Dom_storage2
open Promise

let initializeVaultReducer = (state: ReduxTypes.store, action: Actions.initializeVault) => {
  let {name, password} = action

  localStorage->setItem(storageIdentifiers["vaultName"], name)

  Wasm.passwdGenerateVerificationBytes(password)
  ->then(bytes => {
    let bytesJoined = bytes->Js.Typed_array.Uint8Array.toString
    localStorage->setItem(storageIdentifiers["vaultVerificationBytes"], bytesJoined)

    resolve(bytes)
  })
  ->ignore

  let newState = {
    ...state,
    vaultName: name,
  }

  Logger.Redux.action(
    `InitializeVault({name: "${name}", password: "${password}"})`,
    state,
    newState,
  )

  RescriptReactRouter.replace("/unlock-vault")

  newState
}

let finishSetupReducer = (state: ReduxTypes.store) => {
  localStorage->setItem(storageIdentifiers["setupDone"], true->string_of_bool)

  Logger.Redux.action("FinishSetup()", state, state)

  state
}

let openVaultReducer = (state: ReduxTypes.store, action: Actions.openVault) => {
  let {name} = action

  let newState = {
    ...state,
    vaultName: name,
  }

  Logger.Redux.action(`OpenVault({name: "${name}"})`, state, newState)

  newState
}

let setVaultKeyReducer = (state: ReduxTypes.store, action: Actions.setVaultKey) => {
  let {key} = action

  let newState = {
    ...state,
    vaultKey: key,
  }

  Logger.Redux.action(
    `SetVaultKey({key: "${key->Js.TypedArray2.Uint8Array.toString}"})`,
    state,
    newState,
  )

  newState
}
