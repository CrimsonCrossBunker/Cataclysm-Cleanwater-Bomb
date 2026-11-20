local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_level_4_metaphysics",
    name = ccb.content.text("Calm Mind"),
    description = ccb.content.text("While you still have a few stray thoughts, you have an easy time slipping into the mindframe to use psionic powers."),
    requirements = { { statistic = "num_gains_metaphysics_level_4", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_level_7_metaphysics",
    name = ccb.content.text("No-Mind"),
    description = ccb.content.text("With a moment's concentration you can slip into the mind-state necessary to channel Netherum energies."),
    requirements = { { statistic = "num_gains_metaphysics_level_7", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_level_10_metaphysics",
    name = ccb.content.text("Galaxy Brain"),
    description = ccb.content.text("You are one with the Nether and the Nether is with you.  Even powerful psionic manipulations are like child's play."),
    requirements = { { statistic = "num_gains_metaphysics_level_10", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_biokinesis",
    name = ccb.content.text("Better, Faster, Stronger."),
    description = ccb.content.text("Awaken as a biokinetic."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_clairsentience",
    name = ccb.content.text("Sight Beyond Sight."),
    description = ccb.content.text("Awaken as a clairsentient."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_electrokinesis",
    name = ccb.content.text("1.21 Jigawatts"),
    description = ccb.content.text("Awaken as an electrokinetic."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_photokinesis",
    name = ccb.content.text("Let There Be Light"),
    description = ccb.content.text("Awaken as a photokinetic."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_pyrokinesis",
    name = ccb.content.text("Firestarter"),
    description = ccb.content.text("Awaken as a pyrokinetic."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_telekinesis",
    name = ccb.content.text("Unequal and Opposite Reaction"),
    description = ccb.content.text("Awaken as a telekinetic."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_telepathy",
    name = ccb.content.text("Free Your Mind"),
    description = ccb.content.text("Awaken as a telepath."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_teleportation",
    name = ccb.content.text("Wherever You Go, There You Are"),
    description = ccb.content.text("Awaken as a teleporter."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_psi_awakening_vitakinesis",
    name = ccb.content.text("First, Do No Harm"),
    description = ccb.content.text("Awaken as a vitakinetic."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_gain_any_nether_attunement",
    name = ccb.content.text("I Feel A Tingling"),
    description = ccb.content.text("Gained any level of Nether Attunement."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_gain_rank_four_nether_attunement",
    name = ccb.content.text("It's Starting to Affect Me"),
    description = ccb.content.text("Gained four levels of Nether Attunement."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_gain_any_nether_attunement" },
}

ccb.content.define_achievement {
    id = "mom_gain_rank_eight_nether_attunement",
    name = ccb.content.text("I Can Feel It Flowing Through Me"),
    description = ccb.content.text("Gained eight levels of Nether Attunement."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_gain_rank_four_nether_attunement" },
}

ccb.content.define_achievement {
    id = "mom_gain_maximum_nether_attunement",
    name = ccb.content.text("Power Overwhelming"),
    description = ccb.content.text("Gained maximum possible level of Nether Attunement."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_gain_rank_eight_nether_attunement" },
}

ccb.content.define_achievement {
    id = "mom_learn_extended_channeling",
    name = ccb.content.text("Haste Makes Waste"),
    description = ccb.content.text("Learned the methods of extended channeling, enabling a safer way to draw on the Nether."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_learn_torrential_channeling",
    name = ccb.content.text("Rider on the Storm"),
    description = ccb.content.text("Learned the methods of torrential channeling, enabling greater power at correspondingly greater risk."),
    manual = true,
    requirements = {},
}

ccb.content.define_achievement {
    id = "mom_learn_verdant_hand_protocols",
    name = ccb.content.text("One-Punch Man"),
    description = ccb.content.text("Mastered the VERDANT HAND Combat Protocols."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_learn_verdant_hand_protocols" },
}

ccb.content.define_achievement {
    id = "mom_learn_flicker_flash_stance",
    -- TRANSLATORS: This is a reference to the sound that the X-man Nightcrawler makes when teleporting
    name = ccb.content.text("Bamf"),
    description = ccb.content.text("Mastered the TURQUOISE KEYSTONE protocols and learned the Flickerflash Stance power."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_learn_flicker_flash_stance" },
}

ccb.content.define_achievement {
    id = "mom_learn_guided_evolution",
    -- TRANSLATORS: This is a reference to Teenage Mutant Ninja Turtles
    name = ccb.content.text("Secrets of the Ooze"),
    description = ccb.content.text("Mastered the EMERALD VANGUARD techniques and learned the Guided Evolution power."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_learn_guided_evolution" },
}

ccb.content.define_achievement {
    id = "mom_get_the_hounds_on_your_trail",
    name = ccb.content.text("They Are Lean and Athirst!"),
    description = ccb.content.text("\"In an awful light that was not light, in a silence that shrieked, I saw them.\"\n\nUse of your powers attracted the attention of the Hounds.  Run."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_get_the_hounds_on_your_trail" },
}

ccb.content.define_achievement {
    id = "mom_use_telepathy_to_steal",
    name = ccb.content.text("These Aren't The Droids You're Looking For"),
    description = ccb.content.text("Used telepathy to get away with theft."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_use_telepathy_to_steal" },
}

ccb.content.define_achievement {
    id = "mom_oublietted_refugee_center_traitor",
    name = ccb.content.text("Jaunt"),
    description = ccb.content.text("It's longer than you think, pal!  Longer than you think!\n\nSent the refugee center traitor on a very, very long trip."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_oublietted_refugee_center_traitor" },
}

ccb.content.define_achievement {
    id = "teleported_offworld",
    name = ccb.content.text("Quantum Leapt"),
    description = ccb.content.text("There's so many worlds out there.  Why stick with just one?\n\nUsed your powers to teleport offworld during a raging portal storm."),
    manual = true,
    requirements = {},
    hidden_by = { "teleported_offworld" },
}

ccb.content.define_achievement {
    id = "mom_read_rubiks_mind",
    name = ccb.content.text("By the Rivers of Babylon"),
    description = ccb.content.text("\"Not once, in a dozen or a hundred or you know not how many worlds, was there anything left to save.\"\n\nLearned Rubik's history through telepathy."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_read_rubiks_mind" },
}

ccb.content.define_achievement {
    id = "mom_find_dead_fifth_sun_ocelopilli_trooper",
    name = ccb.content.text("In ie Tlecujlixquac, in ie Tlamamatlac"),
    description = ccb.content.text("\"Already at the edge of the fire, already at the stairway.\"\n\nFound the body of the ocēlōpilli soldier."),
    manual = true,
    requirements = {},
    hidden_by = { "mom_find_dead_fifth_sun_ocelopilli_trooper" },
}
