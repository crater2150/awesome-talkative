# talkative

A simple logging library for awesome.

## Installation

Put the contents of this repository inside a folder named `talkative` in your
awesome config dir (usually `~/.config/awesome`). If your awesome configuration
is managed by git, I recommend adding this repo as a git submodule:

```git submodule add https://github.com/crater2150/awesome-talkative.git talkative ```

Then, in your `rc.lua`:

```local talkative = require("talkative")```

or to use a shorter name:

```local log = require("talkative")```

## Usage

To log a message, call one of the following methods:

- `log.dbg(msg)`, log level `DEBUG` (lowest)
- `log.log(msg)`, log level `NORMAL`
- `log.warn(msg)`, log level `WARNING`
- `log.error(msg)`, log level `ERROR` (highest)

As a shorthand, the module can be called directly, causing a message to be
logged with level `NORMAL`:

```lua
local log = require("talkative")
log("Hello")
```

## Declaring loggers

To see the message, you must declare loggers in your `rc.lua` using
`add_logger(logger, level)`:

```lua
log.add_logger(log.loggers.stdio, log.level.DEBUG)
log.add_logger(log.loggers.naughty, log.level.WARNING)
```

A logger is called, whenever a message is logged with a level, that is at
least as high as the level given to `add_logger`.

Talkative contains two predefined loggers:

- `talkative.loggers.stdio` writes messages to stdout.
- `talkative.loggers.naughty` uses naughty to display a popup. For log levels
  `WARNING` and `ERROR`, the font color is set to yellow, resp. red.

## Custom loggers

Loggers are simple Lua functions, that take two parameters: the *message* and
the *log level*. A logger function may use the level to change formatting, but
should not restrict output based on it, this is handled by the message methods.
