local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_microgen",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Microfusion Generator CBM", "Microfusion Generator CBMs"),
    description = ccb.content.text("A miniaturized fusion reactor.  It has modest output, but will run continuously for over two hundred years thanks to its internal nuclear fuel reservoir."),
    mass = "500 g",
    price = "1 kUSD 200 USD",
    survival_price = "15 USD",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "afs_bio_missiles",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Deployable Grenade Launcher CBM", "Deployable Grenade Launcher CBMs"),
    description = ccb.content.text("A small, folding tube that attaches to your right arm.  Once implanted, it can serve as a portable, integrated tool for firing 40mm grenades and canisters."),
    price = "1 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "afs_bio_monowhip",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Monofilament Whip CBM", "Monofilament Whip CBMs"),
    description = ccb.content.text("A carbon nanotube wire covertly installed in your right arm.  When activated, it extends to its full length and can be used to strike enemies both at close and long range."),
    price = "15 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "afs_bio_blood_plus",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Synthblood Biofactory CBM", "Synthblood Biofactory CBMs"),
    description = ccb.content.text("A Mercurial Genomics brand biofactory that replaces the user's blood with a synthetic substitute.  Primarily designed to boost combat performance, it's common among the corporation's own security forces.  The biofactory can't be removed once integrated with a host."),
    survival_price = "15 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "afs_bio_deck",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Military Infolink CBM", "Military Infolink CBMs"),
    description = ccb.content.text("An implanted miniaturized computer isolated from the rest of your systems by military-grade firewalls.  An accompanying jack allows you to interface with external computer systems with minimal risk.  Skill in computers is important, and a failed use may damage your circuits."),
    survival_price = "10 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "afs_bio_beavy_batteries",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("High-Voltage Battery System CBM", "High-Voltage Battery System CBMs"),
    description = ccb.content.text("A high voltage battery port compatible with the power cartridges normally used in military weaponry.  Intended to supplement internally installed power generation and storage."),
    survival_price = "7 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "afs_bio_blood_brain",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Blood Neurology CBM", "Blood Neurology CBMs"),
    description = ccb.content.text("A radical nanite treatment that allows its host's circulatory system to function as a secondary nervous system, greatly increasing their mental acuity and allowing them to survive trauma that would otherwise be fatal.  A cybernetic enhancement of this category is a rare find and could be easily traded for significant favors and resources."),
    survival_price = "475 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "afs_bio_linguistic_coprocessor",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Linguistic Coprocessor CBM", "Linguistic Coprocessor CBMs"),
    description = ccb.content.text("A microcomputer installed into the left hemisphere of your brain to increase the speed that it processes language.  When installed, it provides a passive boost to reading speed."),
    price = "1 kUSD",
    survival_price = "500 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_shock_absorber",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Archeotech Grav Chute CBM", "Archeotech Grav Chute CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Pre-Discontinuity bionic module that was implanted into elite drop troops who could jump from their insertion vehicle during the radar disruption of reentry.  While active, the field will prevent damage to your body from severe impacts, at the cost of impaired movement."),
    price = "100 USD",
    mass = "3000 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_power_storage_salvaged",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Salvaged Power Storage CBM", "Salvaged Power Storage CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A battered and used Compact Bionics Module that upgrades the user's power capacity by 50 kJ.  Having at least one of these is a prerequisite to using powered bionics.  The user will also need a power supply, found in various CBMs."),
    price = "3 kUSD 800 USD",
    mass = "70 g",
    bionic = { difficulty = 1, installation = "AID_bio_power_storage" },
}

ccb.content.define_item {
    id = "afs_bio_dopamine_stimulators",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Dopamine Stimulators CBM", "Dopamine Stimulators CBMs"),
    description = ccb.content.text("A set of tiny bionic nerve stimulators that install into the reward center of your brain.  When run with bionic power, it periodically releases a hit of dopamine and other reward chemicals, inducing a state of euphoria and suppressing fear."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "afs_bio_melee_counteraction",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Counteractive Reflexes CBM", "Counteractive Reflexes CBMs"),
    description = ccb.content.text("Cybernetic stimulators installed across your nervous system boost your reflexes whenever you are hit in melee, granting you an extra action.  This bionic must be active to function."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "afs_bio_blade_fire",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Bioweapon Thermal Conduits", "Bioweapon Thermal Conduits"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An improved ulnar sheath equipped with thermal inductors allows for the super heating of all types of implanted bladed weaponry.  While this bionic is active, any deployed bionic blades will deal additional fire damage to targets."),
    price = "80 USD",
    survival_price = "35 USD",
    mass = "250 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "afs_bio_blade_electric",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Bioweapon Superconductive Channels", "Bioweapon Superconductive Channels"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Paired capacitor banks maintain implanted bladed weaponry under constant electrical charge.  While this bionic is active, any deployed bionic blades will deal additional electric damage with a chance of the damage arcing to other nearby targets."),
    price = "80 USD",
    survival_price = "35 USD",
    mass = "250 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "afs_bio_melee_optimization_unit",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Melee Optimization Unit CBM", "Melee Optimization Unit CBMs"),
    description = ccb.content.text("An implanted AI module calculates the optimal followup to each of your melee strikes, allowing you to chain them with unnatural speed and grace.  This bionic must be active to function."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 10 },
}

