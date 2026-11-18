local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_mil_ship_plate",
        name = ccb.content.plural_text("military ablative plating", "military ablative platings"),
        description = ccb.content.text("A segment of thick armor plating that would normally be found mounted on a spaceship.  Incredibly heavy."),
        mass_milligrams = 28500000,
        melee_to_hit = -1,
        color = "green",
        symbol = "]",
        volume_ml = 10000,
        category = "veh_parts",
        price_cents = 16000,
        price_postapoc_cents = 750,
        replace_qualities = true,
    }
    item:material("qt_steel", 1)
    item:material("vacuum_carbide", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "exo_gantry",
        copy_from = "veh_tools_workshop",
        looks_like = "veh_tools_workshop",
        name = ccb.content.plural_text("exosuit maintenance gantry", "exosuit maintenance gantries"),
        description = ccb.content.text("A vehicle-mounted gantry for supporting an exosuit upright during maintenance and repair.  Includes the specialized tools needed for complex repairs and will also charge the suit's power when activated from the vehicle's controls."),
    }
    content.add(item)
end
