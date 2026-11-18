local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "brew_sake_koji",
        looks_like = "rice_cooked",
        name = ccb.content.plural_text("unfinished koji rice (obsolete)", "unfinished koji rice (obsolete)"),
        description = ccb.content.text("Some cooked rice mixed with yeast and koji mold fragments, set aside to let koji mold grow on it so that it can make a passable sake base."),
        mass_milligrams = 200000,
        color = "white",
        default_container = "bottle_glass",
        symbol = "%",
        price_cents = 0,
        volume_ml = 250,
        category = "food",
    }
    item:material("veggy", 1)
    item:material("mold", 1)
    item:material("yeast", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SOFT")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "sake_koji_rice" },
        message = ccb.content.text("The koji mold seems to have overtaken all the rice; this batch is usable now."),
        moves = 50,
        minimum_age_turns = 345600,
        not_ready_message = ccb.content.text("The koji mold is still growing."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "young_koji",
        looks_like = "rice_cooked",
        name = ccb.content.plural_text("growing wild koji mold (obsolete)", "growing wild koji mold (obsolete)"),
        description = ccb.content.text("Some cooked rice sprinkled with ash and wrapped into a corn husk.  If left alone for a while, it will most likely grow koji mold."),
        mass_milligrams = 200000,
        color = "white",
        symbol = ",",
        price_cents = 0,
        volume_ml = 250,
    }
    item:material("veggy", 1)
    item:material("mold", 1)
    item:material("yeast", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "young_koji_done" },
        message = ccb.content.text("Patches of koji mold have grown on the rice; you can now extract it."),
        moves = 50,
        minimum_age_turns = 345600,
        not_ready_message = ccb.content.text("The koji mold hasn't grown yet."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "soy_wheat_dough",
        looks_like = "flour",
        name = ccb.content.plural_text("soy and wheat dough (obsolete)", "soy and wheat dough (obsolete)"),
        description = ccb.content.text("Dough made from cooked and mashed soybeans and wheat flour, wrapped in wet paper.  If left to dry for some time, it'll grow koji mold, as necessary for making soy sauce."),
        mass_milligrams = 550000,
        color = "white",
        symbol = "%",
        price_cents = 0,
        volume_ml = 500,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "soy_wheat_dough_done" },
        message = ccb.content.text("The koji mold seems to have overtaken all the dough; this batch is usable now."),
        moves = 50,
        minimum_age_turns = 345600,
        not_ready_message = ccb.content.text("The koji mold hasn't grown yet."),
    }
    content.add(item)
end

do
    -- Should be about a week. Irl it's ten days, so make big batches.
    local item = content.Item {
        id = "soft_adobe_brick",
        category = "spare_parts",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("soft adobe brick (obsolete)", "soft adobe bricks (obsolete)"),
        description = ccb.content.text("A compacted mass of soil and natural fibers, still too wet to build with.  Load it onto a pallet and leave it to dry."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 11500000,
        volume_ml = 8000,
        longest_side_mm = 360,
        melee_to_hit = -4,
    }
    item:material("soil", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "adobe_brick" },
        message = ccb.content.text("You test the brick, and it seems solid enough to use."),
        moves = 50,
        minimum_age_turns = 604800,
        not_ready_message = ccb.content.text("The brick is still too damp to bear weight."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end
