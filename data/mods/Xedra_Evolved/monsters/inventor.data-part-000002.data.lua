local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_shotgunbot",
    name = ccb.content.plural_text("shotgun bot", "shotgun bots"),
    description = ccb.content.text("A heavy, but quick two-legged drone that holds a massive shotgun system above himself.  Effectively a machinegun with legs."),
    copy_from = "mon_sniperbot",
    species = { "ROBOT" },
    categories = { "XE_CLASSIC" },
    tracking_distance = 4,
    revert_item = "bot_shotgunbot",
    starting_ammo = { shot_00 = 240 },
    attacks = {
        {
            cooldown = 1,
            move_cost = 50,
            kind = "gun",
            gun = {
                weapon = "inventor_shotgun",
                ammo = "shot_00",
                skills = { { id = "gun", level = 8 }, { id = "shotgun", level = 8 } },
                lock_npc = false,
                lock_monster = false,
                dexterity = 12,
                ranges = { { minimum = 0, maximum = 10, mode = "DEFAULT" } },
                empty_sound = ccb.content.text("chk-chk!"),
            },
        },
    },
}
