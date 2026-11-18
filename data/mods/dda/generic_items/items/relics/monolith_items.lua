local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "monolith_disc",
        category = "artifacts",
        symbol = ".",
        color = "dark_gray",
        name = ccb.content.plural_text("inscribed disc", "inscribed discs"),
        description = ccb.content.text("A thin, palm-sized disc of incredibly dense stone, engraved with meaningless swirls.  Its surface seems to repel grime and debris, and it refuses to tarnish or scratch."),
        mass_milligrams = 5320000,
        volume_ml = 190,
        longest_side_mm = 110,
    }
    item:material("monolith", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "monolith_brick",
        category = "artifacts",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("warped brick", "warped bricks"),
        description = ccb.content.text("This brick of too-dense stone is warped in a way that just barely makes it worthless as a building material.  Its smooth surface is unmarred by texture, dirt, or color."),
        mass_milligrams = 28000000,
        volume_ml = 1000,
    }
    item:material("monolith", 1)
    content.add(item)
end
