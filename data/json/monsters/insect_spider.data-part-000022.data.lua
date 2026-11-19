local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_dermatik_larva",
    name = ccb.content.plural_text("dermatik larva", "dermatik larvae"),
    description = ccb.content.text("A fat white grub as big as a squirrel, with a pair of large, spadelike mandibles."),
    copy_from = "mon_larva_abstract",
    default_faction = "dermatik",
    speed = 20,
    color = "white",
    aggression = -20,
    morale = -20,
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 1 } },
    dodge = 1,
    upgrade = { grow_at_age = 61, monster = "mon_dermatik" },
    inheritance = { add = { flags = { "CAN_DIG" } } },
}
