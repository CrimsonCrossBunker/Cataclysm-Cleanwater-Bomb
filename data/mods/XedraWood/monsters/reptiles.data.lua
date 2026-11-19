local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_rattlesnake_mega",
    copy_from = "mon_rattlesnake_mega",
    name = ccb.content.plural_text("deathrattle elder serpent", "deathrattle elder serpents"),
    description = ccb.content.text("An enormous serpent of the deep swamps, bigger around than a man and at least four times as long.  Vicious fangs dripping with venom gleam in its mouth and its eyes are alive with malign intent.  Its rattle is large enough to be worked into a mace.  This one definitely hunts humans."),
    default_faction = "snakes",
    harvest = "animal_large_noskin",
    regenerates = 0,
    reproduction = { offspring = { monster = "mon_rattlesnake_big_s" }, count = 20, interval = 90 },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_big_s",
    copy_from = "mon_rattlesnake_big_s",
    name = ccb.content.plural_text("deathrattle snakelet", "deathrattle snakelet"),
    description = ccb.content.text("A baby deathrattle, not dangerous now but with time it will eventually become a monster.  It will eventually grow a rattle and learn how to hunt."),
    default_faction = "snakes",
    harvest = "mammal_tiny",
    regenerates = 0,
    upgrade = { grow_at_age = 260, monster = "mon_rattlesnake_big" },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_big",
    copy_from = "mon_rattlesnake_big",
    name = ccb.content.plural_text("deathrattle youth", "deathrattle youths"),
    description = ccb.content.text("A young deathrattle serpent, having learned to hunt and seeking prey.  It won't hunt humans yet, but it's only a matter of time."),
    default_faction = "snakes",
    harvest = "animal_large_noskin",
    regenerates = 0,
    upgrade = { grow_at_age = 260, monster = "mon_rattlesnake_giant" },
}

ccb.content.define_monster {
    id = "mon_rattlesnake_giant",
    copy_from = "mon_rattlesnake_giant",
    name = ccb.content.plural_text("deathrattle serpent", "deathrattle serpents"),
    description = ccb.content.text("A large deathrattle serpent, about the same size and weight as a human.  They only rarely hunt humans, but will attack opportunistically or if threatened."),
    default_faction = "snakes",
    harvest = "animal_large_noskin",
    regenerates = 0,
    anger_triggers = { "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    placate_triggers = {},
    upgrade = false,
}
