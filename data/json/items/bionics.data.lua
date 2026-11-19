local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "bionic_general",
    abstract = true,
    category = "bionics",
    name = ccb.content.text_without_extraction("abstract bionic module"),
    mass = "2041 g",
    volume = "2500 ml",
    materials = { "steel", "plastic" },
    symbol = ":",
    color = "yellow",
    survival_price = "10 USD",
    flags = { "CBM", "FRAGILE_MELEE" },
    faults = { { fault = "fault_bionic_salvaged" } },
    bionic = { upgrade = false },
    use_actions = { "install_bionic" },
}

-- NO_I18N
ccb.content.define_item {
    id = "bionic_general_npc_usable",
    abstract = true,
    copy_from = "bionic_general",
    name = ccb.content.text_without_extraction("abstract bionic module (NPC usable)", "abstract bionic modules (NPC usable)"),
    inheritance = { add = { flags = { "BIONIC_NPC_USABLE" } } },
    bionic = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "bionic_general_faulty",
    abstract = true,
    copy_from = "bionic_general",
    name = ccb.content.text_without_extraction("abstract faulty bionic module"),
    price = "0 cent",
    survival_price = "0 cent",
    mass = "500 g",
    description = ccb.content.text("A CBM that is broken beyond repair; you can't do anything with it."),
    bionic = {},
}

ccb.content.define_item {
    id = "bio_adrenaline",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Adrenaline Pump CBM", "Adrenaline Pump CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A stimulator system that is implanted alongside the adrenal glands, allowing the user to trigger their body's adrenaline response at the cost of some bionic power."),
    price = "40 USD",
    survival_price = "50 USD",
    mass = "250 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_ads",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Active Defense System CBM", "Active Defense System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic that projects a thin forcefield around the user's body.  Everything loses velocity when penetrating this field, which results in a reduced amount of dealt damage at the cost of user's bionic energy.  Bullets and stabbing attacks will lose more velocity than cutting attacks, and those in turn more than bashing attacks."),
    price = "9 kUSD 500 USD",
    survival_price = "150 USD",
    mass = "1000 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_alarm",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Alarm System CBM", "Alarm System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A motion-detecting alarm system will notice almost all movement within a fifteen-foot radius, and will silently alert the user.  This is very useful during sleep, or if the user suspects a cloaked pursuer."),
    price = "250 USD",
    survival_price = "20 USD",
    mass = "500 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_ar",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Integrated AR System CBM", "Integrated AR System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This bionic module integrates augmented reality interface into user's eyes."),
    price = "5 kUSD",
    mass = "100 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_armor_arms",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Subcutaneous Protective Mesh - Arms CBM", "Subcutaneous Protective Mesh - Arms CBMs"),
    description = ccb.content.text("An advanced protective mesh that weaves into the user's flesh.  Provides passive protection at the cost of mild encumbrance, and can be used in conjunction with bionic martial arts."),
    price = "3 kUSD 500 USD",
    survival_price = "50 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_armor_eyes",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Protective Lenses CBM", "Protective Lenses CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic package that seals the user's eye sockets with highly-protective mirrored lenses and re-routes their tear ducts to their mouth.  When the user cries, they must spit out or swallow their tears."),
    price = "5 kUSD 500 USD",
    survival_price = "35 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_armor_head",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Subcutaneous Protective Mesh - Head CBM", "Subcutaneous Protective Mesh - Head CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An advanced protective mesh that weaves into the user's flesh, protecting both their head and jaw regions at the cost of mild encumbrance."),
    price = "3 kUSD 500 USD",
    survival_price = "50 USD",
    mass = "1000 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_armor_legs",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Subcutaneous Protective Mesh - Legs CBM", "Subcutaneous Protective Mesh - Legs CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An advanced protective mesh that weaves into the user's flesh.  Provides passive protection at the cost of mild encumbrance, and can be used in conjunction with bionic martial arts."),
    price = "3 kUSD 500 USD",
    survival_price = "50 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_armor_torso",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Subcutaneous Protective Mesh - Torso CBM", "Subcutaneous Protective Mesh - Torso CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An advanced protective mesh that weaves into the user's flesh, protecting it from physical trauma at the cost of mild encumbrance."),
    price = "3 kUSD 500 USD",
    survival_price = "60 USD",
    mass = "3000 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_batteries",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Battery System CBM", "Battery System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A battery draining attachment to make use of the energy contained in normal, everyday batteries."),
    price = "800 USD",
    survival_price = "20 USD",
    mass = "250 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_blade",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Monomolecular Blade CBM", "Monomolecular Blade CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A deadly foot-long blade made of advanced material that is installed inside the forearm, capable of being extended through the back of the user's wrist at the cost of a small amount of power.  Though exceptionally sharp, it will prevent the user from holding anything else while extended."),
    price = "80 USD",
    survival_price = "35 USD",
    mass = "250 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_shotgun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Shotgun Arm CBM", "Shotgun Arm CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A concealed, single shot 12 gauge shotgun that is implanted inside the left forearm.  Perfect in a pinch."),
    price = "2 kUSD 200 USD",
    survival_price = "20 USD",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_blood_anal",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Blood Analysis CBM", "Blood Analysis CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Small sensors that are implanted in the user's heart, allowing them to analyze their blood.  This will detect many illnesses, drugs, and other conditions."),
    price = "3 kUSD 200 USD",
    survival_price = "12 USD",
    mass = "150 g",
    bionic = { difficulty = 2 },
}

