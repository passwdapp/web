open Promise

@module("./wasm.js") external wasmInit: unit => Promise.t<unit> = "InitWasm"

let initializeWasm = (callback: unit => unit) => {
  wasmInit()
  ->then(() => {
    Js.log("[Passwd] Wasm Initialized")
    callback()
    resolve()
  })
  ->ignore
}

@val
external passwdGenerateVaultKey: (string, string) => Promise.t<Js.Typed_array.Uint8Array.t> =
  "passwdGenerateVaultKey"

@val
external passwdGenerateKey: (
  Js.Typed_array.Uint8Array.t,
  string,
  int,
  int,
  int,
) => Promise.t<string> = "passwdGenerateKey"

@val
external passwdGenerateVerificationBytes: string => Promise.t<Js.Typed_array.Uint8Array.t> =
  "passwdGenerateVerificationBytes"

@val
external passwdVerifyVaultPassword: (string, Js.Typed_array.Uint8Array.t) => Promise.t<bool> =
  "passwdVerifyVaultPassword"
