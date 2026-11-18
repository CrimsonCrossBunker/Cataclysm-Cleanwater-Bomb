local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "can_sealer",
        category = "tools",
        name = ccb.content.plural_text("can sealer", "can sealers"),
        description = ccb.content.text("A hand-crank-powered cast steel machine designed to automatically seal tin cans."),
        mass_milligrams = 9800000,
        volume_ml = 5000,
        price_cents = 52500,
        price_postapoc_cents = 2500,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_pot",
        category = "tools",
        name = ccb.content.plural_text("clay pot", "clay pots"),
        description = ccb.content.text("A crude clay pot used for cooking."),
        mass_milligrams = 480000,
        volume_ml = 2100,
        price_cents = 2500,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket {
        max_volume_ml = 2000,
        max_weight_milligrams = 2100000,
        open_container = true,
        watertight = true,
        rigid = true,
    }
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("CHEM", 1)
    item:clear_use_actions()
    item:native_use("HEAT_ALL_ITEMS")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "clay_teapot",
        category = "tools",
        name = ccb.content.plural_text("clay teapot", "clay teapots"),
        description = ccb.content.text("A clay teapot.  Now all you need is tea and water."),
        mass_milligrams = 429000,
        volume_ml = 787,
        price_cents = 2000,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("clay", 1)
    item:container_pocket { max_volume_ml = 750, max_weight_milligrams = 2000000, watertight = true, rigid = true }
    item:quality("BOIL", 1)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "milk_cream_jar",
        category = "food",
        name = ccb.content.plural_text("milk cream jar", "milk cream jars"),
        looks_like = "jar_glass_sealed",
        description = ccb.content.text("This jar contains raw milk separated into cream.  It is sealed until you are ready to use it."),
        mass_milligrams = 3461000,
        volume_ml = 3850,
        longest_side_mm = 298,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "%",
        color = "white",
    }
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "pastaextruder",
        category = "tools",
        name = ccb.content.plural_text("pasta extruder", "pasta extruders"),
        description = ccb.content.text("A pasta extruder powered by a hand crank.  Useful in making pasta.  It comes with various heads to make various kinds of pasta."),
        mass_milligrams = 650000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 100,
        symbol = ")",
        color = "dark_gray",
    }
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "sieve_primitive",
        category = "tools",
        name = ccb.content.plural_text("wicker sieve", "wicker sieves"),
        description = ccb.content.text("A primitive sieve constructed from woven strips of plant material.  Early sieves like this were used to sift grain, though the openings on this one are too small for that."),
        mass_milligrams = 50000,
        volume_ml = 500,
        price_cents = 300,
        price_postapoc_cents = 10,
        symbol = ";",
        replace_qualities = true,
        color = "light_gray",
    }
    item:material("paper", 1)
    item:quality("SIEVE", 1)
    item:quality("WINNOW", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sieve_steel",
        category = "tools",
        name = ccb.content.plural_text("sieve", "sieves"),
        description = ccb.content.text("This is no mere strainer for noodles; it's a laboratory-grade sieve used to separate particles of certain sizes.  You could use this to do a really good job sifting flour, remove dust and soil from grain, or perhaps conduct gradation tests for any civil engineers you might know.  This one has been constructed from steel mesh."),
        volume_ml = 500,
        mass_milligrams = 318000,
        price_cents = 700,
        price_postapoc_cents = 50,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("SIEVE", 2)
    item:quality("STRAIN", 1)
    item:quality("WINNOW", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "sieve_steel_makeshift",
        category = "tools",
        name = ccb.content.plural_text("makeshift sieve", "makeshift sieves"),
        description = ccb.content.text("Some fine steel mesh attached to a length of thicker steel wire, forming a rigid frame.  Useful for sieving."),
        volume_ml = 106,
        mass_milligrams = 170000,
        price_cents = 700,
        price_postapoc_cents = 50,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("SIEVE", 2)
    item:quality("STRAIN", 1)
    item:quality("WINNOW", 1)
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B07WWW1S84
    local item = content.Item {
        id = "waffleiron",
        category = "tools",
        name = ccb.content.plural_text("waffle iron", "waffle irons"),
        description = ccb.content.text("A waffle iron, generally used for making waffles."),
        mass_milligrams = 520000,
        volume_ml = 870,
        longest_side_mm = 300,
        price_cents = 1600,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        symbol = ")",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("aluminum", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end
