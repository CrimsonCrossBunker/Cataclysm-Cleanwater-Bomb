local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_shock_absorber",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Kinetic Shock Absorbers CBM", "Kinetic Shock Absorbers CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of hydraulic springs and foldable padding equipped with microgravity offset sensors can be implanted into the flesh of the limbs and upper torso.  While active, these absorbers will negate damage from severe impacts such as falling, at the cost of reducing the user's ability to move effectively."),
    price = "100 USD",
    mass = "3000 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "fcl_bio_neurosoft_aeronautics",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Neurosoft: Aeronautics CBM", "Neurosoft: Aeronautics CBMs"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the operation of flying machines."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "fcl_bio_neurosoft_aircraft_mechanic",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Neurosoft: Airframe and Powerplant Mechanic CBM", "Neurosoft: Airframe and Powerplant Mechanic CBMs"),
    description = ccb.content.text("A brain implant that grants instinctual knowledge about the repair of flying machines."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "fcl_bio_railgun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Railgun CBM", "Railgun CBMs"),
    looks_like = "bio_railgun",
    description = ccb.content.text("EM field generators in the user's arms allow them to launch metallic objects in an unconventional way.  This mechanism requires the projectile to hover briefly in the air in front of an outstretched arm, usually after being thrown up slightly.  Then, at the precise moment, a massive magnetic pulse is released, causing the object to be launched by electrical currents emitted alongside the user's arms, requiring no actual throwing motion.  It consumes a tremendous amount of energy and relies far more on the user's intelligence to control than on physical strength.  In theory, it can even hit with the force of a sniper rifle using nothing more than a coin."),
    price = "2200 USD",
    survival_price = "950 USD",
    mass = "1000 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "fcl_bio_linguistic_coprocessor",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Linguistic Coprocessor CBM", "Linguistic Coprocessor CBMs"),
    description = ccb.content.text("A microcomputer installed into the left hemisphere of your brain to increase the speed that it processes language.  When installed, it provides a passive boost to reading speed."),
    price = "1 kUSD",
    survival_price = "500 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "fcl_bio_dopamine_stimulators",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Dopamine Stimulators CBM", "Dopamine Stimulators CBMs"),
    description = ccb.content.text("A set of tiny bionic nerve stimulators that install into the reward center of your brain.  When run with bionic power, it periodically releases a hit of dopamine and other reward chemicals, inducing a state of euphoria and suppressing fear."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "fcl_bio_deck",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Military Infolink CBM", "Military Infolink CBMs"),
    description = ccb.content.text("An implanted miniaturized computer isolated from the rest of your systems by military-grade firewalls.  An accompanying jack allows you to interface with external computer systems with minimal risk.  Skill in computers is important, and a failed use may damage your circuits."),
    survival_price = "10 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "fcl_bio_missiles",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Deployable Grenade Launcher CBM", "Deployable Grenade Launcher CBMs"),
    description = ccb.content.text("A small, folding tube that attaches to your right arm.  Once implanted, it can serve as a portable, integrated tool for firing 40mm grenades and canisters."),
    price = "1 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "fcl_bio_monowhip",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Monofilament Whip CBM", "Monofilament Whip CBMs"),
    description = ccb.content.text("A carbon nanotube wire covertly installed in your right arm.  When activated, it extends to its full length and can be used to strike enemies both at close and long range."),
    price = "15 kUSD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "fcl_bio_melee_counteraction",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Counteractive Reflexes CBM", "Counteractive Reflexes CBMs"),
    description = ccb.content.text("Cybernetic stimulators installed across your nervous system boost your reflexes whenever you are hit in melee, granting you an extra action.  This bionic must be active to function."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "fcl_bio_melee_optimization_unit",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Melee Optimization Unit CBM", "Melee Optimization Unit CBMs"),
    description = ccb.content.text("An implanted AI module calculates the optimal followup to each of your melee strikes, allowing you to chain them with unnatural speed and grace.  This bionic must be active to function."),
    price = "10 kUSD",
    survival_price = "1 kUSD",
    bionic = { difficulty = 10 },
}

ccb.content.define_item {
    id = "fcl_bio_blood_brain",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Blood Neurology CBM", "Blood Neurology CBMs"),
    description = ccb.content.text("A radical nanite treatment that allows its host's circulatory system to function as a secondary nervous system, greatly increasing their mental acuity and allowing them to survive trauma that would otherwise be fatal.  A cybernetic enhancement of this category is a rare find and could be easily traded for significant favors and resources."),
    survival_price = "475 kUSD",
    bionic = { difficulty = 5 },
}
