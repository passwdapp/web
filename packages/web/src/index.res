%%raw(`
import "./index.css";
import "@material/typography/dist/mdc.typography.css";
`)

let root = ReactDOM.querySelector("#root")
switch root {
| None => ()
| Some(el) => ReactDOM.render(<App />, el)
}
