local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "cantilever_medium",
        category = "veh_parts",
        name = ccb.content.plural_text("steel boom", "steel booms"),
        description = ccb.content.text("A large, rigid steel boom.  If attached to a frame it could be used to lift up to 20 metric tonnes."),
        price_cents = 23400,
        price_postapoc_cents = 2000,
        mass_milligrams = 31600000,
        volume_ml = 12500,
        symbol = "&",
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cantilever_small",
        category = "veh_parts",
        name = ccb.content.plural_text("telescopic cantilever", "telescopic cantilevers"),
        description = ccb.content.text("A small, telescoping steel cantilever.  If attached to a frame it could be used to lift up to 3.5 metric tonnes."),
        price_cents = 7900,
        price_postapoc_cents = 1000,
        mass_milligrams = 12000000,
        volume_ml = 3000,
        symbol = "&",
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pallet_lifter",
        category = "veh_parts",
        name = ccb.content.plural_text("pallet lifter", "pallet lifters"),
        description = ccb.content.text("A makeshift pallet lifter.  If attached to a frame it could be used to lift up to 0.5 metric tonnes."),
        price_cents = 7900,
        price_postapoc_cents = 500,
        mass_milligrams = 12000000,
        volume_ml = 3000,
        symbol = "&",
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- made out of High-Strength Low-Alloy steel, which is used as structural steel automobiles and modelled as lc_steel
    local item = content.Item {
        id = "v_rockwheel_item",
        symbol = "&",
        name = ccb.content.plural_text("rockwheel", "rockwheels"),
        color = "dark_gray",
        description = ccb.content.text("A large, heavy, jagged metal disc for digging trenches."),
        mass_milligrams = 62000000,
        category = "veh_parts",
        price_cents = 8500,
        price_postapoc_cents = 500,
        volume_ml = 80000,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "v_airjack_item",
        symbol = "&",
        name = ccb.content.plural_text("airjack", "airjacks"),
        color = "dark_gray",
        description = ccb.content.text("An extendable metal pylon used to replace a portable jack.  If mounted to a vehicle, it could be used to lift it up."),
        mass_milligrams = 21000000,
        category = "veh_parts",
        price_cents = 8500,
        price_postapoc_cents = 500,
        volume_ml = 8750,
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("SELF_JACK", 17)
    content.add(item)
end

do
    local item = content.Item {
        id = "v_motorcycle_kickstand_item",
        symbol = "&",
        name = ccb.content.plural_text("motorcycle kickstand", "motorcycle kickstands"),
        color = "dark_gray",
        description = ccb.content.text("A kickstand to keep a bike from falling over.  You could use this to lean a small vehicle forward or backward to change a tire."),
        mass_milligrams = 500000,
        category = "veh_parts",
        price_cents = 500,
        price_postapoc_cents = 100,
        volume_ml = 500,
        replace_qualities = true,
    }
    item:material("lc_steel", 1)
    item:quality("SELF_JACK", 1)
    content.add(item)
end
