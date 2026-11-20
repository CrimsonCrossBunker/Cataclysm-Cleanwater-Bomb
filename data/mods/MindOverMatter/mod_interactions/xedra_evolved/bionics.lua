local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_psi_range_increaser",
    name = ccb.content.text("Noetic Range Booster CBM"),
    description = ccb.content.text("Taken from another reality, this CBM enables much more distant channeling of psionic powers at the cost of occasional crippling headaches."),
    activation_energy_millijoules = 30000,
    over_time_energy_millijoules = 12000,
    charge_time_turns = 1,
    enchantments = { "ench_bio_psi_range_increaser" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 5 }, { bodypart = "eyes", slots = 2 } },
})
