local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_triffid_greenseer",
    copy_from = "mon_triffid",
    name = ccb.content.plural_text("triffid greenseer", "triffid greenseers"),
    description = ccb.content.text("A creeping mobile plant, as tall as a moose.  It has a single bark-covered stalk supporting a flowery head with a paralyzing sting concealed within.  The foliage seems to bend out of its way as it moves."),
    inheritance = {
        add = {
            flags = { "MAGIC_USER" },
            attacks = {
                {
                    id = "xe_greenseer_create_grasses",
                    spell = { id = "summon_grass_field_monster", min_level = 4 },
                    cooldown = 25,
                    casting_message = ccb.content.text("%1$s's fronds quiver."),
                    kind = "spell",
                    when = "allow_march_lord_spring_xe_march_lord_create_grasses",
                },
                {
                    id = "xe_greenseer_summon_solar_spirit",
                    spell = { id = "summon_solar_spirit_triffid_monster", min_level = 5, hit_self = true },
                    cooldown = 60,
                    casting_message = ccb.content.text("%1$s's fronds extend toward the sky."),
                    kind = "spell",
                },
                {
                    id = "xe_greenseer_summon_vinebeast",
                    spell = { id = "summon_vinebeast_triffid_monster", min_level = 5 },
                    cooldown = 45,
                    casting_message = ccb.content.text("%1$s's fronds make wavy motions."),
                    kind = "spell",
                    when = "allow_march_lord_spring_xe_march_lord_summon_plants",
                },
                {
                    id = "xe_greenseer_destroy_summon",
                    spell = { id = "kill_summoned_creature_monster", min_level = 8 },
                    cooldown = 15,
                    casting_message = ccb.content.text("%1$s's fronds leave trails of greenish light in the air."),
                    kind = "spell",
                    when = "allow_triffid_greenseer_xe_greenseer_destroy_summon",
                },
            },
        },
    },
}
