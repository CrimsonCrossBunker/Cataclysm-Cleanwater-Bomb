local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "art_trident",
        copy_from = "art_spear",
        name = ccb.content.plural_text("impossible trident", "impossible tridents"),
        description = ccb.content.text("A large trident made entirely out of an indiscernible material.  The prong in the middle seems to fade away into nothingness when looked at from the top, but you can clearly see the shaft connecting the tip of the weapon from the bottom.  It's giving you a headache.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        looks_like = "pitchfork",
        color = "dark_gray",
        techniques = { "WBLOCK_1", "DEF_DISARM", "MOUNTED_CHARGE" },
        volume_ml = 1750,
        longest_side_mm = 1400,
        replace_qualities = true,
    }
    item:material("anomaly", 1)
    item:quality("COOK", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 28)
    item:tool()
    content.add(item)
end
