# fish-autoupdate-plugin
A fish shell plugin that triggers a plugin manager to run an update up to once a
day.

## Installation
To install this plugin with [fisher], just run:
```console
fisher install TeFiLeDo/fish-autoupdate-plugin
```

## Configuration
You can configure several aspects of this programs functionality with universal 
variables.

### Disable extension
You can disable this extension on specific computers, in case you share your 
plugin list across several systems:
```console
set -U faup_disabled true
```

### Automatically download plugins list via curl
If you want to automatically download the plugin list via http, this plugin can
do that for you:
```console
set -U faup_url <your_url>
```

If you want to save it somewhere else than `$HOME/.config/fish_plugins`, the
output path can be configured:
```console
set -U faup_target <path>
```

### Use other plugin manager than [fisher]
If you want to use another plugin manager than [fisher], you can do this by:
```console
set -U faup_plugin_manager <pm>
```

For supported plugin managers see the list below.

**Note:** If `<pm>` doesn't match a supported plugin manager, [fisher] is used
as default.

### Change update frequency
If you want updates to happen more often or less than once a day, you can do
this:
```console
set -U faup_update_delta <delta>
```

`<delta>` is the minimum number of seconds between updates.

**Note:** `<delta>` is passed as an argument to [fishs math command][fish-math].
This means you can use expressions like `"24*60*60"` (which is also the
_default_ value).

## Supported plugin managers
Currently only [fisher] is supported. I'm happy to add support for more plugin
managers if requested. In fact, I already prepared the plugin for that
eventuality.

If your plugin manager is not already supported, you have two options:

1. Implement support yourself and open a pull request.
2. Open an issue and I will implement it. However, I can only do this if the
   plugin manager in question provides adequate documentation concerning its
   usage and behaviour.

## Changelog
### [v0.1 - Adamant Ant - 2021-08-28][v0.1]
This is the _initial release_. As such, there are no changes to explain.

[fisher]: https://github.com/jorgebucaran/fisher
[fish-math]: https://fishshell.com/docs/current/cmds/math.html
[v0.1]: https://github.com/TeFiLeDo/fish-autoupdate-plugin/releases/tags/v0.1