ccb.content.define_item {
    id = "bio_blood_filter",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Blood Filter CBM", "Blood Filter CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A filtration system that is installed in the heart and can actively filter out chemical impurities, primarily drugs, with limited impact on viruses.  Note that it is not a targeted filter; ALL drugs in the system will be affected."),
    price = "3 kUSD 500 USD",
    survival_price = "25 USD",
    mass = "200 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_cable",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Cable Charger System CBM", "Cable Charger System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A complex port that is mounted above the hip.  While active, it will recharge bionic power when connected to a battery via jumper cable."),
    price = "800 USD",
    survival_price = "25 USD",
    mass = "250 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_carbon",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Subdermal Carbon Filament CBM", "Subdermal Carbon Filament CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Thin armor made of carbon nanotubes, implanted just beneath the skin.  It reduces cutting, stabbing and ballistic damage."),
    price = "7 kUSD 500 USD",
    survival_price = "50 USD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_chain_lightning",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Chain Lightning CBM", "Chain Lightning CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A chain lightning generator that emits a blast of lightning at a target, leaving a trail of lightning in its wake and jumping to additional targets within 4 tiles of the previous target."),
    price = "2 kUSD 200 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_claws",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Bionic Claws CBM", "Bionic Claws CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of vicious, retractable claws that are implanted inside the user's fingers.  They do considerable cutting damage, but prevent the user from holding anything else while extended."),
    price = "5 kUSD 500 USD",
    survival_price = "30 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_climate",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Internal Climate Control CBM", "Internal Climate Control CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A network of thermal piping which eases the effects of high and low ambient temperatures once activated."),
    price = "3 kUSD 500 USD",
    survival_price = "15 USD",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_cloak",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Cloaking System CBM", "Cloaking System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A high-power system that uses a set of cameras and LEDs to make the user blend into their surroundings, rendering them fully invisible to eyes and optical sensors.  However, this doesn't prevent detection from other means such as infrared, sonar, etc."),
    price = "8 kUSD 500 USD",
    survival_price = "130 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_cqb",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Close Quarters Battle CBM", "Close Quarters Battle CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of bionic processors and databanks, loaded with martial arts combat programs.  While active, the CQB module will improve the user's hand-to-hand combat skills, but prevents them from improving them through combat experience."),
    price = "2 kUSD 200 USD",
    survival_price = "30 USD",
    mass = "250 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_dex_enhancer",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Wired Reflexes CBM", "Wired Reflexes CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of bionic nerve stimulators that greatly enhance reaction times, granting a +2 bonus to dexterity while powered.  However, user will suffer penalties if unpowered."),
    price = "8 kUSD",
    survival_price = "30 USD",
    mass = "500 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_digestion",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Expanded Digestive System CBM", "Expanded Digestive System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This module contains three synthetic stomachs and industrial-grade intestines which replace the user's corresponding organs.  Not only will these extract much more nutrition from food, but also increase the user's resistance to foodborne illness, and occasionally allow the digestion of rotten food.  Installing this CBM will correct any abnormalities in the user's digestive system."),
    price = "5 kUSD 500 USD",
    survival_price = "90 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_ears",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Enhanced Hearing CBM", "Enhanced Hearing CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("While this bionic is active, the user's hearing will be drastically improved, allowing them to hear over three times better than the average person.  Additionally, high-intensity sounds will be automatically dampened before they can damage the user's hearing."),
    mass = "43 g",
    price = "5 kUSD",
    survival_price = "25 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_voice_b",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("AudioVox CBM", "AudioVox CBMs"),
    description = ccb.content.text("An implanted set of vocal cords and speakers allowing the user to remodulate and project their voice at will."),
    mass = "100 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_mp3",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("WearMan CBM", "WearMan CBMs"),
    description = ccb.content.text("A set of speakers implanted into the skull, able to pick up local radiowaves and play downloaded music."),
    mass = "100 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_sonar",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Subaquatic Navigation System CBM", "Subaquatic Navigation System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A tiny device implanted in the inner ear.  When active, it will periodically generate ultrasonic pulses which aid in navigation, provided the user is underwater and able to hear."),
    price = "2 kUSD 500 USD",
    survival_price = "12 USD 50 cent",
    mass = "50 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_emp",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Directional EMP CBM", "Directional EMP CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of small parabolic EMP field generators that are mounted in the palm of the user's right hand.  They can be used to instantly fire a wide, but short-ranged blast which will disable electronics and robots."),
    price = "7 kUSD 200 USD",
    survival_price = "12 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_emp_armgun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("EMP Projector CBM", "EMP Projector CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A ranged EMP generator system that is implanted in the user's right arm and hand.  The system fires precise, single-target pulses that require time to aim.  Extremely effective against electronic targets, but mostly useless otherwise."),
    price = "2 kUSD 200 USD",
    survival_price = "15 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_ethanol",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Ethanol Burner CBM", "Ethanol Burner CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A reactor that burns alcohol as fuel in an extremely efficient reaction.  It can store up to 500 mL and accepts ethanol, methanol and denatured alcohol as fuel."),
    price = "1 kUSD 200 USD",
    survival_price = "20 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_evap",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Aero-Evaporator CBM", "Aero-Evaporator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This unit draws moisture from the surrounding air, which slowly trickles directly into the user's blood stream.  It may fail in very dry environments."),
    price = "5 kUSD 500 USD",
    survival_price = "20 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_eye_enhancer",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Ocular Amplifiers CBM", "Ocular Amplifiers CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of ocular amplifiers which greatly enhance the user's vision, granting a +2 bonus to perception while powered.  However, user will suffer penalties if unpowered."),
    price = "8 kUSD",
    survival_price = "30 USD",
    mass = "100 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_eye_optic",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Telescopic Eyes CBM", "Telescopic Eyes CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An array of high-powered, auto-focusing lenses that replaces much of the material in the user's inner eye.  This fixes any vision problems and allows for an increased vision range akin to binoculars."),
    price = "5 kUSD",
    survival_price = "20 USD",
    mass = "100 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_face_mask",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Facial Distortion CBM", "Facial Distortion CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Through controlled application of electrochemical impulses, this bionic module lets the user alter their facial structure so as to subtly affect the reactions of others.  This grants a bonus to all social interactions."),
    price = "8 kUSD 500 USD",
    survival_price = "10 USD",
    mass = "200 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_faraday",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Dielectric Capacitance System CBM", "Dielectric Capacitance System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A network of miniature piezoelectric capacitors, implanted throughout the user's body to protect from external electrical discharge."),
    price = "50 USD",
    survival_price = "10 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_fingerhack",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Fingerhack CBM", "Fingerhack CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A miniature electrohack, surgically embedded in a finger of the user's right hand.  This is an all-purpose hacking unit used to override control panels and the like, but not computers.  Computer proficiency is important, and a failed use may cause damage."),
    price = "3 kUSD 500 USD",
    survival_price = "10 USD",
    mass = "100 g",
    bionic = { difficulty = 2 },
}

