local ccb = require("ccb")
local content = ccb.content

local templates = {}

local function template(options)
    templates[options.id] = options
    content.add(content.SubBodyPart(options))
end

content.add(content.SubBodyPart {
    id = "sub_limb_debug",
    parent = "bp_null",
    name = "debug limb should never be seen",
    plural_name = "",
})

content.add(content.SubBodyPart {
    id = "sub_limb_debug_tail",
    parent = "debug_tail",
    name = "debug limb for debug tail",
    plural_name = "",
})

content.add(content.SubBodyPart {
    id = "sub_limb_debug_muzzle",
    parent = "muzzle",
    name = "debug limb for debug muzzle",
    plural_name = "",
})

template({
    id = "torso_upper",
    parent = "torso",
    name = ccb.content.text("upper torso"),
    plural_name = ccb.content.text("torso"),
    opposite = "torso_lower",
    maximum_coverage = 60,
})

template({
    id = "torso_neck",
    parent = "torso",
    name = ccb.content.text("neck"),
    plural_name = "",
    opposite = "sub_limb_debug",
    secondary = true,
    maximum_coverage = 10,
    locations_under = { "torso_upper" },
})

template({
    id = "torso_lower",
    parent = "torso",
    name = ccb.content.text("lower torso"),
    plural_name = ccb.content.text("torso"),
    opposite = "torso_upper",
    maximum_coverage = 40,
})

template({
    id = "torso_hanging_front",
    parent = "torso",
    name = ccb.content.text("front torso (hang)"),
    plural_name = ccb.content.text("item hangs off you"),
    opposite = "torso_hanging_back",
    secondary = true,
    maximum_coverage = 35,
    locations_under = { "torso_upper", "torso_lower" },
})

template({
    id = "torso_hanging_back",
    parent = "torso",
    name = ccb.content.text("back torso (hang)"),
    plural_name = ccb.content.text("item hangs off you"),
    opposite = "torso_hanging_front",
    secondary = true,
    maximum_coverage = 45,
    locations_under = { "torso_upper", "torso_lower" },
})

content.add(content.SubBodyPart {
    id = "leg_draped_l",
    parent = "leg_l",
    name = ccb.content.text("left leg (draped)"),
    plural_name = ccb.content.text("legs (draped)"),
    opposite = "leg_draped_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "leg_hip_l", "leg_upper_l" },
})

content.add(content.SubBodyPart {
    id = "leg_draped_r",
    parent = "leg_r",
    name = ccb.content.text("right leg (draped)"),
    plural_name = ccb.content.text("legs (draped)"),
    opposite = "leg_draped_l",
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "leg_hip_r", "leg_upper_r" },
})

template({
    id = "torso_waist",
    parent = "torso",
    name = ccb.content.text("waist"),
    plural_name = "",
    opposite = "sub_limb_debug",
    secondary = true,
    maximum_coverage = 10,
    locations_under = { "leg_hip_r", "leg_hip_l" },
})

template({
    id = "arm_shoulder_r",
    parent = "arm_r",
    name = ccb.content.text("right shoulder"),
    plural_name = ccb.content.text("shoulders"),
    opposite = "arm_shoulder_l",
    side = "right",
    maximum_coverage = 20,
})

template({
    id = "arm_upper_r",
    parent = "arm_r",
    name = ccb.content.text("right upper arm"),
    plural_name = ccb.content.text("upper arms"),
    opposite = "arm_upper_l",
    side = "right",
    maximum_coverage = 40,
})

template({
    id = "arm_elbow_r",
    parent = "arm_r",
    name = ccb.content.text("right elbow"),
    plural_name = ccb.content.text("elbows"),
    opposite = "arm_elbow_l",
    side = "right",
    maximum_coverage = 5,
})

template({
    id = "arm_lower_r",
    parent = "arm_r",
    name = ccb.content.text("right forearm"),
    plural_name = ccb.content.text("lower arms"),
    opposite = "arm_lower_l",
    side = "right",
    maximum_coverage = 35,
})

template({
    id = "arm_shoulder_l",
    parent = "arm_l",
    name = ccb.content.text("left shoulder"),
    plural_name = ccb.content.text("shoulders"),
    opposite = "arm_shoulder_r",
    side = "left",
    maximum_coverage = 20,
})

