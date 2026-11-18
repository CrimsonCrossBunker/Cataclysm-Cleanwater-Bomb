local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

register {
    id = "practice_biokin_flexibility_knack",
    name = content.text("contemplation: flexibility"),
    description = content.text("Contemplate your powers and improve your ability to move your body.\n\nCurrent Power Level: <u_spell_level:biokin_flexibility_knack>"),
    spell = "biokin_flexibility_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_biokinesis",
    learning = "study",
}

register {
    id = "practice_biokin_adrenaline_knack",
    name = content.text("contemplation: adrenaline trigger"),
    description = content.text("Contemplate your powers and improve your ability to trigger a burst of adrenaline on command.\n\nCurrent Power Level: <u_spell_level:biokin_adrenaline_knack>"),
    spell = "biokin_adrenaline_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_biokinesis",
    learning = "study",
}

register {
    id = "practice_clair_better_senses_knack",
    name = content.text("contemplation: heightened senses"),
    description = content.text("Contemplate your powers and improve your ability to enhance your mundane senses.\n\nCurrent Power Level: <u_spell_level:clair_better_senses_knack>"),
    spell = "clair_better_senses_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
}

register {
    id = "practice_clair_danger_sense_knack",
    name = content.text("contemplation: premonition"),
    description = content.text("Contemplate your powers and improve your sense of nearby danger.\n\nCurrent Power Level: <u_spell_level:clair_danger_sense_knack>"),
    spell = "clair_danger_sense_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
}

register {
    id = "practice_clair_examine_item_knack",
    name = content.text("contemplation: psychometry"),
    description = content.text("Contemplate your powers and improve your ability to determine hidden aspects of items.\n\nCurrent Power Level: <u_spell_level:clair_examine_item_knack>"),
    spell = "clair_examine_item_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
}

register {
    id = "practice_clair_astral_projection_knack",
    name = content.text("contemplation: astral projection"),
    description = content.text("Contemplate your powers and improve your ability to cast your spirit forth from your body.\n\nCurrent Power Level: <u_spell_level:clair_astral_projection_knack>"),
    spell = "clair_astral_projection_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_clairsentience",
    learning = "study",
}

register {
    id = "practice_electrokinetic_see_electric_knack",
    name = content.text("contemplation: spark sight"),
    description = content.text("Contemplate your powers and improve your ability to detect electrical creatures or robots.\n\nCurrent Power Level: <u_spell_level:electrokinetic_see_electric_knack>"),
    spell = "electrokinetic_see_electric_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "study",
}

register {
    id = "practice_electrokinetic_pain_immune_knack",
    name = content.text("contemplation: analgesic block"),
    description = content.text("Contemplate your powers and improve your ability to put off the effects of pain completely until later.\n\nCurrent Power Level: <u_spell_level:electrokinetic_pain_immune_knack>"),
    spell = "electrokinetic_pain_immune_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "study",
}

register {
    id = "practice_electrokinetic_hacking_interface_knack",
    name = content.text("contemplation: hacking interface"),
    description = content.text("Contemplate your powers and improve your ability to hack nearby devices with your powers.\n\nCurrent Power Level: <u_spell_level:electrokinetic_hacking_interface_knack>"),
    spell = "electrokinetic_hacking_interface_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_electrokinesis",
    learning = "study",
}

register {
    id = "practice_photokinetic_camouflage_knack",
    name = content.text("contemplation: chameleoflage"),
    description = content.text("Contemplate your powers and improve your ability to hide your presence from distant observers.\n\nCurrent Power Level: <u_spell_level:photokinetic_camouflage_knack>"),
    spell = "photokinetic_camouflage_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_photokinesis",
    learning = "study",
}

register {
    id = "practice_photokinetic_hide_ugly_knack",
    name = content.text("contemplation: mirror-mask"),
    description = content.text("Contemplate your powers and improve your ability to disguise your appearance behind an illusion.\n\nCurrent Power Level: <u_spell_level:photokinetic_hide_ugly_knack>"),
    spell = "photokinetic_hide_ugly_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_photokinesis",
    learning = "study",
}

