local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_skitterbot_hunter",
    copy_from = "mon_skitterbot",
    name = ccb.content.plural_text("pest hunter", "pest hunters"),
    description = ccb.content.text("A salvaged skitterbot refitted with an 8mm integrated firearm.  The robot's small size precludes rapid-fire, due to recoil, and requires the use of lightweight caseless ammo."),
    color = "dark_gray",
    scents_tracked = { "sc_human" },
    aggression = 50,
    speed = 200,
    hp = 30,
    vision_day = 20,
    melee_dice = 1,
    melee_sides = 5,
    revert_item = "bot_skitterbot_hunter",
    starting_ammo = { ["8mm_caseless"] = 120 },
    attacks = {
        {
            cooldown = 3,
            move_cost = 300,
            kind = "gun",
            gun = {
                weapon = "rm103a_pistol",
                ammo = "8mm_caseless",
                skills = { { id = "gun", level = 5 }, { id = "pistol", level = 6 } },
                dexterity = 10,
                empty_sound = ccb.content.text("click!"),
                ranges = { { minimum = 0, maximum = 10, mode = "DEFAULT" } },
            },
        },
    },
    armor = { bash = 8, cut = 10, bullet = 15 },
}
