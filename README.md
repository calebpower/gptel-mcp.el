# gptel-mcp.el - Interface Integration for `gptel.el` and `mcp.el`

[![GPLv3 License](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This is a fork of [lizqwerscott/gptel-mcp.el](https://github.com/lizqwerscott/gptel-mcp.el).
It provides an interface between [harthink/gptel](https://github.com/karthink/gptel)
and [lizqwerscott/mcp.el](https://github.com/lizqwerscott/mcp.el).

## Installation

There is no true path to installation, young Padawan.

### ~/.emacs config

Slap this in your `~/.emacs` config. Probably.

```lisp
(use-package mcp
  :vc (:url "https://github.com/lizqwerscott/mcp.el"))

(use-package gptel-mcp
  :vc (:url "https://github.com/calebpower/gptel-mcp.el"
       :branch "main")
  :after gptel
  :bind (:map gptel-mode-map
              ("C-c m" . gptel-mcp-dispatch)))
```