template({
    id = "arm_upper_l",
    parent = "arm_l",
    name = ccb.content.text("left upper arm"),
    plural_name = ccb.content.text("upper arms"),
    opposite = "arm_upper_r",
    side = "left",
    maximum_coverage = 40,
})

template({
    id = "arm_elbow_l",
    parent = "arm_l",
    name = ccb.content.text("left elbow"),
    plural_name = ccb.content.text("elbows"),
    opposite = "arm_elbow_r",
    side = "left",
    maximum_coverage = 5,
})

template({
    id = "arm_lower_l",
    parent = "arm_l",
    name = ccb.content.text("left forearm"),
    plural_name = ccb.content.text("lower arms"),
    opposite = "arm_lower_r",
    side = "left",
    maximum_coverage = 35,
})

template({
    id = "leg_hip_r",
    parent = "leg_r",
    name = ccb.content.text("right hip"),
    plural_name = ccb.content.text("hips"),
    opposite = "leg_hip_l",
    side = "right",
    maximum_coverage = 20,
})

template({
    id = "leg_upper_r",
    parent = "leg_r",
    name = ccb.content.text("right thigh"),
    plural_name = ccb.content.text("thighs"),
    opposite = "leg_upper_l",
    side = "right",
    maximum_coverage = 40,
})

template({
    id = "leg_knee_r",
    parent = "leg_r",
    name = ccb.content.text("right knee"),
    plural_name = ccb.content.text("knees"),
    opposite = "leg_knee_l",
    side = "right",
    maximum_coverage = 5,
})

template({
    id = "leg_lower_r",
    parent = "leg_r",
    name = ccb.content.text("right lower leg"),
    plural_name = ccb.content.text("lower legs"),
    opposite = "leg_lower_l",
    side = "right",
    maximum_coverage = 35,
})

template({
    id = "leg_hip_l",
    parent = "leg_l",
    name = ccb.content.text("left hip"),
    plural_name = ccb.content.text("hips"),
    opposite = "leg_hip_r",
    side = "left",
    maximum_coverage = 20,
})

template({
    id = "leg_upper_l",
    parent = "leg_l",
    name = ccb.content.text("left thigh"),
    plural_name = ccb.content.text("thighs"),
    opposite = "leg_upper_r",
    side = "left",
    maximum_coverage = 40,
})

template({
    id = "leg_knee_l",
    parent = "leg_l",
    name = ccb.content.text("left knee"),
    plural_name = ccb.content.text("knees"),
    opposite = "leg_knee_r",
    side = "left",
    maximum_coverage = 5,
})

template({
    id = "leg_lower_l",
    parent = "leg_l",
    name = ccb.content.text("left lower leg"),
    plural_name = ccb.content.text("lower legs"),
    opposite = "leg_lower_r",
    side = "left",
    maximum_coverage = 35,
})

template({
    id = "hand_wrist_r",
    parent = "hand_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "hand_wrist_l",
    side = "right",
    maximum_coverage = 10,
})

template({
    id = "hand_palm_r",
    parent = "hand_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "hand_palm_l",
    side = "right",
    maximum_coverage = 20,
})

template({
    id = "hand_back_r",
    parent = "hand_r",
    name = ccb.content.text("right back of hand"),
    plural_name = ccb.content.text("back of hands"),
    opposite = "hand_back_l",
    side = "right",
    maximum_coverage = 20,
})

template({
    id = "hand_fingers_r",
    parent = "hand_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "hand_fingers_l",
    side = "right",
    maximum_coverage = 50,
})

template({
    id = "hand_wrist_l",
    parent = "hand_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "hand_wrist_r",
    side = "left",
    maximum_coverage = 10,
})

template({
    id = "hand_palm_l",
    parent = "hand_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "hand_palm_r",
    side = "left",
    maximum_coverage = 20,
})

template({
    id = "hand_back_l",
    parent = "hand_l",
    name = ccb.content.text("left back of hand"),
    plural_name = ccb.content.text("back of hands"),
    opposite = "hand_back_r",
    side = "left",
    maximum_coverage = 20,
})

