local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spider_web_mega",
    name = ccb.content.plural_text("wyrd spider", "wyrd spiders"),
    description = ccb.content.text("A cow-sized mutated grass spider with long spindly legs, light gray in color.  It moves ponderously, depending on its webs to prevent prey from fleeing."),
    copy_from = "mon_spider_web",
    volume = "625 L",
    mass = "815 kg",
    melee_dice = 2,
    dissect = "dissect_spider_sample_small",
    grab_strength = 75,
    attacks = { { id = "grab", cooldown = 5, when = "monster_attack_intact_legs" } },
    zombify_into = "mon_meat_cocoon_large",
    armor = { bash = 2, cut = 6, bullet = 5, electric = 1 },
    inheritance = {
        add = { flags = { "DESTROYS", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 10, speed = 0.25, dodge = 0.5, vision_day = 2 },
    },
}
