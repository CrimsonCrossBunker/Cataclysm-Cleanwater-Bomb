local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_ant_acid_larva",
    name = ccb.content.plural_text("acidic ant larva", "acidic ant larvae"),
    description = ccb.content.text("A squirming yellow grub that seems to be oozing liquid from both ends of its body.  It appears its chitin hasn't developed enough to resist acid."),
    copy_from = "mon_larva_abstract",
    default_faction = "acid_ant",
    body_type = "snake",
    volume = "30 L",
    mass = "40750 g",
    hp = 20,
    speed = 15,
    color = "yellow",
    aggression = -1,
    morale = 10,
    melee_skill = 2,
    melee_dice = 1,
    upgrade = { grow_at_age = 30, monster = "mon_ant_acid" },
    harvest = "arachnid_acid",
    dissect = "dissect_insect_sample_single",
    zombify_into = "mon_meat_cocoon_small",
    flags = { "ACIDPROOF", "POISON", "SMELLS" },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}
