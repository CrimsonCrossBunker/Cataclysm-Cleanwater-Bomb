local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "exosuit_power_cutter_on",
        copy_from = "exosuit_power_cutter",
        looks_like = "exosuit_power_cutter",
        name = ccb.content.plural_text("exosuit power cutter (on)", "exosuit power cutters (on)"),
        description = ccb.content.text("A huge, multi-fuel powered saw with a diamond blade, currently a whirling blur.  It's consuming fuel and can be used as a fantastic tool for cutting metal.  You can also use it as a terrifying weapon, if you're into that sort of thing."),
        replace_qualities = true,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "exosuit_power_cutter" },
        message = ccb.content.text("Your power cutter falls quiet."),
        menu_text = ccb.content.text("Turn off"),
        ammo_scale = 0,
    }
    item:quality("CUT", 3)
    item:quality("SAW_M", 20)
    item:quality("SAW_M_FINE", 1)
    item:quality("BUTCHER", -80)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 100)
    item:flag("MESSY")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "exosuit_power_cutter" }
    item:tool { turns_per_charge = 5 }
    content.add(item)
end
