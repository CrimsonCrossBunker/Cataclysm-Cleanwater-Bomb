local ccb = require("ccb")
local content = ccb.content

do
    -- Based off battle axe +1.  Metals chosen for being two most conductive metals + balancing reasons
    local item = content.Item {
        id = "rune_stormshaper_weapon",
        copy_from = "copper_ax",
        looks_like = "copper_ax",
        name = ccb.content.plural_text("Stormshaper axe", "Stormshaper axes"),
        description = ccb.content.text("A forged copper axe with silver trimmings and a wooden handle.  There is a Stormshaper rune embedded in the eye."),
        mass_milligrams = 2850000,
        volume_ml = 2025,
        longest_side_mm = 900,
        price_cents = 3900,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("copper", 1)
    item:material("silver", 1)
    item:quality("AXE", 1)
    item:quality("BUTCHER", -20)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_AXE")
    item:flag("TRADER_AVOID")
    item:flag("MAGIC_FOCUS")
    item:flag("SPELLCASTING_AID")
    item:flag("HYGROMETER")
    item:flag("BAROMETER")
    item:clear_melee_damage()
    item:melee_damage("bash", 21)
    item:melee_damage("cut", 42)
    content.add(item)
end
