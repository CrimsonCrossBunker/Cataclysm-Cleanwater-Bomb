local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "inert_glowing_string",
        category = "artifacts",
        symbol = ",",
        color = "magenta",
        name = ccb.content.plural_text("glowing string", "glowing strings"),
        description = ccb.content.text("A plastic test-tube housing a fluorescent purple string of unknown material.  The string gently flickers and twitches on its own."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 10000,
        volume_ml = 20,
    }
    item:material("plastic", 1)
    content.add(item)
end
