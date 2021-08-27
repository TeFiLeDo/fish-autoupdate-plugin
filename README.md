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

## Supported plugin managers
Currently only [fisher] is supported. I'm happy to add support for more plugin
managers if requested. In fact, I already prepared the plugin for that
eventuality.

If your plugin manager is not already supported, you have two options:

1. Implement support yourself and open a pull request.
2. Open an issue and I will implement it. However, I can only do this if the
   plugin manager in question provides adequate documentation concerning its
   usage and behaviour.



[fisher]: https://github.com/jorgebucaran/fisher
