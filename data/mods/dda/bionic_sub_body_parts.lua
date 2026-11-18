local ccb = require("ccb")
local content = ccb.content

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_draped_l",
    parent = "robofac_leg_bionic_basic_l",
    name = ccb.content.text("left bionic leg (draped)"),
    plural_name = ccb.content.text("bionic legs (draped)"),
    opposite = "robofac_leg_bionic_basic_draped_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    similar_body_part = "leg_draped_l",
    locations_under = { "robofac_leg_bionic_basic_hip_l", "robofac_leg_bionic_basic_upper_l" },
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_draped_r",
    parent = "robofac_leg_bionic_basic_r",
    name = ccb.content.text("right bionic leg (draped)"),
    plural_name = ccb.content.text("bionic legs (draped)"),
    opposite = "robofac_leg_bionic_basic_draped_l",
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    similar_body_part = "leg_draped_r",
    locations_under = { "leg_hip_r", "leg_upper_r" },
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_shoulder_r",
    parent = "robofac_arm_bionic_basic_r",
    name = ccb.content.text("right bionic shoulder"),
    plural_name = ccb.content.text("bionic shoulders"),
    opposite = "robofac_arm_bionic_basic_shoulder_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_r",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_upper_r",
    parent = "robofac_arm_bionic_basic_r",
    name = ccb.content.text("right upper bionic arm"),
    plural_name = ccb.content.text("upper bionic arms"),
    opposite = "robofac_arm_bionic_basic_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_r",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_elbow_r",
    parent = "robofac_arm_bionic_basic_r",
    name = ccb.content.text("right bionic elbow"),
    plural_name = ccb.content.text("bionic elbows"),
    opposite = "robofac_arm_bionic_basic_elbow_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_r",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_lower_r",
    parent = "robofac_arm_bionic_basic_r",
    name = ccb.content.text("right bionic forearm"),
    plural_name = ccb.content.text("lower bionic arms"),
    opposite = "robofac_arm_bionic_basic_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_r",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_shoulder_l",
    parent = "robofac_arm_bionic_basic_l",
    name = ccb.content.text("left bionic shoulder"),
    plural_name = ccb.content.text("bionic shoulders"),
    opposite = "robofac_arm_bionic_basic_shoulder_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_l",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_upper_l",
    parent = "robofac_arm_bionic_basic_l",
    name = ccb.content.text("left upper bionic arm"),
    plural_name = ccb.content.text("upper bionic arms"),
    opposite = "robofac_arm_bionic_basic_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_l",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_elbow_l",
    parent = "robofac_arm_bionic_basic_l",
    name = ccb.content.text("left bionic elbow"),
    plural_name = ccb.content.text("bionic elbows"),
    opposite = "robofac_arm_bionic_basic_elbow_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_l",
})

content.add(content.SubBodyPart {
    id = "robofac_arm_bionic_basic_lower_l",
    parent = "robofac_arm_bionic_basic_l",
    name = ccb.content.text("left bionic forearm"),
    plural_name = ccb.content.text("lower bionic arms"),
    opposite = "robofac_arm_bionic_basic_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_l",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_hip_r",
    parent = "robofac_leg_bionic_basic_r",
    name = ccb.content.text("right bionic hip"),
    plural_name = ccb.content.text("bionic hips"),
    opposite = "robofac_leg_bionic_basic_hip_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "leg_hip_r",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_upper_r",
    parent = "robofac_leg_bionic_basic_r",
    name = ccb.content.text("right bionic thigh"),
    plural_name = ccb.content.text("bionic thighs"),
    opposite = "robofac_leg_bionic_basic_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "leg_upper_r",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_knee_r",
    parent = "robofac_leg_bionic_basic_r",
    name = ccb.content.text("right bionic knee"),
    plural_name = ccb.content.text("bionic knees"),
    opposite = "robofac_leg_bionic_basic_knee_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "leg_knee_r",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_lower_r",
    parent = "robofac_leg_bionic_basic_r",
    name = ccb.content.text("right bionic lower leg"),
    plural_name = ccb.content.text("bionic lower legs"),
    opposite = "robofac_leg_bionic_basic_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "leg_lower_r",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_hip_l",
    parent = "robofac_leg_bionic_basic_l",
    name = ccb.content.text("left bionic hip"),
    plural_name = ccb.content.text("bionic hips"),
    opposite = "robofac_leg_bionic_basic_hip_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "leg_hip_l",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_upper_l",
    parent = "robofac_leg_bionic_basic_l",
    name = ccb.content.text("left bionic thigh"),
    plural_name = ccb.content.text("bionic thighs"),
    opposite = "robofac_leg_bionic_basic_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "leg_upper_l",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_knee_l",
    parent = "robofac_leg_bionic_basic_l",
    name = ccb.content.text("left bionic knee"),
    plural_name = ccb.content.text("bionic knees"),
    opposite = "robofac_leg_bionic_basic_knee_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "leg_knee_l",
})

