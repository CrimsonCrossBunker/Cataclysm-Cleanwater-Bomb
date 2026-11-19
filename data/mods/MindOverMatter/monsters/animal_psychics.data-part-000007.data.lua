local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_fear_deer_fawn",
    copy_from = "mon_deer_fawn",
    looks_like = "mon_deer_fawn",
    name = ccb.content.plural_text("prince of the wood", "princes of the wood"),
    description = ccb.content.text("A juvenile northern woodland white-tailed deer, a quick and strong grazing animal.  Favored prey of coyotes, wolves, and giant spider mutants.  This one doesn't seem as skittish as most deer are."),
    melee_damage = { { type = "cut", amount = 1 }, { type = "heat", amount = 3 } },
    upgrade = { grow_at_age = 330, monster = "mon_fear_deer" },
    inheritance = { add = { flags = { "TEEP_IMMUNE" } } },
}
