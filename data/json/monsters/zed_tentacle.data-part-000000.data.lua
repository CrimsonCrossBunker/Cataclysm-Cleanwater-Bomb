local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_lashing",
    name = ccb.content.plural_text("lashing zombie", "lashing zombies"),
    description = ccb.content.text("This zombie has very elongated arms.  While they're menacingly long, they seem quite thin and floppy, as if they lack bones."),
    copy_from = "mon_zombie_base",
    hp = 90,
    color = "white_cyan",
    melee_skill = 6,
    grab_strength = 10,
    attacks = {
        { id = "grab", cooldown = 5, move_cost = 50 },
        { id = "scratch_humanoid" },
        {
            id = "stretch_attack",
            cooldown = 5,
            move_cost = 50,
            range = 2,
            damage = { { type = "bash", amount = 3 } },
        },
    },
    upgrade = { half_life = 96, monster = "mon_zombie_tentacle" },
}

ccb.content.define_monster {
    id = "mon_zombie_tentacle",
    name = ccb.content.plural_text("tentacled zombie", "tentacled zombies"),
    description = ccb.content.text("What likely used to be the arms of this zombie are now a set of strange, purplish tentacles, with what appear to be vestigial fingers at the end.  They trail several meters behind the tall zombie as it shambles along."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 2,
    hp = 95,
    color = "light_gray_cyan",
    melee_skill = 6,
    grab_strength = 15,
    attacks = {
        { id = "grab", cooldown = 5, move_cost = 50 },
        { id = "grab_2", cooldown = 5, move_cost = 50 },
        {
            id = "stretch_attack",
            cooldown = 5,
            move_cost = 50,
            range = 2,
            damage = { { type = "bash", amount = 4 } },
        },
        { id = "tentacle", cooldown = 15, damage = { { type = "bash", amount = 3 } } },
        { id = "ranged_pull", cooldown = 10, grab_settings = { pull_weight_ratio = 1 } },
    },
    upgrade = { half_life = 96, monster = "mon_zombie_strider" },
}
