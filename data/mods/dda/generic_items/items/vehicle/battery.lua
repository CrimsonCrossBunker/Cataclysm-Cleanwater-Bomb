local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "it_battery_mount",
        name = ccb.content.plural_text("storage battery case", "storage battery cases"),
        description = ccb.content.text("A battery case for storage batteries.  It has a charging controller chip, connecting wires, and a harness for securing a battery.  Allows quick removal or addition of a storage battery to a vehicle's power grid, if you can lift the battery."),
        ascii_picture = "it_battery_mount",
        mass_milligrams = 1231000,
        melee_to_hit = -4,
        color = "light_gray",
        symbol = ":",
        volume_ml = 2250,
        category = "veh_parts",
        price_cents = 1000,
        price_postapoc_cents = 100,
    }
    item:material("plastic", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "it_handheld_battery_mount",
        name = ccb.content.plural_text("tool battery mount", "tool battery mounts"),
        description = ccb.content.text("A mount for batteries usually used in handheld tools.  It has a power converter, a charging controller chip, connecting wires, and a harness for securing a battery.  Allows quick removal or addition of such batteries to a vehicle's power grid."),
        mass_milligrams = 400000,
        color = "light_gray",
        symbol = ":",
        volume_ml = 300,
        category = "veh_parts",
        price_cents = 1000,
        price_postapoc_cents = 500,
    }
    item:material("plastic", 1)
    item:material("lc_steel", 1)
    item:material("copper", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end
