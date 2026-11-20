local ccb = require("ccb")

return ccb.ModDefinition {
    id = "vehicle_degradation",
    name = ccb.content.text("Disable vehicle degradation"),
    authors = { "LunaGlaze" },
    description = ccb.content.text("This mod disables the vehicle degradation mechanism, preventing vehicle parts from losing maximum durability when damaged, thus allowing for full repair.  This mod may affect balance and will not affect vehicle parts that have already experienced durability loss."),
    category = "rebalance",
    dependencies = { "ccb" },
    world_options = {
        -- If false, it will disable the reduction in the maximum repairable damage capacity of vehicle parts when they are damaged.
        VEHICLE_DEGRADATION_WHEN_DAMAGE = false,
    },
}
