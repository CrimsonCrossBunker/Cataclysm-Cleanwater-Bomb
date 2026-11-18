local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "milk_cream_rising",
        category = "food",
        name = ccb.content.plural_text("rising cream jar (obsolete)", "rising cream jars (obsolete)"),
        description = ccb.content.text("This jar contains raw milk separating into cream.  You can seal up the jar once the process is completed."),
        mass_milligrams = 3461000,
        volume_ml = 3850,
        longest_side_mm = 298,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        looks_like = "jar_glass_sealed",
        color = "white",
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "milk_cream_jar" },
        message = ccb.content.text("You examine the batch and see that the cream has risen to the top, so you seal the jar up for storage."),
        moves = 50,
        minimum_age_turns = 21600,
        not_ready_message = ccb.content.text("The cream has not risen yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "eggs_ferment",
        category = "food",
        name = ccb.content.plural_text("fermenting eggs jar", "fermenting eggs jars"),
        description = ccb.content.text("This jar contains a batch of eggs in a pickling solution.  You can seal up the jar once the process is completed."),
        mass_milligrams = 700000,
        volume_ml = 680,
        longest_side_mm = 132,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        color = "white",
    }
    item:material("glass", 1)
    item:material("egg", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "pickled_egg", container = "jar_glass_sealed", charges = 10 },
        message = ccb.content.text("You examine the batch and see that the pickling solution has done its job, so you seal the jar up for storage."),
        moves = 50,
        minimum_age_turns = 201600,
        not_ready_message = ccb.content.text("The eggs are not done yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- 12 hours
    local item = content.Item {
        id = "flask_yeast",
        category = "food",
        name = ccb.content.plural_text("sealed yeast culture", "sealed yeast culture"),
        description = ccb.content.text("A sealed jar holding sanitized yeast wort.  You may harvest the yeast inside when it's done culturing."),
        mass_milligrams = 460000,
        volume_ml = 680,
        longest_side_mm = 132,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        color = "white",
    }
    item:material("glass", 1)
    item:material("powder", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "yeast", container = "jar_glass_sealed", charges = 50 },
        message = ccb.content.text("You open the jar and harvest the culture."),
        moves = 50,
        minimum_age_turns = 43200,
        not_ready_message = ccb.content.text("The yeast isn't done culturing yet."),
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- 2 1/3 days, from the suggested recipe of 1 rl week
    local item = content.Item {
        id = "pickles_ferment",
        category = "food",
        name = ccb.content.plural_text("fermenting pickle jar", "fermenting pickle jars"),
        description = ccb.content.text("This jar contains a batch of pickles set to ferment.  You can seal up the jar once the process is completed."),
        mass_milligrams = 850000,
        volume_ml = 680,
        longest_side_mm = 132,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        color = "white",
    }
    item:material("glass", 1)
    item:material("veggy", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "pickle", container = "jar_glass_sealed", charges = 8 },
        message = ccb.content.text("You test the batch, and it tastes good, so you seal the jar up for storage."),
        moves = 50,
        minimum_age_turns = 201600,
        not_ready_message = ccb.content.text("The pickles are not done fermenting yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    -- 2 1/3 days, from the suggested recipe of 1 rl week
    local item = content.Item {
        id = "sauerkraut_ferment",
        category = "food",
        name = ccb.content.plural_text("fermenting sauerkraut jar", "fermenting sauerkraut jars"),
        description = ccb.content.text("This jar contains a batch of sauerkraut set to ferment.  You can seal up the jar once the process is completed."),
        mass_milligrams = 710000,
        volume_ml = 680,
        longest_side_mm = 132,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        color = "white",
    }
    item:material("glass", 1)
    item:material("veggy", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "sauerkraut", container = "jar_glass_sealed", charges = 2 },
        message = ccb.content.text("You test the batch, and it tastes good, so you seal the jar up for storage."),
        moves = 50,
        minimum_age_turns = 201600,
        not_ready_message = ccb.content.text("The sauerkraut isn't done fermenting yet."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end