ccb.content.define_item {
    id = "bio_fitnessband",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Calorie Tracker CBM", "Calorie Tracker CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A small medical implant that passively tracks your calorie expenditure and consumption."),
    price = "350 USD",
    survival_price = "5 USD",
    mass = "10 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_flashbang",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Flashbang Generator CBM", "Flashbang Generator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A combination of LEDs and speakers that create a flash and sound comparable to a flashbang grenade, deafening and blinding nearby enemies."),
    price = "7 kUSD 200 USD",
    survival_price = "15 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_flashlight",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Cranial Flashlight CBM", "Cranial Flashlight CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A small, but powerful LED flashlight that is mounted between the user's eyes."),
    price = "200 USD",
    survival_price = "10 USD",
    mass = "250 g",
    bionic = { difficulty = 2 },
}

ccb.content.define_item {
    id = "bio_tattoo_led",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("LED Tattoo CBM", "LED Tattoo CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An LED display implanted beneath the epidermis that can display patterns or pictures through the skin.  When active it glows dimly, providing a very small amount of light."),
    price = "200 USD",
    survival_price = "2 USD 50 cent",
    mass = "20 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_geiger",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Integrated Dosimeter CBM", "Integrated Dosimeter CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of small radiation sensors that are implanted throughout the body, allowing the user to analyze their level of absorbed radiation.  They will also alert the user whenever exposed to environmental radiation."),
    price = "3 kUSD 500 USD",
    survival_price = "30 USD",
    mass = "150 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_gills",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Respirator CBM", "Respirator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A complex respiration augmentation system that increases the user's maximal oxygen uptake and allows for underwater breathing akin to gills.  Will automatically activate if the user is drowning."),
    price = "4 kUSD 500 USD",
    survival_price = "15 USD",
    mass = "700 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_ground_sonar",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Terranian Sonar CBM", "Terranian Sonar CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of precision sonar equipment, implanted in the user's feet to allow the detection of below-ground movement, buried traps, and unstable terrain."),
    price = "4 kUSD 500 USD",
    survival_price = "20 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_heat_absorb",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Heat Drain CBM", "Heat Drain CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("While fighting unarmed against a warm-blooded opponent, there is a chance that a successful hit will drain body heat, inflicting a small amount of extra damage and recharging the user's bionic power reserves slightly."),
    price = "5 kUSD 500 USD",
    survival_price = "10 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_heatsink",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Thermal Dissipation CBM", "Thermal Dissipation CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of powerful heatsinks and supermaterials woven into the user's flesh.  While powered, this system will prevent external heat damage up to 2000 degrees Fahrenheit.  Note that this does not affect the internal body temperature."),
    price = "3 kUSD 500 USD",
    survival_price = "20 USD",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_hydraulics",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Hydraulic Muscles CBM", "Hydraulic Muscles CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A hydraulic muscle support system that, when active, increasing  your strength by 10, with a minimum setting to 20."),
    price = "4 kUSD",
    survival_price = "60 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_infrared",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Infrared Vision CBM", "Infrared Vision CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic module that extends the user's range of vision into the infrared, allowing them to see warm-blooded creatures in the dark and through smoke."),
    price = "4 kUSD 500 USD",
    survival_price = "60 USD",
    mass = "500 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_int_enhancer",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Cerebral Booster CBM", "Cerebral Booster CBMs"),
    description = ccb.content.text("A set of bionic coprocessors that are implanted in the user's brain, granting a +2 bonus to intelligence while powered.  However, user will suffer penalties if unpowered.  It takes over and replaces numerous cognitive functions once installed and cannot be removed."),
    price = "8 kUSD",
    survival_price = "30 USD",
    mass = "100 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_laser",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Finger-Mounted Laser CBM", "Finger-Mounted Laser CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A small, high-powered laser that is embedded in the user's fingertip.  This long-range weapon is not incredibly damaging, but is very accurate, and has the potential to start fires."),
    price = "7 kUSD 200 USD",
    survival_price = "15 USD",
    mass = "500 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_leukocyte",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Leukocyte Breeder System CBM", "Leukocyte Breeder System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of bionic stimulators which augment the user's haematopoiesis system, allowing them to accelerate white blood cell production using bionic power.  It is designed for continuous use and may cause unpleasant side effects when turned off."),
    price = "60 USD",
    survival_price = "20 USD",
    mass = "600 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_lighter",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Finger Lighter CBM", "Finger Lighter CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A pair of powerful fire starters which extend from the tip of both hands' index fingers."),
    price = "1 kUSD 300 USD",
    survival_price = "4 USD",
    mass = "500 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_lockpick",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Fingerpick CBM", "Fingerpick CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An electronic lockpick that is embedded in a fingertip.  This automatic system will quickly unlock all but the most advanced key locks without any skill required on the part of the user."),
    price = "3 kUSD 500 USD",
    survival_price = "15 USD",
    mass = "200 g",
    bionic = { difficulty = 2 },
}

ccb.content.define_item {
    id = "bio_magnet",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Electromagnetic Unit CBM", "Electromagnetic Unit CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A powerful electromagnet that is implanted into the user's right hand, allowing them to indiscriminately pull all nearby magnetic objects towards them.  Unlucky bystanders might be injured or killed by flying objects."),
    price = "2 kUSD",
    survival_price = "4 USD",
    mass = "700 g",
    bionic = { difficulty = 2 },
}

