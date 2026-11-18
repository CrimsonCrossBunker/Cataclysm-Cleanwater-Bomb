local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "disc_golf",
        category = "other",
        price_cents = 1000,
        price_postapoc_cents = 50,
        name = ccb.content.plural_text("disc", "discs"),
        symbol = "o",
        color = "red",
        description = ccb.content.text("A plastic disc made for playing disc golf.  It is smaller and denser than a normal frisbee."),
        volume_ml = 250,
        mass_milligrams = 170000,
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:throwing_damage { { type = "bash", amount = 1 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "lawn_dart",
        category = "weapons",
        price_cents = 1000,
        price_postapoc_cents = 250,
        name = ccb.content.plural_text("lawn dart", "lawn darts"),
        symbol = ";",
        color = "yellow",
        description = ccb.content.text("A large plastic dart made for outdoor games."),
        volume_ml = 500,
        mass_milligrams = 175000,
        longest_side_mm = 300,
        melee_to_hit = -1,
    }
    item:material("plastic", 1)
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 4)
    item:throwing_damage { { type = "stab", amount = 12 } }
    content.add(item)
end

do
    -- These are plumbatae, but that's probably not a well known word.
    local item = content.Item {
        id = "weighted_dart",
        category = "weapons",
        price_cents = 1000,
        price_postapoc_cents = 250,
        name = ccb.content.plural_text("weighted dart", "weighted darts"),
        symbol = ";",
        color = "dark_gray",
        description = ccb.content.text("A lead weighted dart for throwing at enemies, like the Romans used."),
        volume_ml = 500,
        mass_milligrams = 300000,
        longest_side_mm = 300,
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:material("iron", 1)
    item:material("lead", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 8)
    item:throwing_damage { { type = "stab", amount = 18 }, { type = "bash", amount = 4 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "throwing_axe",
        category = "weapons",
        price_cents = 12400,
        price_postapoc_cents = 1000,
        name = ccb.content.plural_text("throwing axe", "throwing axes"),
        symbol = ";",
        color = "light_gray",
        description = ccb.content.text("A lightweight hatchet made for throwing.  Its ineffective cutting edge and light weight make it unsuitable for use as a tool."),
        volume_ml = 3058,
        mass_milligrams = 1000000,
        longest_side_mm = 430,
        melee_to_hit = -1,
        weapon_categories = { "HAND_AXES" },
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 17)
    item:throwing_damage { { type = "bash", amount = 6 }, { type = "cut", amount = 16 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "throwing_knife",
        category = "weapons",
        price_cents = 5200,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        name = ccb.content.plural_text("throwing knife", "throwing knives"),
        symbol = ";",
        color = "light_gray",
        description = ccb.content.text("A thin, flat knife made for throwing.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
        volume_ml = 56,
        mass_milligrams = 200000,
        longest_side_mm = 350,
        weapon_categories = { "KNIVES" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 10)
    item:throwing_damage { { type = "stab", amount = 14 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "throwing_stick",
        category = "weapons",
        name = ccb.content.plural_text("throwing stick", "throwing sticks"),
        description = ccb.content.text("A stick carved into a shape suitable for throwing at a target.  It's not a boomerang, so don't expect it to return to your hand."),
        mass_milligrams = 574000,
        volume_ml = 500,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NOGIB")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 7)
    item:throwing_damage { { type = "bash", amount = 2 }, { type = "stab", amount = 6 } }
    content.add(item)
end

do
    -- Had to mess with the weight and volume to get the right range, 17-18 tiles. They also have wide-bladed heads, instead of points, so cut damage.
    local item = content.Item {
        id = "javelin_fletched",
        name = ccb.content.plural_text("iron war dart", "iron war darts"),
        description = ccb.content.text("An iron-tipped fletched throwing spear with a throwing loop for extra range."),
        mass_milligrams = 600000,
        color = "light_gray",
        symbol = "/",
        volume_ml = 800,
        longest_side_mm = 800,
        melee_to_hit = -1,
        weapon_categories = { "POLEARMS", "SPEARS" },
        price_cents = 9000,
        price_postapoc_cents = 500,
    }
    item:material("wood", 1)
    item:material("iron", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("JAVELIN")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 18)
    item:throwing_damage { { type = "bash", amount = 5 }, { type = "cut", amount = 17 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "javelin_fletched_bronze",
        name = ccb.content.plural_text("bronze war dart", "bronze war darts"),
        description = ccb.content.text("A bronze-tipped fletched throwing spear with a throwing loop for extra range."),
        mass_milligrams = 600000,
        color = "light_gray",
        symbol = "/",
        volume_ml = 800,
        longest_side_mm = 800,
        melee_to_hit = -1,
        weapon_categories = { "POLEARMS", "SPEARS" },
        price_cents = 9000,
        price_postapoc_cents = 500,
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("JAVELIN")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 16)
    item:throwing_damage { { type = "bash", amount = 5 }, { type = "cut", amount = 15 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_huntsman_javelin",
        name = ccb.content.plural_text("huntsman outgrowth", "huntsman outgrowths"),
        copy_from = "javelin_fletched",
        looks_like = "javelin_fletched",
        symbol = "/",
        color = "light_gray",
        description = ccb.content.text("A wet alien rod with a sharp point at the end, vaguely shaped like a javelin of sorts.  It is heavier than what you expected, and gives off a weird acidic smell you can't quite describe."),
        volume_ml = 1400,
        mass_milligrams = 1200000,
        longest_side_mm = 760,
        stack_size = 1,
        melee_to_hit = -1,
        weapon_categories = { "POLEARMS", "SPEARS" },
        price_cents = 0,
        price_postapoc_cents = 50,
    }
    item:material("bone", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("JAVELIN")
    item:flag("NPC_THROWN")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 10)
    item:throwing_damage { { type = "bash", amount = 5 }, { type = "stab", amount = 10 } }
    item:ammunition {
        type = "nether_huntsman_javelin_ammo",
        count = 1,
        dispersion = 15,
        loudness = 0,
        recovery_chance = 90,
        stack_size = 1,
        damage = { { type = "stab", amount = 14 } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_clay_250",
        name = ccb.content.plural_text("clay sling bullet (250g)", "clay sling bullets (250g)"),
        symbol = "=",
        color = "brown",
        description = ccb.content.text("A baked clay sling bullet, shaped for stable flight.  It will likely shatter on impact."),
        volume_ml = 140,
        mass_milligrams = 250000,
        throwing_recovery_chance = 10,
    }
    item:material("clay", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 6 } }
    item:ammunition { type = "pebble", recovery_chance = 10, damage = { { type = "bash", amount = 12 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_clay_500",
        name = ccb.content.plural_text("clay sling bullet (500g)", "clay sling bullets (500g)"),
        symbol = "=",
        color = "brown",
        description = ccb.content.text("A baked clay sling bullet, shaped for stable flight.  It will likely shatter on impact."),
        volume_ml = 275,
        mass_milligrams = 500000,
        throwing_recovery_chance = 5,
    }
    item:material("clay", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 7.5 } }
    item:ammunition { type = "pebble", recovery_chance = 5, damage = { { type = "bash", amount = 15 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_clay_750",
        name = ccb.content.plural_text("clay sling bullet (750g)", "clay sling bullets (750g)"),
        symbol = "=",
        color = "brown",
        description = ccb.content.text("A baked clay sling bullet, shaped for stable flight.  It will likely shatter on impact."),
        volume_ml = 400,
        mass_milligrams = 750000,
        throwing_recovery_chance = 0,
    }
    item:material("clay", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 9 } }
    item:ammunition { type = "pebble", recovery_chance = 0, damage = { { type = "bash", amount = 18 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_stone_250",
        name = ccb.content.plural_text("stone sling bullet (250g)", "stone sling bullets (250g)"),
        symbol = "=",
        color = "light_gray",
        looks_like = "pebble",
        description = ccb.content.text("A stone sling bullet, polished into a smooth round shape for improved accuracy."),
        volume_ml = 100,
        mass_milligrams = 250000,
        throwing_recovery_chance = 80,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 5 } }
    item:ammunition { type = "pebble", recovery_chance = 80, damage = { { type = "bash", amount = 10 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_stone_500",
        name = ccb.content.plural_text("stone sling bullet (500g)", "stone sling bullets (500g)"),
        symbol = "=",
        color = "light_gray",
        looks_like = "pebble",
        description = ccb.content.text("A stone sling bullet, polished into a smooth round shape for improved accuracy."),
        volume_ml = 200,
        mass_milligrams = 500000,
        throwing_recovery_chance = 70,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 6 } }
    item:ammunition { type = "pebble", recovery_chance = 70, damage = { { type = "bash", amount = 12 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_stone_750",
        name = ccb.content.plural_text("stone sling bullet (750g)", "stone sling bullets (750g)"),
        symbol = "=",
        color = "light_gray",
        looks_like = "pebble",
        description = ccb.content.text("A stone sling bullet, polished into a smooth round shape for improved accuracy."),
        volume_ml = 300,
        mass_milligrams = 750000,
        throwing_recovery_chance = 60,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 7 } }
    item:ammunition { type = "pebble", recovery_chance = 60, damage = { { type = "bash", amount = 14 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_steel_250",
        name = ccb.content.plural_text("steel sling bullet (250g)", "steel sling bullets (250g)"),
        symbol = "=",
        color = "dark_gray",
        looks_like = "bearing",
        description = ccb.content.text("A solid steel ball, perfectly round and polished, ideal for sling use.  Heavy for its size."),
        volume_ml = 35,
        mass_milligrams = 250000,
        throwing_recovery_chance = 95,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 6, armor_penetration = 5 } }
    item:ammunition {
        type = "pebble",
        recovery_chance = 95,
        damage = { { type = "bash", amount = 12, armor_penetration = 5 } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_steel_500",
        name = ccb.content.plural_text("steel sling bullet (500g)", "steel sling bullets (500g)"),
        symbol = "=",
        color = "dark_gray",
        looks_like = "bearing",
        description = ccb.content.text("A solid steel ball, perfectly round and polished, ideal for sling use.  Heavy for its size."),
        volume_ml = 70,
        mass_milligrams = 500000,
        throwing_recovery_chance = 90,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 8, armor_penetration = 9 } }
    item:ammunition {
        type = "pebble",
        recovery_chance = 90,
        damage = { { type = "bash", amount = 16, armor_penetration = 9 } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_steel_750",
        name = ccb.content.plural_text("steel sling bullet (750g)", "steel sling bullets (750g)"),
        symbol = "=",
        color = "dark_gray",
        looks_like = "bearing",
        description = ccb.content.text("A solid steel ball, perfectly round and polished, ideal for sling use.  Heavy for its size."),
        volume_ml = 100,
        mass_milligrams = 750000,
        throwing_recovery_chance = 85,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 10, armor_penetration = 12 } }
    item:ammunition {
        type = "pebble",
        recovery_chance = 85,
        damage = { { type = "bash", amount = 20, armor_penetration = 12 } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_lead_250",
        name = ccb.content.plural_text("lead sling bullet (250g)", "lead sling bullets (250g)"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A lead sling bullet cast into a biconical shape for stable flight.  Extremely dense and hits hard."),
        volume_ml = 25,
        mass_milligrams = 250000,
        throwing_recovery_chance = 50,
    }
    item:material("lead", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 7.5 } }
    item:ammunition { type = "pebble", recovery_chance = 50, damage = { { type = "bash", amount = 15 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_lead_500",
        name = ccb.content.plural_text("lead sling bullet (500g)", "lead sling bullets (500g)"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A lead sling bullet cast into a biconical shape for stable flight.  Extremely dense and hits hard."),
        volume_ml = 50,
        mass_milligrams = 500000,
        throwing_recovery_chance = 40,
    }
    item:material("lead", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 9.5 } }
    item:ammunition { type = "pebble", recovery_chance = 40, damage = { { type = "bash", amount = 19 } } }
    content.add(item)
end

do
    local item = content.Item {
        id = "sling_bullet_lead_750",
        name = ccb.content.plural_text("lead sling bullet (750g)", "lead sling bullets (750g)"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A lead sling bullet cast into a biconical shape for stable flight.  Extremely dense and hits hard."),
        volume_ml = 75,
        mass_milligrams = 750000,
        throwing_recovery_chance = 30,
    }
    item:material("lead", 1)
    item:clear_flags()
    item:flag("NPC_THROWN")
    item:flag("SLING_PROJECTILE")
    item:throwing_damage { { type = "bash", amount = 11.5 } }
    item:ammunition { type = "pebble", recovery_chance = 30, damage = { { type = "bash", amount = 23 } } }
    content.add(item)
end
