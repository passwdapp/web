open RescriptRmwc.RMWC

@react.component
let make = () => {
  let (state, _) = Reducer.Context.use()

  <Dialog \"open"={state.loading} renderToPortal={true} preventOutsideDismiss={true}>
    <DialogTitle> {"Loading"->React.string} </DialogTitle>
    <DialogContent> <LinearProgress /> </DialogContent>
  </Dialog>
}
