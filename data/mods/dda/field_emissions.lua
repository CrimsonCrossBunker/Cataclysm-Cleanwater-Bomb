local content = require("ccb").content

-- Intermittent cigarette smoke (example: lit cigarette)
content.add(content.Emission { id = "emit_tobacco_trail", field = "fd_cigsmoke", intensity = 2, chance = 2 })
-- Intermittent joint smoke (example: lit cigarette)
content.add(content.Emission { id = "emit_joint_trail", field = "fd_weedsmoke", intensity = 3, chance = 2 })
-- Intermittent smoke from an artifact
content.add(content.Emission { id = "emit_AEP_SMOKE", field = "fd_smoke", intensity = 3, quantity = 15, chance = 5 })
-- Large blast of smoke (example: smoker zombie explosion)
content.add(content.Emission { id = "emit_smoke_blast", field = "fd_smoke", intensity = 3, quantity = 200 })
-- Small plume of thick smoke (example: muzzle smoke)
content.add(content.Emission { id = "emit_smoke_plume", field = "fd_smoke", intensity = 3, quantity = 6 })
-- Small plume of thick smoke (example: muzzle smoke)
content.add(content.Emission { id = "emit_small_smoke_plume", field = "fd_smoke", intensity = 3, quantity = 3 })
-- Small plume of thick smoke (example: smallarms muzzle smoke)
content.add(content.Emission { id = "emit_smaller_smoke_plume", field = "fd_smoke", quantity = 1, chance = 30 })
-- Steady stream of thick smoke (example: smoke bomb)
content.add(content.Emission { id = "emit_smoke_stream", field = "fd_smoke", intensity = 3, quantity = 24 })
-- Steady stream of tear gas (example: tear gas canister)
content.add(content.Emission { id = "emit_tear_gas_stream", field = "fd_tear_gas", intensity = 3, quantity = 18 })
-- Large blast of tear gas (example: tear gas canister)
content.add(content.Emission { id = "emit_tear_gas_blast", field = "fd_tear_gas", intensity = 3, quantity = 200 })
-- Large blast of toxic gas (example: bloated zombie explosion)
content.add(content.Emission { id = "emit_toxic_blast", field = "fd_toxic_gas", intensity = 3, quantity = 200 })
-- Slow infrequent leak of toxic gas (example: bloated zombie movement)
content.add(content.Emission { id = "emit_toxic_leak", field = "fd_toxic_gas", intensity = 3, chance = 15 })
-- Steady stream of toxic gas
content.add(content.Emission { id = "emit_toxic_stream", field = "fd_toxic_gas", intensity = 3, quantity = 24 })
-- Large blast of relaxation gas (similar to riot control bot)
content.add(content.Emission { id = "emit_relax_gas_blast", field = "fd_relax_gas", intensity = 3, quantity = 200 })
-- Periodic leaking of relaxation gas
content.add(content.Emission { id = "emit_relax_gas_leak", field = "fd_relax_gas", intensity = 3, chance = 15 })
-- Periodic leaking of tear gas
content.add(content.Emission { id = "emit_tear_gas_leak", field = "fd_tear_gas", intensity = 3, chance = 15 })
-- Periodic leaking of tear gas
content.add(content.Emission {
    id = "emit_tear_gas_toad",
    field = "fd_tear_gas",
    intensity = 3,
    quantity = 3,
    chance = 15,
})
-- Slow infrequent leak of tindalos gas (example: hound of tindalos movement)
content.add(content.Emission {
    id = "emit_tindalos_gas_leak",
    field = "fd_tindalos_gas",
    intensity = 3,
    quantity = 10,
    chance = 15,
})
content.add(content.Emission {
    id = "emit_twisting_mass_dust",
    field = "fd_twisting_mass_dust",
    intensity = 3,
    quantity = 10,
    chance = 15,
})
-- Small cloud of toxic gas emitted infrequently
content.add(content.Emission {
    id = "emit_toxic_cloud",
    field = "fd_toxic_gas",
    intensity = 3,
    quantity = 10,
    chance = 2,
})
-- Large cloud of toxic gas emitted infrequently
content.add(content.Emission {
    id = "emit_toxic_belch",
    field = "fd_toxic_gas",
    intensity = 3,
    quantity = 25,
    chance = 1,
})
-- Small amount of strong acid - will need more to melt anything
content.add(content.Emission { id = "emit_acid_drop", field = "fd_acid", intensity = 3, chance = 50 })
content.add(content.Emission {
    id = "emit_shadow_field",
    field = "fd_shadow",
    intensity = 1,
    quantity = 10,
    chance = 100,
})
-- small sparks
content.add(content.Emission { id = "emit_spark", field = "fd_electricity", intensity = 1, quantity = 1, chance = 100 })
-- small cloud of lightning
content.add(content.Emission {
    id = "emit_shock_burst",
    field = "fd_electricity",
    intensity = 3,
    quantity = 10,
    chance = 1,
})
-- small cloud of lightning
content.add(content.Emission {
    id = "emit_shock_burst_rat",
    field = "fd_electricity",
    intensity = 3,
    quantity = 10,
    chance = 5,
})
-- Thick cloud of lightning (example: incandescent husk)
content.add(content.Emission { id = "emit_shock_cloud", field = "fd_electricity", intensity = 7, quantity = 6 })
-- Large cloud of lightning (example: supercharged incandescent husk)
content.add(content.Emission { id = "emit_shock_cloud_big", field = "fd_electricity", intensity = 10, quantity = 12 })
content.add(content.Emission { id = "emit_cold_air2_stream", field = "fd_cold_air2", intensity = 3, quantity = 50 })
content.add(content.Emission { id = "emit_cold_air2_blast", field = "fd_cold_air2", intensity = 3, quantity = 100 })
content.add(content.Emission { id = "emit_cold_air4_blast", field = "fd_cold_air4", intensity = 3, quantity = 100 })
content.add(content.Emission { id = "emit_hot_air2_stream", field = "fd_hot_air2", intensity = 3, quantity = 50 })
content.add(content.Emission { id = "emit_pollen_stream", field = "fd_pollen_triffid", intensity = 2, quantity = 24 })
content.add(content.Emission { id = "emit_hot_air2_blast", field = "fd_hot_air2", intensity = 3, quantity = 100 })
content.add(content.Emission {
    id = "emit_heater_vehicle",
    field = "fd_hot_air2",
    intensity = 3,
    quantity = 3,
    chance = 100,
})
content.add(content.Emission {
    id = "emit_cooler_vehicle",
    field = "fd_cold_air2",
    intensity = 3,
    quantity = 3,
    chance = 100,
})
content.add(content.Emission {
    id = "emit_hot_air_migo_seep",
    field = "fd_hot_air_sauna",
    intensity = 2,
    quantity = 60,
})
content.add(content.Emission {
    id = "emit_hot_air_migo_blast",
    field = "fd_hot_air_sauna",
    intensity = 3,
    quantity = 150,
})
content.add(content.Emission {
    id = "emit_migo_atmosphere",
    field = "fd_migo_atmosphere",
    intensity = 3,
    quantity = 300,
})
content.add(content.Emission { id = "emit_glimmer", field = "fd_dazzling", quantity = 2, chance = 75 })
content.add(content.Emission { id = "emit_plasma", field = "fd_plasma", quantity = 2, chance = 75 })
content.add(content.Emission { id = "emit_plasma_continuously", field = "fd_plasma", quantity = 4, chance = 100 })
content.add(content.Emission {
    id = "emit_fungicidal_stream",
    field = "fd_fungicidal_gas",
    intensity = 3,
    quantity = 18,
})
content.add(content.Emission {
    id = "emit_insecticidal_stream",
    field = "fd_insecticidal_gas",
    intensity = 3,
    quantity = 18,
})
content.add(content.Emission {
    id = "emit_small_fungicidal_stream",
    field = "fd_fungicidal_gas",
    intensity = 2,
    quantity = 10,
})
content.add(content.Emission {
    id = "emit_small_insecticidal_stream",
    field = "fd_insecticidal_gas",
    intensity = 2,
    quantity = 10,
})
content.add(content.Emission { id = "emit_fungal_haze_plume", field = "fd_fungal_haze", intensity = 3, quantity = 3 })
content.add(content.Emission { id = "emit_fungal_leak", field = "fd_fungal_haze", chance = 15 })
content.add(content.Emission { id = "emit_fungal_blast", field = "fd_fungal_haze", quantity = 200 })
-- Slow infrequent leak of hallucinogenic cloud
content.add(content.Emission {
    id = "emit_hallucinogenic_spores",
    field = "fd_hallucinogenic_spores",
    intensity = 1,
    quantity = 4,
})
content.add(content.Emission {
    id = "emit_hallucinogenic_spores_blast",
    field = "fd_hallucinogenic_spores",
    intensity = 2,
    quantity = 200,
})
content.add(content.Emission { id = "emit_swamp_gas_leak", field = "fd_swamp_gas", intensity = 1, chance = 15 })
content.add(content.Emission { id = "emit_fog_plume", field = "fd_fog", intensity = 2, quantity = 200 })
content.add(content.Emission {
    id = "emit_extinguisher_burst",
    field = "fd_extinguisher",
    intensity = 1,
    quantity = 10,
})
content.add(content.Emission { id = "emit_rad_leak", field = "fd_nuke_gas", intensity = 1, quantity = 1 })
-- Negative, negative, it's a large reactor leak, very dangerous
content.add(content.Emission { id = "emit_rad_cloud", field = "fd_nuke_gas", intensity = 3, quantity = 100 })
-- Occasionally leave a web, not too often because we spawn in mixed groups
content.add(content.Emission { id = "emit_web_small", field = "fd_web", intensity = 3, chance = 50 })
-- Infrequent emission of sludge along the ground, made because sludge trail is too frequent
content.add(content.Emission { id = "emit_sludge_puddle", field = "fd_sludge", intensity = 3, chance = 20 })
content.add(content.Emission { id = "emit_tiny_fire", field = "fd_fire", intensity = 1, quantity = 1 })
content.add(content.Emission { id = "emit_clairvoyant", field = "fd_clairvoyant", intensity = 1, quantity = 9 })
-- Periodic swarm of bees
content.add(content.Emission { id = "emit_bees", field = "fd_bee_swarm", intensity = 3, chance = 15 })
content.add(content.Emission { id = "emit_monster_gas_1", field = "fd_nm_monster_gas_1", intensity = 3, chance = 10 })
content.add(content.Emission { id = "emit_monster_gas_2", field = "fd_nm_monster_gas_2", intensity = 3, chance = 10 })
content.add(content.Emission {
    id = "emit_nauseating_smell",
    field = "fd_nauseating_smell",
    intensity = 1,
    quantity = 50,
})
content.add(content.Emission {
    id = "emit_scarlet_sea_wave",
    field = "fd_scarlet_sea_wave",
    intensity = 3,
    quantity = 4,
})
content.add(content.Emission { id = "emit_scarlet_sea_gas", field = "fd_scarlet_sea_gas", intensity = 3, quantity = 4 })
content.add(content.Emission {
    id = "emit_congealed_light",
    field = "fd_congealed_light",
    intensity = 1,
    quantity = 30,
    chance = 85,
})