content.add(content.SubBodyPart {
    id = "robofac_leg_bionic_basic_lower_l",
    parent = "robofac_leg_bionic_basic_l",
    name = ccb.content.text("left bionic lower leg"),
    plural_name = ccb.content.text("bionic lower legs"),
    opposite = "robofac_leg_bionic_basic_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "leg_lower_l",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_wrist_r",
    parent = "robofac_hand_bionic_basic_r",
    name = ccb.content.text("right bionic wrist"),
    plural_name = ccb.content.text("bionic wrists"),
    opposite = "robofac_hand_bionic_basic_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_r",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_palm_r",
    parent = "robofac_hand_bionic_basic_r",
    name = ccb.content.text("right bionic palm"),
    plural_name = ccb.content.text("bionic palms"),
    opposite = "robofac_hand_bionic_basic_palm_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_r",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_back_r",
    parent = "robofac_hand_bionic_basic_r",
    name = ccb.content.text("right back of bionic hand"),
    plural_name = ccb.content.text("back of bionic hands"),
    opposite = "robofac_hand_bionic_basic_back_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_back_r",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_fingers_r",
    parent = "robofac_hand_bionic_basic_r",
    name = ccb.content.text("right bionic fingers"),
    plural_name = ccb.content.text("bionic fingers"),
    opposite = "robofac_hand_bionic_basic_fingers_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_r",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_wrist_l",
    parent = "robofac_hand_bionic_basic_l",
    name = ccb.content.text("left bionic wrist"),
    plural_name = ccb.content.text("bionic wrists"),
    opposite = "robofac_hand_bionic_basic_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_l",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_palm_l",
    parent = "robofac_hand_bionic_basic_l",
    name = ccb.content.text("left bionic palm"),
    plural_name = ccb.content.text("bionic palms"),
    opposite = "robofac_hand_bionic_basic_palm_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_l",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_back_l",
    parent = "robofac_hand_bionic_basic_l",
    name = ccb.content.text("left back of bionic hand"),
    plural_name = ccb.content.text("back of bionic hands"),
    opposite = "robofac_hand_bionic_basic_back_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_back_l",
})

content.add(content.SubBodyPart {
    id = "robofac_hand_bionic_basic_fingers_l",
    parent = "robofac_hand_bionic_basic_l",
    name = ccb.content.text("left bionic fingers"),
    plural_name = ccb.content.text("bionic fingers"),
    opposite = "robofac_hand_bionic_basic_fingers_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_l",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_sole_l",
    parent = "robofac_foot_bionic_basic_l",
    name = ccb.content.text("left bionic foot bottom"),
    plural_name = ccb.content.text("bionic foot bottoms"),
    opposite = "robofac_foot_bionic_basic_sole_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "foot_sole_l",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_arch_l",
    parent = "robofac_foot_bionic_basic_l",
    name = ccb.content.text("left bionic foot arch"),
    plural_name = ccb.content.text("bionic foot arches"),
    opposite = "robofac_foot_bionic_basic_arch_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "foot_arch_l",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_toes_l",
    parent = "robofac_foot_bionic_basic_l",
    name = ccb.content.text("left bionic toes"),
    plural_name = ccb.content.text("bionic toes"),
    opposite = "robofac_foot_bionic_basic_toes_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "foot_toes_l",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_ankle_l",
    parent = "robofac_foot_bionic_basic_l",
    name = ccb.content.text("left bionic ankle"),
    plural_name = ccb.content.text("bionic ankles"),
    opposite = "robofac_foot_bionic_basic_ankle_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "foot_ankle_l",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_heel_l",
    parent = "robofac_foot_bionic_basic_l",
    name = ccb.content.text("left bionic heel"),
    plural_name = ccb.content.text("bionic heels"),
    opposite = "robofac_foot_bionic_basic_heel_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "foot_heel_l",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_sole_r",
    parent = "robofac_foot_bionic_basic_r",
    name = ccb.content.text("right bionic foot bottom"),
    plural_name = ccb.content.text("bionic foot bottoms"),
    opposite = "robofac_foot_bionic_basic_sole_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "foot_sole_r",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_arch_r",
    parent = "robofac_foot_bionic_basic_r",
    name = ccb.content.text("bionic right foot arch"),
    plural_name = ccb.content.text("bionic foot arches"),
    opposite = "foot_arch_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "foot_arch_r",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_toes_r",
    parent = "robofac_foot_bionic_basic_r",
    name = ccb.content.text("bionic right toes"),
    plural_name = ccb.content.text("bionic toes"),
    opposite = "robofac_foot_bionic_basic_toes_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "foot_toes_r",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_ankle_r",
    parent = "robofac_foot_bionic_basic_r",
    name = ccb.content.text("bionic right ankle"),
    plural_name = ccb.content.text("bionic ankles"),
    opposite = "robofac_foot_bionic_basic_ankle_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "foot_ankle_r",
})

