local content = require("ccb").content

content.replace(content.Emission {
    id = "emit_clairvoyant",
    field = "fd_clairvoyant",
    intensity = 1,
    quantity = 27,
    chance = 100,
})
content.add(content.Emission {
    id = "afs_emit_geovent",
    field = "fd_hot_air3",
    intensity = 3,
    quantity = 60,
    chance = 100,
})
content.add(content.Emission { id = "afs_emit_AC", field = "fd_hot_airAC", quantity = 60, chance = 100 })
content.add(content.Emission {
    id = "afs_emit_survival_heater",
    field = "fd_hot_airAC_temporary",
    quantity = 60,
    chance = 100,
})
content.add(content.Emission {
    id = "heavy_rad_glimmer",
    field = "fd_rad_glimmer",
    intensity = 3,
    quantity = 70,
    chance = 70,
})
content.add(content.Emission {
    id = "weak_rad_glimmer",
    field = "fd_rad_glimmer",
    intensity = 3,
    quantity = 12,
    chance = 100,
})
content.add(content.Emission {
    id = "weak_toxic_dust",
    field = "fd_toxic_dust",
    intensity = 2,
    quantity = 6,
    chance = 2,
})
