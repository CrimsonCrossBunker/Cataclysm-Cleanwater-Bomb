local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "glow_light",
        category = "tools",
        name = ccb.content.plural_text("magical reading light", "magical reading lights"),
        description = ccb.content.text("Powered by the magic of glow powder and lesser mana potions, this extremely expensive little light will provide just enough light to read by for at least a decade.  Use it to close the cover and hide the light."),
        mass_milligrams = 270000,
        volume_ml = 250,
        price_cents = 15000,
        symbol = ",",
        color = "light_blue",
        light = 5,
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "glow_light_off" },
        message = ccb.content.text("You close the lamp's cover."),
        menu_text = ccb.content.text("Close cover"),
    }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    content.add(item)
end

do
    local item = content.Item {
        id = "glow_light_off",
        category = "tools",
        name = ccb.content.plural_text("magical reading light (covered)", "magical reading lights (covered)"),
        description = ccb.content.text("Powered by the magic of glow powder and lesser mana potions, this extremely expensive little light will provide just enough light to read by for at least a decade.  The cover is closed.  Use it to open the cover and show the light."),
        mass_milligrams = 270000,
        volume_ml = 250,
        price_cents = 15000,
        symbol = ",",
        color = "light_blue",
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "glow_light" },
        message = ccb.content.text("You open the lamp's cover."),
        menu_text = ccb.content.text("Open cover"),
    }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    content.add(item)
end

do
    -- The embers have to be preserved first before they are usable.
    local item = content.Item {
        id = "fading_embers_active",
        name = ccb.content.plural_text("fading embers", "fading embers"),
        description = ccb.content.text("The embers of a slain Balrog.  It burns with otherworldly intensity.  Soon, it will fade into nothing."),
        volume_ml = 0,
        price_cents = 100,
        symbol = "w",
        color = "red",
        category = "spare_parts",
        countdown_turns = 1200,
    }
    item:material("concentrated_mana", 1)
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "ash" }
    content.add(item)
end
