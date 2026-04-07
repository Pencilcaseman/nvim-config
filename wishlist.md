# Feature/Change Wish List

## Blink.Pairs Build

`blink.cmp` provides `:BlinkCmp build`. `blink.pairs` does not currently provide
this, but may in the future. If possible, we should probably switch to the
automatic build command for both plugins.

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
