local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_shock_absorber",
    name = ccb.content.text("Kinetic Shock Absorbers"),
    description = ccb.content.text("The flesh in your arms, legs, and upper torso has been implanted with industrial-strength springs and protective padding  equipped with microgravity offset sensors.  Clenching your fist allows you to fold and unfold this padding; while active, the hydraulic absorbers will prevent damage to your body from severe impacts, at the cost of impaired movement."),
    activation_energy_millijoules = 2000000,
    over_time_energy_millijoules = 2000000,
    charge_time_turns = 10,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "fcl_bio_neurosoft_aeronautics",
    name = ccb.content.text("Neurosoft: Aeronautics"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the operation of flying machines."),
    proficiencies = { "prof_helicopter_pilot" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "fcl_bio_neurosoft_aircraft_mechanic",
    name = ccb.content.text("Neurosoft: Airframe and Powerplant Mechanic"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the repair of flying machines."),
    proficiencies = { "prof_aircraft_mechanic" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "fcl_bio_railgun",
    name = ccb.content.text("The Railgun"),
    description = ccb.content.text("EM field generators in the user's arms allow them to launch metallic objects in an unconventional way.  This mechanism requires the projectile to hover briefly in the air in front of an outstretched arm, usually after being thrown up slightly.  Then, at the precise moment, a massive magnetic pulse is released, causing the object to be launched by electrical currents emitted alongside the user's arms, requiring no actual throwing motion.  It consumes a tremendous amount of energy and relies far more on the user's intelligence to control than on physical strength.  In theory, it can even hit with the force of a sniper rifle using nothing more than a coin."),
    activation_energy_millijoules = 1000000,
    over_time_energy_millijoules = 100000,
    trigger_energy_millijoules = 200000000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 }, { bodypart = "torso", slots = 2 }, { bodypart = "arm_r", slots = 10 }, { bodypart = "hand_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "fcl_bio_linguistic_coprocessor",
    name = ccb.content.text("Linguistic Coprocessor"),
    description = ccb.content.text("The left hemisphere of your brain has been augmented with a microcomputer that moderately increases the speed that language and written words are processed, granting a 15% increase to reading speed."),
    enchantments = { "BIONIC_ENCH_fcl_bio_linguistic_coprocessor_0" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "fcl_bio_dopamine_stimulators",
    name = ccb.content.text("Dopamine Stimulators"),
    description = ccb.content.text("Tiny cybernetic stimulators have been installed throughout your ventral tegmental area, and trigger at set intervals using bionic power.  This slowly releases a stream of reward chemicals and hormones into your brain, inducing a state of euphoria that notably elevates mood."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 200,
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY" },
    occupied_bodyparts = { { bodypart = "head", slots = 5 } },
})
content.add(content.Bionic {
    id = "fcl_bio_deck",
    name = ccb.content.text("Military Infolink"),
    description = ccb.content.text("An implanted miniaturized computer isolated from the rest of your systems by military-grade firewalls.  An accompanying jack allows you to interface with external computer systems with minimal risk.  Skill in computers is important, and a failed use may damage your circuits."),
    passive_pseudo_items = { "fcl_bio_deck_jack" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "fcl_bio_missiles",
    name = ccb.content.text("Deployable Grenade Launcher"),
    description = ccb.content.text("Your right hand can fold inward to reveal a mechanism capable of igniting and firing 40mm grenades across medium distances."),
    activation_energy_millijoules = 35000,
    fake_weapon = "fcl_bionic_rocket",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "NO_UNWIELD" },
    occupied_bodyparts = { { bodypart = "hand_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "fcl_bio_monowhip",
    name = ccb.content.text("Monofilament Whip"),
    description = ccb.content.text("A carbon nanotube wire covertly installed in your right arm.  When activated, it extends to its full length and can be used to strike enemies both at close and long range."),
    activation_energy_millijoules = 50000,
    fake_weapon = "fcl_bio_whip_weapon",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "arm_r", slots = 4 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "fcl_bio_melee_counteraction",
    name = ccb.content.text("Counteractive Reflexes"),
    description = ccb.content.text("Cybernetic stimulators installed across your nervous system boost your reflexes whenever you are hit in melee, granting you an extra action.  This bionic must be active to function."),
    activation_energy_millijoules = 12000000,
    over_time_energy_millijoules = 12000000,
    charge_time_turns = 1,
    enchantments = { "fcl_melee_counteraction" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 4 }, { bodypart = "arm_l", slots = 5 }, { bodypart = "arm_r", slots = 5 }, { bodypart = "leg_l", slots = 6 }, { bodypart = "leg_r", slots = 6 } },
})
content.add(content.Bionic {
    id = "fcl_bio_melee_optimization_unit",
    name = ccb.content.text("Melee Optimization Unit"),
    description = ccb.content.text("An implanted AI module calculates the optimal followup to each of your melee strikes, allowing you to chain them with unnatural speed and grace.  This bionic must be active to function."),
    activation_energy_millijoules = 12000000,
    over_time_energy_millijoules = 12000000,
    charge_time_turns = 1,
    enchantments = { "fcl_melee_optimization" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 10 }, { bodypart = "arm_l", slots = 5 }, { bodypart = "arm_r", slots = 5 }, { bodypart = "leg_l", slots = 10 }, { bodypart = "leg_r", slots = 10 } },
})
content.add(content.Bionic {
    id = "fcl_bio_blood_brain",
    name = ccb.content.text("Blood Neurology"),
    description = ccb.content.text("Your blood is laced with neuron-analogue nanites, allowing your entire circulatory system to function as a secondary brain.  This radical modification increases your intelligence, reflexes and perception by 4, increases your pain tolerance and allows you to survive brain damage that would otherwise prove fatal."),
    enchantments = { "BIONIC_ENCH_fcl_bio_blood_brain_0" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
