local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_titanium_bat",
        copy_from = "bat_metal",
        looks_like = "bat_metal",
        name = ccb.content.plural_text("titanium bat", "titanium bats"),
        description = ccb.content.text("A luxury baseball bat made out of titanium that was banned from competitive sport due to the increased performance that put defenders at risk."),
        mass_milligrams = 680000,
        color = "light_gray",
        symbol = "/",
        price_cents = 20000,
        price_postapoc_cents = 1750,
        weapon_categories = { "MACES" },
    }
    item:material("titanium", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 22)
    content.add(item)
end

do
    local item = content.Item {
        id = "trident",
        looks_like = "pitchfork",
        name = ccb.content.plural_text("trident", "tridents"),
        category = "tools",
        description = ccb.content.text("A three pronged spear that is surface treated to be used confidently above and below water."),
        mass_milligrams = 1200000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "DEF_DISARM" },
        volume_ml = 1750,
        longest_side_mm = 1400,
        replace_qualities = true,
        price_cents = 7500,
        price_postapoc_cents = 1200,
        melee_to_hit = 1,
        weapon_categories = { "POLEARMS", "SPEARS" },
    }
    item:material("steel", 1)
    item:material("ceramic", 1)
    item:quality("COOK", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 28)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_bio_whip_weapon",
        symbol = "/",
        color = "red",
        name = ccb.content.plural_text("monofilament whip", "monofilament whips"),
        description = ccb.content.text("A long filament of nested carbon nanotubes only a few microns in diameter.  In essence a very thin, very strong and very sharp blade that you throw at a moment's notice."),
        mass_milligrams = 40000,
        volume_ml = 200,
        price_cents = 3500,
        price_postapoc_cents = 500,
        techniques = { "WBLOCK_1", "WIDE", "SPIN", "RAPID" },
        melee_to_hit = -2,
        weapon_categories = { "BIONIC_WEAPONRY" },
    }
    item:material("nanotubes", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("NONCONDUCTIVE")
    item:flag("BIONIC_WEAPON")
    item:flag("BIONIC_WEAPON_MELEE")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("TRADER_AVOID")
    item:flag("USE_UPS")
    item:clear_melee_damage()
    item:melee_damage("cut", 27)
    content.add(item)
end
