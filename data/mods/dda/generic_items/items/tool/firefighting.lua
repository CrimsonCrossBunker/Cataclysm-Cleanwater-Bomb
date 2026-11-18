local ccb = require("ccb")
local content = ccb.content

do
    --  If the pole itself has a diameter of around 3 cm which is thick, to be frank, then we half it for the radius -> 1,5 cm, square it -> 2,25, mulitplicate with pi -> ~7,07 cm² multiplicate with 160 cm length -> 1130 cm³ which is 1,13 liters. We add the hook which is around 100 ml of volume.
    local item = content.Item {
        id = "pike_pole",
        symbol = "/",
        color = "yellow",
        looks_like = "spear_pipe",
        name = ccb.content.plural_text("pike pole", "pike poles"),
        description = ccb.content.text("A durable tool consisting of a sturdy fiberglass shaft tipped with a small steel hook."),
        price_cents = 10000,
        techniques = { "WBLOCK_1", "SWEEP" },
        mass_milligrams = 3100000,
        volume_ml = 1250,
        longest_side_mm = 1600,
        melee_to_hit = 0,
        replace_qualities = true,
    }
    item:material("fiberglass", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:melee_damage("cut", 6)
    content.add(item)
end

do
    -- postapoc pricing was determined based off the pricing guide, which states that rare items with no utility are ~10-50 USD, and rare items with some theoreticaly utility are ~100-500 USD, and while the EOD is very rare, it's utility in game is non-existent beyond being an okay melee weapon.
    local item = content.Item {
        id = "EOD_hotstick",
        symbol = "/",
        color = "yellow",
        copy_from = "pike_pole",
        looks_like = "pike_pole",
        name = ccb.content.plural_text("EOD hot stick", "EOD hot sticks"),
        description = ccb.content.text("A durable tool consisting of a sturdy fiberglass shaft tipped with a set of 3 hooks, one large opposed by two small.  Hot sticks are used to maintain some standoff distance when manual manipulation of explosives is necessary, and robot assistance is unavailable."),
        price_cents = 50000,
        price_postapoc_cents = 2500,
    }
    content.add(item)
end
