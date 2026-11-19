local ccb = require("ccb")

-- an enemy could get under the protection in melee but ranged shots should almost always be blocked
ccb.content.define_item {
    id = "afs_military_vest",
    name = ccb.content.plural_text("IPAV armor", "IPAV armors"),
    description = ccb.content.text("Multipurpose military armor for the torso and upper arms, intended to protect against a wide variety of ballistic or direct energy attacks.  Made from a single piece of ablative carbide that keeps it relatively lightweight and completely disposable."),
    category = "armor",
    price = "1 kUSD 500 USD",
    mass = "7 kg",
    volume = "8 L",
    symbol = "[",
    materials = { "nylon", "vacuum_carbide_hard" },
    flags = { "OVERSIZE", "FRAGILE", "OUTER", "WATER_FRIENDLY" },
    faults = { { group = "carbide_armor" } },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "vacuum_carbide_hard", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "torso" },
                volume_encumbrance = 0.3,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "vacuum_carbide_hard", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 5,
                coverage = 90,
                melee_coverage = 90,
                ranged_coverage = 100,
                vitals_coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "vacuum_carbide_hard", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 2,
                coverage = 75,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                volume_encumbrance = 0,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 10 }, { kind = "detach_molle" } },
}