content.add(content.SubBodyPart {
    id = "robofac_foot_bionic_basic_heel_r",
    parent = "robofac_foot_bionic_basic_r",
    name = ccb.content.text("bionic right heel"),
    plural_name = ccb.content.text("bionic heels"),
    opposite = "robofac_foot_bionic_basic_heel_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "foot_heel_r",
})

content.add(content.SubBodyPart {
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

content.add(content.SubBodyPart {
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

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_shoulder_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right bionic shoulder"),
    plural_name = ccb.content.text("bionic shoulders"),
    opposite = "arm_bionic_basic_shoulder_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_r",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_upper_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right upper bionic arm"),
    plural_name = ccb.content.text("upper bionic arms"),
    opposite = "arm_bionic_basic_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_r",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_elbow_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right bionic elbow"),
    plural_name = ccb.content.text("bionic elbows"),
    opposite = "arm_bionic_basic_elbow_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_r",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_lower_r",
    parent = "arm_bionic_basic_r",
    name = ccb.content.text("right bionic forearm"),
    plural_name = ccb.content.text("lower bionic arms"),
    opposite = "arm_bionic_basic_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_r",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_shoulder_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left bionic shoulder"),
    plural_name = ccb.content.text("bionic shoulders"),
    opposite = "arm_bionic_basic_shoulder_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_l",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_upper_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left upper bionic arm"),
    plural_name = ccb.content.text("upper bionic arms"),
    opposite = "arm_bionic_basic_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_l",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_elbow_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left bionic elbow"),
    plural_name = ccb.content.text("bionic elbows"),
    opposite = "arm_bionic_basic_elbow_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_l",
})

content.add(content.SubBodyPart {
    id = "arm_bionic_basic_lower_l",
    parent = "arm_bionic_basic_l",
    name = ccb.content.text("left bionic forearm"),
    plural_name = ccb.content.text("lower bionic arms"),
    opposite = "arm_bionic_basic_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_l",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_hip_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic hip"),
    plural_name = ccb.content.text("bionic hips"),
    opposite = "leg_bionic_basic_hip_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "leg_hip_r",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_upper_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic thigh"),
    plural_name = ccb.content.text("bionic thighs"),
    opposite = "leg_bionic_basic_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "leg_upper_r",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_knee_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic knee"),
    plural_name = ccb.content.text("bionic knees"),
    opposite = "leg_bionic_basic_knee_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "leg_knee_r",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_lower_r",
    parent = "leg_bionic_basic_r",
    name = ccb.content.text("right bionic lower leg"),
    plural_name = ccb.content.text("bionic lower legs"),
    opposite = "leg_bionic_basic_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "leg_lower_r",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_hip_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic hip"),
    plural_name = ccb.content.text("bionic hips"),
    opposite = "leg_bionic_basic_hip_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "leg_hip_l",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_upper_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic thigh"),
    plural_name = ccb.content.text("bionic thighs"),
    opposite = "leg_bionic_basic_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "leg_upper_l",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_knee_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic knee"),
    plural_name = ccb.content.text("bionic knees"),
    opposite = "leg_bionic_basic_knee_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "leg_knee_l",
})

