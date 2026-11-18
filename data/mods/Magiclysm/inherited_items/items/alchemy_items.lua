local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "demon_chitin_piece",
        category = "spare_parts",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("chunk of demon chitin", "chunks of demon chitin"),
        description = ccb.content.text("A piece of demon spider exoskeleton.  It is light and very durable, and probably has some magical properties."),
        price_cents = 1000,
        mass_milligrams = 89000,
        volume_ml = 250,
    }
    item:material("demon_chitin", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bundle_demon_chitin_piece",
        copy_from = "demon_chitin_piece",
        looks_like = "demon_chitin_piece",
        symbol = "=",
        name = ccb.content.plural_text("bundle of demon chitin chunks", "bundles of demon chitin chunks"),
        description = ccb.content.text("Pieces of demon spider exoskeleton, bundled tightly together for storage.  Disassemble to unpack."),
    }
    item:adjust_measurements { price_cents = { factor = 10 }, volume_ml = { factor = 10 }, mass_milligrams = { factor = 10 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "demon_chitin_flux",
        category = "spare_parts",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("flux of demon chitin", "flux of demon chitin"),
        description = ccb.content.text("Demon chitin turned into a paste like substance referred to as flux.  Used to create new; and fill in, repairing existing demon chitin items."),
        price_cents = 1000,
        mass_milligrams = 500,
        volume_ml = 1,
        phase = "solid",
    }
    item:material("demon_chitin", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    -- In terms of alchemy the gastrolith could serve to combine different effects, such as safely mixing together potions, or it could be used as an element of change, such as for shapechanging potions.
    local item = content.Item {
        id = "owlbear_stone",
        name = ccb.content.plural_text("owlbear gastrolith", "owlbear gastroliths"),
        description = ccb.content.text("This strangely shaped rock was once a part of an owlbear's complex digestive system, creating a link between owl throat and bear stomach.  It is possible that it could serve a similar purpose in alchemy, helping to bind together two disparate halves."),
        mass_milligrams = 2000000,
        volume_ml = 750,
        price_cents = 3100,
        melee_to_hit = -1,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:quality("HAMMER", 2)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "alchemist_bomb",
        category = "weapons",
        name = ccb.content.plural_text("mana bomb", "mana bombs"),
        description = ccb.content.text("Mana bombs are powerful explosive devices developed by a little-known alchemist group for use against enemy spellcasters.  These bombs are fueled by pure arcane energy and can kill instantly.  The exact workings are unclear, but they appear to use some kind of massive mana burn."),
        mass_milligrams = 430000,
        volume_ml = 200,
        price_cents = 2000,
        price_postapoc_cents = 550,
        melee_to_hit = -1,
        symbol = "*",
        color = "green",
    }
    item:material("crystallized_mana", 1)
    item:material("concentrated_mana", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "alchemist_bomb_act", timer_turns = 8 },
        need_wielding = true,
        message = ccb.content.text("You mix the contents of the bottle, and it starts to sizzle."),
        menu_text = ccb.content.text("Mix liquid"),
    }
    item:clear_flags()
    item:flag("BOMB")
    item:flag("GRENADE")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:tool()
    content.add(item)
end
