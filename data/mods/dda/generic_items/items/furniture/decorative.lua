local ccb = require("ccb")
local content = ccb.content

do
    -- Tried to base it on <https://www.amazon.com/dp/B09YPNXLFM>, but it's weight and out glass density seems to be incompatible
    -- 165 cm x 61 cm x 0.5 cm, additional volume is from frame and stand
    local item = content.Item {
        id = "bigmirror",
        name = ccb.content.plural_text("standing mirror", "standing mirrors"),
        looks_like = "f_bigmirror",
        description = ccb.content.text("A full-length mirror mounted in a sleek aluminum frame.  Metal stand is currently folded."),
        mass_milligrams = 12977000,
        volume_ml = 5450,
        longest_side_mm = 1650,
        price_cents = 14900,
        price_postapoc_cents = 300,
        symbol = "{",
        color = "white",
    }
    item:material("glass", 96)
    item:material("aluminum", 4)
    item:clear_use_actions()
    item:deploy_furniture("f_bigmirror")
    content.add(item)
end

do
    local item = content.Item {
        id = "piano",
        category = "other",
        name = ccb.content.plural_text("piano", "piano"),
        description = ccb.content.text("An elegant piano, capable of producing beautiful music if used by a skilled player.  A set of off-white and black keys are linked to a set of hammers, which strike their corresponding tightly-coiled wire to produce sound."),
        mass_milligrams = 300000000,
        volume_ml = 1000000,
        price_cents = 500000,
        price_postapoc_cents = 1500,
        symbol = "P",
        color = "i_black",
    }
    item:material("wood", 1)
    content.add(item)
end
