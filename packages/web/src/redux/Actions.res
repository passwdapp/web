type initializeVault = {name: string, password: string}
type openVault = {name: string}
type setVaultKey = {key: Js.TypedArray2.Uint8Array.t}

type actionType =
  | SetLoading({loading: bool})
  | InitializeVault(initializeVault)
  | OpenVault(openVault)
  | SetVaultKey(setVaultKey)
  | FinishVaultSetup
