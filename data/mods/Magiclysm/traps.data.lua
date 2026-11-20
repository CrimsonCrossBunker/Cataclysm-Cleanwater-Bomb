local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_rune_trap_summon_blades",
    name = ccb.content.text("glowing runes"),
    color = "blue",
    symbol = "o",
    visibility = 15,
    avoidance = 13,
    difficulty = 99,
    action = "none",
    trigger_weight = "50000 g",
    avatar_message = ccb.content.text("As you step forward, runes begin glowing brightly!"),
    npc_message = ccb.content.text("As <npcname> steps forward, runes begin glowing brightly!"),
    flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "summon_blades_trap",
}

ccb.content.define_trap {
    id = "tr_rune_trap_summon_krabgek",
    name = ccb.content.text("glowing runes"),
    color = "red",
    symbol = "o",
    visibility = 15,
    avoidance = 13,
    difficulty = 99,
    action = "none",
    trigger_weight = "50000 g",
    avatar_message = ccb.content.text("As you step forward, runes begin glowing brightly!"),
    npc_message = ccb.content.text("As <npcname> steps forward, runes begin glowing brightly!"),
    flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "summon_krabgek_trap",
}
