local ccb = require("ccb")
local content = ccb.content

do
    -- Price should be 300 but Velzain charges almost double. If this gets moved to another vender bump up price to 300.
    local item = content.Item {
        id = "forge_warp_scroll",
        name = ccb.content.plural_text("Forge of Wonders warp scroll", "Forge of Wonders warp scrolls"),
        description = ccb.content.text("This scroll is imbued with a magical spell that, when activated, will transport you to the Forge of Wonders.  Good for one round-trip."),
        looks_like = "spell_scroll",
        category = "other",
        mass_milligrams = 475000,
        volume_ml = 500,
        price_cents = 15200,
        symbol = "?",
        color = "white",
    }
    item:clear_use_actions()
    item:cast_spell { spell = "forge_teleport", no_fail = true, level = 1 }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "forge_return_warp_scroll",
        name = ccb.content.plural_text("return warp scroll", "return warp scrolls"),
        description = ccb.content.text("This scroll is imbued with a magical spell that, when activated, will return you to where you were before you warped to the Forge."),
        looks_like = "spell_scroll",
        category = "other",
        mass_milligrams = 475000,
        volume_ml = 500,
        price_cents = 100,
        symbol = "?",
        color = "white",
    }
    item:clear_use_actions()
    item:cast_spell { spell = "forge_return_teleport", no_fail = true, level = 1 }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mana_leech_unlock_scroll",
        name = ccb.content.plural_text("mana-leech shackle unlock scroll", "mana-leech shackle unlock scrolls"),
        description = ccb.content.text("This scroll is imbued with the magical spell that can unlock any mana-leech shackle when cast.  Utterly useless to anyone not struck wearing one."),
        looks_like = "spell_scroll",
        category = "other",
        mass_milligrams = 475000,
        volume_ml = 500,
        price_cents = 100,
        symbol = "?",
        color = "white",
    }
    item:clear_use_actions()
    item:cast_spell { spell = "mana_leech_unlock", no_fail = true, level = 1 }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:material("paper", 1)
    content.add(item)
end
