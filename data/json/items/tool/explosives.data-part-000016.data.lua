local ccb = require("ccb")

-- ["2% chance per turn of going out harmlessly.", "This is necessary to prevent a player from lighting a ton of molotovs and stuffing them in their backpack until pulling them out 6 weeks later."]
ccb.content.define_item {
    id = "molotov_lit",
    copy_from = "molotov",
    description = ccb.content.text("A bottle of flammable liquid with a flaming rag stoppered in its neck.  Throwing it will shatter the bottle on impact and ignite a fireball.  Dropping it will set you on fire, so don't do that unless you want to burn to death."),
    light = 15,
    flags = {
        "DANGEROUS", "NO_REPAIR", "WATER_EXTINGUISH", "DESTROY_ON_CHARGE_USE", "SPAWN_ACTIVE",
        "ACT_ON_RANGED_HIT", "NO_MANUAL_ACTIVATION",
    },
    tool = {},
    use_actions = { { kind = "explosion", ammo_effects = { "MOLOTOV" }, blast = { power = 0 } } },
    tick_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "molotov",
            chance = 2,
            message = ccb.content.text("Your lit Molotov goes out."),
        },
    },
}
