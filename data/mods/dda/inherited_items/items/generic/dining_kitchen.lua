local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_tin_dish",
        abstract = true,
        name = content.plural_text("generic tin dish", "generic tin dishes"),
        description = content.text("generic item template"),
        symbol = ")",
        color = "light_gray",
        price_cents = 400,
        price_postapoc_cents = 0,
        mass_milligrams = 262000,
        volume_ml = 262,
        melee_to_hit = -5,
    }
    item:material("tin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "tin_cup",
        category = "container",
        name = ccb.content.plural_text("tin cup", "tin cups"),
        symbol = "u",
        description = ccb.content.text("An enameled tin cup.  Great for camping or for prison use; makes a wonderful sound when clanged along bars."),
        looks_like = "ceramic_cup",
        copy_from = "base_tin_dish",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:container_pocket {
        max_volume_ml = 250,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:adjust_measurements { mass_milligrams = { factor = 0.8 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_straw",
        category = "other",
        name = ccb.content.plural_text("plastic straw", "plastic straws"),
        description = ccb.content.text("A plastic straw, for drinking things and littering."),
        copy_from = "base_plastic_silverware",
    }
    item:adjust_measurements { volume_ml = { factor = 0.5 }, mass_milligrams = { factor = 0.7 } }
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B000ARPJRM
    local item = content.Item {
        id = "rolling_pin",
        category = "other",
        ascii_picture = "rolling_pin",
        name = ccb.content.plural_text("rolling pin", "rolling pins"),
        description = ccb.content.text("A stout piece of hardwood, turned and sanded smooth, with rounded handles at the ends.  This timeless kitchen tool also doubles as an effective club."),
        mass_milligrams = 318000,
        longest_side_mm = 460,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "RAPID" },
        volume_ml = 1450,
        price_cents = 800,
        price_postapoc_cents = 5,
        melee_to_hit = -3,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "steel_pan",
        category = "tools",
        name = ccb.content.plural_text("steel frying pan", "steel frying pans"),
        description = ccb.content.text("A steel frying pan.  Makes a decent melee weapon, and is used for cooking."),
        copy_from = "base_cookpot",
        color = "light_gray",
        looks_like = "pan",
        mass_milligrams = 660000,
        volume_ml = 3000,
        longest_side_mm = 350,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:adjust_quality("COOK", -1)
    content.add(item)
end

do
    local item = content.Item {
        id = "copper_pan",
        category = "tools",
        name = ccb.content.plural_text("copper frying pan", "copper frying pans"),
        description = ccb.content.text("A copper frying pan, coated in a thin layer of tin.  Makes a decent melee weapon, and is used for cooking."),
        copy_from = "base_cookpot",
        color = "light_red",
        looks_like = "pan",
        mass_milligrams = 628000,
        volume_ml = 3000,
        longest_side_mm = 350,
        replace_pockets = true,
    }
    item:material("copper", 1)
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 1000000,
        watertight = true,
        open_container = true,
        rigid = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:adjust_quality("COOK", -1)
    content.add(item)
end
