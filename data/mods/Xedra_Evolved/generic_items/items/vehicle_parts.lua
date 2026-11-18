local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "unloaded_wave_rider_engine",
        name = ccb.content.plural_text("elemental wave rider engine", "elemental wave rider engines"),
        symbol = "v",
        description = ccb.content.text("An elementally manifested combustion engine.  Despite operating entirely off of mana rather than normal fuel, it otherwise functions exactly as a conventional internal combustion engine."),
        volume_ml = 2000,
        mass_milligrams = 10000000,
        color = "yellow",
        price_cents = 800000,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "floral_base_item",
        name = ccb.content.plural_text("floral vessel", "floral vessels"),
        symbol = "v",
        description = content.text("The parts of the floral vehicle that have to exist for code reasons."),
        volume_ml = 2000,
        mass_milligrams = 2000000,
        color = "green",
        price_cents = 800000,
    }
    item:material("veggy", 1)
    content.add(item)
end
