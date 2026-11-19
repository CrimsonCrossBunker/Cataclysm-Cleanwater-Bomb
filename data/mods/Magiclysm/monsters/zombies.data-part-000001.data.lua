local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_leyspark",
    name = ccb.content.plural_text("leyspark zombie", "leyspark zombies"),
    description = ccb.content.text("This zombie's ley lines are visibly glowing beneath its skin, casting a blue light on its surroundings.  A stronger burst of light, almost blinding, occasionally flashes from one of the ley lines."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 5 } },
    emissions = { { id = "emit_glimmer_thaumic", delay = "10 s" } },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab" },
        { id = "bite_humanoid", cooldown = 5 },
    },
    luminance = 10,
    upgrade = { half_life = 120, monster = "mon_zombie_levinbolt" },
    inheritance = { offset = { armor = { nether = 6 } } },
}
