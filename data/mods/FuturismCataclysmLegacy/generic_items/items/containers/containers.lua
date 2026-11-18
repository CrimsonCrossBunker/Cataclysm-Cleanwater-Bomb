local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "foil_bag",
        copy_from = "plastic_bag_vac",
        looks_like = "plastic_bag_vac",
        name = ccb.content.plural_text("foil bag", "foil bags"),
        description = ccb.content.text("A plastic and aluminum foil bag for long term food storage."),
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:container_pocket {
        max_volume_ml = 1500,
        max_weight_milligrams = 3000000,
        open_container = true,
        watertight = true,
        sealed_spoil_multiplier = 0.0,
    }
    content.add(item)
end
