local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_fuel_cell_blood",
    name = ccb.content.text("Blood Power Generator"),
    description = ccb.content.text("Embedded into your back and connected to your bionic power supply is a powerful spell focus able to consume blood from dead creatures to produce bionic power.  It can store up to 750 mL of blood."),
    charge_time_turns = 6,
    fuel_efficiency = 0.6,
    exothermic_power_gen = true,
    fuel_options = { "blood", "dragon_blood", "blood_tainted", "hblood" },
    passive_pseudo_items = { "integrated_blood_bank" },
    flags = { "BIONIC_TOGGLED", "BIONIC_POWER_SOURCE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 } },
})
content.add(content.Bionic {
    id = "bio_sneeze_beam",
    name = ccb.content.text("Crystallized Mana Nose Replacement"),
    description = ccb.content.text("A large gem made with crystallized mana and some other stabilizing metals.  Comes with a specially designed power pack (installed into the skull) that does not interfere with your mana ley lines.  WARNING: for Technomancer use only.  By using this spell you are waiving all liability of Frikken Laser Beams Inc.  and its subsidiaries."),
    capacity_energy_millijoules = 500000000,
    enchantments = { "ench_bio_sneeze_beam" },
    flags = { "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "EARTHSHAPER" },
    occupied_bodyparts = { { bodypart = "head", slots = 10 }, { bodypart = "mouth", slots = 1 } },
    learned_spells = { { spell = "overcharge_eyes", level = 4 } },
})
content.add(content.Bionic {
    id = "bio_see_wizards_eyes",
    name = ccb.content.text("Witchfinder Eyes"),
    description = ccb.content.text("Rune-inscribed metal filaments have been implanted around your eyes, allowing you to detect nearby mages.  Activate to turn it on."),
    activation_energy_millijoules = 20000,
    over_time_energy_millijoules = 6000,
    charge_time_turns = 1,
    enchantments = { "ench_bio_see_wizards_eye" },
    flags = { "BIONIC_TOGGLED" },
    mutation_conflicts = { "COMPOUND_EYES", "CEPH_VISION", "CEPH_EYES", "EYEBULGE", "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_ley_energy_blaster",
    name = ccb.content.text("Levinbolt Projector"),
    description = ccb.content.text("Implants in your arm's ley lines allow you to project bolts of magical energy from your hands.  This draws on your personal mana stores, not your bionic power."),
    activated_close_ui = true,
    activation_spell = { id = "bio_ley_energy_blaster_spell" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