register {
    id = "practice_photokinetic_radio_knack",
    name = content.text("contemplation: radio transception"),
    description = content.text("Contemplate your powers and improve your ability to see, interpret, and transmit radio waves.\n\nCurrent Power Level: <u_spell_level:photokinetic_radio_knack>"),
    spell = "photokinetic_radio_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_photokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_flash_knack",
    name = content.text("contemplation: brilliant flash"),
    description = content.text("Contemplate your powers and improve your ability to create light.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_flash_knack>"),
    spell = "pyrokinetic_flash_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_intensify_flames_knack",
    name = content.text("contemplation: intensify flames"),
    description = content.text("Contemplate your powers and improve your ability increase the strength of existing flames.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_intensify_flames_knack>"),
    spell = "pyrokinetic_intensify_flames_knack",
    trait = "PYROKINETIC",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_eruption_knack",
    name = content.text("contemplation: fountain of flames"),
    description = content.text("Contemplate your powers and improve your ability to summon flames.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_eruption_knack>"),
    spell = "pyrokinetic_eruption_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_call_flames_knack",
    name = content.text("contemplation: banked flames"),
    description = content.text("Contemplate your powers and improve your ability to summon a controlled flame.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_call_flames_knack>"),
    spell = "pyrokinetic_call_flames_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_cloak_knack",
    name = content.text("contemplation: cloak of warmth"),
    description = content.text("Contemplate your powers and improve your control of nearby temperatures.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_cloak_knack>"),
    spell = "pyrokinetic_cloak_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_flamethrower_knack",
    name = content.text("contemplation: flamethrower"),
    description = content.text("Contemplate your powers and improve your ability to direct a spray of flame.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_flamethrower_knack>"),
    spell = "pyrokinetic_flamethrower_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_aura_knack",
    name = content.text("contemplation: blazing aura"),
    description = content.text("Contemplate your powers and improve your ability to heat the surrounding air to dangerous temperatures.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_aura_knack>"),
    spell = "pyrokinetic_aura_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_pyrokinetic_blast_knack",
    name = content.text("contemplation: conflagration"),
    description = content.text("Contemplate your powers and improve your manifestation of explosions.\n\nCurrent Power Level: <u_spell_level:pyrokinetic_blast_knack>"),
    spell = "pyrokinetic_blast_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_pyrokinesis",
    learning = "study",
}

register {
    id = "practice_telekinetic_pull_knack",
    name = content.text("contemplation: far hand"),
    description = content.text("Contemplate your powers and improve your manipulation of non-living matter.\n\nCurrent Power Level: <u_spell_level:telekinetic_pull_knack>"),
    spell = "telekinetic_pull_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
}

register {
    id = "practice_telekinetic_push_knack",
    name = content.text("contemplation: force shove"),
    description = content.text("Contemplate your powers and improve your manipulation of living beings.\n\nCurrent Power Level: <u_spell_level:telekinetic_push_knack>"),
    spell = "telekinetic_push_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
}

register {
    id = "practice_telekinetic_slam_down_knack",
    name = content.text("contemplation: knockdown"),
    description = content.text("Contemplate your powers and improve your ability to knock your targets over.\n\nCurrent Power Level: <u_spell_level:telekinetic_slam_down_knack>"),
    spell = "telekinetic_slam_down_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
}

register {
    id = "practice_telekinetic_wave_knack",
    name = content.text("contemplation: wave of force"),
    description = content.text("Contemplate your powers and develop your ability to control bursts of telekinetic force.\n\nCurrent Power Level: <u_spell_level:telekinetic_wave_knack>"),
    spell = "telekinetic_wave_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
}

register {
    id = "practice_telekinetic_shield_knack",
    name = content.text("contemplation: inertial barrier"),
    description = content.text("Contemplate your powers and improve your creation of force barriers.\n\nCurrent Power Level: <u_spell_level:telekinetic_shield_knack>"),
    spell = "telekinetic_shield_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telekinesis",
    learning = "study",
}

