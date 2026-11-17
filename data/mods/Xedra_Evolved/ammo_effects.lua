local content = require("ccb").content

content.add(content.AmmoEffect { id = "GRENADE_EXPL" }
    :explosion{ power = 1200, distance_factor = 0.4, max_noise = 70 })

content.add(content.AmmoEffect { id = "GRENADE_FIRE_EXPL" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1, footprint = 5 }
    :explosion{ power = 250, distance_factor = 0.7, fire = true })

content.add(content.AmmoEffect { id = "GRENADE_ELEC_EXPL" }
    :field_burst{ field = "fd_electricity", intensity_min = 10, intensity_max = 10, chance = 100, footprint = 50 }
    :emp())
