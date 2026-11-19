local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_wasp_guard",
    name = ccb.content.plural_text("giant wasp guard", "giant wasp guards"),
    description = ccb.content.text("A wasp worker grown to the size of a person, buzzing around her home.  While her foraging sisters are relatively content to live and let live, this one won't hesitate to attack anything she considers a threat to the nest.  Don't linger."),
    copy_from = "mon_wasp",
    aggression = 4,
    melee_skill = 8,
    dissect = "dissect_insect_sample_small",
    fungalize_into = "mon_wasp_guard_fungus",
    armor = { bash = 5, cut = 14, stab = 12, bullet = 12, electric = 2 },
    inheritance = {
        add = { anger_triggers = { "HURT", "FIRE" }, flags = { "BASHES" } },
        remove = { fear_triggers = { "HURT", "FIRE" } },
    },
}
