%%raw(`
import "./index.css";
import "./tailwind.css";

import "@material/typography/dist/mdc.typography.css";
import "@material/textfield/dist/mdc.textfield.css";
import "@material/floating-label/dist/mdc.floating-label.css";
import "@material/notched-outline/dist/mdc.notched-outline.css";
import "@material/line-ripple/dist/mdc.line-ripple.css";
import "@material/ripple/dist/mdc.ripple.css";
import "@rmwc/icon/icon.css";
import "@material/button/dist/mdc.button.css";
import "@material/card/dist/mdc.card.css";
import "@material/icon-button/dist/mdc.icon-button.css";
import "@material/dialog/dist/mdc.dialog.css"; 
import "@material/linear-progress/dist/mdc.linear-progress.css";
import "@material/icon-button/dist/mdc.icon-button.css";
`)

let root = ReactDOM.querySelector("#root")
switch root {
| None => ()
| Some(el) => ReactDOM.render(<Reducer.Provider> <App /> </Reducer.Provider>, el)
}
