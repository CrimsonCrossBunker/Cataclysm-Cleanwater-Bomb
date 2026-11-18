local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_electroshock_grenade_1_act",
        copy_from = "afs_electroshock_grenade_1",
        looks_like = "grenade_emp_act",
        name = ccb.content.plural_text("armed electroshock grenade", "armed electroshock grenades"),
        description = ccb.content.text("This electroshock grenade is currently creating a dangerous electric field."),
        field_emissions = { "emit_shock_cloud" },
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:transform_into { target = "afs_material_1" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_oxygen_bomb_act",
        copy_from = "pipebomb_act",
        looks_like = "pipebomb_act",
        name = ccb.content.plural_text("active oxygen bomb", "active oxygen bombs"),
        price_cents = 0,
        description = ccb.content.text("This bomb's fuse is lit, and it will explode any second now.  Throw it immediately!"),
    }
    item:tool()
    content.add(item)
end
