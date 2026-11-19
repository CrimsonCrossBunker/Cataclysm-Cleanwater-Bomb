local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_toad_zombie",
    name = ccb.content.plural_text("giant zombie toad", "giant zombie toads"),
    description = ccb.content.text("The revivified remains of a giant mutant toad.  Its condition has left it slowed but no less dangerous."),
    copy_from = "mon_proxy_frog_zombie",
    color = "brown_green",
    attack_cost = 50,
    burn_into = "mon_frog_mummy",
    upgrade = { half_life = 120, monster_group = "GROUP_DEADTOAD_UPGRADE" },
}
