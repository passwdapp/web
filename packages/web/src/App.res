open Dom_storage2
open RescriptRmwc.RMWC

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (_, dispatch) = Reducer.Context.use()

  let checkVaultStatus = () => {
    switch localStorage->getItem(Const.storageIdentifiers["setupDone"]) {
    | None => false
    | Some(doneString) =>
      switch doneString->bool_of_string_opt {
      | None => false
      | Some(v) =>
        switch localStorage->getItem(Const.storageIdentifiers["vaultName"]) {
        | None => false
        | Some(name) => {
            dispatch(Actions.OpenVault({name: name}))
            v
          }
        }
      }
    }
  }

  React.useEffect1(() => {
    dispatch(Actions.SetLoading({loading: true}))

    Wasm.initializeWasm(() => {
      dispatch(Actions.SetLoading({loading: false}))

      let path = if checkVaultStatus() {
        "/unlock-vault"
      } else {
        "/new-vault"
      }
      RescriptReactRouter.replace(path)
    })

    Some(() => ())
  }, [])

  let component = switch url.path {
  | list{"new-vault"} => <NewVault />
  | list{"unlock-vault"} => <OpenVault />
  | _ => <div> {"Not Found"->React.string} </div>
  }

  <> <Portal /> <LoadingDialog /> component </>
}
