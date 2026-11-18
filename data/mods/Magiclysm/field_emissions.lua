local content = require("ccb").content

content.add(content.Emission {
    id = "emit_vault_atmosphere",
    field = "fd_vault_atmosphere",
    intensity = 1,
    chance = 30,
})
content.add(content.Emission { id = "emit_safe_shoppers", field = "fd_safe_shoppers", intensity = 1, chance = 100 })
content.add(content.Emission {
    id = "emit_everfrost",
    field = "fd_cold_air2",
    intensity = 3,
    quantity = 3,
    chance = 100,
})
content.add(content.Emission {
    id = "emit_cold_energy_strong",
    field = "fd_cold_energy",
    intensity = 3,
    quantity = 300,
    chance = 100,
})
content.add(content.Emission { id = "emit_electric_sparks", field = "fd_electricity", intensity = 1, quantity = 10 })
content.add(content.Emission {
    id = "emit_eshaper_dust",
    field = "fd_eshaper_dust",
    intensity = 1,
    quantity = 22,
    chance = 100,
})
content.add(content.Emission {
    id = "emit_kelvinist_anti_heat",
    field = "fd_kelvinist_cold",
    intensity = 3,
    quantity = 300,
    chance = 100,
})
content.add(content.Emission {
    id = "emit_kelvinist_anti_cold",
    field = "fd_kelvinist_warmth",
    intensity = 3,
    quantity = 300,
    chance = 100,
})
content.add(content.Emission { id = "emit_rad_mage", field = "fd_rad_mage_aura", intensity = 1, quantity = 4 })
content.add(content.Emission { id = "emit_rad_mage_cloud", field = "fd_rad_mage_aura", intensity = 3, quantity = 100 })
content.upsert_emission(content.Emission {
    id = "emit_obscuring_fog",
    field = "fd_obscuring_fog",
    intensity = 3,
    quantity = 80,
})
content.add(content.Emission { id = "emit_hot_air3_blast", field = "fd_hot_air3", intensity = 3, quantity = 100 })
content.upsert_emission(content.Emission {
    id = "emit_hot_air4_blast",
    field = "fd_hot_air4",
    intensity = 3,
    quantity = 100,
})
content.add(content.Emission { id = "emit_glimmer_thaumic", field = "fd_dazzling_thaumic", quantity = 2, chance = 75 })
content.add(content.Emission {
    id = "emit_magic_disjunction",
    field = "fd_nullifying_field",
    intensity = 1,
    quantity = 50,
})
content.add(content.Emission { id = "emit_dragon_adult_fright", field = "fd_fright", intensity = 2, quantity = 60 })
