type initializeVault = {name: string, password: string}

type actionType =
  | SetLoading({loading: bool})
  | InitializeVault(initializeVault)
  | FinishVaultSetup
