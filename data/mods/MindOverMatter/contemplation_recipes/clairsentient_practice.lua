local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_clairsentience", count = 1 },
    { id = "matrix_crystal_clairsentience_artifact", count = 1 },
}

register {
    id = "practice_clair_better_senses",
    name = content.text("contemplation: heightened senses"),
    description = content.text("Contemplate your powers and improve your ability to enhance your mundane senses.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:clair_better_senses>"),
    spell = "clair_better_senses",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_clair_speed_reading",
    name = content.text("contemplation: speed reading"),
    description = content.text("Contemplate your powers and improve your ability to comprehend books.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:clair_speed_reading>"),
    spell = "clair_speed_reading",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_clair_danger_sense",
    name = content.text("contemplation: premonition"),
    description = content.text("Contemplate your powers and improve your sense of nearby danger.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:clair_danger_sense>"),
    spell = "clair_danger_sense",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_clair_night_vision",
    name = content.text("contemplation: night eyes"),
    description = content.text("Contemplate your powers and improve your ability to sense your surroundings in the dark.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:clair_night_vision>"),
    spell = "clair_night_vision",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_clair_spot_weakness",
    name = content.text("contemplation: discern weakness"),
    description = content.text("Contemplate your powers and improve your sense of the vulnerabilities of your enemies.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:clair_spot_weakness>"),
    spell = "clair_spot_weakness",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_clair_sense_rads",
    name = content.text("contemplation: sense radiation"),
    description = content.text("Contemplate your powers and improve your ability to detect radiation.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:clair_sense_rads>"),
    spell = "clair_sense_rads",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
    require_known = true,
    tools = crystal_tools,
}

register {
    id = "practice_clair_aura_sight",
    name = content.text("contemplation: aura sight"),
    description = content.text("Contemplate your powers and improve your ability to see others' emotional states.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:clair_see_auras>"),
    spell = "clair_see_auras",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_clair_ranged_enhance",
    name = content.text("contemplation: marksman's eye"),
    description = content.text("Contemplate your powers and improve your ability to aim ranged weapons with precision.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:clair_ranged_enhance>"),
    spell = "clair_ranged_enhance",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_examine_item",
    name = content.text("contemplation: psychometry"),
    description = content.text("Contemplate your powers and improve your ability to determine hidden aspects of items.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:clair_examine_item>"),
    spell = "clair_examine_item",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_sense_hostile_creatures",
    name = content.text("contemplation: sense hostility"),
    description = content.text("Contemplate your powers and improve your ability to determine nearby creatures' hostility even if you can't see them with your physical senses.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:clair_sense_hostile_creatures>"),
    spell = "clair_sense_hostile_creatures",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_voyance",
    name = content.text("contemplation: clairvoyance"),
    description = content.text("Contemplate your powers and improve your ability to extend your senses beyond your body.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:clair_voyance>"),
    spell = "clair_voyance",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_dodge_power",
    name = content.text("contemplation: combat sense"),
    description = content.text("Contemplate your powers and improve your ability to see into the very near-term future.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:clair_dodge_power>"),
    spell = "clair_dodge_power",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_craft_bonus",
    name = content.text("contemplation: intuitive artisan"),
    description = content.text("Contemplate your powers and improve your ability to determine exactly how you should build that thing you're working on.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:clair_craft_bonus>"),
    spell = "clair_craft_bonus",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_see_map",
    name = content.text("contemplation: satellite view"),
    description = content.text("Contemplate your powers and improve your ability to extend your senses over a vast distance.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:clair_see_map>"),
    spell = "clair_see_map",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_perfect_shot",
    name = content.text("contemplation: one perfect shot"),
    description = content.text("Contemplate your powers and improve your ability to only need one shot.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:clair_perfect_shot>"),
    spell = "clair_perfect_shot",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_clear_sight",
    name = content.text("contemplation: clarity"),
    description = content.text("Contemplate your powers and improve your ability to remove all barriers from your senses.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:clair_clear_sight>"),
    spell = "clair_clear_sight",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_astral_projection",
    name = content.text("contemplation: astral projection"),
    description = content.text("Contemplate your powers and improve your ability to cast your spirit forth from your body.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:clair_astral_projection>"),
    spell = "clair_astral_projection",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_group_tactics",
    name = content.text("contemplation: prescient tactics"),
    description = content.text("Contemplate your powers and improve your ability to use foresight to advise your allies.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:clair_group_tactics>"),
    spell = "clair_group_tactics",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}

register {
    id = "practice_clair_omniscience",
    name = content.text("contemplation: omniscience"),
    description = content.text("Contemplate your powers and improve your ability to see everything.  <color_red>EVERYTHING</color>.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:clair_omniscience>"),
    spell = "clair_omniscience",
    trait = "CLAIRSENTIENT",
    proficiency = "prof_contemplation_clairsentience",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_clair_dust",
}
