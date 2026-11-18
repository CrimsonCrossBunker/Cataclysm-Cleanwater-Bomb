local ccb = require("ccb")
local content = ccb.content

do
    -- Density the same as steel.
    local item = content.Item {
        id = "orichalcum_ingot",
        category = "spare_parts",
        name = ccb.content.plural_text("orichalcum ingot", "orichalcum ingots"),
        description = ccb.content.text("An ingot of orichalcum.  About 3cm by 7cm by 12cm in size, ready to be used for various blacksmithing tasks."),
        mass_milligrams = 2000000,
        volume_ml = 253,
        price_cents = 6399,
        melee_to_hit = -3,
        symbol = "=",
        color = "light_green",
    }
    item:material("orichalcum_metal", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    -- density of aluminum
    local item = content.Item {
        id = "mithril_ingot",
        category = "spare_parts",
        name = ccb.content.plural_text("mithril ingot", "mithril ingots"),
        description = ccb.content.text("An ingot of mithril.  About 3cm by 7cm by 12cm in size, ready to be used for various blacksmithing tasks."),
        mass_milligrams = 683000,
        volume_ml = 253,
        price_cents = 6399,
        melee_to_hit = -3,
        symbol = "=",
        color = "light_blue",
    }
    item:material("mithril_metal", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    -- slightly denser than copper
    local item = content.Item {
        id = "crimsonite_ingot",
        category = "spare_parts",
        name = ccb.content.plural_text("crimsonite ingot", "crimsonite ingots"),
        description = ccb.content.text("An ingot of crimsonite.  About 3cm by 7cm by 12cm in size, ready to be used for various blacksmithing tasks."),
        mass_milligrams = 2250000,
        volume_ml = 253,
        price_cents = 6399,
        symbol = "=",
        color = "red",
    }
    item:material("crimsonite_metal", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end
