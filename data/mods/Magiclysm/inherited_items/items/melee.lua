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
