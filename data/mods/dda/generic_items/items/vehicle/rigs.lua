local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "vehicle_rig",
        abstract = true,
        category = "veh_parts",
        name = content.plural_text("vehicle crafting rig", "vehicle crafting rigs"),
        mass_milligrams = 40000000,
        volume_ml = 20000,
        price_cents = 40000,
        price_postapoc_cents = 2000,
        symbol = "&",
        color = "light_cyan",
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "forgerig",
        copy_from = "vehicle_rig",
        name = ccb.content.plural_text("vehicle forge rig", "vehicle forge rigs"),
        description = ccb.content.text("A forge rig made to run off a vehicle's storage battery, with integrated tool storage for metalworking equipment."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "kilnrig",
        copy_from = "vehicle_rig",
        name = ccb.content.plural_text("vehicle kiln", "vehicle kilns"),
        description = ccb.content.text("An electric kiln made to run off a vehicle's storage battery."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "weldkit",
        copy_from = "vehicle_rig",
        name = ccb.content.plural_text("vehicle high-temperature welding kit", "vehicle high-temperature welding kits"),
        description = ccb.content.text("A welder combined with a fireproof insulating blanket, allowing for advanced welds and repairs to tempered steels."),
    }
    content.add(item)
end
