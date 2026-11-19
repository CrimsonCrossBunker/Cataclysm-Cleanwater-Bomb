local ccb = require("ccb")

ccb.content.define_spell {
    id = "gargantuan_raptor_spawn",
    name = ccb.content.text("Summon Raptor Horde"),
    description = ccb.content.text("Summons a horde of zombiespawn raptors."),
    flags = { "HOSTILE_SUMMON", "RANDOM_DAMAGE", "PERMANENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "ground", "self" },
    min_damage = 7,
    max_damage = 15,
    min_aoe = 4,
    max_aoe = 4,
    base_casting_time = 500,
    shape = "blast",
    effect = "summon",
    effect_data = "mon_spawn_raptor",
}
