local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rune_biomancer",
        symbol = "=",
        color = "pink",
        name = ccb.content.plural_text("Biomancer rune", "Biomancer runes"),
        description = ccb.content.text("This magical pebble has an insignia of rended flesh and bones on it.  It is necessary for Biomancers to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_technomancer",
        symbol = "=",
        color = "blue",
        name = ccb.content.plural_text("Technomancer rune", "Technomancer runes"),
        description = ccb.content.text("This magical pebble has an insignia of clockwork and gears on it.  It is necessary for Technomancers to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_magus",
        symbol = "=",
        color = "magenta",
        name = ccb.content.plural_text("Magus rune", "Magi runes"),
        description = ccb.content.text("This magical pebble has an insignia of crystal and mana orbs on it.  It is necessary for Magi to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_earthshaper",
        symbol = "=",
        color = "green",
        name = ccb.content.plural_text("Earthshaper rune", "Earthshaper runes"),
        description = ccb.content.text("This magical pebble has an insignia of steel and rocks on it.  It is necessary for Earthshapers to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_kelvinist",
        symbol = "=",
        color = "red",
        name = ccb.content.plural_text("Kelvinist rune", "Kelvinist runes"),
        description = ccb.content.text("This magical pebble has an insignia of ice and flames on it.  It is necessary for Kelvinists to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_stormshaper",
        symbol = "=",
        color = "yellow",
        name = ccb.content.plural_text("Stormshaper rune", "Stormshaper runes"),
        description = ccb.content.text("This magical pebble has an insignia of lightning and storm clouds on it.  It is necessary for Stormshapers to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_druid",
        symbol = "=",
        color = "brown",
        name = ccb.content.plural_text("Druid rune", "Druid runes"),
        description = ccb.content.text("This magical pebble has an insignia of nature and trees on it.  It is necessary for Druids to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_animist",
        symbol = "=",
        color = "light_red",
        name = ccb.content.plural_text("Animist rune", "Animist runes"),
        description = ccb.content.text("This magical pebble has an insignia of summoners on it.  It is necessary for Animists to channel magic into their crafts."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rune_alchemist",
        symbol = "=",
        color = "dark_gray",
        name = ccb.content.plural_text("alchemist rune", "alchemist runes"),
        description = ccb.content.text("This magical pebble has an insignia of alchemy and potions on it.  While versatile in use, the lack of attunement to any school prevents creation of more advanced recipes."),
        volume_ml = 5,
        mass_milligrams = 1000,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end
