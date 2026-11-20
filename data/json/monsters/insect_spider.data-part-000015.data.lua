local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spider_widow_mega",
    name = ccb.content.plural_text("black death widow", "black death widows"),
    description = ccb.content.text("A cow-sized mutated black widow spider with a distinctive red hourglass shape on its thorax.  Still possesses its infamous venom, but it probably doesn't even need that to crush you like a bug."),
    copy_from = "mon_spider_widow_giant",
    volume = "625 L",
    mass = "815 kg",
    melee_dice = 3,
    dissect = "dissect_spider_sample_large",
    grab_strength = 75,
    attacks = { { id = "grab", cooldown = 5, when = "monster_attack_intact_legs" } },
    zombify_into = "mon_meat_cocoon_large",
    inheritance = {
        add = { flags = { "DESTROYS", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 10, speed = 0.25, dodge = 0.5, vision_day = 2 },
    },
}
