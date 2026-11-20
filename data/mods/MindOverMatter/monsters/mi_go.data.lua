local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_mi_go_biokinetic",
    copy_from = "mon_mi_go_myrmidon",
    name = ccb.content.plural_text("mi-go juggernaut", "mi-go juggernauts"),
    description = ccb.content.text("This creature resembles the smaller mi-go like a grizzly bear resembles a human.  Its enormous, thick body is covered in an iridescent segmented carapace, like a scarab crossed with an isopod.  It boasts several pairs of deadly looking claws and other appendages, and it moves with a strange, slow grace, like an otherworldly dancer.  Sometimes, it moves so quickly that its movements are only a blur."),
    looks_like = "mon_mi_go_myrmidon",
    body_type = "migo",
    species = { "MIGO" },
    armor = { bash = 22, cut = 30, bullet = 26, electric = 6 },
    inheritance = {
        add = {
            attacks = {
                {
                    move_cost = 50,
                    allow_no_target = true,
                    maximum_range = 7,
                    message = ccb.content.text_without_extraction("%1$s moves so quickly your eyes can barely follow it!"),
                    kind = "leap",
                    cooldown = { 2, 6 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_juggernaut_speed_boost",
                    spell = { id = "biokinetic_speed_boost_monster_01", min_level = 5 },
                    casting_message = ccb.content.text("%1$s moves so quickly it's nothing but a blur!"),
                    kind = "spell",
                    cooldown = { 9, 27 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_juggernaut_heightened_reflexes",
                    spell = { id = "biokinetic_heightened_reflexes_enhanced_monster" },
                    cooldown = 1,
                    casting_message = ccb.content.text("%1$s begins moving much more quickly."),
                    kind = "spell",
                    when = "allow_transcendant_alpha_psion_psi_transcendant_alpha_heightened_reflexes",
                },
            },
            flags = { "STUN_IMMUNE" },
        },
        scale = { speed = 1.2 },
        offset = { dodge = 2, armor = { bash = 3, cut = 3, bullet = 4 } },
    },
}

ccb.content.define_monster {
    id = "mon_mi_go_photokinetic",
    copy_from = "mon_mi_go_slaver",
    name = ccb.content.plural_text("mi-go lightbringer", "mi-go lightbringers"),
    description = ccb.content.text("An alien creature of uncertain origin.  Its shapeless pink body bears numerous sets of paired appendages of unknown function, and a pair of ribbed, membranous wings which seem to be quite useless.  Its odd, vaguely pyramid-shaped head bristles with numerous wavering antennae, and it moves with an uncanny fluidity on its many legs."),
    looks_like = "mon_mi_go_slaver",
    attacks = {
        { reference = "PARROT", cooldown = 100 },
        {
            id = "scratch",
            damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } },
            cooldown = { 10, 30 },
        },
        {
            id = "psi_mi-go_illumination",
            spell = { id = "photokinetic_illumination_migo", min_level = 5 },
            casting_message = ccb.content.text("%1$s's numerous antennae sync their movements for a brief moment."),
            kind = "spell",
            cooldown = { 15, 45 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_mi-go_laser",
            spell = { id = "photokinetic_light_beam_monster", min_level = 7 },
            casting_message = ccb.content.text("%1$s's numerous antennae sync their movements for a brief moment."),
            kind = "spell",
            cooldown = { 10, 30 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_mi-go_radiation",
            spell = { id = "photokinetic_radiation_attack_monster", min_level = 10 },
            casting_message = ccb.content.text("%1$s's numerous antennae sync their movements for a brief moment."),
            kind = "spell",
            cooldown = { 12, 36 },
            when = "monster_attack_psionics_available",
        },
    },
}

ccb.content.define_monster {
    id = "mon_mi_go_telepath",
    copy_from = "mon_mi_go_slaver",
    name = ccb.content.plural_text("mi-go mindrender", "mi-go mindrenders"),
    description = ccb.content.text("An alien creature of uncertain origin.  Its shapeless pink body bears numerous sets of paired appendages of unknown function, and a pair of ribbed, membranous wings which seem to be quite useless.  Its odd, vaguely pyramid-shaped head bristles with numerous wavering antennae, and it moves with an uncanny fluidity on its many legs."),
    looks_like = "mon_mi_go_slaver",
    attacks = {
        { reference = "PARROT", cooldown = 100 },
        {
            id = "scratch",
            damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } },
            cooldown = { 10, 30 },
        },
        {
            id = "psi_mi-go_telepath1_blast",
            spell = { id = "telepathic_blast_monster", min_level = 6 },
            casting_message = ccb.content.text("%1$s's numerous antennae sync their movements for a brief moment."),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "allow_mi_go_telepath_psi_mi_go_telepath1_blast",
        },
        {
            id = "psi_mi-go_hallucinations",
            spell = { id = "telepathic_hallucinations_monster", min_level = 10 },
            casting_message = ccb.content.text("%1$s's numerous antennae sync their movements for a brief moment."),
            kind = "spell",
            cooldown = { 10, 30 },
            when = "allow_mi_go_telepath_psi_mi_go_telepath1_blast",
        },
        {
            id = "psi_mi-go_blinding",
            spell = { id = "telepathic_confusion_monster", min_level = 3 },
            casting_message = ccb.content.text("A roar fills %3$s's mind and the world is blotted out!"),
            kind = "spell",
            cooldown = { 15, 45 },
            when = "allow_mi_go_telepath_psi_mi_go_telepath1_blast",
        },
    },
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}
