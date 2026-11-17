local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("wears_flag_active_cryosuit", function(ctx)
    return ctx.character_inputs.worn_flags["ACTIVE_CRYOSUIT"]
end)

ccb.runtime.handler("is_wearing_modular_exosuit_on", function(ctx)
    return ctx.character_inputs.worn_items["modular_exosuit_on"]
end)

content.add(content.Enchantment {
    id = "afs_ench_climate_control_warm_helmet",
    name = content.text("Cold Climate Control Helmet"),
    description = content.text("You are wearing equipment that helps handle harsh climates."),
    has = "WORN",
    condition_handler = "wears_flag_active_cryosuit",
    load_character_inputs = { worn_flags = { "ACTIVE_CRYOSUIT" } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 75 }))

content.add(content.Enchantment {
    id = "afs_ench_climate_control_2",
    name = content.text("Exosuit Climate Control"),
    description = content.text("Your active jumpsuit helps maintain your body temperature."),
    has = "WORN",
    condition_handler = "is_wearing_modular_exosuit_on",
    load_character_inputs = { worn_items = { "modular_exosuit_on" } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 75 })
    :value("CLIMATE_CONTROL_CHILL", { add = 75 }))

content.add(content.Enchantment {
    id = "afs_ench_climate_control_3",
    name = content.text("Exosuit Climate Control"),
    description = content.text("Your active jumpsuit helps maintain your body temperature."),
    has = "WORN",
    condition_handler = "is_wearing_modular_exosuit_on",
    load_character_inputs = { worn_items = { "modular_exosuit_on" } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 100 })
    :value("CLIMATE_CONTROL_CHILL", { add = 150 }))

content.add(content.Enchantment {
    id = "afs_ench_climate_control_4",
    name = content.text("Exosuit Climate Control"),
    description = content.text("Your active jumpsuit helps maintain your body temperature."),
    has = "WORN",
    condition_handler = "is_wearing_modular_exosuit_on",
    load_character_inputs = { worn_items = { "modular_exosuit_on" } },
}
    :value("CLIMATE_CONTROL_HEAT", { add = 300 })
    :value("CLIMATE_CONTROL_CHILL", { add = 300 }))
