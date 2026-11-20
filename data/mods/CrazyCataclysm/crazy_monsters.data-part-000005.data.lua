local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_crowbar",
    name = ccb.content.plural_text("party rocker", "party rockers"),
    copy_from = "mon_feral_human_crowbar",
    description = ccb.content.text("After the event on March 2nd, seemingly ordinary people started coming down with some odd, mass hysteria like dancing.  While some people may have scoffed it off as a silly dance craze, those in the know knew, it was the Party Rock Outbreak.  This one has a drink in hand."),
    starting_ammo = { party_rock = 30 },
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "party_rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The party rocker party rocks!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "party_rocker_bottle" },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
    },
    death = { drops = "party_rocker_death_drop_bottle" },
}
