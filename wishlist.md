# Feature/Change Wish List

## Experimental UI

[This PR](https://github.com/neovim/neovim/pull/27855) merged significant
improvements to the command line UI, but they are still experimental and are
behind a feature flag.

Originally under `vim._extui`, the feature has been renamed to `vim._core.ui2`.

```lua
-- init.lua

-- Enable experimental UI improvements
require('vim._core.ui2').enable {}
```

This should be removed when the feature is no-longer experimental.

## File Picker

[Mini.Pick](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pick.md)
is very capable, but it file searching in large codebases can become difficult.

[fff.nvim](https://github.com/dmtrKovalenko/fff.nvim) is (seems to be?) faster
and finds better matches, so I would like to use this at some point if I can.

The main issue is that the UI is very different, and I do not want different UIs
for different pickers.

[This PR](https://github.com/dmtrKovalenko/fff.nvim/pull/139) adds integrations
with Mini.Pick, so if/when this is merged I would like to make use of it.
