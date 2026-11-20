local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_robofac_laserturret_mk1",
    name = ccb.content.plural_text("prototype laser turret", "prototype laser turrets"),
    description = ccb.content.text("This appears to be a very experimental automated tower.  Lacking armor plating and seemingly half-built, it's little more than an oversized laser emitter and a camera, both welded to a swiveling platform."),
    default_faction = "robofac",
    species = { "ROBOT" },
    volume = "30000 ml",
    mass = "40750 g",
    hp = 30,
    speed = 100,
    materials = { "steel" },
    symbol = "2",
    color = "white",
    aggression = 100,
    morale = 100,
    vision_day = 50,
    attacks = {
        {
            cooldown = 1,
            kind = "gun",
            gun = {
                weapon = "v29_turret",
                skills = { { id = "gun", level = 4 }, { id = "pistol", level = 4 } },
                target_moving_vehicles = true,
                ranges = { { minimum = 0, maximum = 30, mode = "DEFAULT" } },
            },
        },
    },
    defense = { id = "RETURN_FIRE", chance = 100 },
    flags = {
        "SEES",
        "NOHEAD",
        "ELECTRONIC",
        "COLDPROOF",
        "BIOLOGICALPROOF",
        "IMMOBILE",
        "NO_BREATHE",
        "STUN_IMMUNE",
    },
    armor = { bash = 2, cut = 5, bullet = 2 },
    death = { drops = {}, outcome = { corpse = "BROKEN" } },
}
