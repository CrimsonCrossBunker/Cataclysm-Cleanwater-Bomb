local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bottle_metal",
        category = "container",
        name = ccb.content.plural_text("steel bottle", "steel bottles"),
        description = ccb.content.text("A stainless steel water bottle, holds 750 mL of liquid."),
        mass_milligrams = 200000,
        volume_ml = 787,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 750, max_weight_milligrams = 1000000, watertight = true, rigid = true }
    item:quality("CONTAIN", 1)
    item:quality("BOIL", 2)
    item:clear_use_actions()
    item:native_use("HEAT_LIQUID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bottle_folding",
        category = "container",
        name = ccb.content.plural_text("foldable plastic bottle", "foldable plastic bottles"),
        description = ccb.content.text("A non-rigid plastic bottle for easy storage, holds 500 mL of liquid."),
        mass_milligrams = 13000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 25,
        symbol = ")",
        color = "light_cyan",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:container_pocket { max_volume_ml = 500, max_weight_milligrams = 1000000, watertight = true, rigid = false }
    content.add(item)
end
