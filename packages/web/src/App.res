open RescriptRmwc.RMWC

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let component = switch url.path {
  | list{} => <OpenVault />
  | _ => <div> {"Not Found"->React.string} </div>
  }

  <Reducer.Provider> <Portal /> <LoadingDialog /> component </Reducer.Provider>
}
