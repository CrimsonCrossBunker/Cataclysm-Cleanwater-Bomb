local ccb = require("ccb")
local content = ccb.content

do
    -- magical poisons, 'death' and 'bio' related
    local item = content.Item {
        id = "xe_elder_ginseng",
        name = ccb.content.plural_text("elder ginseng", "several elder ginseng"),
        color = "white",
        symbol = "*",
        description = ccb.content.text("A clump of off white roots in the shape of a humanoid body.  It feels strange to the touch, almost alive."),
        price_postapoc_cents = 700,
        volume_ml = 5,
        mass_milligrams = 5000,
    }
    item:material("veggy", 1)
    content.add(item)
end
