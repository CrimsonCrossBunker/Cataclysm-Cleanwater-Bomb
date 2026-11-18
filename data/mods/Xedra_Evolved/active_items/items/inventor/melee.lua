local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "megachette_folded",
        copy_from = "megachette",
        looks_like = "megachette",
        category = "weapons",
        name = ccb.content.plural_text("megachette (folded)", "megachettes (folded)"),
        description = ccb.content.text("Probably a great weapon, it is folded now."),
        volume_ml = 160,
        longest_side_mm = 140,
        symbol = "/",
        melee_to_hit = -1,
        techniques = {},
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "megachette" },
        menu_text = ccb.content.text("Expand"),
        message = ccb.content.text("With a quiet click, the megachette is unfolded."),
    }
    item:clear_melee_damage()
    item:melee_damage("cut", 0)
    item:melee_damage("bash", 3)
    item:clear_mounted_charge()
    content.add(item)
end
