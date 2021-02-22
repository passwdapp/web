import "./wasm_exec";
import wasmBundleUrl from "./main.wasm?url";

export async function InitWasm() {
  const go = new Go();
  const wasmBundle = await WebAssembly.instantiateStreaming(
    fetch(wasmBundleUrl),
    go.importObject
  );
  go.run(wasmBundle.instance);
}
