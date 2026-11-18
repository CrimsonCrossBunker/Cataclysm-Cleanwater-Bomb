local content = require("ccb").content

content.add(content.Emission {
    id = "xedra_dreamer_emit_accelerated_time",
    field = "fd_xedra_dreamer_accelerated_time",
    intensity = 1,
    quantity = 20,
    chance = 100,
})
content.add(content.Emission {
    id = "xedra_monochrome_boomer_frozen_time",
    field = "fd_frozen_time",
    intensity = 1,
    quantity = 1,
})
-- Slow infrequent leak of changeling mist.  This should summon various changeling monsters similar to Angle Dog Fog.
content.add(content.Emission {
    id = "emit_changeling_mist",
    field = "fd_mirrored",
    intensity = 3,
    quantity = 10,
    chance = 15,
})
content.add(content.Emission {
    id = "emit_emerald_poppy_pollen",
    field = "fd_emerald_poppy_pollen",
    intensity = 3,
    quantity = 7,
    chance = 80,
})
content.add(content.Emission {
    id = "emit_blood_karma",
    field = "fd_blood_karma",
    intensity = 1,
    quantity = 1,
    chance = 100,
})
content.upsert_emission(content.Emission {
    id = "emit_obscuring_fog",
    field = "fd_obscuring_fog",
    intensity = 3,
    quantity = 80,
})
content.add(content.Emission {
    id = "emit_kreck_death_stones",
    field = "fd_kreck_death_debris",
    intensity = 1,
    quantity = 2,
})
content.add(content.Emission {
    id = "emit_shoggoth_dissolution",
    field = "fd_shoggoth_dissolution",
    intensity = 1,
    quantity = 7,
})
content.add(content.Emission {
    id = "emit_salamander_heat",
    field = "fd_salamander_heat",
    intensity = 3,
    quantity = 50,
})
content.add(content.Emission {
    id = "emit_arvore_poison_pollen",
    field = "fd_pollen_arvore_weaken",
    intensity = 2,
    quantity = 25,
})
content.upsert_emission(content.Emission {
    id = "emit_hot_air4_blast",
    field = "fd_hot_air4",
    intensity = 3,
    quantity = 100,
})
content.add(content.Emission {
    id = "emit_powder_of_revelation",
    field = "fd_powder_of_revelation",
    intensity = 1,
    quantity = 50,
})
