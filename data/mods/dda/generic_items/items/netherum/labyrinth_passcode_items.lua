local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "ls_sd_passcode_used",
        name = ccb.content.plural_text("holographic shard (used)", "holographic shards (used)"),
        category = "artifact",
        symbol = ",",
        color = "blue",
        description = ccb.content.text("A palm-sized shard of alien glass, reflecting light in holographic prisms."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 10000,
        volume_ml = 5,
    }
    item:material("anomaly", 1)
    content.add(item)
end