ccb.content.define_item {
    id = "afs_bio_neurosoft_aeronautics",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Neurosoft: Aeronautics CBM", "Neurosoft: Aeronautics CBMs"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the operation of flying machines."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "afs_bio_neurosoft_aircraft_mechanic",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Neurosoft: Airframe and Powerplant Mechanic CBM", "Neurosoft: Airframe and Powerplant Mechanic CBMs"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the repair of flying machines."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "afs_bio_cranialbomb",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Cranium Bomb CBM", "Cranium Bomb CBMs"),
    description = ccb.content.text("A bomb installed where your spine meets your brain stem.  It's on a timer from installation and you don't have the codes to reset the timer."),
    price = "0 cent",
    survival_price = "0 cent",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "afs_bio_chemical_enhancement_rig",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Chemical Enhancement Rig and computer CBM", "Chemical Enhancement Rig and computer CBMs"),
    description = ccb.content.text("An implanted AI module and medication dispenser calculates the optimal chemical mix to keep you on your toes and ready for combat.  This bionic must be active to function and while it functions your body is at a heightened performance but if it turns off it will take you several days to get back to normal.  There are a significant number of baseline bonuses granted by this setup but people around will notice your junkie behavior.  This bionic must be active to function."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 9 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_speed_injection",
    copy_from = "bionic_general",
    name = ccb.content.text_without_extraction("Speed Injection System CBM"),
    description = ccb.content.text_without_extraction("Should never be found outside of the chemical enhancement rig, but probably can be uninstalled, there is no point to doing that."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 9 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_healing_injection",
    copy_from = "bionic_general",
    name = ccb.content.text_without_extraction("Pain Suppression Injection System CBM"),
    description = ccb.content.text_without_extraction("Should never be found outside of the chemical enhancement rig, but probably can be uninstalled, there is no point to doing that."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 9 },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "afs_strength_injection",
    copy_from = "bionic_general",
    name = ccb.content.text_without_extraction("Strength Injection System CBM"),
    description = ccb.content.text_without_extraction("Should never be found outside of the chemical enhancement rig, but probably can be uninstalled, there is no point to doing that."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "afs_bio_skullgun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Skullgun CBM", "Skullgun CBMs"),
    description = ccb.content.text("A single shot 10mm gun which implants into the forehead.  It has the shortest time from thought to shot of all bionic guns which makes it popular among street punks for whom every millisecond counts, but this poorly conceived bionic removes a distressing amount of grey matter to make room for it and gives you a concussion every time you fire it."),
    price = "1 kUSD",
    survival_price = "15 USD",
    bionic = { difficulty = 16 },
}

ccb.content.define_item {
    id = "afs_bio_translocator",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Implanted Translocator CBM", "Implanted Translocator CBMs"),
    description = ccb.content.text("An experimental teleportation system carefully weaved into bone marrow and coiled alongside the skeletal system.  It allows its user to safely and readily teleport towards a previously activated telepad."),
    price = "30 kUSD",
    bionic = { difficulty = 16 },
}

ccb.content.define_item {
    id = "bio_cold_absorber",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Emergency Insulation CBM", "Emergency Insulation CBMs"),
    description = ccb.content.text("A system designed to prevent instantaneous frostbite in workers exposed to things like hard vacuum and liquid nitrogen."),
    price = "1 kUSD",
    survival_price = "15 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_shield_weak",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("HawkingCorps Mark I Shield CBM", "HawkingCorps Mark I Shield CBMs"),
    description = ccb.content.text("Imagine a computer inside your body playing pong against the universe.  The paddles are made of -color glass condensate- and any and all of their specific functions are the intellectual property of the Hawking Corporation and/or its local subsidiaries.\n-From the owners manual of HawkingCorps Mark I Shield.\n\nActivating the shield will create an energy shield capable of negating a modest amount of damage from weak or improvised weapons."),
    price = "80 kUSD",
    survival_price = "80 kUSD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_shield_medium",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("HawkingCorps Mark V Shield CBM", "HawkingCorps Mark V Shield CBMs"),
    description = ccb.content.text("Powerful and covert, the Mark V Shield is a military-grade shielding system developed for use within UICA's special service branches.  Although much more effective than anything that could be conceived with current technology, it remains a pale imitation of the Hyperspace Age systems it was reverse-engineered from.\n\nActivating the shield will create an energy barrier capable of withstanding a modest amount of melee and ranged damage."),
    price = "220 kUSD",
    survival_price = "220 kUSD",
    bionic = { difficulty = 10 },
}

ccb.content.define_item {
    id = "bio_shield_heavy",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Kinetic Annulment System CBM", "Kinetic Annulment System CBMs"),
    description = ccb.content.text("A powerful shielding system salvaged from a pre-Discontinuity robotic warframe, crudely adapted for compatibility with biological hosts.  Powerful enough to withstand prolonged assault from anti-vehicle weaponry."),
    price = "1320 kUSD",
    survival_price = "1320 kUSD",
    bionic = { difficulty = 16 },
}
