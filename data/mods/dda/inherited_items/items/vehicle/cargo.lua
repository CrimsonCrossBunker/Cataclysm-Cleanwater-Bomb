local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "livestock_carrier",
        name = ccb.content.plural_text("livestock carrier", "livestock carriers"),
        description = ccb.content.text("A heavy frame outfitted with tie-downs and attachment points for carrying cargo, with additional railings to keep a large animal in place.  It is meant to hold large animals for transport.  Use it on a suitable animal to capture, use it on an empty tile to release."),
        mass_milligrams = 96000000,
        volume_ml = 62500,
        price_cents = 48000,
        price_postapoc_cents = 750,
        category = "veh_parts",
        symbol = "]",
        color = "light_gray",
        looks_like = "cargo_rack",
        capture_capacity = "HUGE",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("CAPTURE_MONSTER_VEH")
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "animal_locker",
        copy_from = "livestock_carrier",
        looks_like = "livestock_carrier",
        name = ccb.content.plural_text("animal locker", "animal lockers"),
        description = ccb.content.text("A locker used to contain animals safely during transportation if installed properly.  There is room for animal food and other animal care goods.  It is meant to hold medium or smaller animals for transport.  Use it on a suitable animal to capture, use it on an empty tile to release."),
        mass_milligrams = 10000000,
        volume_ml = 31250,
        capture_capacity = "MEDIUM",
    }
    content.add(item)
end
