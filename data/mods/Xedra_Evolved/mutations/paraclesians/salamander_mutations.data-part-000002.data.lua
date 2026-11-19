local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_MONCAMS",
    name = ccb.content.text("Within the Firelight"),
    points = 2,
    description = ccb.content.text("As a distant fire reveals that which is nearby, the Salamander can see what surrounds their kin.  The Salamander may see through the eyes of any creatures they summon."),
    prerequisites = { "SALAMANDER_SUMMON_FIRE_SPIRIT" },
    secondary_prerequisites = { "SALAMANDER_HEAT_EYES", "SALAMANDER_HEAT_EYES2" },
    categories = { "SALAMANDER" },
    purifiable = false,
    monster_cameras = { mon_salamander_tiny = 50, mon_smoke_mephit = 50 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_BIGGER_STOMACH",
    name = ccb.content.text("Adding Wood to the Campfire"),
    points = 2,
    description = ccb.content.text("Fires require fuel, and so does the Salamander.  This trait allows them to eat twice as much at once."),
    prerequisites = { "SALAMANDER_EMIT_HEAT" },
    replacements = { "SALAMANDER_BIGGER_STOMACH2" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_BIGGER_STOMACH_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_BIGGER_STOMACH2",
    name = ccb.content.text("Fueling the Hungry Oven"),
    points = 5,
    description = ccb.content.text("Like a coal furnace, the Salamander devours food to keep functioning.  They may eat three times as much at once and eat food 50% faster."),
    prerequisites = { "SALAMANDER_BIGGER_STOMACH" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_BIGGER_STOMACH2_0" },
}
