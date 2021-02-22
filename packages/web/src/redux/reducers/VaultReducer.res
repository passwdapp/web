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
    vault: {
      name: name,
      password: password,
    },
  }

  Logger.Redux.action(
    `InitializeVault({name: "${name}", password: "${password}"})`,
    state,
    newState,
  )

  newState
}

let finishSetupReducer = (state: ReduxTypes.store) => {
  localStorage->setItem(storageIdentifiers["setupDone"], true->string_of_bool)

  Logger.Redux.action("FinishSetup()", state, state)

  state
}
