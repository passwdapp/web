open Dom_storage2
open Promise

let reducer = (state: ReduxTypes.store, action: Actions.initializeVault) => {
  let {name, password} = action

  localStorage->setItem("vault:name", name)
  localStorage->setItem("vault:password", password)

  Wasm.passwdGenerateVerificationBytes(password)
  ->then(bytes => {
    let bytesJoined = bytes->Js.Typed_array.Uint8Array.toString
    localStorage->setItem("vault:verification_bytes", bytesJoined)

    resolve(bytes)
  })
  ->ignore

  {
    ...state,
    vault: {
      name: name,
      password: password,
    },
  }
}
