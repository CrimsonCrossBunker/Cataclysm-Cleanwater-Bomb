local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "boarding_axe",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("boarding axe", "boarding axes"),
        ascii_picture = "halberd",
        description = ccb.content.text("This is a sturdy axe with a pick opposite the blade.  A composite titanium/Kevlar handle provides a sturdy grip that protects against electrical shocks and high temperatures.  Designed for use by soldiers wearing strength-enhancing exosuits, it's quite heavy.  Activate it to fold it into a compact module."),
        mass_milligrams = 7500000,
        volume_ml = 2750,
        longest_side_mm = 1200,
        techniques = { "WBLOCK_2", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        melee_to_hit = 0,
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES" },
        category = "weapons",
    }
    item:quality("AXE", 2)
    item:quality("PRY", 3)
    item:quality("BUTCHER", -30)
    item:material("qt_steel", 1)
    item:material("titanium", 1)
    item:material("kevlar", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:flag("BELT_CLIP")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "collapsed_boarding_axe" },
        menu_text = ccb.content.text("Collapse"),
        message = ccb.content.text("You fold the axe in on itself."),
    }
    item:native_use("CROWBAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:melee_damage("cut", 45)
    content.add(item)
end
