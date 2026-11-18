local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mjolnir",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("Mjölnir", "Mjölnirs"),
        description = ccb.content.text("Mjölnir, the legendary hammer of Thor.  It is rumored to be able to level mountains with a single blow.  You feel the power of Asgard coursing through the hammer."),
        mass_milligrams = 1731000,
        color = "light_gray",
        techniques = { "WBLOCK_2", "BRUTAL", "MOUNTED_CHARGE" },
        volume_ml = 2500,
        price_cents = 200000,
    }
    item:material("orichalcum_metal", 1)
    item:material("wood", 1)
    item:material("gold", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 45)
    item:melee_damage("stab", 23)
    content.upsert_item(item)
end

do
    local item = content.Item {
        id = "gungnir",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("Gungnir", "Gungnirs"),
        description = ccb.content.text("Gungnir, the spear of Odin.  It is rumored to be the perfect spear, perfectly hitting any target regardless of the wielder's strength or skill.  It feels like Odin's protecting you."),
        mass_milligrams = 1854000,
        techniques = { "WBLOCK_1", "IMPALE", "SWEEP", "MOUNTED_CHARGE" },
        volume_ml = 3250,
        price_cents = 200000,
    }
    item:material("orichalcum_metal", 1)
    item:material("wood", 1)
    item:material("gold", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 35)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    content.add(item)
end

do
    local item = content.Item {
        id = "orich_knife_combat",
        copy_from = "knife_combat",
        looks_like = "knife_combat",
        name = ccb.content.plural_text("orichalcum combat knife", "orichalcum combat knives"),
        description = ccb.content.text("A variant of the combat knife that is made of orichalcum instead of steel.  Sharper and easier to maintain than steel while just as dense, this knife also has a thinner blade, which shaves off some weight."),
        color = "yellow",
    }
    item:material("orichalcum_metal", 1)
    item:adjust_measurements { price_cents = { factor = 5 }, mass_milligrams = { factor = 0.99 } }
    item:adjust_melee_damage { factors = { stab = 1.1 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "orich_longsword",
        copy_from = "longsword",
        looks_like = "longsword",
        name = ccb.content.plural_text("orichalcum longsword", "orichalcum longswords"),
        description = ccb.content.text("A variant of the longsword that is made of orichalcum instead of steel.  Sharper and easier to maintain than steel while just as dense, this longsword also has a thinner blade, which shaves off some weight."),
        color = "yellow",
    }
    item:material("orichalcum_metal", 1)
    item:adjust_measurements { price_cents = { factor = 5 }, mass_milligrams = { factor = 0.99 } }
    item:adjust_melee_damage { factors = { cut = 1.1 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "orich_fire_ax",
        copy_from = "fire_ax",
        looks_like = "fire_ax",
        name = ccb.content.plural_text("orichalcum fire axe", "orichalcum fire axes"),
        description = ccb.content.text("A fire axe made with orichalcum instead of steel.  This makes it possible to chop through harder materials, and in the very well-funded fire stations is preferred."),
        color = "yellow",
    }
    item:material("orichalcum_metal", 1)
    item:adjust_measurements { price_cents = { factor = 5 } }
    item:adjust_melee_damage { factors = { cut = 1.1 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "longsword_mithril",
        copy_from = "longsword",
        looks_like = "longsword",
        name = ccb.content.plural_text("longsword", "longswords"),
        description = ccb.content.text("This is a classic medieval sword, the size being in-between the lighter arming sword and later two-handed swords.  Thanks to the mysterious silvery metal it was forged from, it is stronger than tempered steel while weighing substantially less."),
        mass_milligrams = 939000,
    }
    item:material("mithril_metal", 1)
    item:adjust_melee_damage { factors = { bash = 0.7, cut = 1.5 } }
    item:tool()
    content.add(item)
end
