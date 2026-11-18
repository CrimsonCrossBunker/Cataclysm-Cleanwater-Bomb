local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "integrated_blood_bank",
        category = "container",
        name = ccb.content.plural_text("internal blood bank", "internal blood banks"),
        description = ccb.content.text("Internal tank for blood power generator bionic."),
        volume_ml = 751,
        mass_milligrams = 1000,
        price_cents = 0,
        symbol = "(",
        color = "magenta",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("NO_REPAIR")
    item:flag("ALLOWS_NATURAL_ATTACKS")
    item:flag("BIONIC_FUEL_SOURCE")
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        max_item_volume_ml = 250,
        allowed_materials = { "blood", "dragon_blood", "blood_tainted", "hblood" },
    }
    content.add(item)
end
