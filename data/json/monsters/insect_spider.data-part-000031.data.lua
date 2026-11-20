local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_ant_larva",
    name = ccb.content.plural_text("ant larva", "ant larvae"),
    description = ccb.content.text("A pulsating sausage of glistening white flesh, the size of a large cat.  On one end is a set of squirming mouth parts."),
    copy_from = "mon_larva_abstract",
    default_faction = "ant",
    body_type = "snake",
    volume = "30 L",
    mass = "40750 g",
    speed = 15,
    color = "white",
    aggression = -1,
    morale = 10,
    melee_skill = 2,
    melee_dice = 1,
    dissect = "dissect_insect_sample_single",
    upgrade = { grow_at_age = 30, monster = "mon_ant" },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SMELLS" },
}
