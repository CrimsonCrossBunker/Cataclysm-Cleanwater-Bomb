local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_nl_surgicalbot_1_1",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("broken surgical bonebot", "broken surgical bonebots"),
        category = "other",
        description = ccb.content.text("A broken surgical bonebot.  Could be gutted for parts."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 81500000,
        volume_ml = 62500,
    }
    item:material("cyber_bone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_nl_surgicalbot_assist",
        name = ccb.content.plural_text("broken surgical bonebot", "broken surgical bonebots"),
        copy_from = "broken_nl_surgicalbot_1_1",
        looks_like = "broken_nl_surgicalbot_1_1",
    }
    content.add(item)
end
