type store = {
  loading: bool,
  vaultName: string,
  vaultKey: Js.TypedArray2.Uint8Array.t,
}

let initialState: store = {
  loading: false,
  vaultName: "",
  vaultKey: Js.TypedArray2.Uint8Array.make([]),
}
