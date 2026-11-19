local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_boomer_claymore",
    name = ccb.content.plural_text("bombardier boomer", "bombardier boomers"),
    description = ccb.content.text("This zombie's exposed ribcage is encircled by swollen lungs and other organs.  You would prefer to be far away when they burst."),
    copy_from = "mon_boomer",
    difficulty_adjustment = 9,
    mass = "135 kg",
    hp = 150,
    speed = 95,
    color = "red",
    melee_skill = 1,
    vision_night = 2,
    attacks = {
        {
            cooldown = 0,
            spell = { id = "boomer_claymore_initial", min_level = 0 },
            casting_message = ccb.content.text("A bombardier boomer explodes!"),
            kind = "spell",
        },
    },
    armor = { bash = 10, cut = 5, bullet = 5, electric = 2 },
    inheritance = { remove = { flags = { "BILE_BLOOD", "GRABS", "GROUP_BASH", "PUSH_MON" } } },
}
