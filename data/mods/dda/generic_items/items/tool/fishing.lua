local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fishing_hook_basic",
        name = ccb.content.plural_text("fishing hook", "fishing hooks"),
        description = ccb.content.text("A simple metal fishing hook."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 25,
        price_postapoc_cents = 25,
        symbol = ",",
        color = "cyan",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "fishing_hook_bone",
        name = ccb.content.plural_text("improvised fishing hook", "improvised fishing hooks"),
        description = ccb.content.text("An improvised fishing hook carved from wood or bone."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 25,
        price_postapoc_cents = 25,
        symbol = ",",
        color = "white",
    }
    item:material("bone", 1)
    content.add(item)
end