ccb.content.define_item {
    id = "bio_membrane",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Nictitating Membrane CBM", "Nictitating Membrane CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Thin membranes that cover the user's eyes while underwater, negating any vision penalties."),
    price = "4 kUSD 500 USD",
    survival_price = "3 USD",
    mass = "1 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_memory",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Enhanced Memory Banks CBM", "Enhanced Memory Banks CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of highly-advanced quantum storage drives used to enhance memory.  While active, they increase the rate that the user learns skills.  Once it is installed, it will partially replace the functionality of the hippocampus, and thus cannot be removed without risk of severe permanent amnesia and difficulty forming new memories."),
    price = "10 kUSD",
    survival_price = "5 USD",
    mass = "100 g",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_metabolics",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Metabolic Interchange CBM", "Metabolic Interchange CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This module interconnects the user's digestive system and power supply, letting them replenish bionic energy by burning calories."),
    price = "700 USD",
    survival_price = "20 USD",
    mass = "700 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_meteorologist",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Weather Reader CBM", "Weather Reader CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A multitude of scientific instruments and sensors collects environmental data.  The data are compiled and presented as a simple readout of the current weather.  It also passively tells the user their external temperature."),
    price = "3 kUSD 500 USD",
    survival_price = "2 USD",
    mass = "700 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_nanobots",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Repair Nanobots CBM", "Repair Nanobots CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A fleet of tiny, dormant robots.  While activated, they will flit about the user's body, repairing damage and stopping bleeding at the cost of power."),
    price = "9 kUSD 500 USD",
    survival_price = "100 USD",
    mass = "200 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_night",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Artificial Night Generator CBM", "Artificial Night Generator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("When active, this bionic eliminates all light within a 2 tile radius of the user through destructive interference."),
    price = "8 kUSD 500 USD",
    survival_price = "80 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_night_vision",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Implanted Night Vision CBM", "Implanted Night Vision CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This bionic module modifies the user's eyes to amplify existing light, allowing them to see in the dark."),
    price = "9 kUSD",
    survival_price = "40 USD",
    mass = "100 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_ods",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Offensive Defense System CBM", "Offensive Defense System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A thin forcefield gets projected around the user's body, continually draining power.  This field does not deflect attacks, but rather delivers a strong shock, damaging unarmed attackers and those with a conductive weapon."),
    price = "9 kUSD 500 USD",
    survival_price = "45 USD",
    mass = "1000 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_painkiller",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Sensory Dulling CBM", "Sensory Dulling CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This module lets the user's nervous system inhibit pain signals, allowing them to dull their senses at will.  However, the use of this system may cause delayed reaction times and drowsiness."),
    price = "2 kUSD",
    survival_price = "35 USD",
    mass = "300 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_power_storage",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Power Storage CBM", "Power Storage CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A Compact Bionic Module, its shiny metallic casing is covered in stamped markings.  One end has interface ports for connecting other bionics.  Multiple Power Storage units can be implanted - their side connectors allow them to link together into a single power network.\n\nThis module upgrades the user's bionic power capacity by 100 kJ, which is required to use any powered bionics.  It can be recharged via other CBMs that function as power supplies."),
    price = "3 kUSD 800 USD",
    survival_price = "5 USD",
    mass = "70 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_power_storage_mkII",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Power Storage Mk. II CBM", "Power Storage Mk. II CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A Compact Bionic Module, its shiny metallic casing is covered in stamped markings.  One end has interface ports for connecting other bionics.  Multiple Power Storage units can be implanted - their side connectors allow them to link together into a single power network.\n\nThis enhanced version upgrades the user's bionic power capacity by 250 kJ, which is required to use any powered bionics.  It can be recharged via other CBMs that function as power supplies."),
    price = "10 kUSD",
    survival_price = "7 USD 50 cent",
    mass = "50 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_probability_travel",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Probability Travel CBM", "Probability Travel CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Increases the body's wavelength, allowing the user to quantum tunnel through walls, reappearing on the other side.  Power drain in standby is minimal, but each tile tunneled through costs 250 bionic power."),
    price = "14 kUSD",
    survival_price = "40 USD",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_purifier",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Air Filtration System CBM", "Air Filtration System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An advanced filtration system that is implanted in the user's trachea.  If toxins or airborne diseases find their way into the windpipe, the filter will attempt to remove them."),
    price = "4 kUSD 500 USD",
    survival_price = "60 USD",
    mass = "100 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_radio",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Infolink CBM", "Infolink CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A wireless communications device that integrates with the ear canal to enable hands-free communication over radio waves."),
    price = "500 USD",
    survival_price = "10 USD",
    mass = "100 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_radio_pat",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Modified Infolink CBM", "Modified Infolink CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A wireless communications device that integrates with the ear canal to enable hands-free communication over radio waves.  This one has custom software for communicating with your pal Pat."),
    price = "500 USD",
    survival_price = "10 USD",
    flags = { "TRADER_AVOID" },
    mass = "100 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_radscrubber",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Radiation Scrubber System CBM", "Radiation Scrubber System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A system of advanced piezomechanical blood filters that are implanted throughout the body, allowing the user to purge themself of absorbed radiation at the cost of some bionic power."),
    price = "4 kUSD 500 USD",
    survival_price = "75 USD",
    mass = "100 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_razors",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Fingertip Razors CBM", "Fingertip Razors CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of ten double-edged, four centimeter long razor-sharp claws that are implanted underneath the fingernails.  They deal a small amount of unarmed slashing damage whenever the user's fingertips are uncovered."),
    price = "4 kUSD 500 USD",
    survival_price = "5 USD",
    mass = "5 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_fuel_cell_gasoline",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Gasoline Fuel Cell CBM", "Gasoline Fuel Cell CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A small gasoline fuel cell able to convert gasoline to bionic power.  It's connected to a heat exhaust and a diffuse network of bio-plastic bladders able to hold up to 500 mL of gasoline.  When implanted, the system incurs a moderate amount of torso encumbrance."),
    price = "4 kUSD 500 USD",
    survival_price = "20 USD",
    mass = "600 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_recycler",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Recycler Unit CBM", "Recycler Unit CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A series of filters and processors that is implanted in the user's digestive system, allowing them to reclaim waste liquid and, to a lesser degree, nutrients.  The net effect is a greatly reduced need to eat and drink."),
    price = "8 kUSD 500 USD",
    survival_price = "50 USD",
    mass = "1500 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_remote",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Remote Controller CBM", "Remote Controller CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A small module that connects to the user's brain and allows them to interface with nearby devices with wireless capabilities."),
    price = "6 kUSD",
    survival_price = "4 USD",
    mass = "250 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_resonator",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Sonic Resonator CBM", "Sonic Resonator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic module that allows the user's entire body to resonate at very high power, creating a short-range shockwave.  While it will not do much damage to creatures, solid objects such as walls and doors will be damaged."),
    price = "12 kUSD",
    survival_price = "5 USD",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_scent_mask",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Olfactory Mask CBM", "Olfactory Mask CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("While this system is powered, the user's body will produce very little odor, making it nearly impossible for creatures to track them by scent."),
    price = "8 kUSD 500 USD",
    survival_price = "20 USD",
    mass = "1000 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_shock",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Electroshock Unit CBM", "Electroshock Unit CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("While fighting unarmed, or with a weapon that conducts electricity, there is a chance that a successful hit will shock the user's opponent, inflicting extra damage and disabling them temporarily at the cost of some energy."),
    price = "5 kUSD 500 USD",
    survival_price = "5 USD",
    mass = "1000 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_shockwave",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Shockwave Generator CBM", "Shockwave Generator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic module that generates a powerful shockwave, knocking back all nearby creatures.  Targets are stunned briefly, take damage and additional stun upon impact with impassable terrain, and knock back any creatures they collide with."),
    price = "5 kUSD 500 USD",
    survival_price = "25 USD",
    mass = "1000 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_speed",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Synaptic Accelerator CBM", "Synaptic Accelerator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of bionic stimulators that enhance the user's nervous system, granting a 10% boost to speed."),
    price = "100 USD",
    survival_price = "20 USD",
    mass = "400 g",
    bionic = { difficulty = 12 },
}

