local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_photokinesis", count = 1 },
    { id = "matrix_crystal_photokinesis_artifact", count = 1 },
}

register {
    id = "practice_photokinetic_light_local",
    name = content.text("contemplation: candle's glow"),
    description = content.text("Contemplate your powers and improve your ability to create a small amount of light.\n\nPower Difficulty: 1\n\nCurrent Power Level: <u_spell_level:photokinetic_light_local>"),
    spell = "photokinetic_light_local",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_create_light",
    name = content.text("contemplation: field of light"),
    description = content.text("Contemplate your powers and improve your ability to create light at a distance.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:photokinetic_create_light>"),
    spell = "photokinetic_create_light",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "study",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_snuff_light",
    name = content.text("contemplation: blackout"),
    description = content.text("Contemplate your powers and improve your ability to snuff the light of an area.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:photokinetic_snuff_light>"),
    spell = "photokinetic_snuff_light",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_light_up_enemy",
    name = content.text("contemplation: illuminate"),
    description = content.text("Contemplate your powers and improve your ability to light up a single target.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:photokinetic_light_up_enemy>"),
    spell = "photokinetic_light_up_enemy",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_light_dodge",
    name = content.text("contemplation: trick of the light"),
    description = content.text("Contemplate your powers and improve your ability to create illusionary forms around yourself.\n\nPower Difficulty: 2\n\nCurrent Power Level: <u_spell_level:photokinetic_light_dodge>"),
    spell = "photokinetic_light_dodge",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_light_beam",
    name = content.text("contemplation: photon beam"),
    description = content.text("Contemplate your powers and improve your ability to focus photons into a high-energy beam.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:photokinetic_light_beam>"),
    spell = "photokinetic_light_beam",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_camouflage",
    name = content.text("contemplation: chameleoflage"),
    description = content.text("Contemplate your powers and improve your ability to hide your presence from distant observers.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:photokinetic_camouflage>"),
    spell = "photokinetic_camouflage",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_rad_immunity",
    name = content.text("contemplation: lucent barrier"),
    description = content.text("Contemplate your powers and improve your ability to create a barrier of light around you.\n\nPower Difficulty: 3\n\nCurrent Power Level: <u_spell_level:photokinetic_rad_immunity>"),
    spell = "photokinetic_rad_immunity",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
}

register {
    id = "practice_photokinetic_light_arms",
    name = content.text("contemplation: refracted arms"),
    description = content.text("Contemplate your powers and improve your ability to create illusions of extra arms.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:photokinetic_light_arms>"),
    spell = "photokinetic_light_arms",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_flash_bang",
    name = content.text("contemplation: flashbang"),
    description = content.text("Contemplate your powers and improve your ability to create a burst of light that will blind and deafen anyone nearby.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:photokinetic_flash_bang>"),
    spell = "photokinetic_flash_bang",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_hide_ugly",
    name = content.text("contemplation: mirror-mask"),
    description = content.text("Contemplate your powers and improve your ability to disguise your appearance behind an illusion.\n\nPower Difficulty: 4\n\nCurrent Power Level: <u_spell_level:photokinetic_hide_ugly>"),
    spell = "photokinetic_hide_ugly",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_light_image",
    name = content.text("contemplation: lucid shadows"),
    description = content.text("Contemplate your powers and improve your ability to create light clones.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:photokinetic_light_image>"),
    spell = "photokinetic_light_image",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_radio",
    name = content.text("contemplation: radio transception"),
    description = content.text("Contemplate your powers and improve your ability to see, interpret, and transmit radio waves.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:photokinetic_radio>"),
    spell = "photokinetic_radio",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_sterilize_food",
    name = content.text("contemplation: gamma sterilization"),
    description = content.text("Contemplate your powers and improve your ability use focused radiation to make food last longer.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:photokinetic_sterilize_food>"),
    spell = "photokinetic_sterilize_food",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_stun_robots",
    name = content.text("contemplation: sensor jamming"),
    description = content.text("Contemplate your powers and improve your ability to overload the sensors of robots and other electronics.\n\nPower Difficulty: 5\n\nCurrent Power Level: <u_spell_level:photokinetic_stun_robots>"),
    spell = "photokinetic_stun_robots",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_invisibility",
    name = content.text("contemplation: veil of light"),
    description = content.text("Contemplate your powers and improve your ability to refract light in a way that makes you invisible.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:photokinetic_invisibility>"),
    spell = "photokinetic_invisibility",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_light_flash",
    name = content.text("contemplation: star flash"),
    description = content.text("Contemplate your powers and improve your ability to create a destructive flash of light towards a target.\n\nPower Difficulty: 6\n\nCurrent Power Level: <u_spell_level:photokinetic_light_flash>"),
    spell = "photokinetic_light_flash",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_light_blinding_glare",
    name = content.text("contemplation: blinding radiance"),
    description = content.text("Contemplate your powers and improve your ability to glow so brightly you can blind your enemies.\n\nPower Difficulty: 7\n\nCurrent Power Level: <u_spell_level:photokinetic_blinding_glare>"),
    spell = "photokinetic_blinding_glare",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_light_disintegrate",
    name = content.text("contemplation: luminous disintegration"),
    description = content.text("Contemplate your powers and improve your ability to disintegrate matter with light.\n\nPower Difficulty: 8\n\nCurrent Power Level: <u_spell_level:photokinetic_light_disintegrate>"),
    spell = "photokinetic_light_disintegrate",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}

register {
    id = "practice_photokinetic_light_army",
    name = content.text("contemplation: phantom legion"),
    description = content.text("Contemplate your powers and improve your ability to summon a myriad of holographic clones of yourself.\n\nPower Difficulty: 9\n\nCurrent Power Level: <u_spell_level:photokinetic_light_army>"),
    spell = "photokinetic_light_army",
    trait = "PHOTOKINETIC",
    proficiency = "prof_contemplation_photokinesis",
    learning = "discover",
    tools = crystal_tools,
    component = "matrix_crystal_photokin_dust",
}
