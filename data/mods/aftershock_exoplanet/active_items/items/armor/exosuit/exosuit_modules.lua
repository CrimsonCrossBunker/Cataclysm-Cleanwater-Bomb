local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "collapsed_boarding_axe",
        symbol = "%",
        color = "light_gray",
        name = ccb.content.plural_text("collapsed boarding axe", "collapsed boarding axes"),
        description = ccb.content.text("This is an exosuit-scale boarding axe, folded into a compact module.  Activate to extend."),
        mass_milligrams = 7500000,
        volume_ml = 1500,
        longest_side_mm = 450,
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("EXO_MEDIUM_GADGET")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "boarding_axe" },
        menu_text = ccb.content.text("Expand"),
        message = ccb.content.text("With a snap of your arm, the axe extends."),
    }
    content.add(item)
end
