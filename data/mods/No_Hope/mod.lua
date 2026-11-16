local ccb = require("ccb")

return ccb.ModDefinition {
    world_options = {
        OVERRIDE_VEHICLE_INIT_STATE = true,
        VEHICLE_STATUS_AT_SPAWN = 1,
        VEHICLE_FUEL_AT_SPAWN = 0,
        -- Only relevant if points are enabled. A few points are still provided. Can be used to shore
        -- up trait points if single pool is selected, but otherwise doesn't allow someone to pick
        -- particularly high stats.
        INITIAL_STAT_POINTS = 2,
        -- Only relevant if points are enabled. A negative starting balance forces points players to
        -- pick massive negative traits.
        INITIAL_TRAIT_POINTS = -10,
        -- Only relevant if points are enabled. Zeroed out intentionally. Behold the tasks ahead of
        -- you, mortal, and realize that you are not prepared.
        INITIAL_SKILL_POINTS = 0,
        -- Only relevant if points are enabled. Must be high enough to overcome INITIAL_TRAIT_POINTS.
        MAX_TRAIT_POINTS = 14,
        -- Speed is slightly slowed down. Not enough to make the game into a grind, but to contribute
        -- to the general feeling that 'there is no hope'. Everything the player does here is a little
        -- harder, a little more difficult, and it only gets worse.
        SKILL_TRAINING_SPEED = 0.9,
        -- Speed is slightly slowed down. Not enough to make the game into a grind, but to contribute
        -- to the general feeling that 'there is no hope'. Everything the player does here is a little
        -- harder, a little more difficult, and it only gets worse.
        PROFICIENCY_TRAINING_SPEED = 0.9,
        -- Extra pain scaling on strength, but only strength. Having strength lower at a much faster
        -- rate means that combat is more explosively threatening, where damage can quickly tip a fight
        -- into unwinnable and inescapable.
        PAIN_PENALTY_MOD_STR = 0.01,
        -- No natural regen at all, only bandaged healing works. Note that this only affects passive
        -- regeneration, healing via bandaging is unaffected!
        PLAYER_HEALING_RATE = 0.0,
        -- Just to equalize the rates.
        NPC_HEALING_RATE = 0.0,
        -- The end is approaching faster than you can imagine.
        EVOLUTION_INVERSE_MULTIPLIER = 0.667,
        -- Note that this is only intended to change the climate. The mod is not set in Russia, even
        -- though the geographic coordinates would suggest so.
        -- Cold, miserable, with little sunlight and much twilight. This makes solar power less
        -- effective. In combination with scarce fuel, it better fits the setting.
        LATITUDE = 60.0,
        -- Note that this is only intended to change the climate. The mod is not set in Russia, even
        -- though the geographic coordinates would suggest so. Technically there is no reason to change
        -- the longitude. I just felt like it, and since it will have a minute impact on sunrise times
        -- it may be a fun detail for some of our players.
        LONGITUDE = 30.0,
        -- If true, custom characters must be Average or weaker in all rating categories.
        CHARACTER_CREATION_HARD_LIMIT = true,
    },
}
