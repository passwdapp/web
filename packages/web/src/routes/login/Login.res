open PasswdappSharedComponents
open RescriptRmwc.RMWC

@react.component
let make = () => {
  <div className="flex flex-col md:flex-row w-full h-full items-center justify-center">
    <div className="flex flex-col items-center md:items-end">
      <Logo fontSize="3rem" />
      <span className="font-semibold text-xl"> {"Login"->React.string} </span>
      <div className="mt-4" />
    </div>
    <div className="w-0 h-4 md:h-0 md:w-16" />
    <Card>
      <div className="m-6 flex flex-col items-center justify-center">
        <TextField outlined={true} label={"Username"->React.string} />
        <div className="mt-4" />
        <TextField outlined={true} \"type"="password" label={"Password"->React.string} />
        <div className="mt-6" />
        <Button
          raised={true}
          ripple={{surface: None, accent: Some(true), unbounded: None}}
          style={ReactDOM.Style.make(~width="100%", ~color="black", ())}>
          {"Login"->React.string}
        </Button>
      </div>
    </Card>
  </div>
}
