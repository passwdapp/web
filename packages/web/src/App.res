@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let component = switch url.path {
  | list{} => <OpenVault />
  | _ => <div> {"Not Found"->React.string} </div>
  }

  component
}
