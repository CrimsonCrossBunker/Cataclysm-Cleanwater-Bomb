local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_smoker_brute",
    name = ccb.content.plural_text("ashen brawler", "ashen brawlers"),
    description = ccb.content.text("A gigantic, twisted human frame with a menacing stance and rapid movements.  Thick clouds of smoke pour from violent-looking eviscerations spread across its muscular body, and its arms appear to have elongated massively."),
    copy_from = "mon_zombie_brute",
    hp = 150,
    speed = 110,
    color = "light_gray",
    melee_skill = 5,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 7,
    vision_day = 30,
    emissions = { { id = "emit_smoke_stream", delay = "1 s" } },
    grab_strength = 35,
    attacks = {
        { id = "grab", cooldown = 15 },
        { id = "smash", throw_strength = 48, cooldown = 30, when = "allow_zombie_brute_smash" },
        { id = "bite_humanoid", cooldown = 5 },
        { id = "scratch_humanoid", cooldown = 15 },
        { id = "ranged_pull", cooldown = 20, grab_settings = { pull_weight_ratio = 1.2 } },
        { id = "grab_drag" },
        { id = "drag_followup" },
    },
    upgrade = false,
    armor = { bash = 2, cut = 8, stab = 8, heat = 5, bullet = 10, electric = 2 },
    inheritance = { add = { flags = { "HARDTOSHOOT", "RANGED_ATTACKER" } }, remove = { flags = { "SMELLS" } } },
    death = {
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
        },
    },
}
