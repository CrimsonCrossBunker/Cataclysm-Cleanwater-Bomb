local ccb = require("ccb")

-- Assuming it's grabbing with its mouth a bit grabbier than a zed should be about right
ccb.content.define_monster {
    id = "mon_zoose_brute",
    name = ccb.content.plural_text("antlered hammer", "antlered hammers"),
    copy_from = "mon_zoose",
    description = ccb.content.text("This once-great moose's eyes ooze with dark, oily fluid, and its flesh is torn and scarred.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "465 L",
    mass = "465 kg",
    hp = 315,
    speed = 200,
    attack_cost = 200,
    color = "red",
    aggression = 100,
    melee_dice = 4,
    melee_sides = 9,
    melee_damage = { { type = "cut", amount = 8 } },
    bleed_rate = 50,
    vision_night = 6,
    grab_strength = 30,
    attacks = {
        { cooldown = 5, kind = "bite", when = "allow_zoose_brute_bite" },
        { id = "smash", throw_strength = 108, cooldown = 30 },
        { id = "grab", cooldown = 7 },
    },
    upgrade = false,
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "WARM", "BASHES", "GROUP_BASH", "GRABS", "POISON",
        "NO_BREATHE", "REVIVES", "PUSH_MON", "PUSH_VEH", "FILTHY",
    },
    armor = { electric = 2, bash = 10, cut = 10, bullet = 8 },
}

-- Let's say the thorns make it half again as grabby
ccb.content.define_monster {
    id = "mon_zoose_thorny",
    name = ccb.content.plural_text("thorny moose shambler", "thorny moose shamblers"),
    copy_from = "mon_zoose",
    description = ccb.content.text("This once-great moose is covered with long, matted hair twisted with thorny vines that wrap together and then twist back into its body.  Long, interlocking thorns wrap its antlers, dripping with a silvery liquid."),
    species = { "ZOMBIE", "PLANT" },
    speed = 100,
    materials = { "veggy" },
    color = "light_green",
    aggression = 100,
    melee_skill = 5,
    melee_damage = { { type = "cut", amount = 3 } },
    bleed_rate = 0,
    vision_night = 7,
    harvest = "zombie_thorny",
    attack_effects = { { id = "paralyzepoison", duration = 33 } },
    grab_strength = 45,
    attacks = {
        { cooldown = 5, kind = "bite", when = "allow_zoose_brute_bite" },
        { id = "scratch" },
        { id = "grab", cooldown = 7 },
        { reference = "PARA_STING", cooldown = 30 },
    },
    upgrade = false,
    flags = {
        "SEES", "HEARS", "SMELLS", "STUMBLES", "BASHES", "GROUP_BASH", "POISON", "NO_BREATHE", "REVIVES",
        "PUSH_MON", "FILTHY", "PARALYZEVENOM",
    },
    armor = { electric = 2, bash = 8, cut = 8, bullet = 6 },
}
