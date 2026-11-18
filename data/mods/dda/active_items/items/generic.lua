local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "brew_sake_koji_active",
        looks_like = "rice_cooked",
        name = ccb.content.plural_text("unfinished koji rice", "unfinished koji rice"),
        description = ccb.content.text("Some cooked rice mixed with yeast and koji mold fragments, set aside to let koji mold grow on it so that it can make a passable sake base."),
        mass_milligrams = 200000,
        color = "white",
        default_container = "bottle_glass",
        symbol = "%",
        price_cents = 0,
        volume_ml = 250,
        category = "food",
        countdown_turns = 345600,
    }
    item:material("veggy", 1)
    item:material("mold", 1)
    item:material("yeast", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SOFT")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "sake_koji_rice" }
    content.add(item)
end

do
    local item = content.Item {
        id = "young_koji_active",
        looks_like = "rice_cooked",
        name = ccb.content.plural_text("growing wild koji mold", "growing wild koji mold"),
        description = ccb.content.text("Some cooked rice sprinkled with ash and wrapped into a corn husk.  If left alone for a while, it will most likely grow koji mold."),
        mass_milligrams = 200000,
        color = "white",
        symbol = ",",
        price_cents = 0,
        volume_ml = 250,
        countdown_turns = 345600,
    }
    item:material("veggy", 1)
    item:material("mold", 1)
    item:material("yeast", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "young_koji_done" }
    content.add(item)
end

do
    local item = content.Item {
        id = "soy_wheat_dough_active",
        looks_like = "flour",
        name = ccb.content.plural_text("soy and wheat dough", "soy and wheat dough"),
        description = ccb.content.text("Dough made from cooked and mashed soybeans and wheat flour, wrapped in wet paper.  If left to dry for some time, it'll grow koji mold, as necessary for making soy sauce."),
        mass_milligrams = 550000,
        color = "white",
        symbol = "%",
        price_cents = 0,
        volume_ml = 500,
        countdown_turns = 345600,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "soy_wheat_dough_done" }
    content.add(item)
end

do
    local item = content.Item {
        id = "soft_adobe_brick_active",
        category = "spare_parts",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("soft adobe brick", "soft adobe bricks"),
        description = ccb.content.text("A compacted mass of soil and natural fibers, still too wet to build with.  Load it onto a pallet and leave it to dry."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 11500000,
        volume_ml = 8000,
        longest_side_mm = 360,
        melee_to_hit = -4,
        countdown_turns = 604800,
    }
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:material("soil", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:transform_into { target = "adobe_brick" }
    content.add(item)
end
