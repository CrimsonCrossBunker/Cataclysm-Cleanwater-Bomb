local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_serum_user_landru",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("With bloodshot eyes and a ripped orange jumpsuit, this obviously-feral human wanders among the undead.  Their movements are uncanny, almost like an old-fashioned camera film that's been sped up.  All of their motions are jerky and unfocused but they make them at blinding speed."),
    speed = 110,
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The feral human throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { reference = "BROWSE", cooldown = 100 },
        { reference = "EAT_FOOD", cooldown = 100 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "feral_weapon_pipe", move_cost = 55 },
    },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_speed", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}
