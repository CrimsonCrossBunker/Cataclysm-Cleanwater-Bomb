local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_wraitheon_isohypsa",
    copy_from = "mon_advbot_base",
    name = ccb.content.plural_text("Wraitheon Isohypsa", "Wraitheon Isohypsas"),
    description = ccb.content.text("A bulky aerial drone that mounts an advanced AI overwatch unit within its bulbous carapace-like armor.  As an autonomous drone control platform, the Isohypsa is principally meant to coordinate and enhance the combat capabilities of simpler Wraitheon robots in lieu of human operators."),
    default_faction = "WraitheonRobotics",
    symbol = "y",
    difficulty_adjustment = 20,
    speed = 100,
    color = "light_red",
    morale = 20,
    tracking_distance = 20,
    attacks = {
        {
            spell = { id = "isohypsa_buff", hit_self = true },
            cooldown = 5,
            casting_message = ccb.content.text("The Isohypsa emits a rapid sequence of sibilant tones!"),
            kind = "spell",
        },
    },
    armor = { bash = 15, cut = 20, bullet = 30, afs_laser = 10 },
    inheritance = { add = { flags = { "FIREPROOF", "PACIFIST", "KEEP_DISTANCE", "FLIES" } } },
}

ccb.content.define_monster {
    id = "mon_wraitheon_kaburaya",
    copy_from = "base_drone",
    name = ccb.content.plural_text("Wraitheon Kabura-ya", "Wraitheon Kabura-ya"),
    description = ccb.content.text("A microplane drone designed to seek enemy personnel before detonating at close range."),
    default_faction = "WraitheonRobotics",
    difficulty_adjustment = 10,
    speed = 250,
    color = "green",
    revert_item = "bot_wraitheon_kaburaya",
    starting_ammo = { afs_kaburaya_bomb = 1 },
    attacks = { { reference = "KAMIKAZE", cooldown = 0 } },
}
