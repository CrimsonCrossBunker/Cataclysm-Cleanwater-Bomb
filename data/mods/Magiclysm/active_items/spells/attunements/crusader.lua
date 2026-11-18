local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "longsword_judgement",
        name = ccb.content.plural_text("sword of judgement", "swords of judgement"),
        looks_like = "longsword",
        symbol = "/",
        color = "light_gray",
        price_cents = 0,
        price_postapoc_cents = 0,
        description = ccb.content.text("A large sword made of glowing, radiant fire.  It explodes with radiance when striking enemies."),
        weapon_categories = { "LONG_SWORDS", "GREAT_SWORDS" },
        techniques = { "RSTRIKE", "WBLOCK_2", "BRUTAL", "RAPID" },
        melee_to_hit = 2,
        mass_milligrams = 1067000,
        volume_ml = 2750,
        longest_side_mm = 1200,
    }
    item:material("concentrated_mana", 1)
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:flag("SHEATH_SWORD")
    item:flag("RELIC_PINK")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "dagger_judgement" },
        message = ccb.content.text("Concentrating, you change your sword into a much smaller, quicker blade."),
        menu_text = ccb.content.text("Transform to dagger."),
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 13)
    item:melee_damage("cut", 45)
    item:melee_damage("light", 15)
    content.add(item)
end

do
    local item = content.Item {
        id = "dagger_judgement",
        name = ccb.content.plural_text("dagger of judgement", "daggers of judgement"),
        symbol = "/",
        color = "light_gray",
        looks_like = "kris",
        description = ccb.content.text("A short blade made of glowing, radiant fire.  It explodes with radiance when striking enemies."),
        melee_to_hit = 0,
        mass_milligrams = 328000,
        volume_ml = 750,
        longest_side_mm = 500,
        techniques = { "RSTRIKE", "WBLOCK_1", "RAPID" },
        weapon_categories = { "KNIVES" },
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:flag("SHEATH_KNIFE")
    item:flag("RELIC_PINK")
    item:material("concentrated_mana", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "zwei_judgement" },
        message = ccb.content.text("Concentrating, you change your dagger into a much larger, more intimidating form."),
        menu_text = ccb.content.text("Transform to great sword."),
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("stab", 28)
    item:melee_damage("light", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "zwei_judgement",
        name = ccb.content.plural_text("great sword of judgement", "great swords of judgement"),
        symbol = "/",
        color = "light_gray",
        looks_like = "zweihander",
        description = ccb.content.text("A very large sword glowing with radiant fire.  It explodes with radiance when striking enemies."),
        mass_milligrams = 1868000,
        volume_ml = 3250,
        longest_side_mm = 1800,
        techniques = { "RSTRIKE", "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
        melee_to_hit = 2,
        weapon_categories = { "GREAT_SWORDS" },
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("REACH_ATTACK")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:flag("SHEATH_SWORD")
    item:flag("RELIC_PINK")
    item:material("concentrated_mana", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "qiang_judgement" },
        message = ccb.content.text("Concentrating, you change your dagger into a longer, much more precise piercing form."),
        menu_text = ccb.content.text("Transform into spear."),
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 51)
    item:melee_damage("light", 22)
    content.add(item)
end

do
    local item = content.Item {
        id = "qiang_judgement",
        name = ccb.content.plural_text("spear of judgement", "spears of judgement"),
        symbol = "/",
        color = "light_gray",
        looks_like = "qiang",
        description = ccb.content.text("A very thin, nimble spear glowing with radiant fire.  It explodes with radiance when striking enemies."),
        mass_milligrams = 822000,
        volume_ml = 2500,
        longest_side_mm = 1800,
        techniques = { "RSTRIKE", "WBLOCK_1", "IMPALE" },
        weapon_categories = { "POLEARMS", "SPEARS" },
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:flag("SHEATH_SPEAR")
    item:flag("RELIC_PINK")
    item:material("concentrated_mana", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "mace_judgement" },
        message = ccb.content.text("Concentrating, you change your spear into a shorter, more hefty form."),
        menu_text = ccb.content.text("Transform to mace."),
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("stab", 34)
    item:melee_damage("light", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_judgement",
        name = ccb.content.plural_text("mace of judgement", "maces of judgement"),
        symbol = "/",
        color = "light_gray",
        looks_like = "mace",
        description = ccb.content.text("A short and hefty mace glowing with radiant fire.  It explodes with radiance when striking enemies."),
        melee_to_hit = 1,
        mass_milligrams = 882000,
        volume_ml = 1250,
        longest_side_mm = 800,
        techniques = { "RSTRIKE", "WBLOCK_1", "SWEEP" },
        weapon_categories = { "MACES" },
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:flag("BELT_CLIP")
    item:flag("RELIC_PINK")
    item:material("concentrated_mana", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "longsword_judgement" },
        message = ccb.content.text("Concentrating, you change your spear into a shorter, more robust blade."),
        menu_text = ccb.content.text("Transform to longsword."),
        need_wielding = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 45)
    item:melee_damage("light", 20)
    content.add(item)
end
