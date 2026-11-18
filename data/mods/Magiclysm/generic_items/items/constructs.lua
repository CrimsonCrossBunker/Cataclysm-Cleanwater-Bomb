local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "golemcore",
        symbol = ".",
        color = "red",
        name = ccb.content.plural_text("golem core", "golem cores"),
        description = ccb.content.text("The \"heart\" of a golem.  Makes a soft humming noise when you hold it close to your ear."),
        price_cents = 10000,
        price_postapoc_cents = 5000,
        mass_milligrams = 5000000,
        volume_ml = 1000,
    }
    item:material("orichalcum_metal", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_claygolem",
        symbol = "x",
        color = "brown",
        name = ccb.content.plural_text("broken clay golem", "broken clay golems"),
        category = "other",
        description = ccb.content.text("A broken clay golem, looking like a piece of post-modern art.  Could be smashed for clay."),
        price_cents = 10000,
        mass_milligrams = 122000000,
        volume_ml = 120000,
        melee_to_hit = -3,
    }
    item:material("clay", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_plasticgolem",
        symbol = "x",
        color = "light_gray",
        name = ccb.content.plural_text("broken plastic golem", "broken plastic golems"),
        category = "other",
        description = ccb.content.text("A broken plastic golem, like a giant action figure chewed up by an equally giant puppy.  You could smash it up into recycled plastic bits."),
        price_cents = 100,
        mass_milligrams = 70000000,
        volume_ml = 150000,
        melee_to_hit = -3,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_stonegolem",
        symbol = "x",
        color = "light_gray",
        name = ccb.content.plural_text("broken stone golem", "broken stone golems"),
        category = "other",
        description = ccb.content.text("A broken stone golem, not that much different from a big boulder.  Could be smashed for stone."),
        price_cents = 10000,
        mass_milligrams = 162000000,
        volume_ml = 120000,
        melee_to_hit = -3,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_irongolem",
        symbol = "x",
        color = "dark_gray",
        name = ccb.content.plural_text("broken iron golem", "broken iron golems"),
        category = "other",
        description = ccb.content.text("A broken iron golem, with all iron you would possibly ever need.  Could be smashed for iron."),
        price_cents = 100000,
        mass_milligrams = 875000000,
        volume_ml = 120000,
        melee_to_hit = -5,
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_forgeborn",
        symbol = "x",
        color = "dark_gray",
        name = ccb.content.plural_text("broken forge born", "broken forge born"),
        category = "other",
        description = ccb.content.text("A broken forge born, with all orichalcum you would possibly ever need.  Could be smashed for orichalcum."),
        price_cents = 100000,
        mass_milligrams = 945000000,
        volume_ml = 120000,
        melee_to_hit = -5,
    }
    item:material("orichalcum_metal", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_eshaper_golem",
        symbol = "x",
        color = "light_gray",
        name = ccb.content.plural_text("broken stone golem", "broken stone golems"),
        category = "other",
        description = ccb.content.text("A broken earthshaper's golem, almost the same as it's natural stone counterpart.  Could be smashed for stone."),
        price_cents = 10000,
        mass_milligrams = 112000000,
        volume_ml = 80000,
        melee_to_hit = -3,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_eshaper_golem_feral_earthshaper",
        symbol = "x",
        color = "light_gray",
        name = ccb.content.plural_text("broken stone golem", "broken stone golems"),
        category = "other",
        description = ccb.content.text("A broken earthshaper's golem, almost the same as it's natural stone counterpart.  Could be smashed for stone."),
        price_cents = 10000,
        mass_milligrams = 112000000,
        volume_ml = 80000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 4)
    content.add(item)
end
