local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "eggs_ferment_active",
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
        countdown_turns = 201600,
    }
    item:material("glass", 1)
    item:material("egg", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:transform_into { target = "pickled_egg", container = "jar_glass_sealed", charges = 10 }
    content.add(item)
end

do
    local item = content.Item {
        id = "flask_yeast_active",
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
        countdown_turns = 43200,
    }
    item:material("glass", 1)
    item:material("powder", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:transform_into { target = "yeast", container = "jar_glass_sealed", charges = 50 }
    content.add(item)
end

do
    local item = content.Item {
        id = "milk_cream_rising_active",
        category = "food",
        name = ccb.content.plural_text("rising cream jar", "rising cream jars"),
        description = ccb.content.text("This jar contains raw milk separating into cream.  It transforms into a milk cream jar after 6 hours."),
        mass_milligrams = 3461000,
        volume_ml = 3850,
        longest_side_mm = 298,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        looks_like = "jar_glass_sealed",
        color = "white",
        countdown_turns = 21600,
    }
    item:material("glass", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:transform_into { target = "milk_cream_jar" }
    content.add(item)
end

do
    local item = content.Item {
        id = "pickles_ferment_active",
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
        countdown_turns = 201600,
    }
    item:material("glass", 1)
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:transform_into { target = "pickle", container = "jar_glass_sealed", charges = 8 }
    content.add(item)
end

do
    local item = content.Item {
        id = "sauerkraut_ferment_active",
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
        countdown_turns = 201600,
    }
    item:material("glass", 1)
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:transform_into { target = "sauerkraut", container = "jar_glass_sealed", charges = 2 }
    content.add(item)
end

do
    local item = content.Item {
        id = "teapot",
        category = "tools",
        name = ccb.content.plural_text("teapot", "teapots"),
        description = ccb.content.text("A small metal teapot.  Teatime wouldn't be complete without one."),
        mass_milligrams = 265000,
        volume_ml = 1600,
        longest_side_mm = 170,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "dark_gray",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 500, max_weight_milligrams = 2000000, watertight = true, rigid = true }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end
