local ccb = require("ccb")
local content = ccb.content

do
    -- 30 x 20 x 18,5 cm external, 27 x 17 x 16,5 cm cm internal
    -- https://www.auer-packaging.com/gb/en/Euro-containers-with-hinge-lid/ED-3217-HG.html
    local item = content.Item {
        id = "box_small_plastic",
        category = "container",
        name = ccb.content.plural_text("secured plastic box", "secured plastic boxes"),
        description = ccb.content.text("A small plastic box with a rugged exterior, the cover securely held by several small latches."),
        mass_milligrams = 815000,
        volume_ml = 11100,
        longest_side_mm = 220,
        price_cents = 1275,
        price_postapoc_cents = 5,
        symbol = "#",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 7573, max_weight_milligrams = 18000000, rigid = true, max_item_length_mm = 165 }
    content.add(item)
end

do
    local item = content.Item {
        id = "30gal_barrel_mutagen",
        copy_from = "30gal_barrel",
        name = ccb.content.plural_text("30 gallon barrel", "30 gallon barrels"),
        looks_like = "55gal_drum",
        description = ccb.content.text("A huge plastic barrel with a watertight lid.  It's surface is completely covered with hazard warning labels and, most importantly, a giant red tape, that reads \"IMPURE CATALYST, DO NOT USE, FAILED SAMPLE, DO NOT USE, IMPURE CATALYST…\""),
        color = "light_blue",
    }
    content.add(item)
end
