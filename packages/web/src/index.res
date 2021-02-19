%%raw(`
import "./index.css";
`)

let root = ReactDOM.querySelector("#root")
switch root {
| None => ()
| Some(el) => ReactDOM.render(<App />, el)
}
