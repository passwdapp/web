open PasswdappSharedComponents
open RescriptRmwc.RMWC

module VaultNamePasswordComponent = {
  @react.component
  let make = (~nextPage: unit => unit) => {
    let (_, dispatch) = Reducer.Context.use()

    let (name, setName) = React.useState(_ => "")
    let (password, setPassword) = React.useState(_ => "")

    let (errorMsg, setErrorMsg) = React.useState(_ => "")
    let (showError, setShowError) = React.useState(_ => false)

    let checkValidity = () => {
      let nameValid = name->String.length >= 4
      let passwordValid = password->String.length >= 8

      if !nameValid {
        setErrorMsg(_ => "Name should be greater than 4 characters")
      } else if !passwordValid {
        setErrorMsg(_ => "Password should be greater than 8 characters")
      }

      let valid = nameValid && passwordValid
      setShowError(_ => !valid)

      valid
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
        label={"Vault Name"->React.string}
        value={name}
        onChange={event => {
          setName(_ => ReactEvent.Form.target(event)["value"])
        }}
      />
      <div className="mt-4" />
      <TextField
        outlined={true}
        \"type"="password"
        label={"Vault Password"->React.string}
        value={password}
        onChange={e => {
          setPassword(_ => ReactEvent.Form.target(e)["value"])
        }}
      />
      <div className="mt-6" />
      <Button
        raised={true}
        onClick={() => {
          if checkValidity() {
            dispatch(Actions.InitializeVault({name: name, password: password}))
            nextPage()
          }
        }}
        ripple={{surface: None, accent: Some(true), unbounded: None}}
        style={ReactDOM.Style.make(~width="100%", ~color="black", ())}>
        {"Next"->React.string}
      </Button>
    </div>
  }
}

module VaultRestoreStartFresh = {
  @react.component
  let make = () => {
    let (_, dispatch) = Reducer.Context.use()

    <div className="m-6 flex flex-col items-center justify-center">
      <TextField
        outlined={true}
        label={"Paste text backup"->React.string}
        trailingIcon={<IconButton icon="chevron_right" />}
      />
      <div className="mt-2" />
      <Typography use="subtitle2" tag="span"> {"OR"->React.string} </Typography>
      <div className="mt-2" />
      <Button
        outlined={true}
        style={ReactDOM.Style.make(~width="100%", ~color="black", ())}
        onClick={() => {
          dispatch(Actions.FinishVaultSetup)
        }}>
        {"Start Fresh"->React.string}
      </Button>
    </div>
  }
}

@react.component
let make = () => {
  let (onPassword, setOnPassword) = React.useState(_ => true)

  <div className="flex flex-col md:flex-row w-full h-full items-center justify-center">
    <div className="flex flex-col items-center md:items-end">
      <Logo fontSize="3rem" />
      <span className="font-semibold text-xl"> {"New Vault"->React.string} </span>
      <div className="mt-4" />
    </div>
    <div className="w-0 h-4 md:h-0 md:w-16" />
    <Card>
      {onPassword
        ? <VaultNamePasswordComponent nextPage={() => setOnPassword(_ => false)} />
        : <VaultRestoreStartFresh />}
    </Card>
  </div>
}
