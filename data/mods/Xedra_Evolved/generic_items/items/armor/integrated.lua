local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "item_undine_liquid_water_pocket",
        category = "clothing",
        name = ccb.content.plural_text("water pocket", "water pockets"),
        description = ccb.content.text("Your skin is capable of ."),
        symbol = ")",
        color = "blue",
        replace_pockets = true,
    }
    item:material("fae_flesh", 1)
    item:container_pocket {
        max_volume_ml = 3000,
        max_weight_milligrams = 6000000,
        watertight = true,
        max_item_volume_ml = 17,
        volume_encumber_modifier = 0,
        volume_multiplier = 0,
        weight_multiplier = 0,
        allowed_items = { "water", "water_clean", "salt_water", "water_mineral" },
    }
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("PADDED")
    item:flag("SEMITANGIBLE")
    item:flag("ZERO_WEIGHT")
    item:flag("TARDIS")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("SOFT")
    item:flag("WATER_FRIENDLY")
    content.add(item)
end
