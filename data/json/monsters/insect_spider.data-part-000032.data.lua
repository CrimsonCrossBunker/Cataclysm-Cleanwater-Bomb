local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_locust_small",
    name = ccb.content.plural_text("oversized locust", "oversized locusts"),
    description = ccb.content.text("A yellow and brown mutated locust the size of a small dog, with big eyes and long, powerful legs."),
    copy_from = "mon_locust",
    volume = "15 L",
    mass = "20 kg",
    zombify_into = "mon_meat_cocoon_tiny",
    upgrade = { grow_at_age = 30, monster = "mon_locust" },
    inheritance = { scale = { hp = 0.5, speed = 1.1, morale = 0.67, melee_sides = 0.67 } },
}
