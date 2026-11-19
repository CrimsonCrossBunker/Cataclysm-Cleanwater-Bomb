local ccb = require("ccb")
local content = ccb.content

-- Native composable explosion-light recipes
do
local definition = content.ExplosionLight {
    id = "immortal_path_fireball_blast",
}
definition:stop(255, 200, 60, 170)
definition:stop(200, 30, 0, 85)
definition:waves {
    travel = 0.40000000000000002,
    gap = 0.28000000000000003,
    rise = 0.050000000000000003,
    fade = 0.13,
    blend = 0.059999999999999998,
    spread_jitter = 0.22,
    color_jitter = 0.070000000000000007,
    flicker = 0.34000000000000002,
    easing = "linear",
}
definition:duration {
    base_ms = 120,
    per_tile_ms = 45,
    minimum_ms = 150,
    maximum_ms = 900,
}
definition:shockwave {
    enabled = true,
    strength = 0.5,
    speed = 1.1499999999999999,
    thickness = 1.2,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "immortal_path_water_burst_blast",
}
definition:stop(150, 230, 255, 165)
definition:stop(20, 70, 200, 80)
definition:waves {
    travel = 0.35999999999999999,
    gap = 0.28000000000000003,
    rise = 0.050000000000000003,
    fade = 0.16,
    blend = 0.070000000000000007,
    spread_jitter = 0.20000000000000001,
    color_jitter = 0.050000000000000003,
    flicker = 0.16,
    easing = "linear",
}
definition:duration {
    base_ms = 120,
    per_tile_ms = 45,
    minimum_ms = 150,
    maximum_ms = 900,
}
definition:shockwave {
    enabled = true,
    strength = 0.59999999999999998,
    speed = 1.25,
    thickness = 1,
}
content.add(definition)
end
