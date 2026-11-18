local ccb = require("ccb")
local content = ccb.content

-- Use the swirling vortex's spotting, dodge, and trigger settings for the abyssal doorway.
content.add(content.Trap {
    id = "tr_abyssal_hunger_next_level",
    name = ccb.content.text("Hole to elsewhere"),
    color = "blue",
    symbol = "#",
    visibility = -1,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    action = "spell",
    spell = "abyssal_hunger_next_level",
}
    :flag("UNDODGEABLE")
    :flag("AVATAR_ONLY"))

content.add(content.Trap {
    id = "tr_salamander_bomb",
    name = ccb.content.text("sigil of detonation"),
    color = "red",
    symbol = "#",
    always_invisible = false,
    memorial_male = ccb.content.text("Detonated by elemental magicks.", "memorial_male"),
    memorial_female = ccb.content.text("Detonated by elemental magicks.", "memorial_female"),
    visibility = 2,
    avoidance = 14,
    difficulty = 10,
    trap_radius = 0,
    action = "spell",
    spell = "salamander_explosion_trap_spell_activated",
}
    :flag("UNDODGEABLE"))

content.add(content.Trap {
    id = "tr_xedra_dreamsmith_time_trap",
    name = ccb.content.text("time cage"),
    color = "light_gray",
    symbol = "#",
    visibility = 2,
    avoidance = 10,
    difficulty = 5,
    trap_radius = 0,
    trigger_message_npc = ccb.content.text("<npcname> is frozen in time!"),
    action = "spell",
    spell = "xedra_dreamsmith_time_trap_freeze",
}
    :flag("UNDODGEABLE")
    :drop("xedra_dreamsmith_time_trap"))
