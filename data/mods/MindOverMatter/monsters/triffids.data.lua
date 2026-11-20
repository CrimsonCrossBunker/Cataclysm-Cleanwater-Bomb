local ccb = require("ccb")

-- Extra bullet armor here is from clairsentient anticipation of bullet trajectories, not literal armor.
ccb.content.define_monster {
    id = "mon_triffid_clairsentient",
    copy_from = "mon_triffid",
    name = ccb.content.plural_text("triffid seedseer", "triffid seedseers"),
    description = ccb.content.text("A creeping mobile plant, as tall as a moose.  It has a single bark-covered stalk supporting a flowery head with a paralyzing sting concealed within.  You have the distinct sense that it's watching you."),
    dodge = 7,
    armor = { bash = 10, cut = 4, bullet = 43, electric = 2 },
    inheritance = {
        add = {
            flags = { "HARDTOSHOOT", "ALL_SEEING" },
            attacks = {
                {
                    id = "psi_triffid_seedseer_discern_weakness",
                    spell = { id = "clairsentient_discern_weakness_monster", min_level = 4 },
                    casting_message = ccb.content.text("%1$s's fronds quiver."),
                    kind = "spell",
                    cooldown = { 12, 44 },
                    when = "allow_civilian_biokinetic_bio_op_takedown",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_triffid_pyrokinetic",
    copy_from = "mon_triffid",
    name = ccb.content.plural_text("triffid flamebreaker", "triffid flamebreakers"),
    species = { "PLANT_INFLAMMABLE" },
    description = ccb.content.text("A creeping mobile plant, as tall as a moose.  It has a single bark-covered stalk supporting a flowery head with a paralyzing sting concealed within.  The air around it wavers slightly, like a summer haze."),
    inheritance = {
        add = {
            flags = { "FIREPROOF" },
            armor = { heat = 500 },
            attacks = {
                {
                    id = "mon_fountain_of_flames",
                    move_cost = 80,
                    range = 4,
                    damage = { { type = "heat", amount = 20 } },
                    dodgeable = true,
                    blockable = false,
                    effects = { { id = "onfire", duration = 60, chance = 50, affect_hit_body_part = true } },
                    avatar_hit = ccb.content.text("%1$s waves its fronds and your %2$s is engulfed in flames!"),
                    npc_hit = ccb.content.text("%1$s waves its fronds and <npcname>'s %2$s is engulfed in flames!"),
                    avatar_miss = ccb.content.text("%1$s waves its fronds and you narrowly avoid a burst of flame!"),
                    npc_miss = ccb.content.text("%1$s waves its fronds and <npcname> narrowly avoids a burst of flame!"),
                    avatar_no_damage = ccb.content.text("%1$s waves its fronds and your %2$s is engulfed in flames, but they do not burn you."),
                    npc_no_damage = ccb.content.text("%1$s waves its fronds and <npcname>'s %2$s is engulfed in flames, but it does not burn them."),
                    kind = "melee",
                    cooldown = { 5, 18 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_triffid_flamebreaker_quell",
                    spell = { id = "pyrokinetic_quell_flames_monster", min_level = 10 },
                    allow_no_target = true,
                    cooldown = 1,
                    casting_message = ccb.content.text("%1$s waves its fronds and the flames gutter and die."),
                    kind = "spell",
                    when = "allow_triffid_pyrokinetic_psi_triffid_flamebreaker_quell",
                },
                {
                    id = "psi_triffid_flamebreaker_no_flame_buff",
                    spell = { id = "pyrokinetic_flame_armor_ally_monster", min_level = 8 },
                    casting_message = ccb.content.text("%1$s waves its fronds at %3$s."),
                    kind = "spell",
                    cooldown = { 10, 35 },
                    when = "allow_triffid_pyrokinetic_psi_triffid_flamebreaker_no_flame_buff",
                },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_triffid_teleporter",
    copy_from = "mon_triffid",
    name = ccb.content.plural_text("triffid riftcaller", "triffid riftcallers"),
    description = ccb.content.text("A creeping mobile plant, as tall as a moose.  It has a single bark-covered stalk supporting a flowery head with a paralyzing sting concealed within.  Occasionally it vanishes and reappears elsewhere."),
    inheritance = {
        add = {
            flags = { "TELEPORT_IMMUNE" },
            attacks = {
                {
                    id = "psi_triffid_teleporter_slow",
                    spell = { id = "teleport_slow_monster", min_level = 8 },
                    casting_message = ccb.content.text("%1$s waves its fronds at %3$s."),
                    kind = "spell",
                    cooldown = { 7, 21 },
                    when = "monster_attack_psionics_available",
                },
                {
                    move_cost = 50,
                    allow_no_target = true,
                    maximum_range = 10,
                    message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
                    kind = "leap",
                    cooldown = { 4, 12 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_porter3_reactive_displacement",
                    spell = { id = "teleporter_reactive_displacement_monster" },
                    cooldown = 1,
                    casting_message = ccb.content.text("The space around %1$s distorts."),
                    kind = "spell",
                    when = "allow_feral_human_porter2_psi_porter2_reactive_displacement",
                },
                {
                    id = "psi_triffid_teleporter_ally_teleport",
                    spell = { id = "teleporter_triffid_summon_allies", min_level = 10 },
                    casting_message = ccb.content.text("%1$s waves its fronds at %3$s and the air around %3$s solidifies into shapes."),
                    kind = "spell",
                    cooldown = { 17, 49 },
                    when = "monster_attack_psionics_available",
                },
            },
        },
    },
}
