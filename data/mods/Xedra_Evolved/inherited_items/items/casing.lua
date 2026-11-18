local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "9x21mm_casing",
        copy_from = "casing",
        name = ccb.content.plural_text("9x21mm casing", "9x21mm casings"),
        description = ccb.content.text("An empty casing from a 9x21mm round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end
