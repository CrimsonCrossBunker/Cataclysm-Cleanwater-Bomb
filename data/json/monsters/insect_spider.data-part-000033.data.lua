local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_ant_soldier_mega",
    name = ccb.content.plural_text("super soldier ant", "super soldier ants"),
    description = ccb.content.text("A cow-sized, hairy red ant.  Bulging pincers extend from her jaws.  Given the relative strength of ants to their body size, you don't doubt that this one could shove cars around or rip through solid walls."),
    copy_from = "mon_ant_soldier",
    volume = "625 L",
    mass = "815 kg",
    morale = 30,
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
    dissect = "dissect_insect_sample_large",
    armor = { bash = 15, cut = 24, bullet = 15, electric = 4 },
    inheritance = {
        add = { flags = { "DESTROYS", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 5, dodge = 0.5, vision_day = 2 },
    },
}
