local ccb = require("ccb")

ccb.content.define_weakpoint_set {
    id = "wps_mon_nether_cucumber_inline",
    points = {
        {
            id = "filaments",
            name = "filaments",
            coverage = 25,
            damage_multiplier = { bullet = 0.5, cut = 0.5, stab = 0.25, bash = 0.25 },
            effects = {
                {
                    effect = "sectioned_filaments",
                    chance = 50,
                    duration = { "5 seconds", "25 seconds" },
                    damage_percent = { 25, 100 },
                    message = "The %s's filaments are cut off!",
                    on_hit = "w16b_wp_hit_dda_2e713f2b057f",
                },
            },
        },
        {
            id = "vital organs",
            name = "vital organs",
            coverage = 10,
            damage_multiplier = { bullet = 2, cut = 2, stab = 2, bash = 0.5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_nether_cucumber",
    name = "waterbed skulker",
    description = "Pink and translucent, with all of its otherworldly organs visible through its skin, this meter-high conical creature creeps along the seabed with its stubby, furry legs.  It retracts some sort of barbed filaments into an orifice at its rear as it aims at potential prey.",
    default_faction = "nether",
    symbol = "s",
    body_type = "snake",
    color = "pink",
    volume = "70 L",
    mass = "75 kg",
    harvest = "mutant_mollusk",
    zombify_into = "mon_meat_cocoon_tiny",
    difficulty_adjustment = 15,
    hp = 50,
    speed = 80,
    aggression = 20,
    morale = 30,
    grab_strength = 40,
    flags = { "AQUATIC", "SEES", "HEARS", "GRABS" },
    species = { "NETHER" },
    anger_triggers = { "HURT", "PLAYER_CLOSE" },
    move_skills = { swim = 2 },
    melee_damage = {
        { type = "bash", amount = 0 },
    },
    attacks = {
        { id = "nether_cucumber_pull" },
        { id = "nether_cucumber_lash" },
        { id = "nether_cucumber_grab" },
        { id = "nether_cucumber_grab_followup" },
    },
    weakpoint_sets = { "wps_mon_nether_cucumber_inline" },
}
