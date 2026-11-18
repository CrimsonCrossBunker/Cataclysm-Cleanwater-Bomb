local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "elec_jackhammer_mining",
        copy_from = "elec_jackhammer",
        looks_like = "elec_jackhammer",
        name = ccb.content.plural_text("electric mining jackhammer", "electric mining jackhammers"),
        description = ccb.content.text("A construction or mining tool for drilling through hard rock or other surfaces.  This model has a cord compatible with a UPS."),
    }
    item:clear_flags()
    item:flag("DIG_TOOL")
    item:flag("ELECTRONIC")
    item:flag("MULTI_DRILL")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    item:flag("POWERED")
    item:flag("USE_UPS")
    item:flag("WATER_BREAK")
    item:adjust_measurements { volume_ml = { factor = 0.4 }, mass_milligrams = { factor = 0.6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "jackhammer_mining",
        copy_from = "jackhammer",
        looks_like = "jackhammer",
        name = ccb.content.plural_text("mining jackhammer", "mining jackhammers"),
        description = ccb.content.text("A construction or mining tool for drilling through hard rock or other surfaces.  This model runs on gasoline."),
    }
    item:clear_flags()
    item:flag("DIG_TOOL")
    item:flag("MULTI_DRILL")
    item:flag("POWERED")
    item:adjust_measurements { volume_ml = { factor = 0.4 }, mass_milligrams = { factor = 0.6 } }
    content.add(item)
end
