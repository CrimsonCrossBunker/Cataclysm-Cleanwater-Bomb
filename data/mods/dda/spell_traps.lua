local ccb = require("ccb")
local content = ccb.content

-- This zombie 'corpse' looks eerily like it could get up and start walking at any moment.
content.add(content.Trap {
    id = "tr_dormant_corpse",
    name = ccb.content.text("dormant zombie corpse"),
    color = "light_green",
    symbol = "Z",
    visibility = 8,
    avoidance = 20,
    difficulty = 99,
    action = "spell",
    spell = "wake_up_dormant",
    trigger_message_u = ccb.content.text("A zombie rises from the ground!"),
    trigger_message_npc = ccb.content.text("A zombie rises from the ground!"),
    sound_threshold_min = 10,
    sound_threshold_max = 20,
}
    :flag("UNDODGEABLE")
    :flag("AVATAR_ONLY")
    :flag("PROXIMITY"))

content.add(content.Trap {
    id = "tr_spider",
    name = ccb.content.text("trapdoor spiderden"),
    color = "green",
    symbol = "#",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 4,
    action = "spell",
    spell = "summon_trapspider",
    always_invisible = true,
})
