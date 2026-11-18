local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_stiltwalker_1_1",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("broken stiltwalker", "broken stiltwalkers"),
        category = "other",
        description = ccb.content.text("A broken stiltwalker.  You think it might be possible to disassemble it into parts, someday, but not now."),
        price_cents = 1000,
        volume_ml = 100000,
        mass_milligrams = 317000000,
    }
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end
