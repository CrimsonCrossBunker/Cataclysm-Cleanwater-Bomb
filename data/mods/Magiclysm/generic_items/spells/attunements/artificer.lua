local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "artificer_toolkit",
        name = ccb.content.plural_text("artificer's toolkit", "artificer's toolkits"),
        description = ccb.content.text("This is a magical device that can take the shape of many tools.  When not in use it looks like a simple screwdriver."),
        looks_like = "screwdriver",
        mass_milligrams = 170000,
        volume_ml = 40,
        longest_side_mm = 250,
        price_cents = 450,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
    }
    item:quality("AXE", 2)
    item:quality("BOIL", 2)
    item:quality("BUTCHER", 20)
    item:quality("CHISEL", 2)
    item:quality("CHISEL_WOOD", 2)
    item:quality("CONTAIN", 1)
    item:quality("COOK", 5)
    item:quality("CUT", 5)
    item:quality("CUT_FINE", 4)
    item:quality("DIG", 2)
    item:quality("FILE", 2)
    item:quality("LEATHER_AWL", 2)
    item:quality("LOCKPICK", 10)
    item:quality("HAMMER", 3)
    item:quality("HAMMER_FINE", 3)
    item:quality("HAMMER_SOFT", 3)
    item:quality("HOSE", 1)
    item:quality("KNIT", 2)
    item:quality("PRY", 3)
    item:quality("PULL", 2)
    item:quality("PUNCH", 3)
    item:quality("SAW_M", 4)
    item:quality("SAW_M_FINE", 3)
    item:quality("SAW_W", 3)
    item:quality("SCREW", 3)
    item:quality("SEW", 2)
    item:quality("SEW_CURVED", 2)
    item:quality("SHEAR", 2)
    item:quality("SMOKE_PIPE", 1)
    item:quality("SMOOTH", 2)
    item:quality("SURFACE", 1)
    item:quality("WRENCH", 3)
    item:quality("WRENCH_FINE", 4)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("BELT_CLIP")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 6)
    content.add(item)
end
