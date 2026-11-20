local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_ads",
    name = ccb.content.text("Active Defense System"),
    description = ccb.content.text("A thin forcefield surrounds your body, continually draining power.  Everything loses velocity when penetrating this field, which results in reduced amount of dealt damage at the cost of your bionic energy.  Bullets and stabbing attacks will lose more velocity than cutting attacks and those in turn more than bashing attacks."),
    activation_energy_millijoules = 1000000,
    over_time_energy_millijoules = 1000000,
    trigger_energy_millijoules = 10000000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 10 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_alarm",
    name = ccb.content.text("Alarm System"),
    description = ccb.content.text("A motion-detecting alarm system will notice almost all movement within a fifteen-foot radius, and will silently alert you.  This is very useful during sleep, or if you suspect a cloaked pursuer."),
    activation_energy_millijoules = 1000,
    over_time_energy_millijoules = 1000,
    trigger_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_alarm_0" },
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 }, { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_ankles",
    name = ccb.content.text("Squeaky Ankles"),
    description = ccb.content.text("In a cruel twist of fate, a poorly executed CBM surgery has given you a pair of useless bionics which make squeaking noises when you walk."),
    enchantments = { "SQUEAKY_ANKLES" },
    flags = { "BIONIC_FAULTY" },
    mutation_conflicts = { "LEG_TENTACLES", "LEG_TENT_BRACE", "GASTROPOD_FOOT", "GASTROPOD_BALANCE", "AMORPHOUS" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_ar",
    name = ccb.content.text("Integrated AR System"),
    description = ccb.content.text("Extremely thin lenses provide user with augmented reality overlay allowing the user to zoom, and it displays handy information about local topology."),
    passive_pseudo_items = { "integrated_ar" },
    flags = { "USES_BIONIC_POWER" },
    mutation_conflicts = { "COMPOUND_EYES", "CEPH_VISION", "CEPH_EYES", "EYEBULGE", "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_armor_arms",
    name = ccb.content.text("Subcutaneous Protective Mesh - Arms"),
    description = ccb.content.text("An advanced protective meshwork has been woven into the flesh on your arms and hands, protecting them from physical trauma."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "BENDY2", "BENDY3", "WINGS_BIRD", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK", "WINGS_BAT", "INSECT_ARMS", "INSECT_ARMS_OK", "ARACHNID_ARMS", "ARACHNID_ARMS_OK", "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8", "CLAWS_TENTACLE", "BIONIC_ARM_BASIC_LEFT", "BIONIC_ARM_BASIC_RIGHT", "BIONIC_ARM_BASIC_BOTH" },
    protection = { { bodypart = "arm_l", damage_type = "bash", amount = 3 }, { bodypart = "arm_l", damage_type = "cut", amount = 3 }, { bodypart = "arm_l", damage_type = "bullet", amount = 3 }, { bodypart = "arm_l", damage_type = "stab", amount = 3 }, { bodypart = "arm_r", damage_type = "bash", amount = 3 }, { bodypart = "arm_r", damage_type = "cut", amount = 3 }, { bodypart = "arm_r", damage_type = "bullet", amount = 3 }, { bodypart = "arm_r", damage_type = "stab", amount = 3 }, { bodypart = "hand_l", damage_type = "bash", amount = 3 }, { bodypart = "hand_l", damage_type = "cut", amount = 3 }, { bodypart = "hand_l", damage_type = "bullet", amount = 3 }, { bodypart = "hand_l", damage_type = "stab", amount = 3 }, { bodypart = "hand_r", damage_type = "bash", amount = 3 }, { bodypart = "hand_r", damage_type = "cut", amount = 3 }, { bodypart = "hand_r", damage_type = "bullet", amount = 3 }, { bodypart = "hand_r", damage_type = "stab", amount = 3 } },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 4 }, { bodypart = "arm_r", slots = 4 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
    encumbrance = { { bodypart = "arm_l", amount = 1 }, { bodypart = "arm_r", amount = 1 }, { bodypart = "hand_l", amount = 1 }, { bodypart = "hand_r", amount = 1 } },
})
content.add(content.Bionic {
    id = "bio_armor_eyes",
    name = ccb.content.text("Protective Lenses"),
    description = ccb.content.text("Your eye sockets have been surgically sealed with highly protective mirrored lenses and your tear ducts have been re-routed to your mouth.  When you cry, you must spit out or swallow your tears."),
    social_modifiers = { intimidate = 10 },
    passive_pseudo_items = { "armor_bio_eyes" },
    mutation_conflicts = { "COMPOUND_EYES", "CEPH_VISION", "CEPH_EYES", "EYEBULGE", "MEMBRANE", "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_armor_head",
    name = ccb.content.text("Subcutaneous Protective Mesh - Head"),
    description = ccb.content.text("An advanced protective meshwork has been woven into the flesh on your head and jaw region, protecting your skull from physical trauma."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK" },
    protection = { { bodypart = "head", damage_type = "bash", amount = 3 }, { bodypart = "head", damage_type = "cut", amount = 3 }, { bodypart = "head", damage_type = "bullet", amount = 3 }, { bodypart = "head", damage_type = "stab", amount = 3 }, { bodypart = "mouth", damage_type = "bash", amount = 3 }, { bodypart = "mouth", damage_type = "cut", amount = 3 }, { bodypart = "mouth", damage_type = "bullet", amount = 3 }, { bodypart = "mouth", damage_type = "stab", amount = 3 } },
    occupied_bodyparts = { { bodypart = "head", slots = 3 }, { bodypart = "mouth", slots = 1 } },
    encumbrance = { { bodypart = "head", amount = 1 } },
})
content.add(content.Bionic {
    id = "bio_armor_legs",
    name = ccb.content.text("Subcutaneous Protective Mesh - Legs"),
    description = ccb.content.text("An advanced protective meshwork has been woven into the flesh on your legs and feet, protecting them from physical trauma."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "BENDY2", "BENDY3", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK", "LEG_TENTACLES", "LEG_TENT_BRACE", "GASTROPOD_FOOT", "GASTROPOD_BALANCE", "INSECT_RESERVOIR", "BIONIC_LEG_BASIC_LEFT", "BIONIC_LEG_BASIC_RIGHT", "BIONIC_LEG_BASIC_BOTH" },
    protection = { { bodypart = "leg_l", damage_type = "bash", amount = 3 }, { bodypart = "leg_l", damage_type = "cut", amount = 3 }, { bodypart = "leg_l", damage_type = "bullet", amount = 3 }, { bodypart = "leg_l", damage_type = "stab", amount = 3 }, { bodypart = "leg_r", damage_type = "bash", amount = 3 }, { bodypart = "leg_r", damage_type = "cut", amount = 3 }, { bodypart = "leg_r", damage_type = "bullet", amount = 3 }, { bodypart = "leg_r", damage_type = "stab", amount = 3 }, { bodypart = "foot_l", damage_type = "bash", amount = 3 }, { bodypart = "foot_l", damage_type = "cut", amount = 3 }, { bodypart = "foot_l", damage_type = "bullet", amount = 3 }, { bodypart = "foot_l", damage_type = "stab", amount = 3 }, { bodypart = "foot_r", damage_type = "bash", amount = 3 }, { bodypart = "foot_r", damage_type = "cut", amount = 3 }, { bodypart = "foot_r", damage_type = "bullet", amount = 3 }, { bodypart = "foot_r", damage_type = "stab", amount = 3 } },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 6 }, { bodypart = "leg_r", slots = 6 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
    encumbrance = { { bodypart = "leg_l", amount = 1 }, { bodypart = "leg_r", amount = 1 }, { bodypart = "foot_l", amount = 1 }, { bodypart = "foot_r", amount = 1 } },
})
content.add(content.Bionic {
    id = "bio_armor_torso",
    name = ccb.content.text("Subcutaneous Protective Mesh - Torso"),
    description = ccb.content.text("An advanced protective meshwork has been woven into the flesh on your torso, protecting it from physical trauma."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK", "INSECT_RESERVOIR" },
    protection = { { bodypart = "torso", damage_type = "bash", amount = 3 }, { bodypart = "torso", damage_type = "cut", amount = 3 }, { bodypart = "torso", damage_type = "bullet", amount = 3 }, { bodypart = "torso", damage_type = "stab", amount = 3 } },
    occupied_bodyparts = { { bodypart = "torso", slots = 10 } },
    encumbrance = { { bodypart = "torso", amount = 1 } },
})
content.add(content.Bionic {
    id = "bio_batteries",
    name = ccb.content.text("Battery System"),
    description = ccb.content.text("You have a battery draining attachment, and thus can make use of the energy contained in normal, everyday batteries.  Use bionic menu to drain charge from a battery.  Can be toggled on and off at will."),
    charge_time_turns = 1,
    fuel_efficiency = 1,
    fuel_options = { "battery" },
    passive_pseudo_items = { "internal_battery_compartment" },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
content.add(content.Bionic {
    id = "bio_blade",
    name = ccb.content.text("Monomolecular Blade"),
    description = ccb.content.text("A deadly foot-long blade made of advanced material now resides inside your forearm, capable of being extended through the back of your wrist at the cost of a small amount of power.  Though exceptionally sharp, it will prevent you from holding anything else while extended."),
    activation_energy_millijoules = 50000,
    fake_weapon = "bio_blade_weapon",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "arm_r", slots = 7 }, { bodypart = "hand_r", slots = 1 } },
    encumbrance = { { bodypart = "arm_r", amount = 2 } },
})
content.add(content.Bionic {
    id = "bio_shotgun",
    name = ccb.content.text("Shotgun Arm"),
    description = ccb.content.text("Concealed in your left arm is a single shot 12 gauge shotgun.  Activate the bionic to fire and reload the shotgun."),
    activation_energy_millijoules = 50000,
    fake_weapon = "bio_shotgun_gun",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "NO_UNWIELD" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 12 } },
    encumbrance = { { bodypart = "arm_l", amount = 5 } },
})
content.add(content.Bionic {
    id = "bio_blindfold",
    name = ccb.content.text("Optical Dampers"),
    description = ccb.content.text("A pair of lenses surgically installed over your eyes that can be tinted to block out incoming light."),
    included = true,
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BLIND" },
})
content.add(content.Bionic {
    id = "bio_blood_anal",
    name = ccb.content.text("Blood Analysis"),
    description = ccb.content.text("Small sensors have been surgically implanted in your heart, allowing you to analyze your blood.  This will detect many illnesses, drugs, and other conditions."),
    activation_energy_millijoules = 100000,
    occupied_bodyparts = { { bodypart = "torso", slots = 4 } },
})
content.add(content.Bionic {
    id = "bio_cable",
    name = ccb.content.text("Cable Charger System"),
    description = ccb.content.text("You have a complex port surgically mounted above your hip.  While active, it will recharge bionic power when connected to a power source via jumper cable."),
    charge_time_turns = 1,
    fuel_efficiency = 1,
    is_remote_fueled = true,
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_SHOCKPROOF", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 7 } },
})
content.add(content.Bionic {
    id = "bio_carbon",
    name = ccb.content.text("Subdermal Carbon Filament"),
    description = ccb.content.text("Lying just beneath your skin is a thin armor made of carbon nanotubes.  This has no impact on blunt trauma but will protect you against deep cuts."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    protection = { { bodypart = "torso", damage_type = "cut", amount = 4 }, { bodypart = "torso", damage_type = "bullet", amount = 4 }, { bodypart = "torso", damage_type = "stab", amount = 4 }, { bodypart = "head", damage_type = "cut", amount = 4 }, { bodypart = "head", damage_type = "bullet", amount = 4 }, { bodypart = "head", damage_type = "stab", amount = 4 }, { bodypart = "mouth", damage_type = "cut", amount = 4 }, { bodypart = "mouth", damage_type = "bullet", amount = 4 }, { bodypart = "mouth", damage_type = "stab", amount = 4 }, { bodypart = "arm_l", damage_type = "cut", amount = 4 }, { bodypart = "arm_l", damage_type = "bullet", amount = 4 }, { bodypart = "arm_l", damage_type = "stab", amount = 4 }, { bodypart = "arm_r", damage_type = "cut", amount = 4 }, { bodypart = "arm_r", damage_type = "bullet", amount = 4 }, { bodypart = "arm_r", damage_type = "stab", amount = 4 }, { bodypart = "leg_l", damage_type = "cut", amount = 4 }, { bodypart = "leg_l", damage_type = "bullet", amount = 4 }, { bodypart = "leg_l", damage_type = "stab", amount = 4 }, { bodypart = "leg_r", damage_type = "cut", amount = 4 }, { bodypart = "leg_r", damage_type = "bullet", amount = 4 }, { bodypart = "leg_r", damage_type = "stab", amount = 4 }, { bodypart = "foot_l", damage_type = "cut", amount = 4 }, { bodypart = "foot_l", damage_type = "bullet", amount = 4 }, { bodypart = "foot_l", damage_type = "stab", amount = 4 }, { bodypart = "foot_r", damage_type = "cut", amount = 4 }, { bodypart = "foot_r", damage_type = "bullet", amount = 4 }, { bodypart = "foot_r", damage_type = "stab", amount = 4 }, { bodypart = "hand_l", damage_type = "cut", amount = 4 }, { bodypart = "hand_l", damage_type = "bullet", amount = 4 }, { bodypart = "hand_l", damage_type = "stab", amount = 4 }, { bodypart = "hand_r", damage_type = "cut", amount = 4 }, { bodypart = "hand_r", damage_type = "bullet", amount = 4 }, { bodypart = "hand_r", damage_type = "stab", amount = 4 } },
    occupied_bodyparts = { { bodypart = "torso", slots = 6 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_chain_lightning",
    name = ccb.content.text("Chain Lightning"),
    description = ccb.content.text("Your body is equipped with a chain lightning generator, allowing you to emit a blast of lightning at a target, leaving a trail of lightning in its wake, jumping to additional targets within 4 tiles of the previous target."),
    fake_weapon = "bio_lightning",
    flags = { "BIONIC_GUN", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 16 }, { bodypart = "arm_l", slots = 4 } },
})
content.add(content.Bionic {
    id = "bio_claws",
    name = ccb.content.text("Bionic Claws"),
    description = ccb.content.text("Vicious claws have been surgically installed inside your fingers, allowing you to extend and retract them at the cost of a small amount of power.  These do considerable cutting damage, but prevent you from holding anything else while extended."),
    activation_energy_millijoules = 25000,
    fake_weapon = "bio_claws_weapon",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON", "BIONIC_NPC_USABLE" },
    mutation_conflicts = { "BENDY3", "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8", "CLAWS_TENTACLE", "TALONS", "CLAWS", "CLAWS_RETRACT", "CLAWS_RAT", "CLAWS_ST" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 4 }, { bodypart = "hand_r", slots = 4 } },
    encumbrance = { { bodypart = "hand_l", amount = 3 }, { bodypart = "hand_r", amount = 3 } },
})
content.add(content.Bionic {
    id = "bio_climate",
    name = ccb.content.text("Internal Climate Control"),
    description = ccb.content.text("Throughout your body lies a network of thermal piping, which eases the effects of high and low ambient temperatures when activated."),
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 100000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_climate_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_cloak",
    name = ccb.content.text("Cloaking System"),
    description = ccb.content.text("This high-power system uses a set of cameras and LEDs to make you blend into your background, rendering you fully invisible to normal vision.  However, you may be detected by infrared, sonar, etc."),
    activation_energy_millijoules = 30000000,
    over_time_energy_millijoules = 30000000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_cloak_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 4 }, { bodypart = "leg_r", slots = 4 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_cqb",
    name = ccb.content.text("Close Quarters Battle"),
    description = ccb.content.text("Bionic processors and databanks, loaded with martial arts combat programs, are surgically integrated into your nervous system.  While active, the CQB module will improve your hand-to-hand combat skills, but prevents you from improving them through combat experience."),
    activation_energy_millijoules = 20000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 1,
    martial_arts = { "style_aikido", "style_barbaran", "style_biojutsu", "style_bojutsu", "style_boxing", "style_capoeira", "style_crane", "style_dragon", "style_eskrima", "style_fencing", "style_judo", "style_karate", "style_kickboxing", "style_krav_maga", "style_leopard", "style_medievalpole", "style_muay_thai", "style_ninjutsu", "style_niten", "style_pankration", "style_silat", "style_snake", "style_sojutsu", "style_swordsmanship", "style_taekwondo", "style_tai_chi", "style_tiger", "style_wingchun", "style_zui_quan" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_deformity",
    name = ccb.content.text("Bionic-Induced Deformity"),
    description = ccb.content.text("A combination of poor surgical installation and unpleasant scarring has lead to the malfunctioning bionic catastrophe you call your face.  People who mind that you look like a dime-store Frankenstein will react poorly to your appearance."),
    social_modifiers = { persuade = -50, intimidate = 20 },
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "head", slots = 4 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_dex_enhancer",
    name = ccb.content.text("Wired Reflexes"),
    description = ccb.content.text("Your reaction time has been greatly enhanced with bionic nerve stimulators, giving you a +2 bonus to dexterity while powered.  However, you will suffer penalties while unpowered."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_dex_enhancer_0", "BIONIC_ENCH_bio_dex_enhancer_1" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 3 }, { bodypart = "torso", slots = 6 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "leg_l", slots = 7 }, { bodypart = "leg_r", slots = 7 } },
})
content.add(content.Bionic {
    id = "bio_digestion",
    name = ccb.content.text("Expanded Digestive System"),
    description = ccb.content.text("You have been outfitted with three synthetic stomachs and industrial-grade intestines.  Not only can you extract much more nutrition from food, but you are highly resistant to foodborne illness, and can sometimes eat rotten food."),
    cant_remove_reason = ccb.content.text("The CBM has replaced the patient's digestive organs and cannot be removed."),
    enchantments = { "BIONIC_ENCH_bio_digestion_0" },
    canceled_mutations = { "WEAKSTOMACH", "STRONGSTOMACH", "TINYSTOMACH", "CARNIVORE", "HERBIVORE", "ANTIJUNK", "ANTIFRUIT", "RUMINANT", "ANTIWHEAT", "NAUSEA", "VOMITOUS", "EATPOISON", "EATDEAD", "ALCMET", "SAPROVORE", "LACTOSE", "GRAZER", "VEGETARIAN" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF", "PARAIMMUNE", "IMMUNE_SPOIL" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
content.add(content.Bionic {
    id = "bio_dis_acid",
    name = ccb.content.text("Acidic Discharge"),
    description = ccb.content.text("A malfunctioning bionic which occasionally discharges acid into your muscles, causing sharp pain and minor damage."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 3 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_dis_shock",
    name = ccb.content.text("Electrical Discharge"),
    description = ccb.content.text("A malfunctioning bionic which occasionally discharges electricity through your body, causing pain and brief paralysis but no damage."),
    trigger_energy_millijoules = 10000000,
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 6 } },
})
content.add(content.Bionic {
    id = "bio_drain",
    name = ccb.content.text("Electrical Drain"),
    description = ccb.content.text("A malfunctioning bionic.  It doesn't perform any useful function, but will occasionally draw power from your batteries."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_earplugs",
    name = ccb.content.text("Sound Dampeners"),
    description = ccb.content.text("When this bionic is active, you can block hearing completely."),
    included = true,
    auto_deactivated_bionics = { "bio_ears" },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "DEAF" },
})
content.add(content.Bionic {
    id = "bio_ears",
    name = ccb.content.text("Enhanced Hearing"),
    description = ccb.content.text("When this bionic is active, your hearing will be drastically improved, allowing you to hear over three times better than the average person.  Additionally, high-intensity sounds will be automatically dampened before they can damage your hearing."),
    activation_energy_millijoules = 400,
    over_time_energy_millijoules = 400,
    charge_time_turns = 1,
    activated_on_install = true,
    enchantments = { "BIONIC_ENCH_bio_ears_0" },
    included_bionics = { "bio_earplugs" },
    auto_deactivated_bionics = { "bio_earplugs" },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "SAFECRACK_NO_TOOL", "IMMUNE_HEARING_DAMAGE" },
    mutation_conflicts = { "BATEARS" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_voice_b",
    name = ccb.content.text("AudioVox"),
    description = ccb.content.text("Hailing from a world choked with neon smog, and appreciated by Exodii artists, the AudioVox implant allows you to change, remodulate, and even autotune your voice.  It also causes vocalizations (such as shouts and singing) to be much louder.  It consists of an electronic voice box, synthetic larynx and multiple speakers implanted throughout your throat."),
    enchantments = { "BIONIC_ENCH_bio_voice_b_0" },
    canceled_mutations = { "GROWL", "SNARL", "HISS", "CROAK", "BOOMING_VOICE" },
    mutation_conflicts = { "SCREECH" },
    occupied_bodyparts = { { bodypart = "torso", slots = 3 }, { bodypart = "mouth", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_emp",
    name = ccb.content.text("Directional EMP"),
    description = ccb.content.text("Surgically mounted in your left arm and the palm of your left hand are small parabolic EMP field generators.  You may use power to fire a wide but short-ranged blast that will disable electronics and robots."),
    activation_energy_millijoules = 50000000,
    occupied_bodyparts = { { bodypart = "arm_l", slots = 6 }, { bodypart = "hand_l", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_emp_armgun",
    name = ccb.content.text("EMP Projector"),
    description = ccb.content.text("A ranged EMP generator system is implanted in your right arm and the palm of your right hand.  The system fires precise, single-target pulses that require time to aim.  Extremely effective against electronic targets but mostly useless otherwise."),
    fake_weapon = "bio_emp_gun",
    flags = { "BIONIC_GUN" },
    occupied_bodyparts = { { bodypart = "arm_r", slots = 8 }, { bodypart = "hand_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_evap",
    name = ccb.content.text("Aero-Evaporator"),
    description = ccb.content.text("This unit draws moisture from the surrounding air, which slowly trickles directly into your blood stream.  It may fail in very dry environments."),
    over_time_energy_millijoules = 60000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 } },
})
content.add(content.Bionic {
    id = "bio_eye_enhancer",
    name = ccb.content.text("Ocular Amplifiers"),
    description = ccb.content.text("Your vision is greatly enhanced, giving you a +2 bonus to perception while powered.  However, you suffer penalties while unpowered."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_eye_enhancer_0", "BIONIC_ENCH_bio_eye_enhancer_1" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_eye_optic",
    name = ccb.content.text("Telescopic Eyes"),
    description = ccb.content.text("Much of the material in your inner eye has been surgically removed and replaced with an array of high-powered, auto-focusing lenses.  They function as integrated binoculars, letting you see much farther than before, and any vision problems you might have had are now gone."),
    cant_remove_reason = ccb.content.text("The CBM has completely replaced %1$s eyes now.  Removing them would leave %2$s blind."),
    canceled_mutations = { "HYPEROPIC", "MYOPIC", "MESOPIC", "URSINE_EYE", "FROG_EYES", "NIGHTVISION3", "NIGHTVISION2", "NIGHTVISION", "BIRD_EYE", "COMPOUND_EYES", "LIZ_IR", "CEPH_VISION", "CEPH_EYES", "ELFA_FNV", "ELFA_NV", "ELFAEYES", "FEL_NV", "FEL_EYE", "INFRARED", "LIZ_EYE", "EYEBULGE", "SEESLEEP", "INTERSTICEEYES" },
    flags = { "ENHANCED_VISION" },
    mutation_conflicts = { "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_face_mask",
    name = ccb.content.text("Facial Distortion"),
    description = ccb.content.text("Through controlled application of electrochemical impulses, you are capable of altering your facial structure so as to subtly affect the reactions of others.  This grants a bonus to all social interactions."),
    social_modifiers = { lie = 20, persuade = 10, intimidate = 10 },
    occupied_bodyparts = { { bodypart = "head", slots = 3 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_faraday",
    name = ccb.content.text("Dielectric Capacitance System"),
    description = ccb.content.text("Throughout your body lies a network of miniature piezoelectric capacitors which can be charged with bionic power to temporarily protect you from external electrical discharge."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    active_flags = { "ELECTRIC_IMMUNE", "EMP_ENERGYDRAIN_IMMUNE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_fingerhack",
    name = ccb.content.text("Fingerhack"),
    description = ccb.content.text("One of your fingers has an electrohack surgically embedded in it; an all-purpose hacking unit used to override control panels and the like (but not computers).  Skill in computers is important, and a failed use may damage your circuits."),
    toggled_pseudo_items = { "electrohack" },
    flags = { "BIONIC_TOGGLED", "USES_BIONIC_POWER" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_fitnessband",
    name = ccb.content.text("Calorie Tracker"),
    description = ccb.content.text("A module implanted in your body measures your calorie intake and expenditure at all times."),
    flags = { "CALORIE_BURN" },
    occupied_bodyparts = { { bodypart = "torso", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_flashbang",
    name = ccb.content.text("Flashbang Generator"),
    description = ccb.content.text("Light emitting diodes surgically integrated into your skin can release a flash comparable to a flashbang grenade, blinding nearby enemies.  Speakers integrated into your body mimic the loud sound, deafening those nearby."),
    activation_energy_millijoules = 10000000,
    occupied_bodyparts = { { bodypart = "torso", slots = 18 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_flashlight",
    name = ccb.content.text("Cranial Flashlight"),
    description = ccb.content.text("Surgically mounted between your eyes is a small but powerful LED flashlight."),
    activation_energy_millijoules = 500,
    over_time_energy_millijoules = 500,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_flashlight_0" },
    included_bionics = { "bio_flashlight_highmode" },
    auto_deactivated_bionics = { "bio_flashlight_highmode" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_flashlight_highmode",
    name = ccb.content.text("Ultrabright Flashlight"),
    description = ccb.content.text("You can greatly intensify the power of your bionic flashlight to be much brighter at a much higher power cost."),
    activation_energy_millijoules = 4000,
    over_time_energy_millijoules = 4000,
    charge_time_turns = 1,
    included = true,
    enchantments = { "BIONIC_ENCH_bio_flashlight_highmode_0" },
    auto_deactivated_bionics = { "bio_flashlight" },
    flags = { "BIONIC_TOGGLED" },
})
content.add(content.Bionic {
    id = "bio_tattoo_led",
    name = ccb.content.text("LED Tattoo"),
    description = ccb.content.text("A small LED display just beneath your dermal layer can be illuminated on command to show patterns of your choice at dim or bright luminosity.  It doesn't provide enough light to comfortably read or craft, but it can suffice if you have nothing else."),
    activation_energy_millijoules = 30,
    over_time_energy_millijoules = 30,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_tattoo_led_0" },
    flags = { "BIONIC_TOGGLED" },
})
content.add(content.Bionic {
    id = "bio_glowy",
    name = ccb.content.text("Glowy Thing"),
    description = ccb.content.text("You don't think that capacitor is *meant* to glow, but it does, and usually at bad times.  A malfunctioning bionic randomly turns on and off, causing you to glow and making you visible in the dark without improving how much you can see in the slightest."),
    trigger_energy_millijoules = 1000000,
    flags = { "BIONIC_FAULTY" },
})
content.add(content.Bionic {
    id = "bio_geiger",
    name = ccb.content.text("Integrated Dosimeter"),
    description = ccb.content.text("Small radiation sensors have been surgically implanted throughout your body, allowing you to analyze your level of absorbed radiation.  They will also alert you whenever exposed to environmental radiation."),
    activation_energy_millijoules = 100000,
    occupied_bodyparts = { { bodypart = "torso", slots = 2 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_gills",
    name = ccb.content.text("Respirator"),
    description = ccb.content.text("A complex respiration augmentation system.  Improves respiration ability in air and allows breathing water.  Will automatically activate when drowning.  Turn on to recharge stamina faster, at moderate power cost.  Asthmatics may also use it to stop asthma attacks."),
    trigger_energy_millijoules = 25000000,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "head", slots = 2 }, { bodypart = "mouth", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_ground_sonar",
    name = ccb.content.text("Terranian Sonar"),
    description = ccb.content.text("Your feet are equipped with precision sonar equipment, allowing you to detect the movements of creatures below the ground, buried traps, and unstable terrain."),
    activation_energy_millijoules = 200000,
    over_time_energy_millijoules = 200000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_ground_sonar_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "foot_l", slots = 3 }, { bodypart = "foot_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_heat_absorb",
    name = ccb.content.text("Heat Drain"),
    description = ccb.content.text("While fighting unarmed against a warm-blooded opponent, there is a chance that a successful hit will drain body heat, inflicting a small amount of extra damage, and increasing your power reserves slightly."),
    trigger_energy_millijoules = 3000000,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 6 }, { bodypart = "head", slots = 3 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 5 }, { bodypart = "leg_r", slots = 5 }, { bodypart = "foot_l", slots = 2 }, { bodypart = "foot_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_heatsink",
    name = ccb.content.text("Thermal Dissipation"),
    description = ccb.content.text("Powerful heatsinks and supermaterials are surgically woven into your flesh.  While powered, this system will prevent heat damage up to 2000 degrees Fahrenheit.  Note that this does not affect your internal temperature."),
    activation_energy_millijoules = 1000000,
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    active_flags = { "HEATSINK" },
    occupied_bodyparts = { { bodypart = "torso", slots = 10 }, { bodypart = "head", slots = 2 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_infrared",
    name = ccb.content.text("Infrared Vision"),
    description = ccb.content.text("Your range of vision extends into the infrared, allowing you to see warm-blooded creatures in the dark or through smoke."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "THERMAL_VISION_GOOD" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_int_enhancer",
    name = ccb.content.text("Cerebral Booster"),
    description = ccb.content.text("Your brain has been enhanced with bionic coprocessors, giving you a +2 bonus to intelligence while powered.  However, you suffer penalties if unpowered."),
    cant_remove_reason = ccb.content.text("The bionic is now critical to the continued functionality of the user's brain."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_int_enhancer_0", "BIONIC_ENCH_bio_int_enhancer_1" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 6 } },
})
content.add(content.Bionic {
    id = "bio_itchy",
    name = ccb.content.text("Itchy Metal Thing"),
    description = ccb.content.text("A bionic of some sort, so badly installed that you cannot even tell what it was originally supposed to be.  Sometimes it itches horribly."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 3 }, { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_laser",
    name = ccb.content.text("Finger-Mounted Laser"),
    description = ccb.content.text("One of your fingers has a small high-powered laser surgically embedded in it.  This long range weapon is not incredibly damaging, but is very accurate, and has the potential to start fires."),
    fake_weapon = "bio_laser_gun",
    flags = { "BIONIC_GUN", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_leaky",
    name = ccb.content.text("Leaky Bionic"),
    description = ccb.content.text("This botched piece of bionic hardware slowly leaks electrolytic compounds, piezoelectric nanomaterials, and other high-tech contaminants into your bloodstream.  Needless to say, this is not good for your health."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 } },
})
content.add(content.Bionic {
    id = "bio_leukocyte",
    name = ccb.content.text("Leukocyte Breeder System"),
    description = ccb.content.text("You are equipped with bionic stimulators which augment your haematopoiesis system, allowing you to accelerate white blood cell production using bionic power.  It is supposed to run continuously and may cause unpleasant side effects when turned off."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_leukocyte_0" },
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 10 } },
})
content.add(content.Bionic {
    id = "bio_lighter",
    name = ccb.content.text("Finger Lighter"),
    description = ccb.content.text("The index finger of your left hand has a fire starter that can extend from the tip."),
    activation_energy_millijoules = 1500000,
    passive_pseudo_items = { "crude_firestarter" },
    flags = { "USES_BIONIC_POWER" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_lockpick",
    name = ccb.content.text("Fingerpick"),
    description = ccb.content.text("One of your fingers has an electronic lockpick surgically embedded in it.  This automatic system will quickly unlock all but the most advanced key locks without any skill required on the part of the user."),
    activation_energy_millijoules = 50000,
    occupied_bodyparts = { { bodypart = "hand_l", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_magnet",
    name = ccb.content.text("Electromagnetic Unit"),
    description = ccb.content.text("Surgically embedded in your left arm is a powerful electromagnet, allowing you to use your own strength to pull all nearby magnetic objects towards you.  Unlucky bystanders might be injured or killed by flying objects."),
    activation_energy_millijoules = 15000000,
    occupied_bodyparts = { { bodypart = "arm_l", slots = 9 } },
})
content.add(content.Bionic {
    id = "bio_membrane",
    name = ccb.content.text("Nictitating Membrane"),
    description = ccb.content.text("Your eyes are equipped with thin membranes that cover your eyes while underwater, negating any vision penalties."),
    flags = { "BIONIC_NPC_USABLE", "EYE_MEMBRANE" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_memory",
    name = ccb.content.text("Enhanced Memory Banks"),
    description = ccb.content.text("Your memory has been enhanced with small quantum storage drives.  While active, you learn - both through reading and practice - more quickly.  Additionally, you forget skills you've learned slower."),
    cant_remove_reason = ccb.content.text("Removing this CBM would cause severe amnesia and neurological issues."),
    activation_energy_millijoules = 2000,
    over_time_energy_millijoules = 2000,
    trigger_energy_millijoules = 25000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_memory_0" },
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY" },
    active_flags = { "CBQ_LEARN_BONUS" },
    occupied_bodyparts = { { bodypart = "head", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_meteorologist",
    name = ccb.content.text("Weather Reader"),
    description = ccb.content.text("A multitude of scientific instruments and sensors collect environmental data.  The data is compiled and presented as a simple readout of the current weather.  It also passively tells you the local air temperature."),
    activation_energy_millijoules = 10000,
    flags = { "THERMOMETER" },
    occupied_bodyparts = { { bodypart = "torso", slots = 1 }, { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_nanobots",
    name = ccb.content.text("Repair Nanobots"),
    description = ccb.content.text("Inside your body is a fleet of tiny dormant robots.  While activated they will flit about your body, repairing damage at 1 HP per minute and stopping bleeding at the cost of extra power and stored calories.  No power is consumed if there is nothing to heal."),
    activation_energy_millijoules = 80000,
    over_time_energy_millijoules = 40000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE", "BIONIC_SLEEP_FRIENDLY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 12 } },
})
content.add(content.Bionic {
    id = "bio_night",
    name = ccb.content.text("Artificial Night Generator"),
    description = ccb.content.text("When active, this bionic eliminates all light within a 2 tile radius through destructive interference."),
    activation_energy_millijoules = 9000000,
    over_time_energy_millijoules = 9000000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_night_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 16 } },
})
content.add(content.Bionic {
    id = "bio_night_vision",
    name = ccb.content.text("Implanted Night Vision"),
    description = ccb.content.text("When active, this bionic will amplify existing light, allowing you to see in the dark."),
    activation_energy_millijoules = 10000,
    over_time_energy_millijoules = 10000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "NIGHT_VISION" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_noise",
    name = ccb.content.text("Noisemaker"),
    description = ccb.content.text("A malfunctioning bionic.  It will occasionally emit a loud burst of noise."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 4 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_nostril",
    name = ccb.content.text("Bionic Nostril"),
    description = ccb.content.text("You're really not sure how the CBM ended up in your nose, but no matter how it got there this badly misplaced bionic makes it difficult to breathe.  Increases mouth encumbrance by ten."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 }, { bodypart = "mouth", slots = 1 } },
    encumbrance = { { bodypart = "mouth", amount = 10 } },
})
content.add(content.Bionic {
    id = "bio_ods",
    name = ccb.content.text("Offensive Defense System"),
    description = ccb.content.text("A thin forcefield surrounds your body, continually draining power.  This field does not deflect attacks, but rather delivers a strong shock, damaging unarmed attackers and those with a conductive weapon."),
    activation_energy_millijoules = 10000,
    over_time_energy_millijoules = 10000,
    trigger_energy_millijoules = 400000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 10 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_painkiller",
    name = ccb.content.text("Sensory Dulling"),
    description = ccb.content.text("Your nervous system is wired to allow you to inhibit the signals of pain, allowing you to dull your senses at will.  However, the use of this system may cause delayed reaction time and drowsiness."),
    trigger_energy_millijoules = 2000000,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_pokedeye",
    name = ccb.content.text("Bionic Visual Impairment"),
    description = ccb.content.text("Due to a badly misplaced dielectric stylette, you are now suffering from mild optic neuropathy.  Increases eye encumbrance by ten."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
    encumbrance = { { bodypart = "eyes", amount = 10 } },
})
content.add(content.Bionic {
    id = "bio_power_storage",
    name = ccb.content.text("Power Storage"),
    description = ccb.content.text("Upgrades your bionic power capacity by 100 kJ.  It can be recharged via other CBMs that function as power supplies."),
    capacity_energy_millijoules = 100000000,
    dupes_allowed = true,
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_power_storage_mkII",
    name = ccb.content.text("Power Storage Mk. II"),
    description = ccb.content.text("Upgrades your bionic power capacity by 250 kJ.  It can be recharged via other CBMs that function as power supplies."),
    capacity_energy_millijoules = 250000000,
    dupes_allowed = true,
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_power_weakness",
    name = ccb.content.text("Power Overload"),
    description = ccb.content.text("Damaged power circuits cause short-circuiting inside your muscles when your batteries are above 75% capacity, causing greatly reduced strength.  This has no effect if you have no internal batteries."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 3 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_probability_travel",
    name = ccb.content.text("Probability Travel"),
    description = ccb.content.text("Increases your body's wavelength, allowing you to quantum tunnel through walls, reappearing on the other side.  Power drain in standby is minimal, but each tile tunneled through costs 250 bionic power."),
    activation_energy_millijoules = 3000,
    over_time_energy_millijoules = 3000,
    trigger_energy_millijoules = 250000000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_purifier",
    name = ccb.content.text("Air Filtration System"),
    description = ccb.content.text("Surgically implanted in your trachea is an advanced filtration system.  If toxins or airborne diseases find their way into your windpipe, the filter will attempt to remove them."),
    passive_pseudo_items = { "internal_bio_purifier" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_radio",
    name = ccb.content.text("Infolink"),
    description = ccb.content.text("A compact communications device has been built into your ears, enabling you to communicate over radio waves."),
    passive_pseudo_items = { "fake_radio" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_radio_pat",
    name = ccb.content.text("Modified Infolink"),
    description = ccb.content.text("A compact communications device has been built into your ears, enabling you to communicate over radio waves.  This one has custom software for communicating with your pal Pat."),
    passive_pseudo_items = { "fake_radio", "integrated_pat_transponder", "integrated_pat_radio" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_radscrubber",
    name = ccb.content.text("Radiation Scrubber System"),
    description = ccb.content.text("A system of advanced piezomechanical blood filters have been surgically implanted throughout your body, allowing you to purge yourself of absorbed radiation at the cost of some bionic power."),
    activation_energy_millijoules = 4500000,
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_razors",
    name = ccb.content.text("Fingertip Razors"),
    description = ccb.content.text("You possess razor-sharp claws underneath your fingernails that do a small amount of unarmed slashing damage whenever your fingertips are uncovered."),
    enchantments = { "BIONIC_ENCH_bio_razors_0" },
    passive_pseudo_items = { "fake_razor" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_recycler",
    name = ccb.content.text("Recycler Unit"),
    description = ccb.content.text("Your digestive system has been outfitted with a series of filters and processors, allowing you to reclaim waste liquid and, to a lesser degree, nutrients.  The net effect is a greatly reduced need to eat and drink."),
    enchantments = { "BIONIC_ENCH_bio_recycler_0" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 15 } },
})
content.add(content.Bionic {
    id = "bio_remote",
    name = ccb.content.text("Remote Controller"),
    description = ccb.content.text("A small module connected to your brain allows you to interface with nearby devices with wireless capabilities."),
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 24,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_resonator",
    name = ccb.content.text("Sonic Resonator"),
    description = ccb.content.text("Your entire body may resonate at very high power, creating a short-range shockwave.  While it will not do much damage to creatures, solid objects such as walls and doors will be damaged."),
    activation_energy_millijoules = 100000000,
    occupied_bodyparts = { { bodypart = "torso", slots = 15 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 4 }, { bodypart = "leg_r", slots = 4 } },
})
content.add(content.Bionic {
    id = "bio_scent_mask",
    name = ccb.content.text("Olfactory Mask"),
    description = ccb.content.text("While this system is powered, your body will produce very little odor, making it nearly impossible for creatures to track you by scent."),
    activation_energy_millijoules = 1000000,
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "NO_SCENT" },
    occupied_bodyparts = { { bodypart = "torso", slots = 3 }, { bodypart = "head", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_shakes",
    name = ccb.content.text("Bionic Short Circuit"),
    description = ccb.content.text("A poorly-wired bionic which fails to serve its intended purpose, this malfunctioning device periodically short-circuits, causing systemic muscle tremors."),
    trigger_energy_millijoules = 25000000,
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 1 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_synaptic_regen",
    name = ccb.content.text("Synaptic Regeneration System"),
    description = ccb.content.text("An electromagnetic stimulator has been surgically implanted on the back of your head and along your spine, continually draining power.  As long as it's active, you will not suffer from sleep deprivation, although you may still feel sleepy; and if you're sleep deprived already, it will gradually reduce the symptoms of lacking sleep."),
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 100,
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "STOP_SLEEP_DEPRIVATION" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 }, { bodypart = "torso", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_shock",
    name = ccb.content.text("Electroshock Unit"),
    description = ccb.content.text("While fighting unarmed, or with a weapon that conducts electricity, there is a chance that a successful hit will shock your opponent, inflicting extra damage and disabling them temporarily at the cost of some energy."),
    trigger_energy_millijoules = 2000000,
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_shockwave",
    name = ccb.content.text("Shockwave Generator"),
    description = ccb.content.text("You generate a powerful shockwave, knocking back all nearby creatures.  Targets are stunned briefly, take damage and additional stun upon impact with impassable terrain, and knockback any creatures they collide with."),
    activation_energy_millijoules = 250000000,
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
content.add(content.Bionic {
    id = "bio_sleepy",
    name = ccb.content.text("Endocrine Enervator"),
    description = ccb.content.text("Through a combination of psychochemical manipulation and old fashioned electrical nerve stimulation, this malfunctioning bionic alters your brain chemistry in such a way as to cause sleepiness.  You will find yourself tiring a bit faster than before."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_spasm",
    name = ccb.content.text("Motor Control Overstimulator"),
    description = ccb.content.text("One piezoelectric solenoid surgically installed backwards, two crossed wires, and four burned-out capacitors later you started falling on your face and writhing around at the least convenient times.  This incorrectly-configured bionic periodically stuns you for a short duration."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "head", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_speed",
    name = ccb.content.text("Synaptic Accelerator"),
    description = ccb.content.text("Your nervous system has been enhanced with bionic stimulators, giving you a 10% boost to your speed."),
    activation_energy_millijoules = 10000,
    over_time_energy_millijoules = 10000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_speed_0" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 }, { bodypart = "leg_l", slots = 6 }, { bodypart = "leg_r", slots = 6 }, { bodypart = "foot_l", slots = 2 }, { bodypart = "foot_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_stiff",
    name = ccb.content.text("Wire-Induced Stiffness"),
    description = ccb.content.text("Improperly installed wires cause a physical stiffness in most of your body, causing increased encumbrance."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
    encumbrance = { { bodypart = "torso", amount = 10 }, { bodypart = "arm_l", amount = 10 }, { bodypart = "arm_r", amount = 10 }, { bodypart = "leg_l", amount = 10 }, { bodypart = "leg_r", amount = 10 }, { bodypart = "foot_l", amount = 10 }, { bodypart = "foot_r", amount = 10 } },
})
content.add(content.Bionic {
    id = "bio_str_enhancer",
    name = ccb.content.text("Muscle Augmentation"),
    description = ccb.content.text("Your muscular system has been surgically enhanced with myomer fibers, giving you a +2 bonus to strength while powered.  However, you will suffer penalties if unpowered."),
    activation_energy_millijoules = 5000,
    over_time_energy_millijoules = 5000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_str_enhancer_0", "BIONIC_ENCH_bio_str_enhancer_1" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 6 }, { bodypart = "arm_l", slots = 4 }, { bodypart = "arm_r", slots = 4 }, { bodypart = "leg_l", slots = 8 }, { bodypart = "leg_r", slots = 8 } },
})
content.add(content.Bionic {
    id = "bio_surgical_razor",
    name = ccb.content.text("Autonomous Surgical Scalpels"),
    description = ccb.content.text("A system of surgical grade scalpels is implanted in your forearms, extending from just above your wrists.  They allow you to make automated precise cuts and can also be used as a high-quality butchering tool."),
    fake_weapon = "bio_scalpel",
    flags = { "BIONIC_TOGGLED", "BIONIC_WEAPON" },
    occupied_bodyparts = { { bodypart = "arm_r", slots = 2 }, { bodypart = "arm_l", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_sunglasses",
    name = ccb.content.text("Anti-Glare Compensators"),
    description = ccb.content.text("Your eyes have quick-reacting transition lenses surgically installed over them.  They negate glare penalties, partially protect you from bright flashes, and protect your eyes when welding."),
    passive_pseudo_items = { "fake_goggles" },
    included_bionics = { "bio_blindfold" },
    flags = { "BIONIC_NPC_USABLE", "GLARE_RESIST" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_synlungs",
    name = ccb.content.text("Synthetic Lungs"),
    description = ccb.content.text("You have highly efficient artificial lungs which greatly increase your oxygen intake.  If they are not powered you will suffocate, and they weaken your immune system somewhat."),
    cant_remove_reason = ccb.content.text("The CBM has replaced the patient's lungs and cannot be removed."),
    activation_energy_millijoules = 3000,
    over_time_energy_millijoules = 3000,
    trigger_energy_millijoules = 3000,
    charge_time_turns = 1,
    activated_on_install = true,
    enchantments = { "BIONIC_ENCH_bio_synlungs_0" },
    canceled_mutations = { "GOODCARDIO", "BADCARDIO", "GOODCARDIO2", "PERSISTENCE_HUNTER", "PERSISTENCE_HUNTER2", "ASTHMA" },
    flags = { "BIONIC_SLEEP_FRIENDLY", "BIONIC_SHOCKPROOF", "BIONIC_TOGGLED" },
    active_flags = { "CARDIO_MIN_GUARANTE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 } },
})
content.add(content.Bionic {
    id = "bio_targeting",
    name = ccb.content.text("Targeting System"),
    description = ccb.content.text("Your eyes are surgically equipped with range finders, and their movement is synced with that of your arms, to a degree.  Shots you fire will be much more accurate, particularly at long range."),
    enchantments = { "BIONIC_ENCH_bio_targeting_0" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_taser",
    name = ccb.content.text("Super Stun Gun"),
    description = ccb.content.text("You have a powerful stun gun built into your hand.  Activate to zap an adjacent enemy."),
    activated_close_ui = true,
    activation_spell = { id = "bio_taser_spell" },
    flags = { "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "hand_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_teleport",
    name = ccb.content.text("Teleportation Unit"),
    description = ccb.content.text("This highly experimental unit folds space over short distances, instantly transporting your body up to 25 feet at the cost of much power.  Note that prolonged or frequent use may have dangerous side effects."),
    activation_energy_millijoules = 250000000,
    occupied_bodyparts = { { bodypart = "torso", slots = 16 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "leg_l", slots = 4 }, { bodypart = "leg_r", slots = 4 } },
})
content.add(content.Bionic {
    id = "bio_thumbs",
    name = ccb.content.text("Self-Locking Thumbs"),
    description = ccb.content.text("Self-locking thumbs hold tight (even when you really don't want them to) and don't let go (even when you'd rather they did).  Increases hand encumbrance by ten, while failing to improve your ability to hold objects whatsoever."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
    encumbrance = { { bodypart = "hand_l", amount = 10 }, { bodypart = "hand_r", amount = 10 } },
})
content.add(content.Bionic {
    id = "bio_tools",
    name = ccb.content.text("Integrated Multitool"),
    description = ccb.content.text("Surgically implanted in your hands and forearms is a set of compact tools and a welder that runs off your internal power banks."),
    passive_pseudo_items = { "toolset", "integrated_welder" },
    flags = { "BIONIC_SHOCKPROOF", "BIONIC_NPC_USABLE" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 2 }, { bodypart = "hand_r", slots = 2 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_multimeter",
    name = ccb.content.text("Integrated Multimeter"),
    description = ccb.content.text("Your fingers and arms have been implanted with retractable electrical probes connected to a multimeter embedded in your arm, allowing you to measure electrical voltage, resistance, and current by touch.  This also provides your hands and arms with a modicum of protection against electric shocks."),
    passive_pseudo_items = { "integrated_multimeter" },
    flags = { "BIONIC_SHOCKPROOF", "BIONIC_NPC_USABLE" },
    available_upgrades = { "bio_electrokit" },
    protection = { { bodypart = "hand_l", damage_type = "electric", amount = 3 }, { bodypart = "hand_r", damage_type = "electric", amount = 3 }, { bodypart = "arm_l", damage_type = "electric", amount = 3 }, { bodypart = "arm_r", damage_type = "electric", amount = 3 } },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_electrokit",
    name = ccb.content.text("Integrated Circuitry Toolset"),
    description = ccb.content.text("Your fingers and arms have been implanted a soldering iron, a multimeter, and a set of small screwdrivers, providing all the tools required for working with bench-scale electrical circuits.  This also provides your hands and arms with a modicum of protection against electric shocks."),
    upgraded_bionic = "bio_multimeter",
    passive_pseudo_items = { "integrated_electrokit", "integrated_multimeter" },
    flags = { "BIONIC_SHOCKPROOF", "BIONIC_NPC_USABLE" },
    protection = { { bodypart = "hand_l", damage_type = "electric", amount = 3 }, { bodypart = "hand_r", damage_type = "electric", amount = 3 }, { bodypart = "arm_l", damage_type = "electric", amount = 3 }, { bodypart = "arm_r", damage_type = "electric", amount = 3 } },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 2 }, { bodypart = "hand_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_torsionratchet",
    name = ccb.content.text("Joint Torsion Ratchet"),
    description = ccb.content.text("Your joints have been surgically equipped with torsion ratchets that slowly generate power when you move, even when turned off.  Whilst this is toggled on, moving will require more effort, but more power will be generated.  This system is actively detrimental to fully mechanical limbs; the additional joint resistance it relies on causes a net loss of bionic power."),
    fuel_efficiency = 0.125,
    passive_fuel_efficiency = 0.00625,
    fuel_options = { "muscle" },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_NPC_USABLE", "BIONIC_TOGGLED" },
    mutation_conflicts = { "AMORPHOUS", "BENDY2", "BENDY3", "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8", "CLAWS_TENTACLE", "GASTROPOD_FOOT", "GASTROPOD_BALANCE", "LEG_TENTACLES", "LEG_TENT_BRACE" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 8 }, { bodypart = "arm_r", slots = 8 }, { bodypart = "leg_l", slots = 12 }, { bodypart = "leg_r", slots = 12 } },
})
content.add(content.Bionic {
    id = "bio_jointservo",
    name = ccb.content.text("Joint Servo"),
    description = ccb.content.text("Your leg joints have been equipped with servomotors that provide power-assisted movement.  Movement takes less effort when this bionic is online.  However, when it's offline it will hamper your movement, as you struggle against its moving parts."),
    activation_energy_millijoules = 5000,
    trigger_energy_millijoules = 35000,
    enchantments = { "BIONIC_ENCH_bio_jointservo_0", "BIONIC_ENCH_bio_jointservo_1" },
    flags = { "BIONIC_TOGGLED" },
    mutation_conflicts = { "LEG_TENTACLES", "LEG_TENT_BRACE", "GASTROPOD_FOOT", "GASTROPOD_BALANCE", "AMORPHOUS" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 12 }, { bodypart = "leg_r", slots = 12 } },
})
content.add(content.Bionic {
    id = "bio_trip",
    name = ccb.content.text("Visual Disruptor"),
    description = ccb.content.text("A malfunctioning bionic which causes occasional visual distortion and pixelation."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_uncanny_dodge",
    name = ccb.content.text("Uncanny Dodge"),
    description = ccb.content.text("Your nervous system has been augmented with bionic processors, allowing you to dodge attacks beyond normal human capability."),
    activation_energy_millijoules = 6000,
    over_time_energy_millijoules = 6000,
    trigger_energy_millijoules = 75000000,
    charge_time_turns = 1,
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 12 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "leg_l", slots = 5 }, { bodypart = "leg_r", slots = 5 }, { bodypart = "foot_l", slots = 1 }, { bodypart = "foot_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_ups",
    name = ccb.content.text("Unified Power System"),
    description = ccb.content.text("You have a Unified Power System wired into your power banks.  Objects that run on a UPS can now draw directly from your bionic power supply."),
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "torso", slots = 5 } },
})
content.add(content.Bionic {
    id = "bio_voice",
    name = ccb.content.text("Voice Remodulator"),
    description = ccb.content.text("You will likely spend the rest of your days serving as a walking testament to why you don't opt for the Autodoc's 'Cyborg Identity Package'.  A remodulator unit jammed down your throat has given you a creepy robot voice."),
    social_modifiers = { lie = 10, persuade = -20, intimidate = 20 },
    canceled_mutations = { "GROWL", "SNARL", "HISS", "CROAK" },
    flags = { "BIONIC_FAULTY" },
    mutation_conflicts = { "SCREECH" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_watch",
    name = ccb.content.text("Internal Chronometer"),
    description = ccb.content.text("You have been equipped with an internal atomic clock, ensuring that you will always know the current time.  Additionally, it includes a silent alarm clock function."),
    flags = { "WATCH", "ALARMCLOCK" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_water_extractor",
    name = ccb.content.text("Water Extraction Unit"),
    description = ccb.content.text("Nanotubes surgically embedded in the palm of your hand will pump any available fluid out of a dead body, cleanse it of impurities and convert it into drinkable water.  You must, however, have a container to store the water in."),
    activation_energy_millijoules = 20000000,
    occupied_bodyparts = { { bodypart = "arm_l", slots = 3 }, { bodypart = "hand_l", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_syringe",
    name = ccb.content.text("Intravenous Needletip"),
    description = ccb.content.text("The flesh of the inside of your middle finger has been replaced with a tube leading into your arteries, with a retractable needle extending out of the tip of the finger when clenched.  This lets you pump intravenous drugs like morphine directly into your bloodstream without needing to carry a syringe."),
    passive_pseudo_items = { "syringe" },
    occupied_bodyparts = { { bodypart = "hand_l", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_weight",
    name = ccb.content.text("Titanium Skeletal Bracing"),
    description = ccb.content.text("Titanium bracing has been installed onto your elbows, knees, and spine, making them far better at handling strain.  Your carrying capacity is increased by 20 kilograms, or about 44 pounds, and you receive slightly less bashing damage to your arms, legs and torso."),
    enchantments = { "BIONIC_ENCH_bio_weight_0" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "BENDY2", "BENDY3", "LARGE", "LARGE_OK", "HUGE", "HUGE_OK", "SMALL", "SMALL2", "SMALL_OK", "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8", "CLAWS_TENTACLE", "GASTROPOD_FOOT", "GASTROPOD_BALANCE", "LEG_TENTACLES", "LEG_TENT_BRACE" },
    protection = { { bodypart = "torso", damage_type = "bash", amount = 2 }, { bodypart = "arm_l", damage_type = "bash", amount = 2 }, { bodypart = "arm_r", damage_type = "bash", amount = 2 }, { bodypart = "leg_l", damage_type = "bash", amount = 2 }, { bodypart = "leg_r", damage_type = "bash", amount = 2 } },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 }, { bodypart = "arm_l", slots = 3 }, { bodypart = "arm_r", slots = 3 }, { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_taste_blocker",
    name = ccb.content.text("Taste Modifier"),
    description = ccb.content.text("A set of highly sensitive sensors is installed in your mouth, and a small yet sophisticated analyzer is installed in the cavity of your skull.  The active bionic will nullify the taste of all comestibles with negative enjoyment value at the cost of draining bionic power."),
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_soporific",
    name = ccb.content.text("Soporific Induction"),
    description = ccb.content.text("An electrode has been implanted into your brain's ventrolateral preoptic nucleus.  It turns on whenever you're trying to fall asleep, creating an artificial but effective sensation of sleepiness."),
    enchantments = { "BIONIC_ENCH_bio_soporific_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_faulty_electromagnetic_leak",
    name = ccb.content.text("Electromagnetic Leak"),
    description = ccb.content.text("A broken implant that sends electromagnetic impulses that reduce other implants' capacity to store charge."),
    capacity_energy_millijoules = -25000000,
    dupes_allowed = true,
    flags = { "BIONIC_FAULTY" },
})
content.add(content.Bionic {
    id = "bio_faulty_grossfood",
    name = ccb.content.text("Taste Fouler"),
    description = ccb.content.text("A malfunctioning processor haphazardly interfaced with your taste receptors has given everything you consume a horrid bitter taste.  Food and drink will severely harm your morale."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 }, { bodypart = "mouth", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_radleak",
    name = ccb.content.text("Radioactive Leak"),
    description = ccb.content.text("This damaged CBM occasionally leaks radiation."),
    flags = { "BIONIC_FAULTY" },
    occupied_bodyparts = { { bodypart = "torso", slots = 4 } },
})
content.add(content.Bionic {
    id = "bio_recoil",
    name = ccb.content.text("Recoil Compensators"),
    description = ccb.content.text("Reactive shock absorbers installed in your wrists and elbows which greatly reduce felt recoil."),
    enchantments = { "BIONIC_ENCH_bio_recoil_0" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 4 }, { bodypart = "arm_r", slots = 4 }, { bodypart = "hand_l", slots = 2 }, { bodypart = "hand_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_sleep_shutdown",
    name = ccb.content.text("Sleep Mode Shutdown"),
    description = ccb.content.text("For better or worse, this CBM suppresses stimuli while asleep, preventing you from waking up until the end of your natural sleep cycle."),
    flags = { "BIONIC_FAULTY", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_betavoltaic",
    name = ccb.content.text("Betavoltaic Invidevice"),
    description = ccb.content.text("A small implantable betavoltaic device.  Utilizing nickel-63 radioisotope decay technology and diamond semiconductors, this CBM achieves a stable conversion of nuclear energy into electrical power.  Its power output is very low, at a mere 1W, but it boasts a stable operational lifespan of up to 50 years, requiring neither charging nor maintenance.  Under the current state of the world, its decommissioning age is longer than the lifespan of most ordinary people."),
    dupes_allowed = true,
    enchantments = { "BIONIC_ENCH_bio_betavoltaic_0" },
    flags = { "BIONIC_POWER_SOURCE", "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_pitch_perfect",
    name = ccb.content.text("Throwing Assist"),
    description = ccb.content.text("Taken from a world that embraced cybernetics in their sports, this CBM links the eyes to a series of nerve stimulators along the arms and hands.  The result is a significant increase to throwing distance and accuracy, and it turns out it works great with fragmentation grenades."),
    enchantments = { "BIONIC_ENCH_bio_pitch_perfect_0" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 1 }, { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 2 }, { bodypart = "hand_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_robofac_xmleg",
    name = ccb.content.text("Hub 01 XM-LEG Interface"),
    description = ccb.content.text("Your legs house chip-free electronics that allow your neurobionic interface to communicate with Hub 01 Lower Extremity Gaitframes."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 2 }, { bodypart = "leg_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_robofac_xmarm",
    name = ccb.content.text("Hub 01 XM-ARM Interface"),
    description = ccb.content.text("Your arms and hands houses chip-free electronics that allow your neurobionic interface to communicate with Hub 01 Arm Reinforcement Motionframes."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 2 }, { bodypart = "hand_r", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_robofac_xmback",
    name = ccb.content.text("Hub 01 XM-BACK Interface"),
    description = ccb.content.text("Your shoulders and back house chip-free electronics that allow your neurobionic interface to communicate with Hub 01 Biomechanical Assisted Carrying Kinetoframes."),
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK" },
    occupied_bodyparts = { { bodypart = "torso", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_robofac_xmlens",
    name = ccb.content.text("Hub 01 XM-LENS Interface"),
    description = ccb.content.text("Your scalp houses chip-free electronics that allow your neurobionic interface to communicate with compatible Hub 01 Low-latency ExoNeural Sensory headgear."),
    canceled_mutations = { "hair_beaded", "hair_body_length", "hair_braid", "hair_bun", "hair_buzzcut", "hair_crewcut", "hair_curls", "hair_detective", "hair_extremely_long", "hair_fro", "hair_long", "hair_long_mohawk", "hair_long_over_eye", "hair_medium", "hair_messy", "hair_modern", "hair_mohawk", "hair_mullet", "hair_ponytail", "hair_puff", "hair_punk_long", "hair_short", "hair_short_no_fringe", "hair_short_over_eye", "hair_super_princess", "hair_twintails", "hair_very_long", "natural_hair_growth" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "AMORPHOUS", "HUGE", "HUGE_OK", "SMALL2", "SMALL_OK" },
    occupied_bodyparts = { { bodypart = "head", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_nl_laser_reader",
    name = ccb.content.text("Laser-Assisted Reading Device"),
    description = ccb.content.text("Your head is implanted with a low-power reading light and a short-distance laser scanner, allowing you to upload digital images of books straight into your brain's optic lobe and language centers.  When active, you read slightly faster, and can read in the dark."),
    activation_energy_millijoules = 2000,
    over_time_energy_millijoules = 2000,
    charge_time_turns = 1,
    enchantments = { "BIONIC_ENCH_bio_nl_laser_reader_0" },
    flags = { "BIONIC_TOGGLED" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_nl_psyshield",
    name = ccb.content.text("Cranial EMF Shielding"),
    description = ccb.content.text("Your skull is coated in a microscopically thin layer of some non-newtonian fluid.  It can protect you from some types of electromagnetic fields.  Is it useful?  Maybe.  It slightly encumbers the head."),
    passive_pseudo_items = { "integrated_nl_psyshield" },
    flags = { "BIONIC_NPC_USABLE", "BIONIC_SHOCKPROOF" },
    occupied_bodyparts = { { bodypart = "head", slots = 1 } },
    encumbrance = { { bodypart = "head", amount = 1 } },
})
content.add(content.Bionic {
    id = "bio_nl_antigravity_jump",
    name = ccb.content.text("Antigravity Leap Assist"),
    description = ccb.content.text("Your legs have been implanted with an antigravity device.  While it doesn't allow you to float or fly, it does allow you to make superhuman long jumps."),
    activation_energy_millijoules = 250000000,
    activated_close_ui = true,
    activation_spell = { id = "bio_nl_antigravity_jump_spell" },
    occupied_bodyparts = { { bodypart = "leg_l", slots = 3 }, { bodypart = "leg_r", slots = 3 } },
})
content.add(content.Bionic {
    id = "bio_exodii_cyberframe_1a",
    name = ccb.content.text("Cyberframe 1a"),
    description = ccb.content.text("Your body is integrated into a bulky Exodii Cyberframe.  Your important internal organs, including much of your core skeleton and musculature, are encased in a solid metal core.  While there is clearly a head and torso, it is difficult to tell where one starts and the other ends.  It will be difficult or impossible to squeeze through tight spaces, or to wear normal-sized clothing and armor.  The frame greatly increases your physical dexterity and strength, and is highly protective, but the internal parts of your head and torso are still affected by temperature, you can still feel pain, and internal bleeding can occur with sufficient damage."),
    cant_remove_reason = ccb.content.text("Cyberframes cannot be removed, only swapped via specialized surgery.  Removing it would kill you."),
    enchantments = { "BIONIC_ENCH_bio_exodii_cyberframe_1a_0", "BIONIC_ENCH_bio_exodii_cyberframe_1a_1" },
    protection = { { bodypart = "head_bionic_basic", damage_type = "bash", amount = 30 }, { bodypart = "head_bionic_basic", damage_type = "cut", amount = 30 }, { bodypart = "head_bionic_basic", damage_type = "bullet", amount = 25 }, { bodypart = "head_bionic_basic", damage_type = "stab", amount = 30 }, { bodypart = "mouth_bionic_basic", damage_type = "bash", amount = 30 }, { bodypart = "mouth_bionic_basic", damage_type = "cut", amount = 30 }, { bodypart = "mouth_bionic_basic", damage_type = "bullet", amount = 25 }, { bodypart = "mouth_bionic_basic", damage_type = "stab", amount = 30 }, { bodypart = "torso_bionic_basic", damage_type = "bash", amount = 30 }, { bodypart = "torso_bionic_basic", damage_type = "cut", amount = 30 }, { bodypart = "torso_bionic_basic", damage_type = "bullet", amount = 25 }, { bodypart = "torso_bionic_basic", damage_type = "stab", amount = 30 } },
})
content.add(content.Bionic {
    id = "bio_exodii_leg_bionic_basic_armored_left",
    name = ccb.content.text("Cyberframe 1a: Bionic Left Leg"),
    description = ccb.content.text("You have a bionic left leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    required_bionic = "bio_exodii_cyberframe_1a",
    enchantments = { "BIONIC_ENCH_bio_exodii_leg_bionic_basic_armored_left_0" },
    replaced_bodyparts = { "leg_l", "foot_l" },
    protection = { { bodypart = "leg_bionic_basic_l", damage_type = "bash", amount = 30 }, { bodypart = "leg_bionic_basic_l", damage_type = "cut", amount = 30 }, { bodypart = "leg_bionic_basic_l", damage_type = "bullet", amount = 25 }, { bodypart = "leg_bionic_basic_l", damage_type = "stab", amount = 30 }, { bodypart = "foot_bionic_basic_l", damage_type = "bash", amount = 30 }, { bodypart = "foot_bionic_basic_l", damage_type = "cut", amount = 30 }, { bodypart = "foot_bionic_basic_l", damage_type = "bullet", amount = 25 }, { bodypart = "foot_bionic_basic_l", damage_type = "stab", amount = 30 } },
})
content.add(content.Bionic {
    id = "bio_exodii_leg_bionic_basic_armored_right",
    name = ccb.content.text("Cyberframe 1a: Bionic Right Leg"),
    description = ccb.content.text("You have a bionic right leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    required_bionic = "bio_exodii_cyberframe_1a",
    enchantments = { "BIONIC_ENCH_bio_exodii_leg_bionic_basic_armored_right_0" },
    replaced_bodyparts = { "leg_r", "foot_r" },
    protection = { { bodypart = "leg_bionic_basic_r", damage_type = "bash", amount = 30 }, { bodypart = "leg_bionic_basic_r", damage_type = "cut", amount = 30 }, { bodypart = "leg_bionic_basic_r", damage_type = "bullet", amount = 25 }, { bodypart = "leg_bionic_basic_r", damage_type = "stab", amount = 30 }, { bodypart = "foot_bionic_basic_r", damage_type = "bash", amount = 30 }, { bodypart = "foot_bionic_basic_r", damage_type = "cut", amount = 30 }, { bodypart = "foot_bionic_basic_r", damage_type = "bullet", amount = 25 }, { bodypart = "foot_bionic_basic_r", damage_type = "stab", amount = 30 } },
})
content.add(content.Bionic {
    id = "bio_exodii_leg_bionic_treads",
    name = ccb.content.text("Cyberframe 1a: Bionic Treads"),
    description = ccb.content.text("In place of legs and feet you have sturdy treads.  They are in fact two side-by-size triangular mechanisms, split in the middle, and independently operated.  Your former ankles and associated anatomy are now a part of the internal servomotors, and your knees are capable of minor telescoping and bending, to facilitate lifting one tread at a time for carefully passing over obstacles, or climbing stairs or ladders.  Unlike bipedal human legs, these move faster over most terrain, but will severely hinder travel over obstacles and through water.  They are immune to temperature and pain and don't bleed.  While they are highly resistant to damage, their external moving parts are less well protected than a standard bionic leg with similar plate thickness.  Due to their size and heft, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    required_bionic = "bio_exodii_cyberframe_1a",
    enchantments = { "BIONIC_ENCH_bio_exodii_leg_bionic_treads_0", "BIONIC_ENCH_bio_exodii_leg_bionic_treads_1" },
    replaced_bodyparts = { "leg_l", "foot_l", "leg_r", "foot_r" },
    protection = { { bodypart = "bionic_treads_leg", damage_type = "bash", amount = 20 }, { bodypart = "bionic_treads_leg", damage_type = "cut", amount = 20 }, { bodypart = "bionic_treads_leg", damage_type = "bullet", amount = 15 }, { bodypart = "bionic_treads_leg", damage_type = "stab", amount = 20 } },
})
content.add(content.Bionic {
    id = "bio_exodii_arm_bionic_basic_armored_left",
    name = ccb.content.text("Cyberframe 1a: Bionic Left Arm"),
    description = ccb.content.text("You have a bionic left leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    required_bionic = "bio_exodii_cyberframe_1a",
    enchantments = { "BIONIC_ENCH_bio_exodii_arm_bionic_basic_armored_left_0" },
    replaced_bodyparts = { "arm_l", "hand_l" },
    protection = { { bodypart = "arm_bionic_basic_l", damage_type = "bash", amount = 30 }, { bodypart = "arm_bionic_basic_l", damage_type = "cut", amount = 30 }, { bodypart = "arm_bionic_basic_l", damage_type = "bullet", amount = 25 }, { bodypart = "arm_bionic_basic_l", damage_type = "stab", amount = 30 }, { bodypart = "hand_bionic_basic_l", damage_type = "bash", amount = 30 }, { bodypart = "hand_bionic_basic_l", damage_type = "cut", amount = 30 }, { bodypart = "hand_bionic_basic_l", damage_type = "bullet", amount = 25 }, { bodypart = "hand_bionic_basic_l", damage_type = "stab", amount = 30 } },
})
content.add(content.Bionic {
    id = "bio_exodii_arm_bionic_basic_armored_right",
    name = ccb.content.text("Cyberframe 1a: Bionic Right Arm"),
    description = ccb.content.text("You have a bionic right leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are highly resistant to damage.  Due to their size and armored plating, a heavy-duty 1a-style Cyberframe is necessary for operation."),
    required_bionic = "bio_exodii_cyberframe_1a",
    enchantments = { "BIONIC_ENCH_bio_exodii_arm_bionic_basic_armored_right_0" },
    replaced_bodyparts = { "arm_r", "hand_r" },
    protection = { { bodypart = "arm_bionic_basic_r", damage_type = "bash", amount = 30 }, { bodypart = "arm_bionic_basic_r", damage_type = "cut", amount = 30 }, { bodypart = "arm_bionic_basic_r", damage_type = "bullet", amount = 25 }, { bodypart = "arm_bionic_basic_r", damage_type = "stab", amount = 30 }, { bodypart = "hand_bionic_basic_r", damage_type = "bash", amount = 30 }, { bodypart = "hand_bionic_basic_r", damage_type = "cut", amount = 30 }, { bodypart = "hand_bionic_basic_r", damage_type = "bullet", amount = 25 }, { bodypart = "hand_bionic_basic_r", damage_type = "stab", amount = 30 } },
})
content.add(content.Bionic {
    id = "bio_exodii_cyberframe_1b",
    name = ccb.content.text("Cyberframe 1b"),
    description = ccb.content.text("Your body is integrated into a very human-like Exodii Cyberframe.  Your important internal organs, including much of your core skeleton and musculature, are encased in a frame that resembles a robotic human.  The frame increases your physical dexterity and strength, and is modestly protective, but the internal parts of your head and torso are still affected by temperature, you can still feel pain, and internal bleeding can occur with sufficient damage."),
    cant_remove_reason = ccb.content.text("Cyberframes cannot be removed, only swapped via specialized surgery.  Removing it would kill you."),
    enchantments = { "BIONIC_ENCH_bio_exodii_cyberframe_1b_0" },
    protection = { { bodypart = "head_bionic_basic", damage_type = "bash", amount = 5 }, { bodypart = "head_bionic_basic", damage_type = "cut", amount = 5 }, { bodypart = "head_bionic_basic", damage_type = "bullet", amount = 2 }, { bodypart = "head_bionic_basic", damage_type = "stab", amount = 5 }, { bodypart = "mouth_bionic_basic", damage_type = "bash", amount = 5 }, { bodypart = "mouth_bionic_basic", damage_type = "cut", amount = 5 }, { bodypart = "mouth_bionic_basic", damage_type = "bullet", amount = 2 }, { bodypart = "mouth_bionic_basic", damage_type = "stab", amount = 5 }, { bodypart = "torso_bionic_basic", damage_type = "bash", amount = 5 }, { bodypart = "torso_bionic_basic", damage_type = "cut", amount = 5 }, { bodypart = "torso_bionic_basic", damage_type = "bullet", amount = 2 }, { bodypart = "torso_bionic_basic", damage_type = "stab", amount = 5 } },
})
content.add(content.Bionic {
    id = "bio_exodii_leg_bionic_basic_left",
    name = ccb.content.text("Cyberframe 1b: Bionic Left Leg"),
    description = ccb.content.text("You have a bionic left leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    required_bionic = "bio_exodii_cyberframe_1b",
    enchantments = { "BIONIC_ENCH_bio_exodii_leg_bionic_basic_left_0" },
    replaced_bodyparts = { "leg_l", "foot_l" },
    protection = { { bodypart = "leg_bionic_basic_l", damage_type = "bash", amount = 5 }, { bodypart = "leg_bionic_basic_l", damage_type = "cut", amount = 5 }, { bodypart = "leg_bionic_basic_l", damage_type = "bullet", amount = 2 }, { bodypart = "leg_bionic_basic_l", damage_type = "stab", amount = 5 }, { bodypart = "foot_bionic_basic_l", damage_type = "bash", amount = 5 }, { bodypart = "foot_bionic_basic_l", damage_type = "cut", amount = 5 }, { bodypart = "foot_bionic_basic_l", damage_type = "bullet", amount = 2 }, { bodypart = "foot_bionic_basic_l", damage_type = "stab", amount = 5 } },
})
content.add(content.Bionic {
    id = "bio_exodii_leg_bionic_basic_right",
    name = ccb.content.text("Cyberframe 1b: Bionic Right Leg"),
    description = ccb.content.text("You have a bionic right leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    required_bionic = "bio_exodii_cyberframe_1b",
    enchantments = { "BIONIC_ENCH_bio_exodii_leg_bionic_basic_right_0" },
    replaced_bodyparts = { "leg_r", "foot_r" },
    protection = { { bodypart = "leg_bionic_basic_r", damage_type = "bash", amount = 5 }, { bodypart = "leg_bionic_basic_r", damage_type = "cut", amount = 5 }, { bodypart = "leg_bionic_basic_r", damage_type = "bullet", amount = 2 }, { bodypart = "leg_bionic_basic_r", damage_type = "stab", amount = 5 }, { bodypart = "foot_bionic_basic_r", damage_type = "bash", amount = 5 }, { bodypart = "foot_bionic_basic_r", damage_type = "cut", amount = 5 }, { bodypart = "foot_bionic_basic_r", damage_type = "bullet", amount = 2 }, { bodypart = "foot_bionic_basic_r", damage_type = "stab", amount = 5 } },
})
content.add(content.Bionic {
    id = "bio_exodii_arm_bionic_basic_left",
    name = ccb.content.text("Cyberframe 1b: Bionic Left Arm"),
    description = ccb.content.text("You have a bionic left leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    required_bionic = "bio_exodii_cyberframe_1b",
    enchantments = { "BIONIC_ENCH_bio_exodii_arm_bionic_basic_left_0" },
    replaced_bodyparts = { "arm_l", "hand_l" },
    protection = { { bodypart = "arm_bionic_basic_l", damage_type = "bash", amount = 5 }, { bodypart = "arm_bionic_basic_l", damage_type = "cut", amount = 5 }, { bodypart = "arm_bionic_basic_l", damage_type = "bullet", amount = 2 }, { bodypart = "arm_bionic_basic_l", damage_type = "stab", amount = 5 }, { bodypart = "hand_bionic_basic_l", damage_type = "bash", amount = 5 }, { bodypart = "hand_bionic_basic_l", damage_type = "cut", amount = 5 }, { bodypart = "hand_bionic_basic_l", damage_type = "bullet", amount = 2 }, { bodypart = "hand_bionic_basic_l", damage_type = "stab", amount = 5 } },
})
content.add(content.Bionic {
    id = "bio_exodii_arm_bionic_basic_right",
    name = ccb.content.text("Cyberframe 1b: Bionic Right Arm"),
    description = ccb.content.text("You have a bionic right leg and foot fit for an Exodii Cyberframe.  These bionics mimic the dynamics of normal human limbs, but are immune to temperature and pain, don't bleed, and are modestly more sturdy."),
    required_bionic = "bio_exodii_cyberframe_1b",
    enchantments = { "BIONIC_ENCH_bio_exodii_arm_bionic_basic_right_0" },
    replaced_bodyparts = { "arm_r", "hand_r" },
    protection = { { bodypart = "arm_bionic_basic_r", damage_type = "bash", amount = 5 }, { bodypart = "arm_bionic_basic_r", damage_type = "cut", amount = 5 }, { bodypart = "arm_bionic_basic_r", damage_type = "bullet", amount = 2 }, { bodypart = "arm_bionic_basic_r", damage_type = "stab", amount = 5 }, { bodypart = "hand_bionic_basic_r", damage_type = "bash", amount = 5 }, { bodypart = "hand_bionic_basic_r", damage_type = "cut", amount = 5 }, { bodypart = "hand_bionic_basic_r", damage_type = "bullet", amount = 2 }, { bodypart = "hand_bionic_basic_r", damage_type = "stab", amount = 5 } },
})
content.add(content.Bionic {
    id = "bio_nl_collar",
    name = ccb.content.text("Mysterious collar implant"),
    description = ccb.content.text("You can feel something implanted in the nape of your neck, but you're not sure what it is.  The whole thing makes you feel a little stiff."),
    cant_remove_reason = ccb.content.text("You know there's an implant there, but it doesn't show up on the scanners?"),
    encumbrance = { { bodypart = "head", amount = 1 } },
})
content.add(content.Bionic {
    id = "bio_nl_collar_deactivated",
    name = ccb.content.text("Mysterious collar implant"),
    description = ccb.content.text("You can feel something implanted in the nape of your neck, but you're not sure what it is.  The whole thing makes you feel a little stiff."),
    encumbrance = { { bodypart = "head", amount = 1 } },
})
