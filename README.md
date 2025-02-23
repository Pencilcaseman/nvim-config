# Neovim Configuration

## Introduction

This is my custom Neovim configuration with a collection of useful plugins,
keybinds and settings.

It is based off [Kickstart.Nvim](https://github.com/nvim-lua/kickstart.nvim),
which is a wonderful starting point for a custom configuration. The actual code
was originally forked from
[Kickstart-Modular.nvim](https://github.com/dam9000/kickstart-modular.nvim),
which is a fork of the original Kickstart configuration with some changes made
to simplify the project layout.

## Installation

### Install Neovim

This configuration targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - If you want to write Rust, you will need `cargo`
  - etc.

#### Additional Dependencies by Plugin

##### CMakeTools

CMakeTools provides integration with the CMake build system, allowing you to
configure, build and run your projects. It also configures your LSP to provide
correct completions and lints for your project.

###### Dependencies

- [`cmake`](https://cmake.org/)

##### Yazi

Yazi is a file explorer for the command line, and integrates nicely with Neovim.
You'll need to have Yazi installed for the integration to work.
Type `<leader>f` for more information.

###### Dependencies

- [`yazi`](https://github.com/sxyazi/yazi)

##### Peek

Peek is a real-time Markdown renderer for Neovim, showing you a live preview of
what your file will look like when rendered. Type `:PeekStart` to use it.

###### Dependencies

- [`deno`](https://deno.com/)

##### Typst-Preview

Typst is a modern typesetting language, akin to LaTeX. Typst supports live,
realtime rendering of your document via the Typst-Preview plugin. Type
`:TypstPreview` to get started.

###### Dependencies

- [`typst`](https://typst.app/)

##### VimTex

VimTex provides LaTeX integrations into Neovim.

###### Dependencies

- [`LaTeX`](https://www.tug.org/texlive/)

##### Debugger Support

Getting debugger support up and running can require a few additional
dependencies on top of whatever is required for full LSP support in that
language.

###### Dependencies

- Rust
  - [Visual Studio Code](https://code.visualstudio.com/)
  - [`codelldb` plugin](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)
- C/C++
  - ???
- Python
  - ???
- Go
  - ???

### Install this Configuration

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your
OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> **NOTE**
> Your fork's url will be something like this:
> `https://github.com/<your_github_username>/nvim-config.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the this repo to make maintenance easier, but it's
[recommmended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone the Configuration
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `Pencilcaseman` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/Pencilcaseman/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/Pencilcaseman/nvim-config.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/Pencilcaseman/nvim-config.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

### Getting Started with Neovim

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

WhichKey will show you available keybinds as you type them.

Type `<leader>sk` to search through (most of) the available keybinds.

### FAQ

- What if I already have a Neovim configuration installed?
  - You should back up your existing configuration to make sure you can roll
    back if necessary.
  - The easiest way to do this is as follows:

    ```sh
    mv ~/.local/share/nvim{,.bak}
    mv ~/.local/state/nvim{,.bak}
    mv ~/.cache/nvim{,.bak}
    mv ~/.local/share/nvim/mason{,.bak}
    mv ~/.cache/nvim/mason{,.bak}
    ```

- Can I keep my existing configuration in parallel to this configuration?
  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install this
    configuration in `~/.config/nvim-pencilcaseman` and create an alias:

    ```sh
    alias nvim-pencilcaseman='NVIM_APPNAME="nvim-pencilcaseman" nvim'
    ```

    When you run Neovim using `nvim-pencilcaseman` alias it will use the
    alternative config directory and the matching local directory
    `~/.local/share/nvim-pencilcaseman`. You can apply this approach to any
    Neovim distribution that you would like to try out.
- What if I want to "uninstall" this configuration:
  - See the above section on having an existing configuration. Removing those
    directories will remove this configuration (be careful not to remove the
    backup!)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the
[Install this Configuration](#install-this-configuration) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for
`telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>
