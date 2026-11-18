local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_telekinesis", count = 1 },
}

local matrix_crystals = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "matrix_crystal_telekinesis", count = 1 },
}

register {
    id = "practice_telekinetic_pull",
    name = content.text("contemplation: far hand"),
    description = content.text("Contemplate your powers and improve your manipulation of non-living matter.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:telekinetic_pull>"),
    spell = "telekinetic_pull",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_telekinetic_push",
    name = content.text("contemplation: force shove"),
    description = content.text("Contemplate your powers and improve your manipulation of living beings.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:telekinetic_push>"),
    spell = "telekinetic_push",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_telekinetic_noise",
    name = content.text("contemplation: noisemaker"),
    description = content.text("Contemplate your powers and improve your ability to create noisy distractions.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:telekinetic_noise>"),
    spell = "telekinetic_noise",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_telekinetic_slam_down",
    name = content.text("contemplation: knockdown"),
    description = content.text("Contemplate your powers and improve your ability to knock your targets over.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:telekinetic_slam_down>"),
    spell = "telekinetic_slam_down",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_telekinetic_momentum",
    name = content.text("contemplation: momentum alteration"),
    description = content.text("Contemplate your powers and improve your control of nearby momentum.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:telekinetic_momentum>"),
    spell = "telekinetic_momentum",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_telekinetic_slowfall",
    name = content.text("contemplation: slowfall"),
    description = content.text("Contemplate your powers and improve your ability to reduce the pull of gravity on yourself.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:telekinetic_slowfall>"),
    spell = "telekinetic_slowfall",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_wave",
    name = content.text("contemplation: wave of force"),
    description = content.text("Contemplate your powers and develop your ability to control bursts of telekinetic force.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:telekinetic_wave>"),
    spell = "telekinetic_wave",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_water_walking",
    name = content.text("contemplation: water walking"),
    description = content.text("Contemplate your powers and develop your ability to lift yourself up just enough to walk across water.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:telekinetic_water_walk>"),
    spell = "telekinetic_water_walk",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_lifting_field",
    name = content.text("contemplation: lifting field"),
    description = content.text("Contemplate your powers and develop your ability to lift a single object for long periods of time.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:telekinetic_lifting_field>"),
    spell = "telekinetic_lifting_field",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_strength",
    name = content.text("contemplation: enhance strength"),
    description = content.text("Contemplate your powers and improve your ability to move very heavy objects.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:telekinetic_strength>"),
    spell = "telekinetic_strength",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_hammer",
    name = content.text("contemplation: mindhammer"),
    description = content.text("Contemplate your powers and improve your ability to smash a small area with telekinetic force.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:telekinetic_hammer>"),
    spell = "telekinetic_hammer",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_vehicle_lift",
    name = content.text("contemplation: lift vehicle"),
    description = content.text("Contemplate your powers and improve your ability to pick up vehicles briefly.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:telekinetic_vehicle_lift>"),
    spell = "telekinetic_vehicle_lift",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_shield",
    name = content.text("contemplation: inertial barrier"),
    description = content.text("Contemplate your powers and improve your creation of force barriers.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:telekinetic_shield>"),
    spell = "telekinetic_shield",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_explosion",
    name = content.text("contemplation: wrecking ball"),
    description = content.text("Contemplate your powers and improve your manifestation of telekinetic explosions.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:telekinetic_explosion>"),
    spell = "telekinetic_explosion",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_levitation",
    name = content.text("contemplation: levitation"),
    description = content.text("Contemplate your powers and improve your ability to not quite fly.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:telekinetic_levitation>"),
    spell = "telekinetic_levitation",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_move_large_weight",
    name = content.text("contemplation: megakinesis"),
    description = content.text("Contemplate your powers and improve your ability to move truly enormous amounts of weight.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:telekinetic_move_large_weight>"),
    spell = "telekinetic_move_large_weight",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = matrix_crystals,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_aegis",
    name = content.text("contemplation: aegis"),
    description = content.text("Contemplate your powers and improve your ability to shield yourself from all harm.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:telekinetic_aegis>"),
    spell = "telekinetic_aegis",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}

register {
    id = "practice_telekinetic_earthshaker",
    name = content.text("contemplation: earthshaker"),
    description = content.text("Contemplate your powers and improve your ability to grip the very earth and shake it.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:telekinetic_earthshaker>"),
    spell = "telekinetic_earthshaker",
    trait = "TELEKINETIC",
    proficiency = "prof_contemplation_telekinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_telekin_dust",
}
