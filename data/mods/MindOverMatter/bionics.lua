local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_dangersight_eyes_non_fifth_sun",
    name = ccb.content.text("Dangersight Eyes"),
    description = ccb.content.text("Minute quantities of matrix crystal interface with your optic nerves, allowing you to detect the presence of living beings that seek to do you harm.  Activate to toggle on."),
    activation_energy_millijoules = 40000,
    over_time_energy_millijoules = 15000,
    charge_time_turns = 1,
    enchantments = { "ench_bio_dangersight_eyes" },
    flags = { "BIONIC_TOGGLED" },
    mutation_conflicts = { "COMPOUND_EYES", "CEPH_VISION", "CEPH_EYES", "EYEBULGE", "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_metabolics_fifth_sun",
    name = ccb.content.text("Tlacuallichicahualiztli Transformer"),
    description = ccb.content.text("Your digestive system and power supply are interconnected; bionic energy is replenished by burning calories.  Can be toggled on and off at will."),
    charge_time_turns = 1,
    fuel_efficiency = 0.3,
    fuel_options = { "metabolism" },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
content.add(content.Bionic {
    id = "bio_physical_buffs_fifth_sun",
    name = ccb.content.text("Teōchicāhualiztli Booster"),
    description = ccb.content.text("A series of implants along your skeleton and in major muscle groups can be activated to greatly increase your strength and agility.  Activate to toggle on."),
    activation_energy_millijoules = 50000,
    over_time_energy_millijoules = 50000,
    charge_time_turns = 1,
    enchantments = { "ench_bio_physical_buffs" },
    flags = { "BIONIC_TOGGLED" },
    mutation_conflicts = { "LARGE", "LARGE_OK", "HUGE_OK", "HUGE", "SMALL", "SMALL2", "SMALL_OK" },
    occupied_bodyparts = { { bodypart = "head", slots = 5 }, { bodypart = "torso", slots = 10 }, { bodypart = "arm_l", slots = 8 }, { bodypart = "arm_r", slots = 8 }, { bodypart = "leg_l", slots = 10 }, { bodypart = "leg_r", slots = 10 } },
})
content.add(content.Bionic {
    id = "bio_cameleoflage_fifth_sun",
    name = ccb.content.text("Tapayaxitilmàtli"),
    description = ccb.content.text("Implants under your skin throughout your body that bend light around you when activated, making it much harder to spot you from a distance.  While not invisibility, it can keep you unseen when it counts.  Activate to toggle on."),
    activation_energy_millijoules = 400000,
    over_time_energy_millijoules = 400000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_cameleoflage_fifth_sun_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 4 }, { bodypart = "leg_r", slots = 4 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_dangersight_eyes_standard",
    name = ccb.content.text("Ohuicatlachiyaliztimeh"),
    description = ccb.content.text("Minute quantities of matrix crystal interface with your optic nerves, allowing you to detect the presence of living beings that seek to do you harm.  Activate to toggle on."),
    activation_energy_millijoules = 40000,
    over_time_energy_millijoules = 15000,
    charge_time_turns = 1,
    enchantments = { "ench_bio_dangersight_eyes" },
    flags = { "BIONIC_TOGGLED" },
    mutation_conflicts = { "COMPOUND_EYES", "CEPH_VISION", "CEPH_EYES", "EYEBULGE", "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_power_storage_fifth_sun",
    name = ccb.content.text("Ikpitikayotecontli System"),
    description = ccb.content.text("A Compact Bionics Module that increases your power capacity by 600 kJ."),
    capacity_energy_millijoules = 600000000,
    dupes_allowed = true,
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 } },
})
