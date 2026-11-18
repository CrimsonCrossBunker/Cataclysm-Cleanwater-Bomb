local ccb = require("ccb")
local content = ccb.content

content.add(content.SubBodyPart {
    id = "sub_limb_debug_tail_1",
    parent = "debug_tail",
    name = ccb.content.text("first debug sublimb for debug tail"),
    plural_name = "",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "sub_limb_debug_tail_2",
    parent = "debug_tail",
    name = ccb.content.text("second debug sublimb for debug tail"),
    plural_name = "",
    maximum_coverage = 50,
})

content.replace(content.SubBodyPart {
    id = "eyes_bulging_l",
    parent = "eyes_bulging",
    name = ccb.content.text("left bulging eye"),
    plural_name = ccb.content.text("bulging eyes"),
    opposite = "eyes_bulging_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.replace(content.SubBodyPart {
    id = "eyes_bulging_r",
    parent = "eyes_bulging",
    name = ccb.content.text("right bulging eye"),
    plural_name = ccb.content.text("bulging eyes"),
    opposite = "eyes_bulging_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_compound_l",
    parent = "eyes_insect_1",
    name = ccb.content.text("left compound eye"),
    plural_name = ccb.content.text("compound eyes"),
    opposite = "eyes_compound_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_compound_r",
    parent = "eyes_insect_1",
    name = ccb.content.text("right compound eye"),
    plural_name = ccb.content.text("compound eyes"),
    opposite = "eyes_compound_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_dragonfly_mono_l",
    parent = "eyes_dragonfly",
    name = ccb.content.text("gigantic compound eye (front left)"),
    plural_name = ccb.content.text("gigantic compound eye (front)"),
    opposite = "eyes_dragonfly_mono_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_dragonfly_mono_r",
    parent = "eyes_dragonfly",
    name = ccb.content.text("gigantic compound eye (front right)"),
    plural_name = ccb.content.text("gigantic compound eye (front)"),
    opposite = "eyes_dragonfly_mono_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.replace(content.SubBodyPart {
    id = "head_dragonfly_forehead",
    parent = "head_dragonfly",
    name = ccb.content.text("gigantic compound eye (forehead)"),
    plural_name = "",
    maximum_coverage = 20,
    similar_body_part = "head_forehead",
})

content.replace(content.SubBodyPart {
    id = "head_dragonfly_crown",
    parent = "head_dragonfly",
    name = ccb.content.text("gigantic compound eye (crown)"),
    plural_name = "",
    maximum_coverage = 20,
    similar_body_part = "head_crown",
})

content.replace(content.SubBodyPart {
    id = "head_dragonfly_nape",
    parent = "head_dragonfly",
    name = ccb.content.text("nape"),
    plural_name = "",
    maximum_coverage = 20,
    similar_body_part = "head_nape",
})

content.replace(content.SubBodyPart {
    id = "head_dragonfly_throat",
    parent = "head_dragonfly",
    name = ccb.content.text("throat"),
    plural_name = "",
    maximum_coverage = 20,
    similar_body_part = "head_throat",
})

content.replace(content.SubBodyPart {
    id = "head_dragonfly_ear_l",
    parent = "head_dragonfly",
    name = ccb.content.text("left ear"),
    plural_name = ccb.content.text("ears"),
    opposite = "head_dragonfly_ear_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "head_ear_l",
})

