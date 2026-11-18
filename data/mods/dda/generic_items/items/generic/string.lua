local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rubber_band",
        name = ccb.content.plural_text("rubber band", "rubber bands"),
        description = ccb.content.text("An elastic loop of rubber commonly used to hold multiple objects together."),
        copy_from = "string_6",
        looks_like = "string_6",
        symbol = ",",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end
