local ccb = require("ccb")
local content = ccb.content

do
    -- The time it takes is a week and this appears to be the minimum time the internet says it takes.
    local item = content.Item {
        id = "aquarium_medium_drying",
        category = "other",
        name = ccb.content.plural_text("50 gallon aquarium (drying) (obsolete)", "50 gallon aquariums (drying) (obsolete)"),
        description = ccb.content.text("A 50-gallon glass aquarium, used for safely storing small animals for use as pets or food.  This one has been freshly made and requires time for the silicone to dry."),
        ascii_picture = "aquarium_medium",
        mass_milligrams = 45000000,
        volume_ml = 222000,
        longest_side_mm = 910,
        price_cents = 5000,
        price_postapoc_cents = 750,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 189000,
        max_weight_milligrams = 300000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "aquarium_medium" },
        message = ccb.content.text("You check that the aquarium does indeed hold water, it is ready."),
        moves = 100,
        minimum_age_turns = 604800,
        not_ready_message = ccb.content.text("The silicone hasn't dried quite yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    -- The time it takes is a week and this appears to be the minimum time the internet says it takes.
    local item = content.Item {
        id = "aquarium_small_drying",
        category = "other",
        name = ccb.content.plural_text("30 gallon aquarium (drying) (obsolete)", "30 gallon aquariums (drying) (obsolete)"),
        description = ccb.content.text("A 30-gallon glass aquarium, used for safely storing small animals for use as pets or food.  This one has been freshly made and requires time for the silicone to dry."),
        ascii_picture = "aquarium_small",
        mass_milligrams = 22000000,
        volume_ml = 133000,
        longest_side_mm = 910,
        price_cents = 1500,
        price_postapoc_cents = 350,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        looks_like = "aquarium_medium",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 113000,
        max_weight_milligrams = 180000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "aquarium_small" },
        message = ccb.content.text("You check that the aquarium does indeed hold water, it is ready."),
        moves = 100,
        minimum_age_turns = 604800,
        not_ready_message = ccb.content.text("The silicone hasn't dried quite yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- The time it takes is a week and this appears to be the minimum time the internet says it takes.
    local item = content.Item {
        id = "aquarium_large_drying",
        category = "other",
        name = ccb.content.plural_text("100 gallon aquarium (drying) (obsolete)", "100 gallon aquariums (drying) (obsolete)"),
        description = ccb.content.text("A 100-gallon glass aquarium, used for safely storing small animals for use as pets or food.  This one has been freshly made and requires time for the silicone to dry."),
        ascii_picture = "aquarium_large",
        mass_milligrams = 80000000,
        volume_ml = 400000,
        longest_side_mm = 1830,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        melee_to_hit = -3,
        symbol = ")",
        color = "light_cyan",
        looks_like = "aquarium_medium",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:container_pocket {
        max_volume_ml = 378000,
        max_weight_milligrams = 500000000,
        rigid = true,
        watertight = false,
        open_container = true,
    }
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "aquarium_large" },
        message = ccb.content.text("You check that the aquarium does indeed hold water, it is ready."),
        moves = 100,
        minimum_age_turns = 604800,
        not_ready_message = ccb.content.text("The silicone hasn't dried quite yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    content.add(item)
end