ccb.content.define_item {
    id = "bio_str_enhancer",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Muscle Augmentation CBM", "Muscle Augmentation CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of myomer fibers that enhance the user's muscular system, granting a +2 bonus to strength while powered.  However, user will suffer penalties if unpowered."),
    price = "8 kUSD",
    survival_price = "30 USD",
    mass = "1500 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_surgical_razor",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Autonomous Surgical Scalpels CBM", "Autonomous Surgical Scalpels CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A system of surgical-grade scalpels that is implanted in the user's fingers.  They allow for automated precise cuts and can be used as a high-quality butchering tool."),
    price = "2 kUSD 200 USD",
    survival_price = "15 USD",
    mass = "20 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_sunglasses",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Anti-Glare Compensators CBM", "Anti-Glare Compensators CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of quick-reacting transition lenses that are installed over the user's eyes.  They negate glare penalties, partially protect from bright flashes, and protect the eyes when welding."),
    price = "4 kUSD 500 USD",
    survival_price = "5 USD",
    mass = "1 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_synlungs",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Synthetic Lungs CBM", "Synthetic Lungs CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Highly efficient synthetic lungs which replace the user's own.  After installation the user's cardio fitness will be greatly increased and will not need regular exercise to maintain but the user will need continuous power to remain breathing.  Further, they will weaken the user's immune system somewhat."),
    price = "8 kUSD",
    survival_price = "80 USD",
    mass = "800 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_targeting",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Targeting System CBM", "Targeting System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic module that contains rangefinders and synchronizes the movement of the user's eyes with their arms, to a degree.  Shots they fire will be much more accurate, particularly at long ranges."),
    price = "6 kUSD 500 USD",
    survival_price = "50 USD",
    mass = "250 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_taser",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Super Stun Gun CBM", "Super Stun Gun CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic stun gun which implants into the hand.  It is highly powerful, able to easily cause electrical burns and cardiac arrest in targets.  The electricity it generates arcs through the air over short distances, making it nearly impossible to miss, but it still requires the user to be nearly adjacent to their target."),
    price = "2 kUSD 500 USD",
    survival_price = "20 USD",
    mass = "100 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_teleport",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Teleportation Unit CBM", "Teleportation Unit CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A highly experimental unit that folds space over short distances, instantly transporting the user's body up to 25 feet in a random direction at the cost of much power.  Note that prolonged or frequent use may have dangerous side effects."),
    price = "7 kUSD",
    survival_price = "100 USD",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_time_freeze",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Time Dilation CBM", "Time Dilation CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("At the cost of all stored bionic power, the user may increase their body speed and reactions dramatically, essentially freezing time.  Violent or rapid movements may cause damage due to friction."),
    price = "14 kUSD",
    survival_price = "150 USD",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_tools",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Integrated Multitool CBM", "Integrated Multitool CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A surgically-implanted set of compact tools and a welder which runs off the user's power banks.  Includes screwdriving heads, a multi-purpose knife, a low-power impact wrench and a nail prying tool."),
    price = "8 kUSD",
    survival_price = "50 USD",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_multimeter",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Integrated Multimeter CBM", "Integrated Multimeter CBMs"),
    looks_like = "bio_tools",
    description = ccb.content.text("A set of electrical leads to be embedded in the user's fingers, connected to a multimeter unit in their hand.  Allows the user to measure voltage, resistance, and current using their fingertips, and provides slight protection against electric shocks."),
    price = "2 kUSD",
    survival_price = "20 USD",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_electrokit",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Integrated Circuitry Toolset CBM", "Integrated Circuitry Toolset CBMs"),
    looks_like = "bio_tools",
    description = ccb.content.text("A soldering iron, multimeter, and set of fine screwdrivers implanted in the user's hands.  Contains all the tools required for manipulating bench-scale electrical circuits, and provides slight protection against electric shocks."),
    price = "4 kUSD",
    survival_price = "35 USD",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_torsionratchet",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Joint Torsion Ratchet CBM", "Joint Torsion Ratchet CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of torsion ratchets that replace the user's joints to slowly generate power when they move.  These can be toggled to generate more power, but movement will require more effort.  This system is actively detrimental to fully mechanical limbs; the additional joint resistance it relies on causes a net loss of bionic power."),
    price = "3 kUSD 800 USD",
    survival_price = "20 USD",
    mass = "1000 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_jointservo",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Joint Servo CBM", "Joint Servo CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of servomotors installed on the leg joints to provide power-assisted movement.  They are optimized for running, but walking also requires less effort while this bionic is active.  However, when it's offline it will hamper the user's movement."),
    price = "4 kUSD 500 USD",
    survival_price = "10 USD",
    mass = "1000 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_uncanny_dodge",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Uncanny Dodge CBM", "Uncanny Dodge CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of bionic processors that augment the user's nervous system, allowing them to dodge attacks beyond normal human capability."),
    price = "9 kUSD 500 USD",
    survival_price = "150 USD",
    mass = "1000 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_ups",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Unified Power System CBM", "Unified Power System CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A Unified Power System that is wired into the user's bionic power banks.  Objects that run on a UPS can now directly draw power from the bionic power supply."),
    price = "250 USD",
    survival_price = "35 USD",
    mass = "700 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_watch",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Internal Chronometer CBM", "Internal Chronometer CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic module containing an atomic clock, complete with a silent alarm clock function."),
    price = "10 USD",
    survival_price = "2 USD",
    mass = "10 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_water_extractor",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Water Extraction Unit CBM", "Water Extraction Unit CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A module containing nanotubes that are embedded in the palm of the user's hand to pump any available fluid out of a dead body, cleanse it of impurities, and convert it into potable water.  Water container not included."),
    price = "5 kUSD 500 USD",
    survival_price = "5 USD",
    mass = "100 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_syringe",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Intravenous Needletip CBM", "Intravenous Needletip CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A small tube with a retractable needle that terminates in a net of tiny hoses instead of a plunger.  When installed, it allows the user to draw substances directly into their bloodstream akin to a regular syringe."),
    price = "10 USD",
    survival_price = "3 USD",
    mass = "10 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_weight",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Titanium Skeletal Bracing CBM", "Titanium Skeletal Bracing CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of hinges, springs, and other synthetic augments for the skeletal structure.  These artificial enhancers strengthen the knees and elbows, allowing the user to carry more weight.  The reinforcement also provides 2 bashing armor to the torso, legs and arms."),
    price = "500 USD",
    survival_price = "15 USD",
    mass = "3000 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_taste_blocker",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Taste Modifier CBM", "Taste Modifier CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A set of highly-sensitive sensors implanted in the user's mouth, combined with a sophisticated analyzer.  While active, it will block all unpleasant taste and texture at the cost of bionic energy."),
    price = "400 USD",
    survival_price = "10 USD",
    mass = "100 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_soporific",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Soporific Induction CBM", "Soporific Induction CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A microscopic electrode designed to gently stimulate a particular cluster of neurons in the hypothalamus, helping the user to fall asleep."),
    price = "3 kUSD 500 USD",
    survival_price = "5 USD",
    mass = "50 g",
    bionic = { difficulty = 2 },
}

