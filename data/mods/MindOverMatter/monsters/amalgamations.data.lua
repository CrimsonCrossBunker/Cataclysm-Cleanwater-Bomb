local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_amalgamation_photokinetic_flashbanger",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    name = ccb.content.plural_text("radiant amalgamation", "radiant amalgamations"),
    description = ccb.content.text("A four-legged creature with a bulbous body and a small head with a fanged maw, with three multi-jointed limbs waving above it in the air.  The limbs emit a soft glow, occasionally brightening into an eye-searing flare."),
    luminance = 5,
    attacks = {
        {
            cooldown = 3,
            move_cost = 150,
            damage = { { type = "cut", amount = 15, penetration = 5 } },
            minimum_hit_size = 4,
            minimum_damage_multiplier = 0.5,
            maximum_damage_multiplier = 1.2,
            infection_chance = 10,
            attack_upper = false,
            kind = "bite",
        },
        {
            id = "psi_amalgamation_photokinetic_flashbang",
            spell = { id = "photokinetic_flashbang_monster", min_level = 5 },
            casting_message = ccb.content.text("The air erupts into an eye-searing flash and a loud screech of static!"),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "monster_attack_psionics_available",
        },
    },
    inheritance = { add = { flags = { "PHOTOKIN_MONSTER_IMMUNE", "FLASHBANGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_photokinetic_irradiator",
    copy_from = "mon_amalgamation_abstract_med",
    symbol = "A",
    name = ccb.content.plural_text("phosphorescent amalgamation", "phosphorescent amalgamations"),
    description = ccb.content.text("A large creature with a sleek body running on seven multi-jointed legs, with four large mandibles dominating what you are forced by necessity to call its face.  It glows with an eerie blue light that gives you an uneasy feeling."),
    volume = "100 L",
    mass = "100 kg",
    hp = 150,
    melee_skill = 5,
    luminance = 30,
    attacks = {
        {
            id = "bite_grab",
            cooldown = 10,
            move_cost = 120,
            damage = { { type = "cut", amount = 15, penetration = 13 } },
            infection_chance = 10,
            minimum_hit_size = 0,
            when = "monster_attack_intact_mandibles",
        },
        {
            id = "grab_drag",
            cooldown = 15,
            grab_settings = { drag_distance = 2, move_cost_multiplier = 0.2 },
        },
        { id = "drag_followup", grab_settings = { drag_distance = 2, move_cost_multiplier = 0.2 } },
        {
            id = "psi_amalgamation_photokinetic_irradiation",
            spell = { id = "photokinetic_irradiation_aura_monster", min_level = 5 },
            casting_message = ccb.content.text("The glow of %1$s suddenly brightens into a flash!"),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "monster_attack_psionics_available",
        },
    },
}

ccb.content.define_monster {
    id = "mon_amalgamation_telekinetic_shielder",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    name = ccb.content.plural_text("guardian amalgamation", "guardian amalgamations"),
    description = ccb.content.text("A four-legged creature with a crab-like shell, with two eyes on stubby stalks and a small mouth filled with sharp fangs.  Three additional limbs with bulbous growths on their ends wave around, seemingly randomly except when they point briefly at one of the walking dead."),
    speed = 100,
    attacks = {
        {
            cooldown = 3,
            move_cost = 150,
            damage = { { type = "cut", amount = 15, penetration = 5 } },
            minimum_hit_size = 4,
            minimum_damage_multiplier = 0.5,
            maximum_damage_multiplier = 1.2,
            infection_chance = 10,
            attack_upper = false,
            kind = "bite",
        },
        {
            id = "smash",
            attack_upper = false,
            throw_strength = 40,
            cooldown = { 5, 15 },
            when = "allow_amalgamation_telekinetic_shielder_smash",
        },
        {
            id = "psi_amalgamation_telekinetic_shielder_shield_other",
            spell = { id = "amalgamation_telekinetic_shielder_shield_other_spell" },
            casting_message = ccb.content.text("%1$s waves its three appendages in the air."),
            kind = "spell",
            cooldown = { 10, 30 },
            when = "allow_amalgamation_telekinetic_shielder_psi_amalgamation_telekinetic_shielder_shield_other",
        },
    },
    tracking_distance = 8,
    inheritance = { add = { flags = { "KEEP_DISTANCE" } } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_telepathic_distractor",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    name = ccb.content.plural_text("whispering amalgamation", "whispering amalgamations"),
    description = ccb.content.text("A smooth, round body skittering around on seven jointed legs, this abomination does not seem to have any sensory organs at all.  When you look at it, you hear faint whispers in the back of your mind."),
    attacks = {
        {
            id = "psi_whispering_amalgamation_telepathic_whispering",
            spell = { id = "whispering_amalgamation_telepathic_whispering_spell" },
            cooldown = 2,
            casting_message = "",
            kind = "spell",
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_whispering_amalgamation_apply_mindsight",
            spell = { id = "whispering_amalgamation_apply_mindsight", hit_self = true },
            cooldown = 1,
            allow_no_target = true,
            casting_message = "",
            kind = "spell",
            when = "allow_amalgamation_telepathic_distractor_psi_whispering_amalgamation_apply_mindsight",
        },
    },
    vision_day = 5,
    tracking_distance = 8,
    inheritance = { add = { flags = { "MIND_SEEING", "KEEP_DISTANCE" } } },
}

ccb.content.define_monster {
    id = "mon_amalgamation_vitakinetic_debuffer",
    name = "enervating amalgamation",
    description = "An elongated body moving irregularly on five legs, with two flexible tentacles waving in the air as it moves.  It seems to have no head, with a ring of black spots on top that might be sensory organs.  Its skin is perfectly smooth and greyish-white, without a single spot or blemish.",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    speed = 95,
    regenerates = 3,
    attacks = {
        {
            kind = "melee",
            id = "mon_amalgamation_vitakinetic_debuff",
            move_cost = 60,
            accuracy = 6,
            dodgeable = true,
            blockable = true,
            cooldown = { 7, 21 },
            damage = {
                { type = "biological", amount = 1 },
            },
            avatar_hit = "%1$s touches you and you feel weaker!",
            avatar_miss = "%1$s tries to touch you, but you dodge!",
            avatar_no_damage = "%1$s touches you and you feel weaker!",
            npc_hit = "%1$s touches <npcname> and they flinch!",
            npc_miss = "%1$s tries to touch <npcname>, but they dodge!",
            npc_no_damage = "%1$s touches <npcname> and they flinch!",
            when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
            on_hit = "w16b_mon_hit_mindovermatter_6cf230094803",
        },
    },
    inheritance = {
        add = {
            flags = { "HIT_AND_RUN" },
        },
    },
}
