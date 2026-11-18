local ccb = require("ccb")
local content = ccb.content

do
    -- Considering writing code to check for u_has_item_named so that the ball can be dynamic based on a final selector ingredient.
    -- Then the EOC would check for what the ball is named and do effects based on that.
    local item = content.Item {
        id = "mag_wildwood_beetle_ball",
        name = ccb.content.plural_text("small wildwood stag beetle ball", "small wildwood stag beetle balls"),
        description = ccb.content.text("A small ball made of wildwood.  A narrative relief of a stag beetle dancing wraps the ball.  A soft chittering noise can be heard from it."),
        mass_milligrams = 425000,
        volume_ml = 500,
        copy_from = "mag_wildwood",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "mag_summon_mushrooms", no_fail = true, level = 1 }
    item:transform_on_use {
        result = { target = "mag_large_wildwood_beetle_ball" },
        message = ccb.content.text("The %s surges in size.  It shudders and rolls around as the relief begins to move on its own."),
        minimum_age_turns = 864000,
        not_ready_message = ccb.content.text("The beetle isn't done growing yet."),
        need_charges = 400,
        need_charges_message = ccb.content.text("The beetle does not have enough liquid to grow."),
    }
    item:tool { charges_per_use = 125 }
    item:magazine_pocket { ammo_capacities = { mag_awakened_water = 400 }, rigid = true, watertight = true }
    content.add(item)
end

do
    -- Add final selector for a beetle vehicle that's drag only.  Intended to be used with a tow chain, and have a small compartment for cargo.
    local item = content.Item {
        id = "mag_large_wildwood_beetle_ball",
        name = ccb.content.plural_text("wildwood stag beetle ball", "wildwood stag beetle balls"),
        description = ccb.content.text("A large ball made of wildwood.  A narrative relief of a dancing stag beetle wraps the ball.  A soft chittering noise can be heard from it as the relief flows across the surface."),
        mass_milligrams = 850000,
        volume_ml = 1000,
        copy_from = "mag_wildwood",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "mag_open_beetle_ball_large", no_fail = true, level = 1 }
    item:flag("SPAWN_ACTIVE")
    item:tool { charges_per_use = 100 }
    item:magazine_pocket { ammo_capacities = { mag_awakened_water = 300 }, rigid = true, watertight = true }
    content.add(item)
end