register {
    id = "practice_telepathic_shield_knack",
    name = content.text("contemplation: telepathic shield"),
    description = content.text("Contemplate your powers and improve the resilience of your mind.\n\nCurrent Power Level: <u_spell_level:telepathic_shield_knack>"),
    spell = "telepathic_shield_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_mind_sense_knack",
    name = content.text("contemplation: mind sense"),
    description = content.text("Contemplate your powers and improve your ability to detect other minds.\n\nCurrent Power Level: <u_spell_level:telepathic_mind_sense_knack>"),
    spell = "telepathic_mind_sense_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_morale_knack",
    name = content.text("contemplation: mood stabilization"),
    description = content.text("Contemplate your powers and improve your control of your own emotions or the emotions of others.\n\nCurrent Power Level: <u_spell_level:telepathic_morale_knack>"),
    spell = "telepathic_morale_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_blast_knack",
    name = content.text("contemplation: synaptic overload"),
    description = content.text("Contemplate your powers and improve your mental strength to telepathically assault your enemies.\n\nCurrent Power Level: <u_spell_level:telepathic_blast_knack>"),
    spell = "telepathic_blast_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_mesmerize_knack",
    name = content.text("contemplation: mesmerize"),
    description = content.text("Contemplate your powers and improve your ability to place your opponents into a trance.\n\nCurrent Power Level: <u_spell_level:telepathic_mesmerize_knack>"),
    spell = "telepathic_mesmerize_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_animal_mind_control_knack",
    name = content.text("contemplation: beastmaster"),
    description = content.text("Contemplate your powers and improve your ability to overpower the minds of animals.\n\nCurrent Power Level: <u_spell_level:telepathic_animal_mind_control_knack>"),
    spell = "telepathic_animal_mind_control_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_invisibility_knack",
    name = content.text("contemplation: obscurity"),
    description = content.text("Contemplate your powers and improve your ability to make your enemies ignore you.\n\nCurrent Power Level: <u_spell_level:telepathic_invisibility_knack>"),
    spell = "telepathic_invisibility_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_telepathic_blast_radius_knack",
    name = content.text("contemplation: psychic scream"),
    description = content.text("Contemplate your powers and improve the volume of your undirected psionic shrieking.\n\nCurrent Power Level: <u_spell_level:telepathic_blast_radius_knack>"),
    spell = "telepathic_blast_radius_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_telepathy",
    learning = "study",
}

register {
    id = "practice_vita_health_power_knack",
    name = content.text("contemplation: healthy glow"),
    description = content.text("Contemplate your powers and improve your ability to enhance your overall health.\n\nCurrent Power Level: <u_spell_level:vita_health_power_knack>"),
    spell = "vita_health_power_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
}

register {
    id = "practice_vita_concentrated_healing_knack",
    name = content.text("contemplation: leukocyte accumulation"),
    description = content.text("Contemplate your powers and improve your ability to direct your body's healing ability to where it is most needed.\n\nCurrent Power Level: <u_spell_level:vita_concentrated_healing_knack>"),
    spell = "vita_concentrated_healing_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
}

register {
    id = "practice_vita_remove_poison_knack",
    name = content.text("contemplation: detoxification"),
    description = content.text("Contemplate your powers and improve your ability to sweat out any dangerous toxins.\n\nCurrent Power Level: <u_spell_level:vita_remove_poison_knack>"),
    spell = "vita_remove_poison_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
}

register {
    id = "practice_vita_cure_disease_knack",
    name = content.text("contemplation: immunostimulus"),
    description = content.text("Contemplate your powers and develop your ability to cure mundane illnesses in yourself.\n\nCurrent Power Level: <u_spell_level:vita_cure_disease_knack>"),
    spell = "vita_cure_disease_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
}

register {
    id = "practice_vita_banish_illness_knack",
    name = content.text("contemplation: banish illness"),
    description = content.text("Contemplate your powers and improve your ability to cure permanent or long-term conditions.\n\nCurrent Power Level: <u_spell_level:vita_banish_illness_knack>"),
    spell = "vita_banish_illness_knack",
    trait = "PSYCHIC_KNACK",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
}
