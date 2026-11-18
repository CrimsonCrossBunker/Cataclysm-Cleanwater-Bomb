local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_vitakinesis", count = 1 },
    { id = "matrix_crystal_vitakinesis_artifact", count = 1 },
}

local physical_crystals = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_vitakinesis", count = 1 },
}

register {
    id = "practice_vita_health_power",
    name = content.text("contemplation: healthy glow"),
    description = content.text("Contemplate your powers and improve your ability to enhance your overall health.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:vita_health_power>"),
    spell = "vita_health_power",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_vita_slow_bleeding",
    name = content.text("contemplation: coagulation"),
    description = content.text("Contemplate your powers and improve your ability to slow your rate of bleeding.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:vita_slow_bleeding>"),
    spell = "vita_slow_bleeding",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_vita_concentrated_healing",
    name = content.text("contemplation: leukocyte accumulation"),
    description = content.text("Contemplate your powers and improve your ability to direct your body's healing ability to where it is most needed.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:vita_concentrated_healing>"),
    spell = "vita_concentrated_healing",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_vita_stop_bleeding",
    name = content.text("contemplation: staunch wound"),
    description = content.text("Contemplate your powers and improve your ability to stop bleeding.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:vita_stop_bleeding>"),
    spell = "vita_stop_bleeding",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_vita_hurt_touch",
    name = content.text("contemplation: enervating touch"),
    description = content.text("Contemplate your powers and improve your ability to induce decay.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:vita_hurt_touch>"),
    spell = "vita_hurt_touch",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_vita_healing_touch",
    name = content.text("contemplation: medicinal touch"),
    description = content.text("Contemplate your powers and improve your ability to speed your allies' healing.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:vita_health_power_ally>"),
    spell = "vita_health_power_ally",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_vita_remove_poison",
    name = content.text("contemplation: detoxification"),
    description = content.text("Contemplate your powers and improve your ability to sweat out any dangerous toxins.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:vita_remove_poison>"),
    spell = "vita_remove_poison",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_vita_sleeping_trance",
    name = content.text("contemplation: wakeful rest"),
    description = content.text("Contemplate your powers and develop your ability to forego sleep in favor of meditation.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:vita_sleeping_trance>"),
    spell = "vita_sleeping_trance",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_cure_disease",
    name = content.text("contemplation: immunostimulus"),
    description = content.text("Contemplate your powers and develop your ability to cure mundane illnesses in yourself.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:vita_cure_disease>"),
    spell = "vita_cure_disease",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_stop_infection",
    name = content.text("contemplation: allay infection"),
    description = content.text("Contemplate your powers and improve your ability to use your powers to disinfect.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:vita_stop_infection>"),
    spell = "vita_stop_infection",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_increased_hp",
    name = content.text("contemplation: durability"),
    description = content.text("Contemplate your powers and improve your durability against debilitating injury.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:vita_stop_infection>"),
    spell = "vita_increased_hp",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_healing_trance",
    name = content.text("contemplation: revitalizing meditation"),
    description = content.text("Contemplate your powers and improve your ability to speed healing while meditating.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:vita_healing_trance>"),
    spell = "vita_healing_trance",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_purge_rads",
    name = content.text("contemplation: radiation decontamination"),
    description = content.text("Contemplate your powers and improve your ability to remove radiation from your body.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:vita_purge_rads>"),
    spell = "vita_purge_rads",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
    require_known = true,
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_attack_touch",
    name = content.text("contemplation: lacerating touch"),
    description = content.text("Contemplate your powers and improve your ability to cause wounds with a touch.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:vita_attack_touch>"),
    spell = "vita_attack_touch",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_vita_no_need_for_sleep",
    name = content.text("contemplation: selective autosomnia"),
    description = content.text("Contemplate your powers and improve your ability to sleep while remaining awake.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:vita_no_need_for_sleep>"),
    spell = "vita_no_need_for_sleep",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = physical_crystals,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_blood_purge",
    name = content.text("contemplation: blood purge"),
    description = content.text("Contemplate your powers and improve your ability to cleanse impurities from your blood.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:vita_blood_purge>"),
    spell = "vita_blood_purge",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_banish_illness",
    name = content.text("contemplation: banish illness"),
    description = content.text("Contemplate your powers and improve your ability to cure permanent or long-term conditions.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:vita_banish_illness>"),
    spell = "vita_banish_illness",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_super_heal",
    name = content.text("contemplation: anabolic rejuvenation"),
    description = content.text("Contemplate your powers and improve your ability to heal unbelievably quickly, but at a cost.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:vita_super_heal>"),
    spell = "vita_super_heal",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_limb_restore",
    name = content.text("contemplation: ameliorate extremity"),
    description = content.text("Contemplate your powers and improve your ability to restore whole limbs, but at an extreme cost.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:vita_limb_restore>"),
    spell = "vita_limb_restore",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_degenerating_touch",
    name = content.text("contemplation: degenerating touch"),
    description = content.text("Contemplate your powers and improve your ability to cause a target's body to break down on a fundamental level.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:vita_degenerating_touch>"),
    spell = "vita_degenerating_touch",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

register {
    id = "practice_vita_return_from_death",
    name = content.text("contemplation: accelerated resuscitation"),
    description = content.text("Contemplate your powers and improve your ability to keep yourself alive in the event of a near-death experience.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:vita_return_from_death>"),
    spell = "vita_return_from_death",
    trait = "VITAKINETIC",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}
