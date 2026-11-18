local ccb = require("ccb")
local content = ccb.content

do
    -- To be sealable, has to be sized for exactly 60 cheese. See issue #81781
    local item = content.Item {
        id = "cheese_wheel_wax",
        category = "container",
        name = ccb.content.plural_text("wax coating", "wax coatings"),
        looks_like = "can_food",
        description = ccb.content.text("The wax coating for a big wheel of cheese.  Could preserve it basically indefinitely, if left sealed."),
        mass_milligrams = 215000,
        volume_ml = 2100,
        longest_side_mm = 160,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "%",
        color = "yellow",
        replace_pockets = true,
    }
    item:material("paraffin_wax", 1)
    item:container_pocket {
        max_volume_ml = 1860,
        max_weight_milligrams = 3000000,
        rigid = true,
        watertight = true,
        sealed_spoil_multiplier = 0.0,
        allowed_items = { "cheese_hard" },
    }
    content.add(item)
end
