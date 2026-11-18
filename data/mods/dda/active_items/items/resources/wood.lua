local ccb = require("ccb")
local content = ccb.content

do
    -- a long pole is a single piece of wood, and the heavy stick just isn't large enough.
    -- 4 hours
    local item = content.Item {
        id = "soaking_long_pole",
        name = ccb.content.plural_text("soaking long pole", "soaking long poles"),
        description = ccb.content.text("A stout, ten-foot pole.  Could be used similarly to a spear.  It's currently soaked with oil and quite slippery.  Once the oil penetrates the wood it can be wiped down and used for further projects."),
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        mass_milligrams = 2250000,
        volume_ml = 3750,
        longest_side_mm = 3050,
        weapon_categories = { "POLEARMS" },
        price_cents = 4000,
        melee_to_hit = -2,
        price_postapoc_cents = 50,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("POLEARM")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "long_pole" },
        message = ccb.content.text("You wipe down the long pole."),
        moves = 1000,
        minimum_age_turns = 15000,
        not_ready_message = ccb.content.text("The long pole is still soaking."),
    }
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    content.add(item)
end

do
    -- 4 hours
    local item = content.Item {
        id = "soaking_spear_shaft",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("soaking spear shaft", "soaking spear shafts"),
        looks_like = "q_staff",
        description = ccb.content.text("A long stick carved and sanded into a smooth staff with a slight taper, for use in making spears.  It's currently soaked with oil and quite slippery.  Once the oil penetrates the wood it can be wiped down and used for further projects."),
        price_cents = 4000,
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1000000,
        volume_ml = 1250,
        longest_side_mm = 1800,
        category = "weapons",
        melee_to_hit = 0,
        price_postapoc_cents = 500,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "spear_shaft" },
        message = ccb.content.text("You wipe down the spear shaft."),
        moves = 1000,
        minimum_age_turns = 15000,
        not_ready_message = ccb.content.text("The spear shaft is still soaking."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end
