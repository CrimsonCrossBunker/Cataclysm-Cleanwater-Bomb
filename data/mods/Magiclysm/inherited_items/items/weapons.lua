local ccb = require("ccb")
local content = ccb.content

do
    -- A heavier version of the standard shillelagh (from melee.json) with a different description to match the lizardfolk lore.  Not craftable, but wieldable if discovered.
    local item = content.Item {
        id = "lizardfolk_club",
        name = ccb.content.plural_text("greatclub", "greatclubs"),
        category = "weapons",
        copy_from = "shillelagh",
        looks_like = "shillelagh",
        description = ccb.content.text("A stout knotty club with a large knob at the top.  While it's very heavy, it's a very effective weapon in the hands of a strong opponent."),
        mass_milligrams = 10000000,
        volume_ml = 8000,
        price_cents = 5000,
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("ALWAYS_TWOHAND")
    item:flag("TRADER_AVOID")
    item:flag("SLOW_WIELD")
    item:flag("FIREWOOD")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 22)
    content.add(item)
end

do
    local item = content.Item {
        id = "lizardfolk_trident",
        name = ccb.content.plural_text("wood trident", "wood tridents"),
        copy_from = "spear_wood_simple",
        looks_like = "spear_wood_simple",
        description = ccb.content.text("A wooden melee weapon with a hand-forged steel forked spearhead attached to the end.  It can be used for stabbing opponents either in close-range or as a thrown weapon, and in the right hands can also readily disarm opponents."),
        mass_milligrams = 1650000,
        techniques = { "WBLOCK_2", "DEF_DISARM", "IMPALE", "MOUNTED_CHARGE" },
        volume_ml = 3000,
        price_cents = 15000,
    }
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 29)
    content.add(item)
end

do
    -- A barbed version of the standard javelin (from spears_and_polearms.json) with a different description to match the lizardfolk lore.  Not craftable, but wieldable if discovered.
    local item = content.Item {
        id = "lizardfolk_javelin",
        name = ccb.content.plural_text("barbed javelin", "barbed javelins"),
        category = "weapons",
        copy_from = "javelin",
        looks_like = "javelin",
        description = ccb.content.text("This weapon measures about 3 feet in length and is fletched like an arrow for better accuracy.  The business end of the javelin has wicked-looking barbs which could cause significant bleeding."),
        mass_milligrams = 2500000,
        volume_ml = 2830,
    }
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("SHEATH_SPEAR")
    item:flag("JAVELIN")
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end
