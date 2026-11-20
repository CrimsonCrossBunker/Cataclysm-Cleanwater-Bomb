local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_ant_acid_soldier_mega",
    name = ccb.content.plural_text("super soldier acidic ant", "super soldier acidic ants"),
    description = ccb.content.text("A cow-sized, woolly brown ant.  Corrosive liquid seeping from her huge mandibles.  Given the relative strength of ants to their body size, you don't doubt that this one could shove cars around or rip through solid walls."),
    copy_from = "mon_ant_acid_soldier",
    volume = "625 L",
    mass = "815 kg",
    morale = 30,
    melee_dice = 2,
    bleed_rate = 60,
    grab_strength = 100,
    attacks = {
        { id = "smash", throw_strength = 48, cooldown = 30 },
        { id = "leg_sweep" },
        {
            id = "bite_grab",
            cooldown = 5,
            damage = { { type = "cut", amount = 12, penetration = 14 } },
            when = "monster_attack_intact_mandibles",
        },
        { reference = "ACID", cooldown = 20 },
    },
    dissect = "dissect_insect_sample_large",
    zombify_into = "mon_meat_cocoon_large",
    armor = { bash = 15, cut = 24, bullet = 15, electric = 4 },
    inheritance = {
        add = { flags = { "DESTROYS", "PUSH_MON", "PUSH_VEH", "RANGED_ATTACKER" } },
        scale = { hp = 5, dodge = 0.5, vision_day = 2 },
    },
}