content.replace(content.SubBodyPart {
    id = "head_dragonfly_ear_r",
    parent = "head_dragonfly",
    name = ccb.content.text("right ear"),
    plural_name = ccb.content.text("ears"),
    opposite = "head_dragonfly_ear_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "head_ear_r",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_shoulder_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered shoulder"),
    plural_name = ccb.content.text("feathered shoulders"),
    opposite = "arm_feathers_shoulder_r",
    side = "left",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_l",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_shoulder_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered shoulder"),
    plural_name = ccb.content.text("feathered shoulders"),
    opposite = "arm_feathers_shoulder_l",
    side = "right",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_r",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_upper_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered upper arm"),
    plural_name = ccb.content.text("feathered upper arms"),
    opposite = "arm_feathers_upper_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "arm_upper_l",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_upper_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered upper arm"),
    plural_name = ccb.content.text("feathered upper arms"),
    opposite = "arm_feathers_upper_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "arm_upper_r",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_elbow_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered elbow"),
    plural_name = ccb.content.text("feathered elbows"),
    opposite = "arm_feathers_elbow_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_l",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_elbow_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered elbow"),
    plural_name = ccb.content.text("feathered elbows"),
    opposite = "arm_feathers_elbow_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_r",
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_lower_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("lower left feathered arms"),
    plural_name = ccb.content.text("lower feathered arms"),
    opposite = "arm_feathers_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.replace(content.SubBodyPart {
    id = "arm_feathers_lower_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("lower right feathered arms"),
    plural_name = ccb.content.text("lower feathered arms"),
    opposite = "arm_feathers_lower_l",
    side = "right",
    maximum_coverage = 45,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_shoulder_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "arm_wing_bird_shoulder_r",
    side = "left",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_l",
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_shoulder_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "arm_wing_bird_shoulder_l",
    side = "right",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_r",
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_upper_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "arm_wing_bird_upper_r",
    side = "left",
    maximum_coverage = 30,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_upper_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "arm_wing_bird_upper_l",
    side = "right",
    maximum_coverage = 30,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_elbow_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "arm_wing_bird_elbow_r",
    side = "left",
    maximum_coverage = 5,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_elbow_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "arm_wing_bird_elbow_l",
    side = "right",
    maximum_coverage = 5,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_lower_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("lower left wings"),
    plural_name = ccb.content.text("lower wing"),
    opposite = "arm_wing_bird_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_lower_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("lower right wing"),
    plural_name = ccb.content.text("lower wings"),
    opposite = "arm_wing_bird_lower_l",
    side = "right",
    maximum_coverage = 45,
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_fingers_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left wing talons"),
    plural_name = ccb.content.text("wing talons"),
    opposite = "arm_wing_bird_fingers_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "hand_fingers_l",
})

content.replace(content.SubBodyPart {
    id = "arm_wing_bird_fingers_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right wing talons"),
    plural_name = ccb.content.text("wing talons"),
    opposite = "arm_wing_bird_fingers_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "hand_fingers_r",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_draped_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic leg (draped)"),
    plural_name = ccb.content.text("bionic legs (draped)"),
    opposite = "leg_bionic_basic_draped_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    similar_body_part = "leg_draped_l",
    locations_under = { "leg_bionic_basic_hip_l", "leg_bionic_basic_upper_l" },
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_draped_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic leg (draped)"),
    plural_name = ccb.content.text("bionic legs (draped)"),
    opposite = "leg_bionic_basic_draped_l",
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    similar_body_part = "leg_draped_r",
    locations_under = { "leg_hip_r", "leg_upper_r" },
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_shoulder_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right bionic shoulder"),
    plural_name = ccb.content.text("bionic shoulders"),
    opposite = "arm_bionic_basic_shoulder_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_r",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_upper_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right upper bionic arm"),
    plural_name = ccb.content.text("upper bionic arms"),
    opposite = "arm_bionic_basic_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_r",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_elbow_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right bionic elbow"),
    plural_name = ccb.content.text("bionic elbows"),
    opposite = "arm_bionic_basic_elbow_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_r",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_lower_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right bionic forearm"),
    plural_name = ccb.content.text("lower bionic arms"),
    opposite = "arm_bionic_basic_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_r",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_shoulder_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left bionic shoulder"),
    plural_name = ccb.content.text("bionic shoulders"),
    opposite = "arm_bionic_basic_shoulder_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_l",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_upper_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left upper bionic arm"),
    plural_name = ccb.content.text("upper bionic arms"),
    opposite = "arm_bionic_basic_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_l",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_elbow_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left bionic elbow"),
    plural_name = ccb.content.text("bionic elbows"),
    opposite = "arm_bionic_basic_elbow_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_l",
})

content.replace(content.SubBodyPart {
    id = "arm_bionic_basic_lower_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left bionic forearm"),
    plural_name = ccb.content.text("lower bionic arms"),
    opposite = "arm_bionic_basic_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_l",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_hip_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic hip"),
    plural_name = ccb.content.text("bionic hips"),
    opposite = "leg_bionic_basic_hip_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "leg_hip_r",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_upper_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic thigh"),
    plural_name = ccb.content.text("bionic thighs"),
    opposite = "leg_bionic_basic_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "leg_upper_r",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_knee_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic knee"),
    plural_name = ccb.content.text("bionic knees"),
    opposite = "leg_bionic_basic_knee_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "leg_knee_r",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_lower_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic lower leg"),
    plural_name = ccb.content.text("bionic lower legs"),
    opposite = "leg_bionic_basic_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "leg_lower_r",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_hip_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic hip"),
    plural_name = ccb.content.text("bionic hips"),
    opposite = "leg_bionic_basic_hip_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "leg_hip_l",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_upper_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic thigh"),
    plural_name = ccb.content.text("bionic thighs"),
    opposite = "leg_bionic_basic_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "leg_upper_l",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_knee_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic knee"),
    plural_name = ccb.content.text("bionic knees"),
    opposite = "leg_bionic_basic_knee_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "leg_knee_l",
})

