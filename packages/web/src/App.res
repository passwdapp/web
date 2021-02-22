open RescriptRmwc.RMWC

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (_, dispatch) = Reducer.Context.use()

  React.useEffect1(() => {
    dispatch(Actions.SetLoading({loading: true}))

    Wasm.initializeWasm(() => {
      dispatch(Actions.SetLoading({loading: false}))
    })

    Some(() => ())
  }, [])

  let component = switch url.path {
  | list{} => <OpenVault />
  | _ => <div> {"Not Found"->React.string} </div>
  }

  <> <Portal /> <LoadingDialog /> component </>
}
