local ccb = require("ccb")

-- All these arms to grab you with
ccb.content.define_monster {
    id = "mon_devourer_hekatonkheire",
    name = ccb.content.plural_text("hekatonkheire devourer", "hekatonkheire devourers"),
    description = ccb.content.text("Zombified human bodies fused together into a colossus, with a multitude of heads and limbs sticking out of its bloated body ready to break free.  Dozens of arms grab at anything nearby and pull it apart once within the grip of multiple hands."),
    default_faction = "zombie",
    copy_from = "mon_devourer",
    body_type = "giant",
    species = { "ZOMBIE" },
    difficulty_adjustment = 9,
    volume = "287500 ml",
    mass = "344500 g",
    hp = 148,
    symbol = "H",
    color = "dark_gray_yellow",
    melee_damage = { { type = "bash", amount = 1 } },
    grab_strength = 50,
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "grab_2", accuracy = 5, cooldown = 0 },
        { id = "grab_3", accuracy = 6, cooldown = 0 },
        { id = "grab_4", accuracy = 5, cooldown = 7 },
        { id = "grab_5", accuracy = 6, cooldown = 8 },
        { id = "hekatonkheire_rend", cooldown = 4 },
        { id = "multi_scratch", cooldown = 14 },
        {
            id = "bite_devourer_h",
            damage = { { type = "stab", amount = 15 } },
            infection_chance = 20,
            cooldown = 9,
            move_cost = 150,
            kind = "bite",
            when = "allow_jabberwock_bite_jabberwock_1",
        },
    },
    regenerates = 1,
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "BASHES", "GROUP_BASH", "POISON", "NO_BREATHE",
        "REVIVES", "BILE_BLOOD", "PUSH_MON", "FILTHY",
    },
    armor = { bash = 15, cut = 8, bullet = 7, electric = 3 },
}
