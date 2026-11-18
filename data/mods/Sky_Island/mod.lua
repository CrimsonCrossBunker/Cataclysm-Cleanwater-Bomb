local ccb = require("ccb")

return ccb.ModDefinition {
    id = "skyisland",
    name = ccb.content.text("Sky Island"),
    authors = { "TGW" },
    maintainers = { "gettingusedto" },
    description = ccb.content.text("An attempt at an entirely new way to play CDDA, inspired by games like Escape from Tarkov and Dark and Darker.  Begin on a floating island in the sky and warp down to random spots on the earth below to conduct expeditions for items you need.  Permadeath is gone - you will return to the island on death but lose any items you had on you.  Build up your stockpile, carry out missions for unique rewards, customize your home island, unlock upgrades, and be prudent about what you take on any given outing.  Be aware that 'PLAY NOW' will NOT work, you MUST make a custom character."),
    category = "total_conversion",
    dependencies = { "ccb" },
    conflicts = { "MA", "extra_mut_scens" },
    version = "0.4.0",
    loading_images = { "skyisland1.png" },
    disable_other_loading_screens = true,
    world_options = {
        -- If true, initial status and amount of fuel for all spawned vehicles will be overridden by
        -- values of VEHICLE_STATUS_AT_SPAWN and VEHICLE_FUEL_AT_SPAWN options.
        OVERRIDE_VEHICLE_INIT_STATE = true,
        -- All vehicles spawn in this status.  -1 is lightly damaged (default), 0 is undamaged, 1 is
        -- disabled (destroyed tires or engine).  Values are read only if OVERRIDE_VEHICLE_INIT_STATE
        -- is set to true.
        VEHICLE_STATUS_AT_SPAWN = 0,
    },
    interaction_world_options = {
        ["backrooms"] = {
            -- Reapply to override backrooms setting
            DEFAULT_REGION = "default_skyisland",
        },
    },
}
