local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_aerodyne_engine",
        category = "veh_parts",
        name = ccb.content.plural_text("multi-axis aerodyne engine", "multi-axis aerodyne engines"),
        description = ccb.content.text("A self-contained multi-axis aerodyne engine, powered by chemical fuel.  Reinstalling it is no trivial matter, it'll probably be best to just sell it if removed."),
        price_cents = 1500000,
        price_postapoc_cents = 1500000,
        mass_milligrams = 300000000,
        volume_ml = 200000,
        looks_like = "m202_flash",
        symbol = "X",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_titanium_frame",
        name = ccb.content.plural_text("ultralight frame", "ultralight frames"),
        description = ccb.content.text("A sturdy, lightweight frame made from titanium.  Useful for crafting."),
        mass_milligrams = 1000000,
        melee_to_hit = -3,
        color = "white",
        symbol = "]",
        looks_like = "xlframe",
        techniques = { "DEF_DISARM" },
        volume_ml = 7500,
        category = "veh_parts",
        price_cents = 4000,
    }
    item:material("titanium", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_titanium_foldable_frame",
        copy_from = "afs_titanium_frame",
        looks_like = "afs_titanium_frame",
        name = ccb.content.plural_text("ultralight foldable frame", "ultralight foldable frames"),
        description = ccb.content.text("A sturdy, lightweight foldable frame made from titanium."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_control_station",
        name = ccb.content.plural_text("control station", "control stations"),
        looks_like = "vehicle_dashboard",
        description = ccb.content.text("A large and complex piloting station from a military vehicle, including a camera station, steering tools, and electronics controls."),
        mass_milligrams = 9000000,
        melee_to_hit = -4,
        color = "red",
        symbol = "$",
        volume_ml = 6000,
        category = "veh_parts",
        price_cents = 60000,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "ship_reactor_pdu",
        copy_from = "veh_tools_abstract",
        name = ccb.content.plural_text("Ship's PDU", "Ship's PDUs"),
        mass_milligrams = 10000000000,
        description = ccb.content.text("A distribution cabinet linking to the ship's main reactor, can be used to build an external electric grid powered by the ship's surplus power."),
        looks_like = "minireactor",
    }
    content.add(item)
end
