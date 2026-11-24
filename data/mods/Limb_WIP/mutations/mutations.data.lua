local ccb = require("ccb")

ccb.content.define_mutation {
    id = "COMPOUND_EYES",
    name = ccb.content.text("Compound Eyes"),
    points = 2,
    visibility = 9,
    ugliness = 5,
    description = ccb.content.text("Your eyes are compound, like those of an insect.  This increases your Perception by 2 whenever you aren't wearing eyewear."),
    types = { "EYES" },
    prerequisites = { "EYEBULGE" },
    valid = false,
}

-- One changing limb per changed area
ccb.content.define_mutation_type {
    id = "CHANGING_LIMB_EYES",
}

ccb.content.define_mutation_type {
    id = "CHANGING_LIMB_HEAD",
}

ccb.content.define_mutation_type {
    id = "HEAD",
}

ccb.content.define_mutation {
    id = "DEBUG_TORSO",
    name = ccb.content.text("Debug Torso Replacement"),
    points = 99,
    valid = false,
    description = ccb.content.text("They said college what make me smart, this is a lot to lug around!"),
    enchantments = { "ENCH_DEBUG_TORSO" },
    debug = true,
}

ccb.content.define_mutation {
    id = "EYEBULGE",
    name = ccb.content.text("Bulging Eyes"),
    types = { "EYES" },
    points = 0,
    visibility = 8,
    ugliness = 4,
    description = ccb.content.text("Your eyes bulge out several inches from your skull.  This does not affect your vision in any way."),
    enchantments = { "INLINE_ENCH_EYEBULGE_0" },
    additions = { "MEMBRANE", "PRE_EYES_INSECT" },
    replacements = { "EYES_INSECT", "COMPOUND_EYES", "EYESTALKS1", "CEPH_EYES", "FROG_EYES" },
    categories = { "BATRACHIAN", "INSECT", "GASTROPOD", "FISH", "CEPHALOPOD", "CRUSTACEAN" },
}

ccb.content.define_mutation {
    id = "PRE_EYES_INSECT",
    name = ccb.content.text("Changing Eyes"),
    types = { "CHANGING_LIMB_EYES" },
    prerequisites = { "EYEBULGE" },
    secondary_prerequisites = { "CHITIN2", "CHITIN2_MOLTED" },
    description = ccb.content.text("Something is shifting painfully behind your eyeballs.  <color_red>This change will be reversible.  The next one might not be, should you continue.</color>"),
    points = 0,
    cooldown = "2 h",
    on_process = "process_pre_eyes_insect",
    categories = { "INSECT" },
}

ccb.content.define_mutation {
    id = "EYES_INSECT",
    name = ccb.content.text("Compound Eyes"),
    types = { "EYES", "CHANGING_LIMB_EYES", "CHANGING_LIMB_HEAD" },
    prerequisites = { "EYEBULGE", "PRE_EYES_INSECT" },
    secondary_prerequisites = { "CHITIN2", "CHITIN2_MOLTED" },
    points = -2,
    description = ccb.content.text("Your eyes have turned into iridescent spheres bulging out of their original sockets.  Your detail vision suffered terribly, and the expanded field of view is dizzying.  <color_red>You can still go back to how you used to be.  If you continue changing in this direction you will be permanently changed.  Progress from this state will need the matching threshold.</color>"),
    categories = { "INSECT" },
    cancels = { "PRE_EYES_INSECT" },
    replacements = { "EYES_INSECT_2" },
    cooldown = "2 h",
    on_process = "process_eyes_insect",
    valid = false,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_EYES_INSECT_0" },
}

