local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dog_whistle",
        name = ccb.content.plural_text("dog whistle", "dog whistles"),
        description = ccb.content.text("A small whistle.  When blown into, it produces a high tone that causes nearby friendly dogs to either follow you closely and stop attacking, or start attacking enemies if they are currently docile."),
        mass_milligrams = 22000,
        volume_ml = 5,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "yellow",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("DOG_WHISTLE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "shears",
        name = ccb.content.plural_text("shears", "shears"),
        description = ccb.content.text("A set of shears designed to obtain wool from sheep."),
        mass_milligrams = 820000,
        volume_ml = 750,
        price_cents = 500,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 1)
    item:quality("FABRIC_CUT", 1)
    item:quality("SHEAR", 1)
    item:quality("BUTCHER", 3)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "forged_shears",
        name = ccb.content.plural_text("forged shears", "forged shears"),
        description = ccb.content.text("A set of heavy-duty shears designed to obtain wool from sheep.  Made of two steel blades connected by spring leaf."),
        mass_milligrams = 820000,
        volume_ml = 750,
        price_cents = 500,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 1)
    item:quality("FABRIC_CUT", 1)
    item:quality("SHEAR", 1)
    item:quality("BUTCHER", 3)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_shears",
        name = ccb.content.plural_text("bronze shears", "bronze shears"),
        description = ccb.content.text("A set of forged single-piece bronze shears for cutting fabrics.  Made of two painstakingly sharpened blades connected by a carefully tempered twisted bridge."),
        mass_milligrams = 900000,
        volume_ml = 750,
        price_cents = 500,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = ";",
        color = "yellow",
        looks_like = "forged_shears",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("bronze", 1)
    item:quality("CUT", 1)
    item:quality("FABRIC_CUT", 1)
    item:quality("SHEAR", 1)
    item:quality("BUTCHER", 3)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pet_carrier_wooden",
        copy_from = "pet_carrier",
        name = ccb.content.plural_text("wooden pet carrier", "wooden pet carriers"),
        description = ccb.content.text("A wooden container meant to hold pets for transport.  Use it on a suitable animal to capture, use it on an empty tile to release."),
        mass_milligrams = 1500000,
        volume_ml = 6250,
        price_cents = 800,
        price_postapoc_cents = 50,
        symbol = "#",
        color = "brown",
        looks_like = "pet_carrier",
    }
    item:material("wood", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "firefly_terrarium",
        name = ccb.content.plural_text("survivor giant firefly lamp", "survivor giant firefly lamps"),
        description = ccb.content.text("Some enterprising survivor has decided to turn this terrarium into a light source, using what appear to be a giant firefly and triffid vegetation."),
        mass_milligrams = 30000000,
        volume_ml = 37000,
        price_cents = 800,
        price_postapoc_cents = 1200,
        symbol = "#",
        color = "white_yellow",
        looks_like = "pet_carrier",
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_firefly_terrarium")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dog_whistle_wood",
        name = ccb.content.plural_text("wooden dog whistle", "wooden dog whistles"),
        description = ccb.content.text("A whistle carved out of hardwood.  When blown into, it produces a high tone that causes nearby friendly dogs to either follow you closely and stop attacking, or start attacking enemies if they are currently docile."),
        mass_milligrams = 50000,
        volume_ml = 20,
        price_cents = 800,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "yellow",
        looks_like = "dog_whistle",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:native_use("DOG_WHISTLE")
    item:tool()
    content.add(item)
end
