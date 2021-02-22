open PasswdappSharedComponents
open RescriptRmwc.RMWC

module VaultNamePasswordComponent = {
  @react.component
  let make = (~nextPage: unit => unit) => {
    let (_, dispatch) = Reducer.Context.use()

    <div className="m-6 flex flex-col items-center justify-center">
      <TextField outlined={true} label={"Vault Name"->React.string} invalid={false} />
      <div className="mt-4" />
      <TextField
        outlined={true} \"type"="password" invalid={false} label={"Vault Password"->React.string}
      />
      <div className="mt-6" />
      <Button
        raised={true}
        onClick={() => {
          dispatch(Actions.SetLoading({loading: true}))
          // setLoading(_ => true)
          nextPage()
        }}
        style={ReactDOM.Style.make(~width="100%", ~color="black", ())}>
        {"Next"->React.string}
      </Button>
    </div>
  }
}

module VaultRestoreStartFresh = {
  @react.component
  let make = () => {
    <div className="m-6 flex flex-col items-center justify-center">
      <TextField outlined={true} label={"Paste text backup"->React.string} invalid={false} />
      <div className="mt-2" />
      <Typography use="subtitle2" tag="span"> {"OR"->React.string} </Typography>
      <div className="mt-2" />
      <Button outlined={true} style={ReactDOM.Style.make(~width="100%", ~color="black", ())}>
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
      <span className="font-semibold text-xl"> {"Open Vault"->React.string} </span>
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
