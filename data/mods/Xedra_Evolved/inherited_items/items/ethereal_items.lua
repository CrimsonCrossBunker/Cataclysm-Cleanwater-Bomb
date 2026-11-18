local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rapier_dreamdross",
        name = ccb.content.plural_text("dreamdross rapier", "dreamdross rapiers"),
        description = ccb.content.text("This is a thin ephemeral sword with an ornate hand guard.  It looks like the preferred weapon of gentlemen and swashbucklers.  Light and quick, it makes any battle a stylish one."),
        mass_milligrams = 500000,
        volume_ml = 1500,
        longest_side_mm = 1000,
        price_cents = 98000,
        price_postapoc_cents = 2500,
        melee_to_hit = 2,
        symbol = "/",
        color = "light_gray",
        looks_like = "rapier",
        techniques = { "RAPID", "WBLOCK_2", "PRECISE" },
        replace_qualities = true,
        weapon_categories = { "FENCING_WEAPONRY" },
        category = "weapons",
    }
    item:material("dreamstuff", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 9)
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    item:flag("SHEATH_SWORD")
    item:flag("RELIC_PINK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 31)
    item:melee_damage("cold", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "changeling_summer_sunglasses",
        copy_from = "fake_item",
        name = ccb.content.plural_text("Under the Noonday Sun", "Under the Noonday Suns"),
        description = ccb.content.text("You are protected from extremely bright lights."),
        replace_qualities = true,
    }
    item:quality("GLARE", 1)
    item:flag("SEMITANGIBLE")
    item:flag("INTEGRATED")
    item:flag("FLASH_PROTECTION")
    item:flag("SUN_GLASSES")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "vampire_blood_ball",
        category = "container",
        name = ccb.content.plural_text("blood-storing sphere", "blood-storing spheres"),
        looks_like = "jar_glass_sealed",
        description = ccb.content.text("A magical transparent sphere.  You can use it to store any type of blood, at least until the sphere vanishes."),
        mass_milligrams = 1000,
        volume_ml = 3050,
        longest_side_mm = 298,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "O",
        color = "red",
        replace_pockets = true,
    }
    item:material("blood", 1)
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 20000000,
        rigid = true,
        watertight = true,
        allowed_materials = { "blood", "hblood", "vampire_blood" },
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:flag("TRADER_AVOID")
    content.add(item)
end
