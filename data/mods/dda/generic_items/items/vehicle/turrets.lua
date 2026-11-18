local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "turret_mount",
        name = ccb.content.plural_text("turret mount", "turret mounts"),
        description = ccb.content.text("A universal mount for weapons intended to be installed as turrets."),
        color = "cyan",
        symbol = "X",
        category = "veh_parts",
        mass_milligrams = 10000000,
        volume_ml = 2500,
        price_cents = 5500,
        price_postapoc_cents = 2500,
    }
    item:material("lc_steel", 1)
    content.add(item)
end
