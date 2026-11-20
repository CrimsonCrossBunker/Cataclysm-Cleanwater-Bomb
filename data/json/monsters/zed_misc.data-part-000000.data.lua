local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_biter",
    name = ccb.content.plural_text("slavering biter", "slavering biters"),
    description = ccb.content.text("A distorted and swollen human body.  Its jaws have elongated into a crocodile-like snout, dripping with foul-smelling saliva."),
    copy_from = "mon_zombie_base",
    hp = 100,
    speed = 110,
    color = "cyan_green",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_skill = 6,
    melee_dice = 4,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 3,
    weakpoints = {
        {
            name = ccb.content.text("the inside of its mouth"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 2,
            id = "the inside of its mouth",
        },
        {
            name = ccb.content.text("the eye"),
            head = true,
            armor_multiplier = { physical = 0 },
            coverage = 1,
            id = "the eye",
        },
    },
    bleed_rate = 0,
    vision_day = 15,
    grab_strength = 30,
    attacks = {
        {
            id = "bite_humanoid",
            cooldown = 4,
            accuracy = 5,
            damage = {
                { type = "stab", amount = 10, armor_multiplier = 0.3 },
                { type = "bash", amount = 10, armor_multiplier = 0.3 },
            },
        },
        { id = "grab", cooldown = 4 },
        { id = "scratch_humanoid", damage = { { type = "cut", amount = 12 } } },
    },
    upgrade = false,
    armor = { bash = 5, cut = 2, bullet = 2, electric = 1 },
    inheritance = { add = { flags = { "SMELLS", "KEENNOSE" } } },
}
