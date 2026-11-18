local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bracken_eye",
        name = ccb.content.plural_text("brackenwight eye", "brackenwight eyes"),
        description = ccb.content.text("A fist-sized lump of plant matter taken from a brackenwight.  It still glows a very faint green."),
        mass_milligrams = 133000,
        volume_ml = 250,
        symbol = "*",
        color = "green",
        light = 3,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "gnome_eye",
        copy_from = "garnet",
        looks_like = "garnet",
        name = ccb.content.plural_text("gnome eye", "gnome eyes"),
        description = ccb.content.text("A glittering gemstone that once formed one of the eyes of a gnome.  You feel like you're being watched when you look at it."),
        category = "spare_parts",
        symbol = "*",
        color = "red",
        mass_milligrams = 2000,
        volume_ml = 60,
    }
    content.add(item)
end
