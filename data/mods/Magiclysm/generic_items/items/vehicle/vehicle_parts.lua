local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "v2_combustion_magic",
        name = ccb.content.plural_text("magic v-twin combustion engine", "magic v-twin combustion engines"),
        symbol = "v",
        description = ccb.content.text("A magically manifested combustion engine.  Despite operating entirely off of mana rather than normal fuel, it otherwise functions exactly as a conventional internal combustion engine."),
        volume_ml = 2000,
        mass_milligrams = 10000000,
        color = "yellow",
        price_cents = 800000,
    }
    item:material("steel", 1)
    content.add(item)
end
