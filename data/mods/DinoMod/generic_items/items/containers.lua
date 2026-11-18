local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "sauropod_stomach_sealed",
        category = "container",
        name = ccb.content.plural_text("sealed sauropod stomach", "sealed sauropod stomachs"),
        description = ccb.content.text("The stomach of a sauropod, cleaned and sealed with strings.  It can hold 6 liters of water."),
        mass_milligrams = 1566000,
        volume_ml = 1000,
        price_cents = 9000,
        price_postapoc_cents = 50,
        symbol = ")",
        color = "brown",
        replace_pockets = true,
    }
    item:material("gutskin", 1)
    item:container_pocket { max_volume_ml = 6000, max_weight_milligrams = 12000000, watertight = true, max_item_volume_ml = 34 }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end
