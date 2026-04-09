# gptel-mcp.el - Interface Integration for `gptel.el` and `mcp.el`

[![GPLv3 License](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This is a fork of [lizqwerscott/gptel-mcp.el](https://github.com/lizqwerscott/gptel-mcp.el).
It provides an interface between [harthink/gptel](https://github.com/karthink/gptel)
and [lizqwerscott/mcp.el](https://github.com/lizqwerscott/mcp.el).

## Installation

There is no true path to installation, young Padawan.

### use-package

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

### hook

You can also define a hook to run after tool activation.

```lisp
(defvar my/gptel-mcp-ignored-tools
  '("write_file" "edit_file" "create_directory" "delete_file" "move_file")
  "List of MCP tool names to automatically remove upon mass-activation.")

(defun my/gptel-mcp-filter-active-tools ()
  "Remove destructive filesystem tools from the active `gptel-tools' list."
  (when (boundp 'gptel-tools)
    (setq gptel-tools
          (cl-remove-if (lambda (tool)
                          (member (gptel-tool-name tool) my/gptel-mcp-ignored-tools))
                        gptel-tools))
    (message "Filtered out destructive MCP tools.")))

(add-hook 'gptel-mcp-after-activate-all-hook #'my/gptel-mcp-filter-active-tools)
```

## Usage

Invoke `gptel` to create your LLM buffer like normal. Within that
buffer, use `C-c m` to open the `gptel-mcp` menu.

| option | description                                             |
|:-------|---------------------------------------------------------|
| s      | start all MCP servers, defined by var `mcp-hub-servers` |
| r      | restart all MCP servers (if already dead, simply start) |
| k      | kill all MCP servers                                    |
| a      | activate all tools and then run tool activation hook    |
| d      | deactivate all tools                                    |
| q      | close the menu                                          |

## Reinstallation

Emacs is sometimes a little strange when trying to reinstall updated
packages. If you choose to fork this repo (please do -- make it
awesome; I'm just updating this so that I hate using it less), then
you might need the included debug script which you can load using
`M-x load-file RET /path/to/reinstall.debug.el RET`.
