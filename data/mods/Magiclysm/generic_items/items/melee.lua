local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "gram",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("Gram", "Grams"),
        description = ccb.content.text("Gram, the sword of Sigurd.  It is rumored to be the sword that slayed the legendary dragon, Fafnir.  Once said to have cleaved Regin's anvil in half, the edge is impeccable."),
        mass_milligrams = 1132000,
        techniques = { "WBLOCK_2", "PRECISE", "DIVIDE", "MOUNTED_CHARGE" },
        volume_ml = 2000,
        price_cents = 200000,
    }
    item:material("orichalcum_metal", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 45)
    content.add(item)
end