ccb.content.define_item {
    id = "bio_ankles",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Squeaky Ankles CBM", "Squeaky Ankles CBMs"),
    description = ccb.content.text("A pair of defective bionics that make squeaking noises."),
    mass = "100 g",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_deformity",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Bionic-Induced Deformity CBM", "Bionic-Induced Deformity CBMs"),
    description = ccb.content.text("A jumble of broken metal pieces that were removed during reconstructive surgery."),
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_dis_acid",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Acidic Discharge CBM", "Acidic Discharge CBMs"),
    description = ccb.content.text("A CBM that has been breached in several places.  Some acid is leaking from it."),
    mass = "700 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_dis_shock",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Electrical Discharge CBM", "Electrical Discharge CBMs"),
    description = ccb.content.text("A formerly-functional CBM that is now a mess of naked wires and burnt resistors."),
    mass = "700 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_drain",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Electrical Drain CBM", "Electrical Drain CBMs"),
    description = ccb.content.text("This CBM was wired incorrectly and would drain power from any system connected to it."),
    mass = "900 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_itchy",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Itchy Metal Thing CBM", "Itchy Metal Thing CBMs"),
    description = ccb.content.text("You can't recognize what this is supposed to be, but you imagine it'd be a very awkward thing to have in one's body."),
    mass = "200 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_glowy",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Glowy Thing CBM", "Glowy Thing CBMs"),
    description = ccb.content.text("It's a… thing?  And it glows, at least it did when it was installed."),
    mass = "5 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_leaky",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Leaky Bionic CBM", "Leaky Bionic CBMs"),
    description = ccb.content.text("A mess of pierced pipes and broken seals, something unpleasant is leaking from it."),
    mass = "600 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_noise",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Noisemaker CBM", "Noisemaker CBMs"),
    description = ccb.content.text("A malfunctioning bionic.  When installed, it occasionally emits a loud burst of noise."),
    mass = "250 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_nostril",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Bionic Nostril CBM", "Bionic Nostril CBMs"),
    description = ccb.content.text("This thing was up someone's nose, they're probably glad to be rid of it."),
    mass = "50 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_pokedeye",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Bionic Visual Impairment CBM", "Bionic Visual Impairment CBMs"),
    description = ccb.content.text("A defective bionic that impairs vision."),
    mass = "100 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_power_weakness",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Power Overload CBM", "Power Overload CBMs"),
    description = ccb.content.text("A bunch of defective power circuits that are prone to short-circuiting."),
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_shakes",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Bionic Short Circuit CBM", "Bionic Short Circuit CBMs"),
    description = ccb.content.text("This bionic is poorly wired and occasionally short-circuits."),
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_sleepy",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Endocrine Enervator CBM", "Endocrine Enervator CBMs"),
    description = ccb.content.text("A malfunctioning bionic that causes sleepiness by altering the unfortunate user's brain chemistry."),
    mass = "100 g",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_synaptic_regen",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Synaptic Regeneration System CBM", "Synaptic Regeneration System CBMs"),
    description = ccb.content.text("An electromagnetic stimulator surgically implanted on the back of the head and along the spine, continually draining power.  As long as it's active, the user will not suffer from sleep deprivation, although they may still feel sleepy; if activated by a user that is already sleep-deprived, it will gradually reduce the symptoms of lacking sleep."),
    price = "100 USD",
    survival_price = "50 USD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_spasm",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Motor Control Overstimulator CBM", "Motor Control Overstimulator CBMs"),
    description = ccb.content.text("The result of poor configuration, this bionic module frequently causes debilitating muscle spasms."),
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_stiff",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Wire-Induced Stiffness CBM", "Wire-Induced Stiffness CBMs"),
    description = ccb.content.text("A length of poorly installed wiring that would cause stiffness."),
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_thumbs",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Self-Locking Thumbs CBM", "Self-Locking Thumbs CBMs"),
    description = ccb.content.text("A pair of faulty, self-locking thumb bionics."),
    mass = "50 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_trip",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Visual Disruptor CBM", "Visual Disruptor CBMs"),
    description = ccb.content.text("A pair of defective ocular bionics that cause visual distortion and pixelation."),
    mass = "100 g",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_voice",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Voice Remodulator CBM", "Voice Remodulator CBMs"),
    description = ccb.content.text("Part of the Autodoc's 'Cyborg Identity Package', this bionic gives the user a creepy robot voice."),
    mass = "100 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_faulty_electromagnetic_leak",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Electromagnetic Leak CBM", "Electromagnetic Leak CBMs"),
    description = ccb.content.text("A broken implant that sends electromagnetic impulses that reduce other implants' capacity to store charge."),
    mass = "100 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_lampoil",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Oil Generator CBM", "Oil Generator CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A CBM that generates power out of kerosene or motor oil.  It is fairly efficient and can store up to 750 mL of fuel, but works somewhat slowly."),
    price = "1 kUSD 200 USD",
    survival_price = "35 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_faulty_grossfood",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Taste Fouler CBM", "Taste Fouler CBMs"),
    description = ccb.content.text("A broken and mis-wired module that would cause food and drink to taste terrible if installed."),
    mass = "100 g",
    bionic = { difficulty = 7 },
}

