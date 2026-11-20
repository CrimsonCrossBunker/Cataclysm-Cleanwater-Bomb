local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_tool",
    name = ccb.content.plural_text("feral mechanic", "feral mechanics"),
    description = ccb.content.text("This wild human-like creature was probably a mechanic before the Cataclysm.  You can see it by his worker uniform, or by his blood-covered hammer in hand, or by his all-hating view."),
    copy_from = "mon_feral_human_pipe",
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
        { id = "feral_weapon_hammer" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    death = { drops = "feral_humans_death_drops_tool" },
}
