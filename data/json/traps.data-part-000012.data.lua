local ccb = require("ccb")

-- Needs to be AVATAR_ONLY, otherwise the summoned monsters trigger the trap again.
ccb.content.define_trap {
    id = "tr_alien_tree_trap_roots",
    name = ccb.content.text("alien roots"),
    color = "dark_gray",
    symbol = "/",
    visibility = 12,
    avoidance = 10,
    difficulty = 99,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    action = "none",
    trigger_weight = "50000 g",
    avatar_message = ccb.content.text("As you step on the roots, they twitch slightly."),
    npc_message = ccb.content.text("As <npcname> steps on the roots, they twitch slightly."),
    trigger_handler = "disturb_alien_roots",
}