ccb.content.define_item {
    id = "bio_radleak",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Radioactive Leak CBM", "Radioactive Leak CBMs"),
    description = ccb.content.text("A broken CBM that has been leaking radiation into its user.  The danger seems to have been sealed off during the removal process, but you definitely shouldn't put it back."),
    mass = "100 g",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_recoil",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Recoil Compensators CBM", "Recoil Compensators CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A CBM that contains shock absorbers and kinetic braces which greatly reduce the recoil of guns."),
    price = "6 kUSD 500 USD",
    survival_price = "35 USD",
    mass = "900 g",
    bionic = { difficulty = 5 },
}

ccb.content.define_item {
    id = "bio_sleep_shutdown",
    copy_from = "bionic_general_faulty",
    name = ccb.content.plural_text("Sleep Mode Shutdown CBM", "Sleep Mode Shutdown CBMs"),
    description = ccb.content.text("A CBM that completely shuts down all communication between the user's brain and the rest of their body when they fall asleep, preventing them from waking up under any circumstance until their natural sleep cycle completes.  An inability to trigger its effects manually makes it useless as an anesthesia substitute."),
    mass = "100 g",
    survival_price = "5 USD",
    bionic = { difficulty = 10 },
}

ccb.content.define_item {
    id = "bio_betavoltaic",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Betavoltaic Invidevice CBM", "Betavoltaic Invidevice CBMs"),
    description = ccb.content.text("A small implantable betavoltaic device.  Utilizing nickel-63 radioisotope decay technology and diamond semiconductors, this CBM achieves a stable conversion of nuclear energy into electrical power.  Its power output is very low, at a mere 1W, but it boasts a stable operational lifespan of up to 50 years, requiring neither charging nor maintenance.  Under the current state of the world, its decommissioning age is longer than the lifespan of most ordinary people."),
    mass = "175 g",
    price = "1 kUSD 200 USD",
    survival_price = "15 USD",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_pitch_perfect",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Throwing Assist CBM", "Throwing Assist CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("The culmination of decades of research into hominid palaeoanthropology and biomechanical modeling, the throwing assist CBM was brought to market to revolutionize Beqball tournaments, soon becoming exhibitions of cybernetic human effort and engineering.  A network of neurostimulators and sensors, mostly in the arms and hands, work in tandem with the eyes for a significant increase in throwing accuracy and precision.  When the Exodii came upon this cybernetic enhancement suite, they found it to be an economical way to ensure precise grenade placement in partial cyborgs."),
    price = "2 kUSD 200 USD",
    mass = "1000 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_robofac_xmleg",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Hub 01 XM-LEG Interface", "Hub 01 XM-LEG Interfaces"),
    description = ccb.content.text("Body area sensor networks were developed as unobtrusive, chip-free personalized medical devices, typically in the form of thin adhesive pads.  Hub 01 has adapted this technology into cybernetic implants that allow a neurobionic interface to communicate with external devices.  These implants will allow your neurobionic interface to communicate with Hub 01 Lower Extremity Gaitframes."),
    price = "45 kUSD 500 USD",
    survival_price = "100 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_robofac_xmarm",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Hub 01 XM-ARM Interface", "Hub 01 XM-ARM Interfaces"),
    description = ccb.content.text("Body area sensor networks were developed as unobtrusive, chip-free personalized medical devices, typically in the form of thin adhesive pads.  Hub 01 has adapted this technology into cybernetic implants that allow a neurobionic interface to communicate with external devices.  These implants will allow your neurobionic interface to communicate with Hub 01 Arm Reinforcement Motionframes."),
    price = "45 kUSD 500 USD",
    survival_price = "100 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_robofac_xmback",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Hub 01 XM-BACK Interface", "Hub 01 XM-BACK Interfaces"),
    description = ccb.content.text("Body area sensor networks were developed as unobtrusive, chip-free personalized medical devices, typically in the form of thin adhesive pads.  Hub 01 has adapted this technology into cybernetic implants that allow a neurobionic interface to communicate with external devices.  These implants will allow your neurobionic interface to communicate with Hub 01 Biomechanical Assisted Carrying Kinetoframes."),
    price = "45 kUSD 500 USD",
    survival_price = "100 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_robofac_xmlens",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Hub 01 XM-LENS Interface", "Hub 01 XM-LENS Interfaces"),
    description = ccb.content.text("Body area sensor networks were developed as unobtrusive, chip-free personalized medical devices, typically in the form of thin adhesive pads.  Installing this cybernetic will remove all of the hair on your head, but you'll have the benefit of being able to directly couple your brain to Hub 01 Low-latency ExoNeural Sensory system headgear."),
    price = "4 kUSD 500 USD",
    survival_price = "100 USD",
    bionic = { difficulty = 4 },
}

ccb.content.define_item {
    id = "bio_nl_dimensional_anchor",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Dimensional Anchor CBM", "Dimensional Anchor CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Advanced technology that locks the body into its native dimensionality, protecting from unwanted teleportation and some other phase altering effects."),
    price = "14 kUSD",
    survival_price = "150 USD",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_nl_laser_reader",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Laser-Assisted Reading Device CBM", "Laser-Assisted Reading Device CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("This implant serves as a reading light and a short-distance laser scanner, allowing one to upload digital images of books straight into the brain's optic lobe and language centers.  When active, one can read slightly faster, and can read in the dark."),
    price = "2 kUSD 200 USD",
    mass = "1000 g",
    bionic = { difficulty = 3 },
}