content.add(content.SubBodyPart {
    id = "leg_bionic_basic_lower_l",
    parent = "leg_bionic_basic_l",
    name = ccb.content.text("left bionic lower leg"),
    plural_name = ccb.content.text("bionic lower legs"),
    opposite = "leg_bionic_basic_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "leg_lower_l",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_wrist_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right bionic wrist"),
    plural_name = ccb.content.text("bionic wrists"),
    opposite = "hand_bionic_basic_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_r",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_palm_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right bionic palm"),
    plural_name = ccb.content.text("bionic palms"),
    opposite = "hand_bionic_basic_palm_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_r",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_back_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right back of bionic hand"),
    plural_name = ccb.content.text("back of bionic hands"),
    opposite = "hand_bionic_basic_back_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_back_r",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_fingers_r",
    parent = "hand_bionic_basic_r",
    name = ccb.content.text("right bionic fingers"),
    plural_name = ccb.content.text("bionic fingers"),
    opposite = "hand_bionic_basic_fingers_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_r",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_wrist_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left bionic wrist"),
    plural_name = ccb.content.text("bionic wrists"),
    opposite = "hand_bionic_basic_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_l",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_palm_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left bionic palm"),
    plural_name = ccb.content.text("bionic palms"),
    opposite = "hand_bionic_basic_palm_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_l",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_back_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left back of bionic hand"),
    plural_name = ccb.content.text("back of bionic hands"),
    opposite = "hand_bionic_basic_back_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_back_l",
})

content.add(content.SubBodyPart {
    id = "hand_bionic_basic_fingers_l",
    parent = "hand_bionic_basic_l",
    name = ccb.content.text("left bionic fingers"),
    plural_name = ccb.content.text("bionic fingers"),
    opposite = "hand_bionic_basic_fingers_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_l",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_sole_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic foot bottom"),
    plural_name = ccb.content.text("bionic foot bottoms"),
    opposite = "foot_bionic_basic_sole_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "foot_sole_l",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_arch_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic foot arch"),
    plural_name = ccb.content.text("bionic foot arches"),
    opposite = "foot_bionic_basic_arch_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "foot_arch_l",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_toes_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic toes"),
    plural_name = ccb.content.text("bionic toes"),
    opposite = "foot_bionic_basic_toes_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "foot_toes_l",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_ankle_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic ankle"),
    plural_name = ccb.content.text("bionic ankles"),
    opposite = "foot_bionic_basic_ankle_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "foot_ankle_l",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_heel_l",
    parent = "foot_bionic_basic_l",
    name = ccb.content.text("left bionic heel"),
    plural_name = ccb.content.text("bionic heels"),
    opposite = "foot_bionic_basic_heel_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "foot_heel_l",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_sole_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("right bionic foot bottom"),
    plural_name = ccb.content.text("bionic foot bottoms"),
    opposite = "foot_bionic_basic_sole_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "foot_sole_r",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_arch_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right foot arch"),
    plural_name = ccb.content.text("bionic foot arches"),
    opposite = "foot_arch_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "foot_arch_r",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_toes_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right toes"),
    plural_name = ccb.content.text("bionic toes"),
    opposite = "foot_bionic_basic_toes_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "foot_toes_r",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_ankle_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right ankle"),
    plural_name = ccb.content.text("bionic ankles"),
    opposite = "foot_bionic_basic_ankle_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "foot_ankle_r",
})

content.add(content.SubBodyPart {
    id = "foot_bionic_basic_heel_r",
    parent = "foot_bionic_basic_r",
    name = ccb.content.text("bionic right heel"),
    plural_name = ccb.content.text("bionic heels"),
    opposite = "foot_bionic_basic_heel_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "foot_heel_r",
})

content.add(content.SubBodyPart {
    id = "torso_bionic_basic_upper",
    parent = "torso_bionic_basic",
    name = ccb.content.text("bionic upper torso"),
    plural_name = ccb.content.text("torso"),
    opposite = "torso_bionic_basic_lower",
    maximum_coverage = 60,
    similar_body_part = "torso_upper",
})

content.add(content.SubBodyPart {
    id = "torso_bionic_basic_neck",
    parent = "torso_bionic_basic",
    name = ccb.content.text("bionic neck"),
    plural_name = "",
    opposite = "sub_limb_debug",
    secondary = true,
    maximum_coverage = 10,
    similar_body_part = "torso_neck",
    locations_under = { "torso_upper" },
})

content.add(content.SubBodyPart {
    id = "torso_bionic_basic_lower",
    parent = "torso_bionic_basic",
    name = ccb.content.text("bionic lower torso"),
    plural_name = ccb.content.text("torso"),
    opposite = "torso_bionic_basic_upper",
    maximum_coverage = 40,
    similar_body_part = "torso_lower",
})