content.replace(content.SubBodyPart {
    id = "leg_bionic_basic_lower_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic lower leg"),
    plural_name = ccb.content.text("bionic lower legs"),
    opposite = "leg_bionic_basic_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "leg_lower_l",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_wrist_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right bionic wrist"),
    plural_name = ccb.content.text("bionic wrists"),
    opposite = "hand_bionic_basic_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_r",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_palm_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right bionic palm"),
    plural_name = ccb.content.text("bionic palms"),
    opposite = "hand_bionic_basic_palm_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_r",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_back_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right back of bionic hand"),
    plural_name = ccb.content.text("back of bionic hands"),
    opposite = "hand_bionic_basic_back_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_back_r",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_fingers_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right bionic fingers"),
    plural_name = ccb.content.text("bionic fingers"),
    opposite = "hand_bionic_basic_fingers_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_r",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_wrist_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left bionic wrist"),
    plural_name = ccb.content.text("bionic wrists"),
    opposite = "hand_bionic_basic_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_l",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_palm_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left bionic palm"),
    plural_name = ccb.content.text("bionic palms"),
    opposite = "hand_bionic_basic_palm_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_l",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_back_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left back of bionic hand"),
    plural_name = ccb.content.text("back of bionic hands"),
    opposite = "hand_bionic_basic_back_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_back_l",
})

content.replace(content.SubBodyPart {
    id = "hand_bionic_basic_fingers_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left bionic fingers"),
    plural_name = ccb.content.text("bionic fingers"),
    opposite = "hand_bionic_basic_fingers_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_l",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_sole_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic foot bottom"),
    plural_name = ccb.content.text("bionic foot bottoms"),
    opposite = "foot_bionic_basic_sole_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "foot_sole_l",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_arch_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic foot arch"),
    plural_name = ccb.content.text("bionic foot arches"),
    opposite = "foot_bionic_basic_arch_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "foot_arch_l",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_toes_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic toes"),
    plural_name = ccb.content.text("bionic toes"),
    opposite = "foot_bionic_basic_toes_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "foot_toes_l",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_ankle_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic ankle"),
    plural_name = ccb.content.text("bionic ankles"),
    opposite = "foot_bionic_basic_ankle_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "foot_ankle_l",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_heel_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic heel"),
    plural_name = ccb.content.text("bionic heels"),
    opposite = "foot_bionic_basic_heel_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "foot_heel_l",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_sole_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("right bionic foot bottom"),
    plural_name = ccb.content.text("bionic foot bottoms"),
    opposite = "foot_bionic_basic_sole_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "foot_sole_r",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_arch_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right foot arch"),
    plural_name = ccb.content.text("bionic foot arches"),
    opposite = "foot_arch_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "foot_arch_r",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_toes_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right toes"),
    plural_name = ccb.content.text("bionic toes"),
    opposite = "foot_bionic_basic_toes_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "foot_toes_r",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_ankle_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right ankle"),
    plural_name = ccb.content.text("bionic ankles"),
    opposite = "foot_bionic_basic_ankle_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "foot_ankle_r",
})

content.replace(content.SubBodyPart {
    id = "foot_bionic_basic_heel_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right heel"),
    plural_name = ccb.content.text("bionic heels"),
    opposite = "foot_bionic_basic_heel_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "foot_heel_r",
})

content.replace(content.SubBodyPart {
    id = "bionic_treads_body",
    parent = "leg_bionic_treads",
    name = ccb.content.text("tank treads shell"),
    plural_name = ccb.content.text("bionic"),
    opposite = "bionic_treads_treads",
    maximum_coverage = 80,
})

content.replace(content.SubBodyPart {
    id = "bionic_treads_treads",
    parent = "leg_bionic_treads",
    name = ccb.content.text("tank treads tracks"),
    plural_name = ccb.content.text("bionic treads"),
    opposite = "bionic_treads_body",
    maximum_coverage = 20,
})
