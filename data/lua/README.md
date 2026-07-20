# Lua UI scripts

The bundled `main.lua` is loaded first.  An optional `config/lua/main.lua` is
then loaded and may add pages or replace a bundled page by registering the same
id.

Open **Debug menu → Game → Lua UI pages** to reload the scripts and choose a
page.  The page's **Reload Lua** button reloads scripts while the page remains
open.

```lua
local count = 0

ui.page("my_page", "My Lua page", function(ctx)
    ctx:text("Count: " .. count)
    if ctx:button("Increment") then
        count = count + 1
    end
end)
```

Available context methods in API version 1 are `text`, `separator`,
`same_line`, `button`, `checkbox`, `slider_int`, `slider_float`, and
`input_text`.  The initial game API provides `game.api_version`,
`game.add_msg(text)`, and `game.player_name()`.

Only Lua's base, package, math, string, and table libraries are opened.  File
loading and dynamic native modules are disabled.  `require("foo.bar")` resolves
only `foo/bar.lua` below `config/lua` or `data/lua`.
