local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_sniperbot",
        symbol = "x",
        color = "brown",
        name = ccb.content.plural_text("broken sniper bot", "broken sniper bots"),
        category = "other",
        description = ccb.content.text("A broken sniper bot.  Total scrap, but some stuff is still useful."),
        mass_milligrams = 40000000,
        volume_ml = 150000,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_shotgunbot",
        symbol = "x",
        color = "brown",
        name = ccb.content.plural_text("broken shotgun bot", "broken shotgun bots"),
        category = "other",
        description = ccb.content.text("A broken shotgun bot.  Total scrap, but some stuff is still useful."),
        mass_milligrams = 40000000,
        volume_ml = 150000,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_meleebot",
        symbol = "x",
        color = "brown",
        name = ccb.content.plural_text("broken cutthroater", "broken cutthroaters"),
        category = "other",
        description = ccb.content.text("A broken cutthroater.  Total scrap, but some stuff is still useful."),
        mass_milligrams = 40000000,
        volume_ml = 150000,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_bitebot",
        symbol = "x",
        color = "brown",
        name = ccb.content.plural_text("broken bitebot", "broken bitebots"),
        category = "other",
        description = ccb.content.text("A broken bitebot.  Total scrap, but some stuff is still useful."),
        mass_milligrams = 40000000,
        volume_ml = 150000,
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_dreamforged_automaton",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("broken dreamforged automaton", "broken dreamforged automatons"),
        category = "other",
        description = ccb.content.text("The automaton is now much more broken than it was before.  It resembles a pile of random parts and its internals are fried beyond salvage but could be gutted for materials."),
        price_cents = 0,
        volume_ml = 210000,
        mass_milligrams = 195000000,
    }
    item:material("lc_steel", 1)
    item:material("dreamstuff", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_xe_golem",
        symbol = "x",
        color = "brown",
        name = ccb.content.plural_text("broken golem", "broken golems"),
        category = "other",
        description = ccb.content.text("A lifeless pile of clay of what once a golem.  Could be smashed for clay."),
        price_cents = 0,
        mass_milligrams = 292490000,
        volume_ml = 200000,
    }
    item:material("clay", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end
