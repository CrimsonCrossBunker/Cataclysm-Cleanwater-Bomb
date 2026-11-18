local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_landfall_kit_2",
        name = ccb.content.plural_text("Type II. landfall survival kit", "Type II. landfall survival kits"),
        description = ccb.content.text("This is a metal box containing survival supplies, often found within ships and their escape pods.  Its cyan highlights indicate that it's a simpler Type II kit, and that it would only be helpful in a planet whose atmosphere and gravity are within two deviations from Earth's."),
        mass_milligrams = 1022000,
        volume_ml = 22000,
        price_postapoc_cents = 3000,
        symbol = ",",
        color = "red",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 20000, max_weight_milligrams = 40000000, max_item_length_mm = 1330, rigid = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_augustmoon_kit_box",
        name = ccb.content.plural_text("survival kit", "survival kits"),
        description = ccb.content.text("A survival kit box clearly repurposed from a ship's escape pod.  It contains a variety of supplies to help you survive planetside."),
        mass_milligrams = 1022000,
        volume_ml = 32000,
        price_postapoc_cents = 500,
        symbol = ",",
        color = "red",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 30000, max_weight_milligrams = 40000000, max_item_length_mm = 1330, rigid = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cargo_crate",
        name = ccb.content.plural_text("cargo crate", "cargo crates"),
        description = ccb.content.text("A standard orbital cargo transfer container.  Its faceted corners are adorned with the livery of company you don't recognize."),
        mass_milligrams = 2710000,
        volume_ml = 30000,
        price_postapoc_cents = 3000,
        symbol = "0",
        color = "light_red",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 28000, max_weight_milligrams = 40000000, max_item_length_mm = 1700, rigid = true }
    item:tool()
    content.add(item)
end
