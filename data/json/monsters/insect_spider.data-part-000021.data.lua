local ccb = require("ccb")

-- sting 15-45 damage, 6 hits to max intensity, 8 to max duration; bite 10-30
ccb.content.define_monster {
    id = "mon_wasp_mega",
    name = ccb.content.plural_text("giant wasp queen", "giant wasp queens"),
    description = ccb.content.text("A yellowjacket queen grown to the size of a horse, towering over her daughters.  Even with her abdomen swollen with eggs and wings long unused she still poses a threat to interlopers, should her children have failed at subduing them."),
    copy_from = "mon_wasp_guard",
    looks_like = "mon_wasp_mega",
    difficulty_adjustment = 4,
    speed = 100,
    attack_cost = 100,
    melee_skill = 7,
    melee_dice = 4,
    melee_sides = 5,
    attacks = {
        {
            id = "sting",
            cooldown = 5,
            move_cost = 200,
            damage = { { type = "stab", amount = 15, penetration = 60 } },
            minimum_damage_multiplier = 1,
            maximum_damage_multiplier = 3,
            effects = {
                { id = "venom_weaken", duration = 600 },
                { id = "downed", duration = 1, chance = 50 },
            },
        },
        {
            cooldown = 3,
            move_cost = 100,
            damage = { { type = "cut", amount = 10, penetration = 30 } },
            minimum_damage_multiplier = 1,
            maximum_damage_multiplier = 3,
            kind = "bite",
            when = "monster_attack_intact_mandibles",
        },
    },
    dodge = 3,
    vision_night = 15,
    bleed_rate = 60,
    harvest = "arachnid_wasp_queen",
    dissect = "dissect_insect_sample_huge",
    reproduction = { offspring = { egg = "egg_wasp" }, count = 4, interval = 5 },
    zombify_into = "mon_meat_cocoon_large",
    fungalize_into = "mon_wasp_mega_fungus",
    armor = { bash = 8, cut = 30, stab = 18, bullet = 22, electric = 4 },
    inheritance = {
        add = { flags = { "PUSH_MON" } },
        remove = { flags = { "HARDTOSHOOT", "FLIES" } },
        scale = { hp = 4, volume = 5, mass = 5 },
    },
}
