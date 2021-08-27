# fish-autoupdate-plugin
A fish shell plugin that triggers a plugin manager to run an update up to once a
day.

## Installation
To install this plugin with fisher, just run:
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
