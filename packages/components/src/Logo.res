@react.component
let make = (~fontSize: string) => {
  <div className="logo" style={ReactDOM.Style.make(~fontSize, ())}>
    <span> {"Pass"->React.string} </span>
    <span style={ReactDOM.Style.make(~color="#00ecd7", ())}> {"wd"->React.string} </span>
    <span> {"."->React.string} </span>
  </div>
}