content.add(content.SubBodyPart {
    id = "torso_bionic_basic_hanging_front",
    parent = "torso_bionic_basic",
    name = ccb.content.text("bionic front torso (hang)"),
    plural_name = ccb.content.text("item hangs off you"),
    opposite = "torso_bionic_basic_hanging_back",
    secondary = true,
    maximum_coverage = 35,
    similar_body_part = "torso_hanging_front",
    locations_under = { "torso_bionic_basic_upper", "torso_bionic_basic_lower" },
})

content.add(content.SubBodyPart {
    id = "torso_bionic_basic_hanging_back",
    parent = "torso_bionic_basic",
    name = ccb.content.text("bionic back torso (hang)"),
    plural_name = ccb.content.text("item hangs off you"),
    opposite = "torso_bionic_basic_hanging_front",
    secondary = true,
    maximum_coverage = 45,
    similar_body_part = "torso_hanging_back",
    locations_under = { "torso_bionic_basic_upper", "torso_bionic_basic_lower" },
})

content.add(content.SubBodyPart {
    id = "torso_bionic_basic_waist",
    parent = "torso_bionic_basic",
    name = ccb.content.text("bionic waist"),
    plural_name = "",
    opposite = "sub_limb_debug",
    secondary = true,
    maximum_coverage = 10,
    similar_body_part = "torso_waist",
    locations_under = { "leg_bionic_basic_hip_r", "leg_bionic_basic_hip_l" },
})

content.add(content.SubBodyPart {
    id = "head_bionic_basic_forehead",
    parent = "head_bionic_basic",
    name = ccb.content.text("bionic forehead"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "head_forehead",
})

content.add(content.SubBodyPart {
    id = "head_bionic_basic_crown",
    parent = "head_bionic_basic",
    name = ccb.content.text("bionic crown"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
    similar_body_part = "head_crown",
})

content.add(content.SubBodyPart {
    id = "head_bionic_basic_nape",
    parent = "head_bionic_basic",
    name = ccb.content.text("bionic nape"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "head_nape",
})

content.add(content.SubBodyPart {
    id = "head_bionic_basic_throat",
    parent = "head_bionic_basic",
    name = ccb.content.text("bionic throat"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "head_throat",
})

content.add(content.SubBodyPart {
    id = "head_bionic_basic_ear_r",
    parent = "head_bionic_basic",
    name = ccb.content.text("bionic r. ear"),
    plural_name = ccb.content.text("bionic ears"),
    opposite = "head_ear_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "head_ear_r",
})

content.add(content.SubBodyPart {
    id = "head_bionic_basic_ear_l",
    parent = "head_bionic_basic",
    name = ccb.content.text("bionic l. ear"),
    plural_name = ccb.content.text("bionic ears"),
    opposite = "head_ear_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "head_ear_l",
})

content.add(content.SubBodyPart {
    id = "eyes_bionic_basic_left",
    parent = "eyes_bionic_basic",
    name = ccb.content.text("bionic l. eye"),
    plural_name = ccb.content.text("bionic eyes"),
    opposite = "eyes_bionic_basic_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_bionic_basic_right",
    parent = "eyes_bionic_basic",
    name = ccb.content.text("bionic r. eye"),
    plural_name = ccb.content.text("bionic eyes"),
    opposite = "eyes_bionic_basic_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "mouth_bionic_basic_lips",
    parent = "mouth_bionic_basic",
    name = ccb.content.text("bionic lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "mouth_lips",
})

content.add(content.SubBodyPart {
    id = "mouth_bionic_basic_nose",
    parent = "mouth_bionic_basic",
    name = ccb.content.text("bionic nose"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "mouth_nose",
})

content.add(content.SubBodyPart {
    id = "mouth_bionic_basic_cheeks",
    parent = "mouth_bionic_basic",
    name = ccb.content.text("bionic cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "mouth_cheeks",
})

content.add(content.SubBodyPart {
    id = "mouth_bionic_basic_chin",
    parent = "mouth_bionic_basic",
    name = ccb.content.text("bionic chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 40,
    similar_body_part = "mouth_chin",
})

content.add(content.SubBodyPart {
    id = "bionic_treads_body",
    parent = "bionic_treads_leg",
    name = ccb.content.text("bionic treads shell"),
    plural_name = ccb.content.text("bionic"),
    opposite = "bionic_treads_treads",
    maximum_coverage = 80,
})

content.add(content.SubBodyPart {
    id = "bionic_treads_treads",
    parent = "bionic_treads_leg",
    name = ccb.content.text("bionic treads tracks"),
    plural_name = ccb.content.text("bionic treads"),
    opposite = "bionic_treads_body",
    maximum_coverage = 20,
})
