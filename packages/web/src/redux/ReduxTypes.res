type vault = {name: string, password: string}
type store = {loading: bool, vault: vault}

let initialState: store = {
  loading: false,
  vault: {
    name: "",
    password: "",
  },
}
