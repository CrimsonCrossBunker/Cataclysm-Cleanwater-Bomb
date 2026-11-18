local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "scalpel",
        name = ccb.content.plural_text("scalpel", "scalpels"),
        description = ccb.content.text("A very sharp knife designed for surgical cutting.  Its small, sharp blade allows for precision strikes in the hands of the skilled."),
        ascii_picture = "scalpel",
        mass_milligrams = 23000,
        volume_ml = 15,
        longest_side_mm = 130,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 3)
    item:quality("BUTCHER", 8)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("cut", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "thermometer",
        category = "tools",
        name = ccb.content.plural_text("thermometer", "thermometers"),
        description = ccb.content.text("A plastic thermometer that can read the air temperature."),
        mass_milligrams = 10000,
        volume_ml = 25,
        price_cents = 100,
        price_postapoc_cents = 10,
        ascii_picture = "thermometer",
        symbol = ";",
        color = "red",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("THERMOMETER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scissors_medical",
        name = ccb.content.plural_text("medical scissors", "medical scissors"),
        description = ccb.content.text("A pair of medical scissors, typically used by nurses or paramedics to cut bandages or fabric."),
        ascii_picture = "scissors",
        mass_milligrams = 50000,
        volume_ml = 95,
        longest_side_mm = 140,
        price_cents = 700,
        price_postapoc_cents = 20,
        melee_to_hit = -3,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 2)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("stab", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dental_tools",
        name = ccb.content.plural_text("dental tool set", "dental tool sets"),
        description = ccb.content.text("A set of picks, hooks, and scrapers designed for cleaning teeth."),
        mass_milligrams = 160000,
        volume_ml = 370,
        longest_side_mm = 200,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "?",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("LOCKPICK", 1)
    item:quality("LEATHER_AWL", 1)
    item:quality("PUNCH", 1)
    item:clear_melee_damage()
    item:melee_damage("stab", 1)
    item:tool()
    content.add(item)
end
