local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_civilian_teleporter",
    name = ccb.content.plural_text("jittery jumper", "jittery jumpers"),
    description = ccb.content.text("This person looks vacantly around them with a blank expression on their face.  Then, in an instant, they are gone."),
    pathing = { max_distance = 30, open_doors = false, avoid_traps = false, avoid_sharp = false },
    speed = 90,
    difficulty_adjustment = 0,
    symbol = "@",
    color = "blue",
    copy_from = "mon_civilian_clairsentient",
    vision_day = 10,
    vision_night = 1,
    dodge = 1,
    upgrade = { half_life = 8, monster = "mon_feral_human_porter" },
    attacks = {
        {
            id = "psi_civilian_teleport_blink",
            spell = { id = "teleport_blink_monster", min_level = 0 },
            casting_message = ccb.content.text("%1$s suddenly vanishes!"),
            kind = "spell",
            cooldown = { 2, 6 },
            when = "monster_attack_psionics_available",
        },
    },
}
