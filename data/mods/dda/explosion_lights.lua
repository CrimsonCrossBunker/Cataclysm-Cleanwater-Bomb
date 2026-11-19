local ccb = require("ccb")
local content = ccb.content

-- Native composable explosion-light recipes
do
local definition = content.ExplosionLight {
    id = "default_blast",
}
definition:stop(255, 215, 70, 150)
definition:stop(210, 40, 0, 70)
definition:waves {
    travel = 0.38,
    gap = 0.25,
    rise = 0.050000000000000003,
    fade = 0.10000000000000001,
    blend = 0.050000000000000003,
    spread_jitter = 0.070000000000000007,
    color_jitter = 0.050000000000000003,
    flicker = 0.17999999999999999,
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
    strength = 0.45000000000000001,
    speed = 1.1000000000000001,
    thickness = 1.5,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "fire_blast",
}
definition:stop(255, 195, 50, 165)
definition:stop(170, 25, 0, 80)
definition:waves {
    travel = 0.41999999999999998,
    gap = 0.29999999999999999,
    rise = 0.050000000000000003,
    fade = 0.14000000000000001,
    blend = 0.059999999999999998,
    spread_jitter = 0.10000000000000001,
    color_jitter = 0.059999999999999998,
    flicker = 0.29999999999999999,
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
    speed = 1,
    thickness = 2,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "rainbow_blast",
}
definition:stop(255, 40, 40, 170)
definition:stop(255, 150, 30, 165)
definition:stop(255, 240, 60, 160)
definition:stop(60, 220, 80, 150)
definition:stop(50, 120, 255, 135)
definition:stop(90, 60, 220, 110)
definition:stop(180, 70, 230, 80)
definition:waves {
    travel = 0.32000000000000001,
    gap = 0.17999999999999999,
    rise = 0.040000000000000001,
    fade = 0.12,
    blend = 0.10000000000000001,
    spread_jitter = 0.059999999999999998,
    color_jitter = 0.029999999999999999,
    flicker = 0.12,
    easing = "smoothstep",
}
definition:duration {
    base_ms = 260,
    per_tile_ms = 70,
    minimum_ms = 350,
    maximum_ms = 1600,
}
definition:screen_shake(5, 320)
definition:shockwave {
    enabled = true,
    strength = 0.5,
    speed = 1.1499999999999999,
    thickness = 1.6000000000000001,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "muzzle_flash",
}
definition:stop(255, 255, 235, 200)
definition:stop(255, 190, 70, 120)
definition:waves {
    travel = 0.10000000000000001,
    gap = 0.29999999999999999,
    rise = 0.059999999999999998,
    fade = 0.25,
    blend = 0.12,
    spread_jitter = 0.040000000000000001,
    color_jitter = 0.040000000000000001,
    flicker = 0.34999999999999998,
    easing = "ease_out",
}
definition:duration {
    base_ms = 60,
    per_tile_ms = 10,
    minimum_ms = 80,
    maximum_ms = 130,
}
definition:screen_shake(2, 130)
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "impact_spark",
}
definition:stop(255, 250, 220, 170)
definition:stop(160, 150, 140, 60)
definition:waves {
    travel = 0.10000000000000001,
    gap = 0.29999999999999999,
    rise = 0.050000000000000003,
    fade = 0.29999999999999999,
    blend = 0.10000000000000001,
    spread_jitter = 0.029999999999999999,
    color_jitter = 0.059999999999999998,
    flicker = 0.29999999999999999,
    easing = "ease_out",
}
definition:duration {
    base_ms = 40,
    per_tile_ms = 0,
    minimum_ms = 55,
    maximum_ms = 90,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "bullet_tracer",
}
definition:stop(255, 240, 200, 70)
definition:waves {
    travel = 0.050000000000000003,
    gap = 0.40000000000000002,
    rise = 0.040000000000000001,
    fade = 0.40000000000000002,
    blend = 0.080000000000000002,
    spread_jitter = 0.02,
    color_jitter = 0,
    flicker = 0.10000000000000001,
    easing = "ease_out",
}
definition:duration {
    base_ms = 45,
    per_tile_ms = 4,
    minimum_ms = 55,
    maximum_ms = 110,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "beam_laser",
}
definition:stop(255, 70, 60, 190)
definition:stop(200, 20, 20, 90)
definition:waves {
    travel = 0.050000000000000003,
    gap = 0.40000000000000002,
    rise = 0.040000000000000001,
    fade = 0.34999999999999998,
    blend = 0.10000000000000001,
    spread_jitter = 0.02,
    color_jitter = 0,
    flicker = 0.12,
    easing = "ease_out",
}
definition:duration {
    base_ms = 60,
    per_tile_ms = 5,
    minimum_ms = 75,
    maximum_ms = 150,
}
definition:shockwave {
    enabled = true,
    strength = 0.34999999999999998,
    speed = 1.3999999999999999,
    thickness = 1.2,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "beam_plasma",
}
definition:stop(180, 255, 220, 200)
definition:stop(40, 200, 150, 100)
definition:waves {
    travel = 0.050000000000000003,
    gap = 0.40000000000000002,
    rise = 0.040000000000000001,
    fade = 0.34999999999999998,
    blend = 0.12,
    spread_jitter = 0.02,
    color_jitter = 0,
    flicker = 0.17999999999999999,
    easing = "ease_out",
}
definition:duration {
    base_ms = 65,
    per_tile_ms = 5,
    minimum_ms = 80,
    maximum_ms = 160,
}
definition:shockwave {
    enabled = true,
    strength = 0.45000000000000001,
    speed = 1.3999999999999999,
    thickness = 1.3999999999999999,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "beam_lightning",
}
definition:stop(235, 245, 255, 210)
definition:stop(90, 140, 255, 90)
definition:waves {
    travel = 0.050000000000000003,
    gap = 0.40000000000000002,
    rise = 0.029999999999999999,
    fade = 0.29999999999999999,
    blend = 0.080000000000000002,
    spread_jitter = 0.029999999999999999,
    color_jitter = 0.02,
    flicker = 0.40000000000000002,
    easing = "ease_out",
}
definition:duration {
    base_ms = 55,
    per_tile_ms = 4,
    minimum_ms = 65,
    maximum_ms = 130,
}
definition:shockwave {
    enabled = true,
    strength = 0.40000000000000002,
    speed = 1.6000000000000001,
    thickness = 1,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "emp_blast",
}
definition:stop(220, 240, 255, 180)
definition:stop(90, 160, 255, 120)
definition:stop(140, 110, 255, 60)
definition:waves {
    travel = 0.34000000000000002,
    gap = 0.16,
    rise = 0.040000000000000001,
    fade = 0.12,
    blend = 0.080000000000000002,
    spread_jitter = 0.070000000000000007,
    color_jitter = 0.040000000000000001,
    flicker = 0.40000000000000002,
    easing = "ease_out",
}
definition:duration {
    base_ms = 180,
    per_tile_ms = 35,
    minimum_ms = 220,
    maximum_ms = 700,
}
definition:screen_shake(3, 200)
definition:shockwave {
    enabled = true,
    strength = 0.5,
    speed = 1.5,
    thickness = 1,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "flashbang_blast",
}
definition:stop(255, 255, 255, 235)
definition:waves {
    travel = 0.29999999999999999,
    gap = 0.5,
    rise = 0.029999999999999999,
    fade = 0.25,
    blend = 0.050000000000000003,
    spread_jitter = 0.050000000000000003,
    color_jitter = 0,
    flicker = 0.080000000000000002,
    easing = "ease_out",
}
definition:duration {
    base_ms = 320,
    per_tile_ms = 40,
    minimum_ms = 380,
    maximum_ms = 1100,
}
definition:screen_shake(6, 280)
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "gas_cloud",
}
definition:stop(170, 220, 90, 90)
definition:stop(120, 170, 60, 70)
definition:stop(90, 130, 50, 40)
definition:waves {
    travel = 0.45000000000000001,
    gap = 0.29999999999999999,
    rise = 0.14999999999999999,
    fade = 0.40000000000000002,
    blend = 0.25,
    spread_jitter = 0.12,
    color_jitter = 0.050000000000000003,
    flicker = 0.059999999999999998,
    easing = "smoothstep",
}
definition:duration {
    base_ms = 600,
    per_tile_ms = 90,
    minimum_ms = 800,
    maximum_ms = 2500,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "incendiary_blast",
}
definition:stop(255, 220, 120, 180)
definition:stop(255, 120, 30, 150)
definition:stop(190, 40, 10, 110)
definition:stop(110, 25, 10, 60)
definition:waves {
    travel = 0.46000000000000002,
    gap = 0.26000000000000001,
    rise = 0.050000000000000003,
    fade = 0.20000000000000001,
    blend = 0.10000000000000001,
    spread_jitter = 0.11,
    color_jitter = 0.070000000000000007,
    flicker = 0.32000000000000001,
    easing = "smoothstep",
}
definition:duration {
    base_ms = 320,
    per_tile_ms = 85,
    minimum_ms = 420,
    maximum_ms = 2000,
}
definition:screen_shake(5, 360)
definition:shockwave {
    enabled = true,
    strength = 0.65000000000000002,
    speed = 0.94999999999999996,
    thickness = 2.2000000000000002,
}
content.add(definition)
end
do
local definition = content.ExplosionLight {
    id = "smoke_cloud",
}
definition:stop(185, 185, 190, 90)
definition:stop(140, 140, 145, 78)
definition:stop(95, 95, 100, 45)
definition:waves {
    travel = 0.050000000000000003,
    gap = 0.34000000000000002,
    rise = 0.16,
    fade = 0.55000000000000004,
    blend = 0.40000000000000002,
    spread_jitter = 0.22,
    color_jitter = 0.040000000000000001,
    flicker = 0.040000000000000001,
    easing = "smoothstep",
}
definition:duration {
    base_ms = 900,
    per_tile_ms = 130,
    minimum_ms = 1300,
    maximum_ms = 3500,
}
content.add(definition)
end
