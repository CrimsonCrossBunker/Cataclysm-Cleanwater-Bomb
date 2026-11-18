local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_exodii_turret",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("broken Exodii turret", "broken Exodii turrets"),
        category = "other",
        description = ccb.content.text("A broken Exodii turret.  Still looks intimidating despite being permanently inoperative, possibly due to the sheer size and mass.  Could be gutted for parts."),
        price_cents = 1000,
        mass_milligrams = 206000000,
        volume_ml = 105000,
    }
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_exodii_sniper_drone",
        symbol = ",",
        color = "yellow",
        name = ccb.content.plural_text("broken Exodii balloon-drone", "broken Exodii balloon-drones"),
        category = "other",
        description = ccb.content.text("A broken balloon drone.  The balloon has been shredded, but most of the chassis is still intact.  Could be gutted for parts."),
        price_cents = 1000,
        volume_ml = 70000,
        mass_milligrams = 150000000,
    }
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end
