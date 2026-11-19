local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lady_bug_larva",
    name = ccb.content.plural_text("lady bug larva", "lady bug larvae"),
    description = ccb.content.text("A large armored larva looking not unlike a centipede.  Even though it's just a juvenile the armor on its back already looks functional."),
    default_faction = "ladybug",
    copy_from = "mon_larva_abstract",
    volume = "20 L",
    mass = "10 kg",
    hp = 25,
    speed = 80,
    symbol = "B",
    aggression = -10,
    morale = 30,
    melee_skill = 1,
    melee_dice = 1,
    dodge = 3,
    melee_damage = { { type = "cut", amount = 3 } },
    dissect = "dissect_insect_sample_single",
    upgrade = { grow_at_age = 30, monster = "mon_lady_bug_giant" },
    armor = { bash = 1, cut = 2, stab = 2 },
}

ccb.content.define_monster {
    id = "mon_grasshopper_small",
    name = ccb.content.plural_text("oversized grasshopper", "oversized grasshoppers"),
    description = ccb.content.text("A large grasshopper a few times bigger than a regular one."),
    copy_from = "mon_grasshopper_giant",
    volume = "750 ml",
    mass = "1 kg",
    upgrade = { grow_at_age = 30, monster = "mon_grasshopper_giant" },
    inheritance = { add = { flags = { "SMALL_HIDER", "NO_BREED" } }, scale = { hp = 0.5, speed = 1.1 } },
}
