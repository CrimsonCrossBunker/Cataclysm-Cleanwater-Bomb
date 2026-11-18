local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "beach_volleyball",
        symbol = "*",
        color = "green",
        name = ccb.content.plural_text("beach volleyball", "beach volleyballs"),
        category = "other",
        description = ccb.content.text("A brightly colored beach volleyball.  It is slightly larger than a regular white one."),
        price_cents = 1200,
        price_postapoc_cents = 10,
        mass_milligrams = 280000,
        volume_ml = 1000,
        longest_side_mm = 270,
    }
    item:material("rubber", 1)
    item:throwing_damage { { type = "bash", amount = 4 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "puck",
        symbol = "*",
        color = "dark_gray",
        name = ccb.content.plural_text("hockey puck", "hockey pucks"),
        category = "other",
        description = ccb.content.text("A heavy circular block of solid rubber, normally used for playing hockey.  You can throw it to cause some serious harm."),
        price_cents = 1000,
        price_postapoc_cents = 0,
        mass_milligrams = 170000,
        volume_ml = 250,
        longest_side_mm = 76,
    }
    item:material("rubber", 1)
    item:throwing_damage { { type = "bash", amount = 7 } }
    content.add(item)
end

do
    -- https://amz.run/7YNm
    local item = content.Item {
        id = "talking_doll",
        name = ccb.content.plural_text("talking doll", "talking dolls"),
        description = ccb.content.text("This is a talking doll, meant for children.  Fortunately it still works, and you could unload the batteries out of it."),
        mass_milligrams = 410000,
        volume_ml = 725,
        price_cents = 6000,
        price_postapoc_cents = 0,
        symbol = "|",
        color = "pink",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:native_use("DOLLCHAT")
    item:fault_group("electronic_general", {  })
    item:magazine_well { rigid = true, flags = { "BATTERY_LIGHT" }, default_magazine = "light_battery_cell" }
    item:tool { charges_per_use = 1, turns_per_charge = 20, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "creepy_doll",
        name = ccb.content.plural_text("talking doll", "talking dolls"),
        description = ccb.content.text("This is a talking doll, meant for children.  Fortunately it still works, and you could unload the batteries out of it."),
        copy_from = "talking_doll",
        looks_like = "talking_doll",
        symbol = "|",
        color = "pink",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "football",
        symbol = "*",
        color = "brown",
        name = ccb.content.plural_text("football", "footballs"),
        category = "other",
        description = ccb.content.text("An oval-shaped ball made of leather and string, it's easily thrown but does little damage.  You could take it apart into leather if you wanted."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 400000,
        volume_ml = 750,
        longest_side_mm = 290,
    }
    item:material("leather", 9)
    item:material("rubber", 1)
    content.add(item)
end

do
    -- lazerlyte trainer target was used as a reference
    -- 670 grams for the target with a bit extra for the generic laser + connectors
    local item = content.Item {
        id = "aim_game",
        symbol = "*",
        color = "white",
        name = ccb.content.plural_text("aim game target practice kit", "aim game target practice kits"),
        category = "other",
        description = ccb.content.text("A collection of laser guns and targets designed to help you practice shooting.  The spot you 'hit' is displayed on the targets."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 800000,
        volume_ml = 3500,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_minus_disposable_cell",
    }
    item:tool { charges_per_use = 50, ammo_types = { "battery" } }
    content.add(item)
end
