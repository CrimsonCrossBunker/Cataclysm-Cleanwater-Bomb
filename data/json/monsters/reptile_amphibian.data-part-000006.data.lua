local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_strange_giganfrog",
    name = ccb.content.plural_text("giant bullfrog", "giant bullfrogs"),
    description = ccb.content.text("A mutated bullfrog taller than you are.  It stares with amber eyes as it considers the easiest way to swallow you whole."),
    copy_from = "mon_proxy_giganfrog",
    color = "light_green",
    upgrade = { grow_at_age = 45, monster_group = "GROUP_FROGS_UPGRADE_STRANGE_MEGA" },
    zombify_into = "mon_zombullfrog",
    reproduction = { offspring = { egg = "egg_strange_bigfrog" }, count = 18, interval = 20 },
}

ccb.content.define_monster {
    id = "mon_odd_giganfrog",
    name = ccb.content.plural_text("giant toad", "giant toads"),
    description = ccb.content.text("This toad has grown bigger than a human.  It looks uninterested in eating you but you better not give it a chance."),
    copy_from = "mon_proxy_giganfrog",
    upgrade = { grow_at_age = 45, monster_group = "GROUP_FROGS_UPGRADE_ODD_MEGA" },
    zombify_into = "mon_toad_zombie",
    reproduction = { offspring = { egg = "egg_odd_bigfrog" }, count = 18, interval = 20 },
    inheritance = { add = { flags = { "POISON" } } },
}
