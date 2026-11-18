local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "magical_throwing_knife",
        copy_from = "throwing_knife",
        looks_like = "throwing_knife",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:material("concentrated_mana", 1)
    item:throwing_damage { { type = "stab", amount = 20, armor_penetration = 5 } }
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_fire",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing, wrapped in ethereal flames.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "heat", amount = 15 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_cold",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing, emanating frigid cold.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "cold", amount = 15 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_cut",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife with wide edge made for throwing, seems unnaturally sharp.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "cut", amount = 15, armor_multiplier = 0.2 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_biological",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing, made of porous substance and covered in dark ooze.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "biological", amount = 15 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_pure_special",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A transparent blade that seems to radiate intent to be thrown.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "pure", amount = 40 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "item_kelvinist_icy_freezing_container",
        category = "container",
        name = ccb.content.plural_text("freezer field", "freezer fields"),
        looks_like = "art_sphere",
        description = ccb.content.text("A large, hollow sphere of ice.  Food placed inside will not rot."),
        mass_milligrams = 3000000,
        volume_ml = 92000,
        longest_side_mm = 550,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -1,
        symbol = "o",
        color = "white",
        replace_pockets = true,
        replace_qualities = true,
        phase = "solid",
    }
    item:material("water", 1)
    item:container_pocket {
        max_volume_ml = 70000,
        max_weight_milligrams = 70000000,
        rigid = true,
        watertight = true,
        spoil_multiplier = 0.0,
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end
