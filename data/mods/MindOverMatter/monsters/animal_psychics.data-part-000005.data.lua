local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_hellhound_pup",
    copy_from = "mon_dog_pup",
    looks_like = "mon_dog_pup",
    name = ccb.content.plural_text("hellpup", "hellpups"),
    description = ccb.content.text("An adorable, defenseless Labrador puppy.  Much safer to tame than an adult dog.  Its breath is very hot."),
    melee_damage = { { type = "cut", amount = 1 }, { type = "heat", amount = 3 } },
    upgrade = { grow_at_age = 42, monster = "mon_hellhound" },
    armor = { heat = 50 },
}
