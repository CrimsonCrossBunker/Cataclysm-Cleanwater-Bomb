local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "robot_carrier",
        name = ccb.content.plural_text("robot carrier", "robot carriers"),
        description = ccb.content.text("A heavy frame outfitted with tie-downs and attachment points for carrying cargo, with additional railings to keep a large machine in place.  It is meant to hold large drones and robots for transport.  Use it on a suitable robot to capture, use it on an empty tile to release."),
        mass_milligrams = 96000000,
        volume_ml = 62500,
        price_cents = 48000,
        category = "veh_parts",
        symbol = "]",
        color = "light_gray",
        looks_like = "cargo_rack",
        capture_capacity = "LARGE",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("CAPTURE_MONSTER_VEH")
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end
