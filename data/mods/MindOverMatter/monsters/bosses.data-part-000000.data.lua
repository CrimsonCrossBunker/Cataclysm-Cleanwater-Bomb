local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_devourer_lab_sec",
    copy_from = "mon_devourer_lab_sec",
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_lab_devourer_slow",
                    spell = { id = "teleport_slow_monster", min_level = 8 },
                    casting_message = ccb.content.text("%1$s glances at %3$s and the world lurches."),
                    kind = "spell",
                    cooldown = { 5, 15 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_lab_devourer_reactive_displacement",
                    spell = { id = "teleporter_reactive_displacement_monster_self", hit_self = true },
                    cooldown = 1,
                    casting_message = ccb.content.text("The space around %1$s distorts."),
                    kind = "spell",
                    when = "allow_devourer_lab_sec_psi_lab_devourer_reactive_displacement",
                },
                {
                    id = "psi_lab_devourer_breach",
                    spell = { id = "teleporter_breach_lab_devourer", min_level = 10 },
                    casting_message = ccb.content.text("The air around %3$s wavers and shapes appear!"),
                    kind = "spell",
                    cooldown = { 17, 49 },
                    when = "monster_attack_psionics_available",
                },
            },
            flags = { "TELEPORT_IMMUNE" },
        },
    },
}
