# Elm + Tauri template

This is a general-purpose template for using the Elm language with Tauri, and calling Rust
functions from Elm through the JavaScript interop.

You can get started building the Tauri portion by following the appropriate Tauri docs for
your operating system
[here](https://tauri.studio/v1/guides/getting-started/prerequisites). Then, you can
install `yarn`, `npm` or `pnpm` and use the appropriate commands to install the
Node dependencies:

```bash
$ (yarn/npm install/pnpm install)
```

This should install elm in the local `node_modules` folder. However, I recommend
installing `elm` and co-tools globally by running the following command:

```bash
$ (yarn global/npm install -g/pnpm install -g) elm elm-format elm-test elm-review
```

After all that is done, you should be able to run the following command to build and run
the development version of the Tauri app.

```bash
$ (cargo/yarn/npm/pnpm) tauri dev
```

<u>Notes:</u> `cargo tauri` requires the `tauri-cli` binary to be installed with `cargo
install tauri-cli --locked --version "^1.0.0-rc"`[[1]](#1), which itself requires `cargo`
installed (which you should have anyway since you're trying to use Tauri).

<br >
<div id="#1></div>

1: The version may be omitted when the "1.x.y" full version of Tauri is released.