template({
    id = "hand_fingers_l",
    parent = "hand_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "hand_fingers_r",
    side = "left",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_left",
    parent = "eyes",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_right",
    side = "left",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_right",
    parent = "eyes",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_left",
    side = "right",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "mouth_lips",
    parent = "mouth",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "mouth_nose",
    parent = "mouth",
    name = ccb.content.text("nose"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "mouth_cheeks",
    parent = "mouth",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "mouth_chin",
    parent = "mouth",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 40,
})

template({
    id = "foot_sole_l",
    parent = "foot_l",
    name = ccb.content.text("left foot bottom"),
    plural_name = ccb.content.text("foot bottoms"),
    opposite = "foot_sole_r",
    side = "left",
    maximum_coverage = 25,
})

template({
    id = "foot_arch_l",
    parent = "foot_l",
    name = ccb.content.text("left foot arch"),
    plural_name = ccb.content.text("foot arches"),
    opposite = "foot_arch_r",
    side = "left",
    maximum_coverage = 25,
})

template({
    id = "foot_toes_l",
    parent = "foot_l",
    name = ccb.content.text("left toes"),
    plural_name = ccb.content.text("toes"),
    opposite = "foot_toes_r",
    side = "left",
    maximum_coverage = 10,
})

template({
    id = "foot_ankle_l",
    parent = "foot_l",
    name = ccb.content.text("left ankle"),
    plural_name = ccb.content.text("ankles"),
    opposite = "foot_ankle_r",
    side = "left",
    maximum_coverage = 20,
})

template({
    id = "foot_heel_l",
    parent = "foot_l",
    name = ccb.content.text("left heel"),
    plural_name = ccb.content.text("heels"),
    opposite = "foot_heel_r",
    side = "left",
    maximum_coverage = 20,
})

template({
    id = "foot_sole_r",
    parent = "foot_r",
    name = ccb.content.text("right foot bottom"),
    plural_name = ccb.content.text("foot bottoms"),
    opposite = "foot_sole_l",
    side = "right",
    maximum_coverage = 25,
})

template({
    id = "foot_arch_r",
    parent = "foot_r",
    name = ccb.content.text("right foot arch"),
    plural_name = ccb.content.text("foot arches"),
    opposite = "foot_arch_l",
    side = "right",
    maximum_coverage = 25,
})

template({
    id = "foot_toes_r",
    parent = "foot_r",
    name = ccb.content.text("right toes"),
    plural_name = ccb.content.text("toes"),
    opposite = "foot_toes_l",
    side = "right",
    maximum_coverage = 10,
})

template({
    id = "foot_ankle_r",
    parent = "foot_r",
    name = ccb.content.text("right ankle"),
    plural_name = ccb.content.text("ankles"),
    opposite = "foot_ankle_l",
    side = "right",
    maximum_coverage = 20,
})

template({
    id = "foot_heel_r",
    parent = "foot_r",
    name = ccb.content.text("right heel"),
    plural_name = ccb.content.text("heels"),
    opposite = "foot_heel_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "head_forehead",
    parent = "head",
    name = ccb.content.text("forehead"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "head_crown",
    parent = "head",
    name = ccb.content.text("crown"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "head_nape",
    parent = "head",
    name = ccb.content.text("nape"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "head_throat",
    parent = "head",
    name = ccb.content.text("throat"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "head_ear_r",
    parent = "head",
    name = ccb.content.text("right ear"),
    plural_name = ccb.content.text("ears"),
    opposite = "head_ear_l",
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "head_ear_l",
    parent = "head",
    name = ccb.content.text("left ear"),
    plural_name = ccb.content.text("ears"),
    opposite = "head_ear_r",
    side = "left",
    maximum_coverage = 10,
})

local function inherit(base, options)
    local parent = assert(templates[base], base)
    options.opposite = options.opposite or options.id
    options.locations_under = options.locations_under or parent.locations_under or { parent.id }
    for key, value in pairs(parent) do
        if options[key] == nil then
            options[key] = value
        end
    end
    content.add(content.SubBodyPart(options))
end

return { template = template, inherit = inherit }
