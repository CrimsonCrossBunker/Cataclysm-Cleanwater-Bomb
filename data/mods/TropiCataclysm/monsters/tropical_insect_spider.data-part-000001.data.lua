local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_termite_king",
    name = ccb.content.plural_text("giant termite king", "giant termite kings"),
    description = ccb.content.text("A gigantic termite dedicated to protecting the queen and their offspring.  While his main role is breeding, the king is certainly well armed as well."),
    copy_from = "mon_termite_soldier",
    volume = "625 L",
    mass = "815 kg",
    symbol = "T",
    melee_dice = 2,
    bleed_rate = 60,
    grab_strength = 75,
    attacks = {
        { id = "smash", throw_strength = 48, cooldown = 30 },
        { id = "leg_sweep" },
        {
            id = "bite_grab",
            cooldown = 5,
            damage = { { type = "cut", amount = 12, penetration = 14 } },
            when = "monster_attack_intact_mandibles",
        },
        { id = "grab_drag", when = "allow_ant_soldier_mega_grab_drag" },
        { id = "drag_followup", when = "allow_ant_soldier_mega_drag_followup" },
    },
    zombify_into = "mon_meat_cocoon_large",
    armor = { bash = 15, cut = 24, bullet = 15, electric = 4 },
    inheritance = {
        add = { flags = { "DESTROYS", "GRABS", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 5, speed = 0.25, dodge = 0.5, vision_day = 2 },
    },
}