ccb.content.define_item {
    id = "bio_nl_psyshield",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Cranial EMF Shielding CBM", "Cranial EMF Shielding CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A microscopically thin layer of some non-newtonian fluid for skull application.  It can protect from some types of electromagnetic fields.  Is it useful?  Maybe."),
    price = "7 kUSD 500 USD",
    survival_price = "50 USD",
    bionic = { difficulty = 9 },
}

ccb.content.define_item {
    id = "bio_nl_hair",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Artificial Hair CBM", "Artificial Hair CBMs"),
    description = ccb.content.text("Synthetic sphincters that control the extrusion and retraction of advanced nanotube hair technology, made to replace hair follicles, allowing one to control their hair length at will."),
    mass = "100 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_nl_blood_factory",
    copy_from = "bionic_general_npc_usable",
    name = ccb.content.plural_text("Bone Marrow Bio-Factory CBM", "Bone Marrow Bio-Factory CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Specialized nanorobots that increase blood cell production at the cost of stored calories and bionic energy."),
    price = "9 kUSD 500 USD",
    survival_price = "100 USD",
    mass = "200 g",
    bionic = { difficulty = 6 },
}

ccb.content.define_item {
    id = "bio_nl_antigravity_jump",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Antigravity Leap Assist CBM", "Antigravity Leap Assist CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("An antigravity device designed to be implanted into the legs.  While it doesn't allow for real floating or flying, it does facilitate superhuman long jumps."),
    price = "14 kUSD",
    survival_price = "40 USD",
    bionic = { difficulty = 11 },
}

ccb.content.define_item {
    id = "bio_exodii_cyberframe_1a",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Exodii Cyberframe 1a", "Exodii Cyberframe 1a"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bulky Exodii Cyberframe.  Your important internal organs, including much of your core skeleton and musculature, will be encased in a solid metal core.  While there is clearly a head and torso, it is difficult to tell where one starts and the other ends.  It will be difficult or impossible to squeeze through tight spaces, or to wear normal-sized clothing and armor.  The frame greatly increases your physical dexterity and strength, and is highly protective, but the internal parts of your head and torso will still be affected by temperature, you will still feel pain, and internal bleeding can occur with sufficient damage."),
    price = "14 kUSD",
    survival_price = "2000 USD",
    flags = { "TRADER_AVOID" },
    mass = "200000 g",
    volume = "200000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_leg_bionic_basic_armored_left",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Left Leg (Cyberframe 1a)", "Bionic Left Legs (Cyberframe 1a)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic left leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "50000 g",
    volume = "50000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_leg_bionic_basic_armored_right",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Right Leg (Cyberframe 1a)", "Bionic Right Legs (Cyberframe 1a)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic right leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "50000 g",
    volume = "50000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_leg_bionic_treads",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Treads (Cyberframe 1a)", "Bionic Treads (Cyberframe 1a)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("Sturdy treads for replacing legs and feet on an Exodii Cyberframe.  They are in fact two side-by-size triangular mechanisms, split in the middle, and independently operated by telescoping knees, to facilitate lifting one tread at a time for carefully passing over obstacles, or climbing stairs or ladders.  One's former ankles and associated anatomy will be integrated into the servomotors.  Unlike bipedal human legs, these move faster over most terrain, but will severely hinder travel over obstacles and through water.  They are immune to temperature and pain and don't bleed.  While they are highly resistant to damage, their external moving parts are less well protected than a standard bionic leg with similar plate thickness.  Due to their size and heft, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "75000 g",
    volume = "75000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_arm_bionic_basic_armored_left",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Left Arm (Cyberframe 1a)", "Bionic Left Arms (Cyberframe 1a)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic right arm and hand fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "50000 g",
    volume = "50000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_arm_bionic_basic_armored_right",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Right Arm (Cyberframe 1a)", "Bionic Right Arms (Cyberframe 1a)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic right arm and hand fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "50000 g",
    volume = "50000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_cyberframe_1b",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Exodii Cyberframe 1b", "Exodii Cyberframe 1b"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A very human-like Exodii Cyberframe.  Your important internal organs, including much of your core skeleton and musculature, will be encased in a frame that resembles a robotic human.  The frame increases your physical dexterity and strength, and is modestly protective, but the internal parts of your head and torso will still be affected by temperature and feel pain.  Internal bleeding can still occur with sufficient damage."),
    price = "14 kUSD",
    survival_price = "2000 USD",
    flags = { "TRADER_AVOID" },
    mass = "100000 g",
    volume = "100000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_leg_bionic_basic_left",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Left Leg (Cyberframe 1b)", "Bionic Left Legs (Cyberframe 1b)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic left leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "25000 g",
    volume = "25000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_leg_bionic_basic_right",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Right Leg (Cyberframe 1b)", "Bionic Right Legs (Cyberframe 1b)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic right leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "25000 g",
    volume = "25000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_arm_bionic_basic_left",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Left Arm (Cyberframe 1b)", "Bionic Left Arms (Cyberframe 1b)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic right arm and hand fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "25000 g",
    volume = "25000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_exodii_arm_bionic_basic_right",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Bionic Right Arm (Cyberframe 1b)", "Bionic Right Arms (Cyberframe 1b)"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A bionic right arm and hand fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    price = "14 kUSD",
    survival_price = "200 USD",
    mass = "25000 g",
    volume = "25000 ml",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_nl_collar",
    copy_from = "bionic_general_faulty",
    materials = { "nanotubes", "cyber_bone" },
    name = ccb.content.plural_text("Cyberbone Collar CBM", "Cyberbone Collar CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A subdermal bone-like implant fit for the nape of the neck, with a mysterious nanotube sheet that ensheaths the throat."),
    price = "0 kUSD",
    survival_price = "0 USD",
    mass = "100 g",
    bionic = { difficulty = 1 },
}

ccb.content.define_item {
    id = "bio_nl_collar_deactivated",
    copy_from = "bionic_general_faulty",
    materials = { "nanotubes", "cyber_bone" },
    name = ccb.content.plural_text("Cyberbone Collar CBM", "Cyberbone Collar CBMs"),
    looks_like = "bio_int_enhancer",
    description = ccb.content.text("A subdermal bone-like implant fit for the nape of the neck, with a mysterious nanotube sheet that ensheaths the throat."),
    price = "0 kUSD",
    survival_price = "0 USD",
    mass = "100 g",
    bionic = { difficulty = 1 },
}
