local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_teleportation", count = 1 },
    { id = "matrix_crystal_teleportation_artifact", count = 1 },
}

register {
    id = "practice_teleport_blink",
    name = content.text("contemplation: blink"),
    description = content.text("Contemplate your powers and improve your ability to travel to a random location nearby without crossing the intervening space.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:teleport_blink>"),
    spell = "teleport_blink",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_teleport_slow",
    name = content.text("contemplation: stutterstep"),
    description = content.text("Contemplate your powers and improve your ability to reshape space around your enemies.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:teleport_slow>"),
    spell = "teleport_slow",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_teleport_phase",
    name = content.text("contemplation: phase"),
    description = content.text("Contemplate your powers and improve your ability to travel short distances in a controlled matter without crossing the intervening space.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:teleport_phase>"),
    spell = "teleport_phase",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_teleport_item_apport",
    name = content.text("contemplation: apportation"),
    description = content.text("Contemplate your powers and improve your ability to teleport an item without following it to its destination.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:teleport_item_apport>"),
    spell = "teleport_item_apport",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_teleport_stride",
    name = content.text("contemplation: extended stride"),
    description = content.text("Contemplate your powers and improve your ability to warp space around your movements.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:teleport_stride>"),
    spell = "teleport_stride",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_teleport_transpose",
    name = content.text("contemplation: transposition"),
    description = content.text("Contemplate your powers and improve your control of relative position exchange.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:teleport_transpose>"),
    spell = "teleport_transpose",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_displacement",
    name = content.text("contemplation: displacement"),
    description = content.text("Contemplate your powers and improve your ability to teleport your enemies away from you.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:teleport_displacement>"),
    spell = "teleport_displacement",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_reactive_displacement",
    name = content.text("contemplation: reactive displacement"),
    description = content.text("Contemplate your powers and improve your ability to automatically teleport attackers away from you.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:teleport_reactive_displacement>"),
    spell = "teleport_reactive_displacement",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_collapse",
    name = content.text("contemplation: spacial vortex"),
    description = content.text("Contemplate your powers and improve your ability to bring distant points close together.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:teleport_collapse>"),
    spell = "teleport_collapse",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_warped_strikes",
    name = content.text("contemplation: warped strikes"),
    description = content.text("Contemplate your powers and improve your ability to maintain a slight distance from reality.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:teleport_warped_strikes>"),
    spell = "teleport_warped_strikes",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_ephemeral_walk",
    name = content.text("contemplation: ephemeral walk"),
    description = content.text("Contemplate your powers and improve your ability to maintain a slight distance from reality.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:teleport_ephemeral_walk>"),
    spell = "teleport_ephemeral_walk",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_farstep",
    name = content.text("contemplation: farstep"),
    description = content.text("Contemplate your powers and develop your ability to instantly travel to a new location.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:teleport_farstep>"),
    spell = "teleport_farstep",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_banish",
    name = content.text("contemplation: oubliette"),
    description = content.text("Contemplate your powers and improve your ability to banish your enemies to other dimensions.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:teleport_banish>"),
    spell = "teleport_banish",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_loci_establishment",
    name = content.text("contemplation: loci establishment"),
    description = content.text("Contemplate your powers and improve your ability to maintain an established locus that you can teleport to.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:teleport_loci_establishment>"),
    spell = "teleport_loci_establishment",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

-- EOC is intentionally missing false effect since the loci technique power is learned via the loci establishment EOC rather than on its own.
register {
    id = "practice_teleport_loci_technique",
    name = content.text("contemplation: loci technique"),
    description = content.text("Contemplate your powers and improve your ability to travel to an established locus.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:teleport_loci_technique>"),
    spell = "teleport_loci_technique",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "study",
    require_known = true,
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_gateway",
    name = content.text("contemplation: gateway"),
    description = content.text("Contemplate your powers and improve your ability to travel to long-distant points.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:teleport_gateway>"),
    spell = "teleport_gateway",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_dilated_gateway",
    name = content.text("contemplation: dilated gateway"),
    description = content.text("Contemplate your powers and improve your ability to teleport other creatures with you to long-distant points.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:teleport_dilated_gateway>"),
    spell = "teleport_dilated_gateway",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_relocation",
    name = content.text("contemplation: relocation"),
    description = content.text("Contemplate your powers and improve your ability to teleport held items to long-distant points.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:teleport_relocation>"),
    spell = "teleport_relocation",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_breach",
    name = content.text("contemplation: breach"),
    description = content.text("Contemplate your powers and improve your ability to open momentary portals to the Nether.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:teleport_summon>"),
    spell = "teleport_summon",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_warper_combat",
    name = content.text("contemplation: flickerflash stance"),
    description = content.text("Contemplate your powers and improve your ability to enact the TURQUOISE KEYSTONE protocols while in combat.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:teleport_warper_combat>"),
    spell = "teleport_warper_combat",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "study",
    require_known = true,
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}

register {
    id = "practice_teleport_reality_tear",
    name = content.text("contemplation: reality tear"),
    description = content.text("Contemplate your powers and improve your ability to permanently tear open reality.\n\nPower Difficulty: 10\n\nCurrent Power Level: <u_spell_level:teleport_reality_tear>"),
    spell = "teleport_reality_tear",
    trait = "TELEPORTER",
    proficiency = "prof_contemplation_teleportation",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_teleport_dust",
}
