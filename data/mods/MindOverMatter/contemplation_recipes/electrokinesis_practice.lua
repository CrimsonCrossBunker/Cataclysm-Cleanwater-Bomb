local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_electrokinesis", count = 1 },
    { id = "matrix_crystal_electrokinesis_artifact", count = 1 },
}

register {
    id = "practice_electrokinetic_see_electric",
    name = content.text("contemplation: spark sight"),
    description = content.text("Contemplate your powers and improve your ability to detect electrical creatures or robots.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:electrokinetic_see_electric>"),
    spell = "electrokinetic_see_electric",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_electrokinetic_shock_touch",
    name = content.text("contemplation: static touch"),
    description = content.text("Contemplate your powers and improve your ability to build up a charge in your hand and unleash it.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:electrokinetic_shock_touch>"),
    spell = "electrokinetic_shock_touch",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_electrokinetic_zap_enemies",
    name = content.text("contemplation: electrical discharge"),
    description = content.text("Contemplate your powers and improve your ability to electrocute those who attack you.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:electrokinetic_zap_enemies>"),
    spell = "electrokinetic_zap_enemies",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_electrokinetic_melee_attacks",
    name = content.text("contemplation: voltaic strikes"),
    description = content.text("Contemplate your powers and improve your ability to channel electrical current through your melee attacks.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:electrokinetic_melee_attacks>"),
    spell = "electrokinetic_melee_attacks",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_electrokinetic_personal_battery",
    name = content.text("contemplation: electron overflow"),
    description = content.text("Contemplate your powers and improve your ability to fuel personal electronic devices with your powers.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:electrokinetic_personal_battery>"),
    spell = "electrokinetic_personal_battery",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_electrokinetic_paralysis",
    name = content.text("contemplation: neural spasms"),
    description = content.text("Contemplate your powers and improve your ability to paralyze your targets.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:electrokinetic_paralysis>"),
    spell = "electrokinetic_paralysis",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_hacking_interface",
    name = content.text("contemplation: hacking interface"),
    description = content.text("Contemplate your powers and improve your ability to psychically interface with computers.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:electrokinetic_hacking_interface>"),
    spell = "electrokinetic_hacking_interface",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_reduce_pain",
    name = content.text("contemplation: pain suppression"),
    description = content.text("Contemplate your powers and improve your ability to reduce the effects of pain.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:electrokinetic_reduce_pain>"),
    spell = "electrokinetic_reduce_pain",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_lightning_bolt",
    name = content.text("contemplation: electrocutioner"),
    description = content.text("Contemplate your powers and improve your ability to unleash blasts of lightning.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:electrokinetic_lightning_bolt>"),
    spell = "electrokinetic_lightning_bolt",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_recharge_vehicle",
    name = content.text("contemplation: re-energize"),
    description = content.text("Contemplate your powers and improve your ability to recharge large-scale batteries or connected power grids.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:electrokinetic_recharge_vehicle>"),
    spell = "electrokinetic_recharge_vehicle",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_speed_boost",
    name = content.text("contemplation: neuro-acceleration"),
    description = content.text("Contemplate your powers and improve your ability to increase your or an ally's speed.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:electrokinetic_speed_boost>"),
    spell = "electrokinetic_speed_boost",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_pain_immune",
    name = content.text("contemplation: analgesic block"),
    description = content.text("Contemplate your powers and improve your ability to put off the effects of pain completely until later.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:electrokinetic_pain_immune>"),
    spell = "electrokinetic_pain_immune",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_kill_robot",
    name = content.text("contemplation: short circuit"),
    description = content.text("Contemplate your powers and improve your ability to overload robots and cyborgs.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:electrokinetic_kill_robot>"),
    spell = "electrokinetic_kill_robot",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_robot_interface",
    name = content.text("contemplation: robotic interface"),
    description = content.text("Contemplate your powers and improve your ability to psychically hack into nearby robots.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:electrokinetic_robot_interface>"),
    spell = "electrokinetic_robot_interface",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_lightning_aura",
    name = content.text("contemplation: galvanic aura"),
    description = content.text("Contemplate your powers and improve your ability to charge the nearby air to blast your enemies.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:electrokinetic_lightning_aura>"),
    spell = "electrokinetic_lightning_aura",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_lightning_blast",
    name = content.text("contemplation: ion blast"),
    description = content.text("Contemplate your powers and improve your ability to unleash enormous blasts of lightning.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:electrokinetic_lightning_blast>"),
    spell = "electrokinetic_lightning_blast",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}

register {
    id = "practice_electrokinetic_revive",
    name = content.text("contemplation: revivification"),
    description = content.text("Contemplate your powers and improve your ability to make the dead move again briefly.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:electrokinetic_revive>"),
    spell = "electrokinetic_revive",
    trait = "ELECTROKINETIC",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_electrokin_dust",
}
