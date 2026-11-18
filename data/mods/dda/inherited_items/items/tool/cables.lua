local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "jumper_cable_heavy",
        name = ccb.content.plural_text("heavy-duty jumper cable", "heavy-duty jumper cables"),
        description = ccb.content.text("A long, thick, heavy-duty jumper cable with power leads on either end.  Attach one end to one vehicle and the other to another, and you can transfer electrical power between the two, though you expect the power loss would be noticeable.  Can also link power grids."),
        volume_ml = 1500,
        mass_milligrams = 750000,
        copy_from = "jumper_cable",
        looks_like = "jumper_cable",
    }
    item:tool { initial_charges = 20, max_charges = 20 }
    content.add(item)
end

do
    local item = content.Item {
        id = "long_extension_cable",
        name = ccb.content.plural_text("outdoor extension cord", "outdoor extension cords"),
        description = ccb.content.text("An extra-long 100-foot (or about 30 m) orange extension cord for extending cables or connecting outdoor appliances.  Could be used on any appliance or other household electrical system."),
        copy_from = "extension_cable",
        looks_like = "extension_cable",
        volume_ml = 3750,
        mass_milligrams = 2500000,
    }
    item:clear_flags()
    item:flag("CABLE_SPOOL")
    item:flag("SINGLE_USE")
    item:tool { initial_charges = 30, max_charges = 30 }
    content.add(item)
end
