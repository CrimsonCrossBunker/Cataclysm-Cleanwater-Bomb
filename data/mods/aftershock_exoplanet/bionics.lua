local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_microgen",
    name = ccb.content.text("Microfusion Generator"),
    description = ccb.content.text("A miniaturized fusion reactor.  It has modest output, but will run continuously for over two hundred years thanks to its internal nuclear fuel reservoir."),
    dupes_allowed = true,
    enchantments = { "BIONIC_ENCH_bio_microgen_0" },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "torso", slots = 6 } },
})
content.add(content.Bionic {
    id = "bio_shock_absorber",
    name = ccb.content.text("Archeotech Grav Chute"),
    description = ccb.content.text("Pre-Discontinuity bionic module that was implanted into elite drop troops who could jump from their insertion vehicle during the radar disruption of reentry.  Clenching your fist allows you to activate what scientists call a grav chute that allows a safe fall; while active, the field will prevent damage to your body from severe impacts, at the cost of impaired movement.  It's best not to think about how many bodies this has been in before yours."),
    activation_energy_millijoules = 2000000,
    over_time_energy_millijoules = 2000000,
    charge_time_turns = 10,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "afs_bio_missiles",
    name = ccb.content.text("Deployable Grenade Launcher"),
    description = ccb.content.text("Your right hand can fold inward to reveal a mechanism capable of igniting and firing 40mm grenades across medium distances."),
    activation_energy_millijoules = 35000,
    fake_weapon = "afs_bionic_rocket",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "NO_UNWIELD" },
    occupied_bodyparts = { { bodypart = "hand_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "afs_bio_monowhip",
    name = ccb.content.text("Monofilament Whip"),
    description = ccb.content.text("A carbon nanotube wire covertly installed in your right arm.  When activated, it extends to its full length and can be used to strike enemies both at close and long range."),
    activation_energy_millijoules = 50000,
    fake_weapon = "afs_bio_whip_weapon",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "arm_r", slots = 4 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "afs_bio_linguistic_coprocessor",
    name = ccb.content.text("Linguistic Coprocessor"),
    description = ccb.content.text("The left hemisphere of your brain has been augmented with a microcomputer that moderately increases the speed that language and written words are processed, granting a 15% increase to reading speed."),
    enchantments = { "BIONIC_ENCH_afs_bio_linguistic_coprocessor_0" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "afs_bio_dopamine_stimulators",
    name = ccb.content.text("Dopamine Stimulators"),
    description = ccb.content.text("Tiny cybernetic stimulators have been installed throughout your ventral tegmental area, and trigger at set intervals using bionic power.  This slowly releases a stream of reward chemicals and hormones into your brain, inducing a state of euphoria that notably elevates mood."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 200,
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY" },
    occupied_bodyparts = { { bodypart = "head", slots = 5 } },
})
content.add(content.Bionic {
    id = "afs_bio_melee_counteraction",
    name = ccb.content.text("Counteractive Reflexes"),
    description = ccb.content.text("Cybernetic stimulators installed across your nervous system boost your reflexes whenever you are hit in melee, granting you an extra action.  This bionic must be active to function."),
    activation_energy_millijoules = 12000000,
    over_time_energy_millijoules = 12000000,
    charge_time_turns = 1,
    enchantments = { "melee_counteraction" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 4 }, { bodypart = "arm_l", slots = 5 }, { bodypart = "arm_r", slots = 5 }, { bodypart = "leg_l", slots = 6 }, { bodypart = "leg_r", slots = 6 } },
})
content.add(content.Bionic {
    id = "afs_bio_blood_plus",
    name = ccb.content.text("Synthetic Marrow"),
    description = ccb.content.text("The interior of your femurs have been scrapped clean, the marrow replaced with a Mercurial brand bio-factory that produces high efficiency blood analogues.  The blood substitutes are fine-tuned for combat, increasing stamina, disease resistance and clotting speed."),
    cant_remove_reason = ccb.content.text("The biofactory has perfectly integrated with your body, removing it would be pointless and potentially fatal."),
    enchantments = { "BIONIC_ENCH_afs_bio_blood_plus_0" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "afs_bio_deck",
    name = ccb.content.text("Military Infolink"),
    description = ccb.content.text("An implanted miniaturized computer isolated from the rest of your systems by military-grade firewalls.  An accompanying jack allows you to interface with external computer systems with minimal risk.  Skill in computers is important, and a failed use may damage your circuits."),
    passive_pseudo_items = { "afs_bio_deck_jack" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "afs_bio_beavy_batteries",
    name = ccb.content.text("High-Voltage Battery System"),
    description = ccb.content.text("A high voltage battery port compatible with the power cartridges normally used in military weaponry.  Intended to supplement internally installed power generation and storage."),
    charge_time_turns = 1,
    fuel_efficiency = 2,
    fuel_options = { "battery" },
    passive_pseudo_items = { "afs_internal_battery_compartment" },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_SHOCKPROOF", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
content.add(content.Bionic {
    id = "afs_bio_blood_brain",
    name = ccb.content.text("Blood Neurology"),
    description = ccb.content.text("Your blood is laced with neuron-analogue nanites, allowing your entire circulatory system to function as a secondary brain.  This radical modification increases your intelligence, reflexes and perception by 4, increases your pain tolerance and allows you to survive brain damage that would otherwise prove fatal."),
    enchantments = { "BIONIC_ENCH_afs_bio_blood_brain_0" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "afs_bio_melee_optimization_unit",
    name = ccb.content.text("Melee Optimization Unit"),
    description = ccb.content.text("An implanted AI module calculates the optimal followup to each of your melee strikes, allowing you to chain them with unnatural speed and grace.  This bionic must be active to function."),
    activation_energy_millijoules = 12000000,
    over_time_energy_millijoules = 12000000,
    charge_time_turns = 1,
    enchantments = { "melee_optimization" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 10 }, { bodypart = "arm_l", slots = 5 }, { bodypart = "arm_r", slots = 5 }, { bodypart = "leg_l", slots = 10 }, { bodypart = "leg_r", slots = 10 } },
})
content.add(content.Bionic {
    id = "bio_power_storage_salvaged",
    name = ccb.content.text("Power Storage, salvaged"),
    description = ccb.content.text("A battered and used Compact Bionics Module that upgrades the user's power capacity by 50 kJ.  Having at least one of these is a prerequisite to using powered bionics.  The user will also need a power supply, found in various CBMs."),
    capacity_energy_millijoules = 50000000,
    dupes_allowed = true,
    flags = { "BIONIC_NPC_USABLE" },
})
content.add(content.Bionic {
    id = "afs_bio_neurosoft_aeronautics",
    name = ccb.content.text("Neurosoft: Aeronautics"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the operation of flying machines."),
    proficiencies = { "prof_helicopter_pilot" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "afs_bio_neurosoft_aircraft_mechanic",
    name = ccb.content.text("Neurosoft: Airframe and Powerplant Mechanic"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the repair of flying machines."),
    proficiencies = { "prof_aircraft_mechanic" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "afs_bio_translocator",
    name = ccb.content.text("Implanted Translocator"),
    description = ccb.content.text("An experimental teleportation system carefully weaved into bone marrow and coiled alongside the skeletal system.  It allows its user to safely and readily teleport towards a previously activated telepad."),
    activation_energy_millijoules = 12000000,
    charge_time_turns = 5,
    activation_spell = { id = "afs_translocation", self = true },
    occupied_bodyparts = { { bodypart = "torso", slots = 10 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "afs_bio_cranialbomb",
    name = ccb.content.text("Cranium Bomb"),
    description = ccb.content.text("You've worked for some nasty people.  People who installed a bomb at the top of your spine.  They are all dead now but there is unfortunately a dead man switch if you don't check in roughly every thirty days.  Those thirty days are almost up but you can't remember exactly how many are left.  You need this out and fast."),
    cant_remove_reason = ccb.content.text("The tamperproof bionic will explode if someone unaware of what it is tries to remove it.  This includes autodocs."),
    enchantments = { "cranial_explosion" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_cold_absorber",
    name = ccb.content.text("Emergency Insulation"),
    description = ccb.content.text("Described in design documents as emergency insulation to protect against exposure to hard vacuum, this CBM is also useful in any encounter that causes instant frostbite."),
    activation_energy_millijoules = 1000000,
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 10,
    enchantments = { "protect_cold" },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "afs_bio_skullgun",
    name = ccb.content.text("Skullgun"),
    description = ccb.content.text("Concealed in your head is a single shot 10mm pistol.  Activate the bionic to fire and reload the skullgun."),
    fake_weapon = "bio_skullgun_gun",
    activated_close_ui = true,
    enchantments = { "BIONIC_ENCH_afs_bio_skullgun_0" },
    canceled_mutations = { "INT_UP", "INT_UP_2", "INT_UP_3", "INT_UP_4", "INT_ALPHA", "SKULLGUN_STUPID" },
    flags = { "BIONIC_GUN" },
    give_mutation_on_removal = { "SKULLGUN_STUPID" },
    occupied_bodyparts = { { bodypart = "head", slots = 5 } },
    encumbrance = { { bodypart = "head", amount = 5 } },
})
