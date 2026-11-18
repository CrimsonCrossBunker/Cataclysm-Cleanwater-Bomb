local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "ap_exo_gantry",
        looks_like = "welding_rig",
        symbol = "T",
        color = "blue",
        name = ccb.content.plural_text("freezer", "freezers"),
        description = ccb.content.text("A gantry for supporting an exosuit upright during maintenance and repair.  Includes the specialized tools needed for complex repairs and will also charge the suit's power when active."),
        longest_side_mm = 1400,
        insulation = 15,
        volume_ml = 900000,
        mass_milligrams = 50000000,
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 450000, max_weight_milligrams = 400000000, rigid = true }
    content.add(item)
end
