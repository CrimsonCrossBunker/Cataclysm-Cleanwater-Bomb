local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bio_claws_weapon",
        name = ccb.content.plural_text("bionic claws", "bionic claws"),
        description = ccb.content.text("Short, sharp claws made from a high-tech metal."),
        melee_to_hit = -1,
        color = "light_gray",
        symbol = "{",
        volume_ml = 500,
        weapon_categories = { "BIONIC_WEAPONRY", "CLAWS" },
        replace_qualities = true,
    }
    item:material("superalloy", 1)
    item:clear_flags()
    item:flag("BIONIC_WEAPON")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("BIONIC_WEAPON_MELEE")
    item:flag("TRADER_AVOID")
    item:flag("ZERO_WEIGHT")
    item:flag("ALLOWS_BODY_BLOCK")
    item:quality("CUT", 2)
    item:quality("BUTCHER", 12)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("stab", 16)
    content.add(item)
end

do
    local item = content.Item {
        id = "bio_blade_weapon",
        name = ccb.content.plural_text("monomolecular blade", "monomolecular blades"),
        description = ccb.content.text("A foot-long blade made from high-tech alloy and edged with bonded nanocrystals."),
        melee_to_hit = 0,
        mass_milligrams = 100000,
        color = "dark_gray",
        symbol = "{",
        techniques = { "WBLOCK_2" },
        volume_ml = 750,
        longest_side_mm = 300,
        weapon_categories = { "BIONIC_WEAPONRY", "BIONIC_SWORDS" },
        replace_qualities = true,
    }
    item:material("superalloy", 1)
    item:clear_flags()
    item:flag("BIONIC_WEAPON")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("BIONIC_WEAPON_MELEE")
    item:flag("TRADER_AVOID")
    item:quality("CUT", 2)
    item:quality("BUTCHER", 22)
    item:clear_melee_damage()
    item:melee_damage("cut", 28)
    content.add(item)
end
