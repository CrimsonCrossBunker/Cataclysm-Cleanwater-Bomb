local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bullwhip",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("bullwhip", "bullwhips"),
        description = ccb.content.text("A long strip of braided leather with a handle on one end.  Originally developed to settle disagreements with cattle, it's better used now for flaying the rotten flesh off of walking corpses.  Great for when a problem comes along."),
        mass_milligrams = 3460000,
        volume_ml = 2000,
        price_cents = 3500,
        price_postapoc_cents = 500,
        melee_to_hit = 0,
        category = "weapons",
        weapon_categories = { "WHIPS" },
    }
    item:material("leather", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("WHIP")
    item:clear_melee_damage()
    item:melee_damage("cut", 3)
    item:fault_group("whips", {  })
    content.add(item)
end

do
    -- There's no way you can swing this thing without hitting SOMETHING.
    local item = content.Item {
        id = "bullwhip_razor",
        name = ccb.content.plural_text("scourge", "scourges"),
        category = "weapons",
        description = ccb.content.text("The \"cat 'o nine tails\", a handle with nine short leather whips, each sporting a razor-sharp metal tip.  This ancient instrument of torture causes massive bleeding, but by design is inefficient as a weapon."),
        symbol = "/",
        color = "brown",
        mass_milligrams = 3496000,
        volume_ml = 2250,
        price_cents = 4800,
        price_postapoc_cents = 5200,
        melee_to_hit = 0,
        weapon_categories = { "WHIPS" },
    }
    item:material("leather", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("WHIP")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("cut", 10)
    item:fault_group("bladed_whips", {  })
    content.add(item)
end
