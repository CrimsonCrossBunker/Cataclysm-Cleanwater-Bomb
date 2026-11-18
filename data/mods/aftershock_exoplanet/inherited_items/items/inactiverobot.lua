local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "bot_defbot_base",
        abstract = true,
        name = content.plural_text("inactive defense robot", "inactive defense robots"),
        looks_like = "mon_riotbot",
        mass_milligrams = 140000000,
        volume_ml = 62500,
        price_cents = 10000,
        price_postapoc_cents = 10000,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end