ccb.content.define_mutation {
    id = "EYES_INSECT_2",
    name = ccb.content.text("Dragonfly Eyes"),
    types = { "EYES", "HEAD" },
    prerequisites = { "EYES_INSECT" },
    secondary_prerequisites = { "CHITIN2", "CHITIN2_MOLTED" },
    points = 2,
    description = ccb.content.text("You remember having tiny, unassuming eyes condemned into cramped slits in your face.  No more.  Since your last molt your eyes take up most of your head, giving you unparalelled reactions at the cost of fine vision.  You wouldn't want to cover up too much of the view, however.  <color_red>This change is permanent.</color>"),
    categories = { "INSECT" },
    threshold_requirements = { "THRESH_INSECT" },
    valid = false,
    purifiable = false,
    vitamin_cost = 500,
    enchantments = { "INLINE_ENCH_EYES_INSECT_2_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_FOOT",
    name = ccb.content.text("Gastropod Foot"),
    points = 1,
    mixed_effect = true,
    description = ccb.content.text("Your legs have consolidated into a single muscular 'foot' that goes up into your belly.  You move about a fourth of your previous speed and can no longer wear pants or shoes, on the other hand you make significantly less noise.  In addition to being harder to knock down, you can move through sludge-covered surfaces easily."),
    categories = { "GASTROPOD" },
    types = { "RUNNING", "LEGS", "FEET" },
    prerequisites = { "SLIMY" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    additions = { "GASTROPOD_BALANCE" },
    flags = { "SLUDGE_IMMUNE" },
    enchantments = { "ENCH_GASTROPOD_FOOT", "INLINE_ENCH_GASTROPOD_FOOT_1" },
    visibility = 8,
    ugliness = 9,
    encumbrance = { leg_l = 10, leg_r = 10, foot_l = 10, foot_r = 10 },
    restricts_gear = { "leg_l", "leg_r", "foot_l", "foot_r", "leg_stub_r", "leg_stub_l" },
    destroys_gear = true,
}

ccb.content.define_mutation {
    id = "PRE_ARM_FEATHERS",
    name = ccb.content.text("Changing Arms"),
    types = { "ARMS" },
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your arms feel…different.  Occasionally something shifts under the skin - sometimes it does so without pain.  Whatever is happening in there, it's far from done.  <color_red>This change will be reversible.  The next one might not be, should you continue.</color>"),
    cooldown = "2 h",
    replacements = { "ARM_FEATHERS" },
    prerequisites = { "FEATHERS", "SPARSE_SCALES" },
    on_process = "process_pre_arm_feathers",
    categories = { "BIRD", "RAPTOR" },
}

ccb.content.define_mutation {
    id = "ARM_FEATHERS",
    name = ccb.content.text("Feathered Arms"),
    types = { "ARMS" },
    points = 2,
    visibility = 8,
    mixed_effect = true,
    description = ccb.content.text("Your forearms are covered by long, stiff feathers.  While they are impressive to look at and resistant to water and other contaminants, they always get in the way and you hate it when they get filthy.  <color_red>You can still go back to how you used to be.  If you continue changing in this direction you will be permanently changed.  Progress from this state will need the matching threshold.</color>"),
    categories = { "RAPTOR", "BIRD" },
    prerequisites = { "FEATHERS", "SPARSE_SCALES" },
    secondary_prerequisites = { "PRE_ARM_FEATHERS" },
    valid = false,
    replacements = { "WINGS_BIRD" },
    cooldown = "2 h",
    on_process = "process_arm_feathers",
    vitamin_cost = 150,
    enchantments = { "INLINE_ENCH_ARM_FEATHERS_0" },
}

ccb.content.define_mutation {
    id = "WINGS_BIRD",
    name = ccb.content.text("Bird Wings"),
    points = 2,
    visibility = 4,
    ugliness = 2,
    description = ccb.content.text("Your arms have mostly transformed into a huge pair of feathered wings.  Though you retain a few fingers, your fine manipulation is greatly hampered.  On the other hand, you can glide from ledges and will take less damage if you fall, provided you're healthy and unburdened."),
    types = { "ARMS", "HANDS" },
    enchantments = { "INLINE_ENCH_WINGS_BIRD_0" },
    prerequisites = { "ARM_FEATHERS" },
    secondary_prerequisites = { "HOLLOW_BONES" },
    threshold_requirements = { "THRESH_BIRD" },
    categories = { "BIRD" },
    restricts_gear = { "arm_l", "arm_r", "hand_l", "hand_r", "arm_stub_r", "arm_stub_l" },
    vitamin_cost = 300,
    valid = false,
    flags = { "WINGS_2" },
}

ccb.content.define_mutation {
    id = "BIRD_LEGS",
    name = ccb.content.text("Avian Legs"),
    points = 0,
    visibility = 4,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("Your legs and feet have become bird-like, with long talons arranged three ahead and one behind.  They probably won't fit in human shoes, but they're perfect for gripping onto precarious perches."),
    active = true,
    activation_setup_only = false,
    on_activate = "activate_avian_leap",
    types = { "LEGS", "FEET" },
    threshold_requirements = { "THRESH_BIRD" },
    categories = { "BIRD" },
    restricts_gear = { "foot_l", "foot_r" },
    destroys_gear = true,
    allowed_item_flags = { "ALLOWS_TALONS" },
}

ccb.content.define_mutation {
    id = "WINGS_STUB",
    name = ccb.content.text("Wing Stubs"),
    points = 0,
    visibility = 2,
    ugliness = 2,
    description = ccb.content.text("You have a pair of stubby little wings projecting from your shoulderblades.  They can be wiggled at will, but are useless."),
    types = { "WINGS" },
    replacements = { "WINGS_INSECT", "WINGS_BUTTERFLY" },
    categories = { "INSECT" },
}

ccb.content.define_mutation {
    id = "HAS_LEFT_LEG",
    name = ccb.content.text_without_extraction("left leg"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_LEFT_LEG" },
    restricts_gear = { "leg_stub_l" },
}

ccb.content.define_mutation {
    id = "HAS_RIGHT_LEG",
    name = ccb.content.text_without_extraction("right leg"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_RIGHT_LEG" },
    restricts_gear = { "leg_stub_r" },
}

ccb.content.define_mutation {
    id = "HAS_LEFT_ARM",
    name = ccb.content.text_without_extraction("left arm"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_LEFT_ARM" },
    restricts_gear = { "arm_stub_l" },
}

ccb.content.define_mutation {
    id = "HAS_RIGHT_ARM",
    name = ccb.content.text_without_extraction("right arm"),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Dummy mutation that keeps you from wearing prosthetics."),
    replacements = { "NO_RIGHT_ARM" },
    restricts_gear = { "arm_stub_r" },
}

ccb.content.define_mutation {
    id = "NO_RIGHT_LEG",
    name = ccb.content.text("No Right Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your right leg.  You can hobble around, but will likely need a wheelchair or other means of locomotion to get somewhere far."),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_r" },
    restricts_gear = { "foot_r" },
    prerequisites = { "HAS_RIGHT_LEG" },
    allowed_item_flags = { "LEG_PROSTHETIC" },
    enchantments = { "ENCH_NO_RIGHT_LEG" },
    cancels = {
        "BADKNEES", "LIGHTSTEP", "STRONGKNEES", "STRONG_LEGS", "PADDED_FEET", "ANIMAL_FEET",
        "FELINE_LEAP", "LEAPING_LEGS", "LEAPING_LEGS2", "BIRD_LEGS", "FLEET2", "FLEET", "HOOVES",
        "RABBIT_FEET", "TOUGH_FEET", "RAP_TALONS", "WEBBED_FEET",
    },
}

ccb.content.define_mutation {
    id = "NO_LEFT_LEG",
    name = ccb.content.text("No Left Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your left leg.  You can hobble around, but will likely need a wheelchair or other means of locomotion to get somewhere far."),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_l" },
    restricts_gear = { "foot_l" },
    prerequisites = { "HAS_LEFT_LEG" },
    allowed_item_flags = { "LEG_PROSTHETIC" },
    enchantments = { "ENCH_NO_LEFT_LEG" },
    cancels = {
        "BADKNEES", "LIGHTSTEP", "STRONGKNEES", "STRONG_LEGS", "PADDED_FEET", "ANIMAL_FEET",
        "FELINE_LEAP", "LEAPING_LEGS", "LEAPING_LEGS2", "BIRD_LEGS", "FLEET2", "FLEET", "HOOVES",
        "RABBIT_FEET", "TOUGH_FEET", "RAP_TALONS", "WEBBED_FEET",
    },
}

ccb.content.define_mutation {
    id = "NO_LEFT_ARM",
    name = ccb.content.text("No Left Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your left arm.  As such, you cannot use anything you normally could with it, like lifting with two hands."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_l" },
    restricts_gear = { "hand_l" },
    prerequisites = { "HAS_LEFT_ARM" },
    allowed_item_flags = { "ARM_PROSTHETIC" },
    enchantments = { "ENCH_NO_LEFT_ARM" },
    cancels = {
        "BARBS", "NAILS", "CLAWS", "CLAWS_RAT", "CLAWS_ST", "CLAWS_RETRACT", "CLAWS_TENTACLE",
        "ARM_FEATHERS", "TALONS", "BENDY1", "PAWS", "PAWS_LARGE", "BURROW", "BURROWLARGE", "PAWS_LITTLE",
        "SLIME_HANDS", "WEBBED",
    },
}

ccb.content.define_mutation {
    id = "NO_RIGHT_ARM",
    name = ccb.content.text("No Right Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("Whether by a serious accident, birth defect, or other means, you have lost your right arm.  As such, you cannot use anything you normally could with it, like lifting with two hands."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_r" },
    restricts_gear = { "hand_r" },
    prerequisites = { "HAS_RIGHT_ARM" },
    allowed_item_flags = { "ARM_PROSTHETIC" },
    enchantments = { "ENCH_NO_RIGHT_ARM" },
    cancels = {
        "CRUSTACEAN_CLAW", "BARBS", "NAILS", "CLAWS", "CLAWS_RAT", "CLAWS_ST", "CLAWS_RETRACT",
        "CLAWS_TENTACLE", "TALONS", "ARM_FEATHERS", "BENDY1", "PAWS", "PAWS_LARGE", "BURROW",
        "BURROWLARGE", "PAWS_LITTLE", "SLIME_HANDS", "WEBBED",
    },
}

ccb.content.define_mutation {
    id = "RIGHT_PROSTHETIC_LEG",
    name = ccb.content.text("Right Prosthetic Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right leg."),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_prosthetic_r" },
    on_process = "wear_right_leg_prosthetic",
    enchantments = { "ENCH_RIGHT_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "LEFT_PROSTHETIC_LEG",
    name = ccb.content.text("Left Prosthetic Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left leg."),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_prosthetic_l" },
    on_process = "wear_left_leg_prosthetic",
    enchantments = { "ENCH_LEFT_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_PEG_LEG",
    name = ccb.content.text("Right Peg Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right leg."),
    bionic_exclusions = { "leg_knee_r", "leg_lower_r", "leg_draped_r", "foot_r" },
    on_process = "wear_right_leg_prosthetic",
    enchantments = { "ENCH_RIGHT_PEGLEG" },
}

ccb.content.define_mutation {
    id = "LEFT_PEG_LEG",
    name = ccb.content.text("Left Peg Leg"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left leg."),
    bionic_exclusions = { "leg_knee_l", "leg_lower_l", "leg_draped_l", "foot_l" },
    on_process = "wear_left_leg_prosthetic",
    enchantments = { "ENCH_LEFT_PEGLEG" },
}

ccb.content.define_mutation {
    id = "LEFT_PROSTHETIC_ARM",
    name = ccb.content.text("Left Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left arm."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_prosthetic_l" },
    on_process = "wear_left_arm_prosthetic",
    enchantments = { "ENCH_LEFT_ARM_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_PROSTHETIC_ARM",
    name = ccb.content.text("Right Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right arm."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_prosthetic_r" },
    on_process = "wear_right_arm_prosthetic",
    enchantments = { "ENCH_RIGHT_ARM_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "LEFT_NEUROPROSTHETIC_ARM",
    name = ccb.content.text("Left Neuroprosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left arm."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_neuroprosthetic_l" },
    on_process = "wear_left_arm_prosthetic",
    enchantments = { "ENCH_LEFT_ARM_NEUROPROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_NEUROPROSTHETIC_ARM",
    name = ccb.content.text("Right Neuroprosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right arm."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_neuroprosthetic_r" },
    on_process = "wear_right_arm_prosthetic",
    enchantments = { "ENCH_RIGHT_ARM_NEUROPROSTHETIC" },
}

ccb.content.define_mutation {
    id = "LEFT_COSMETIC_PROSTHETIC_ARM",
    name = ccb.content.text("Left Cosmetic Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your left arm."),
    bionic_exclusions = { "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_prosthetic_l" },
    on_process = "wear_left_arm_prosthetic",
    enchantments = { "ENCH_LEFT_ARM_COSMETIC_PROSTHETIC" },
}

ccb.content.define_mutation {
    id = "RIGHT_COSMETIC_PROSTHETIC_ARM",
    name = ccb.content.text("Right Cosmetic Prosthetic Arm"),
    points = 0,
    valid = false,
    purifiable = false,
    description = ccb.content.text("You have a prosthetic on your right arm."),
    bionic_exclusions = { "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_prosthetic_r" },
    on_process = "wear_right_arm_prosthetic",
    enchantments = { "ENCH_RIGHT_ARM_COSMETIC_PROSTHETIC" },
}
