open Belt
open Dom_storage2
open PasswdappSharedComponents
open RescriptRmwc.RMWC
open Promise

module OpenVaultRight = {
  @react.component
  let make = () => {
    let (state, dispatch) = Reducer.Context.use()

    let (password, setPassword) = React.useState(_ => "")

    let (errorMsg, setErrorMsg) = React.useState(_ => "")
    let (showError, setShowError) = React.useState(_ => false)

    let deriveAndDispatchVaultKey = () => {
      Wasm.passwdGenerateVaultKey(state.vaultName, password)
      ->then(key => {
        dispatch(Actions.SetVaultKey({key: key}))
        dispatch(Actions.SetLoading({loading: false}))

        RescriptReactRouter.replace("/home")

        resolve(key)
      })
      ->ignore
    }

    let openVault = () => {
      switch localStorage->getItem(Const.storageIdentifiers["vaultVerificationBytes"]) {
      | None => {
          dispatch(Actions.SetLoading({loading: false}))
          setErrorMsg(_ => "Verification bytes are missing")
          setShowError(_ => true)
        }
      | Some(vbytesString) => {
          let vbytesSplit = vbytesString->Js.String2.split(",")
          let vbytesInt = vbytesSplit->Array.map(v => v->int_of_string)
          let vbytes = vbytesInt->Js.TypedArray2.Uint8Array.make

          Wasm.passwdVerifyVaultPassword(password, vbytes)
          ->then(ans => {
            if !ans {
              dispatch(Actions.SetLoading({loading: false}))
              setErrorMsg(_ => "Entered password is not valid")
              setShowError(_ => true)
            } else {
              let _ = Js.Global.setTimeout(() => {
                deriveAndDispatchVaultKey()
              }, 500)
            }

            resolve(ans)
          })
          ->ignore
        }
      }
    }

    let checkValidity = () => {
      let passwordValid = password->String.length >= 8

      if passwordValid {
        dispatch(Actions.SetLoading({loading: true}))
        openVault()
      } else {
        setErrorMsg(_ => "Password should be greater than 8 characters")
        setShowError(_ => true)
      }
    }

    <div className="m-6 flex flex-col items-center justify-center">
      <Dialog \"open"={showError} renderToPortal={true} onClose={_ => setShowError(_ => false)}>
        <DialogTitle> {"Error"->React.string} </DialogTitle>
        <DialogContent> {errorMsg->React.string} </DialogContent>
        <DialogActions>
          <DialogButton action="close"> {"OK"->React.string} </DialogButton>
        </DialogActions>
      </Dialog>
      <TextField
        outlined={true}
        \"type"="password"
        label={"Vault Password"->React.string}
        value={password}
        onChange={e => setPassword(_ => ReactEvent.Form.target(e)["value"])}
      />
      <div className="mt-6" />
      <Button
        raised={true}
        onClick={() => {
          checkValidity()
        }}
        ripple={{surface: None, accent: Some(true), unbounded: None}}
        style={ReactDOM.Style.make(~width="100%", ~color="black", ())}>
        {"Open"->React.string}
      </Button>
    </div>
  }
}

@react.component
let make = () => {
  let (state, _) = Reducer.Context.use()

  <ResponsiveTwoColumn
    left={<div className="flex flex-col items-center md:items-end">
      <Logo fontSize="3rem" />
      <div className="flex">
        <span className="font-semibold text-xl mr-2"> {"Open"->React.string} </span>
        <span className="font-semibold text-xl" style={ReactDOM.Style.make(~color="#00ecd7", ())}>
          {state.vaultName->React.string}
        </span>
      </div>
      <div className="mt-4" />
    </div>}
    right={<Card> <OpenVaultRight /> </Card>}
  />
}
