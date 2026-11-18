local ccb = require("ccb")
local content = ccb.content

local parts = require("sub_body_parts")

content.add(content.SubBodyPart {
    id = "head_dragonfly_forehead",
    parent = "head_dragonfly",
    name = ccb.content.text("gigantic compound eye (forehead)"),
    plural_name = "",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "head_dragonfly_crown",
    parent = "head_dragonfly",
    name = ccb.content.text("gigantic compound eye (crown)"),
    plural_name = "",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "head_dragonfly_nape",
    parent = "head_dragonfly",
    name = ccb.content.text("nape"),
    plural_name = "",
    maximum_coverage = 20,
    similar_body_part = "head_nape",
})

content.add(content.SubBodyPart {
    id = "head_dragonfly_throat",
    parent = "head_dragonfly",
    name = ccb.content.text("throat"),
    plural_name = "",
    maximum_coverage = 20,
    similar_body_part = "head_throat",
})

content.add(content.SubBodyPart {
    id = "head_dragonfly_ear_l",
    parent = "head_dragonfly",
    name = ccb.content.text("left ear"),
    plural_name = ccb.content.text("ears"),
    opposite = "head_dragonfly_ear_r",
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "head_dragonfly_ear_r",
    parent = "head_dragonfly",
    name = ccb.content.text("right ear"),
    plural_name = ccb.content.text("ears"),
    opposite = "head_dragonfly_ear_l",
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "head_slime_forehead",
    parent = "head_slime",
    name = ccb.content.text("forehead?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "head_forehead",
})

content.add(content.SubBodyPart {
    id = "head_slime_nape",
    parent = "head_slime",
    name = ccb.content.text("nape?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
    similar_body_part = "head_nape",
})

content.add(content.SubBodyPart {
    id = "head_slime_crown",
    parent = "head_slime",
    name = ccb.content.text("crown?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "head_crown",
})

content.add(content.SubBodyPart {
    id = "head_slime_throat",
    parent = "head_slime",
    name = ccb.content.text("throat?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "head_throat",
})

content.add(content.SubBodyPart {
    id = "head_slime_ear_r",
    parent = "head_slime",
    name = ccb.content.text("right ear?"),
    plural_name = ccb.content.text("ears?"),
    opposite = "head_slime_ear_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "head_ear_r",
})

content.add(content.SubBodyPart {
    id = "head_slime_ear_l",
    parent = "head_slime",
    name = ccb.content.text("left ear?"),
    plural_name = ccb.content.text("ears?"),
    opposite = "head_slime_ear_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "head_ear_l",
})

content.add(content.SubBodyPart {
    id = "eyes_bulging_l",
    parent = "eyes_bulging",
    name = ccb.content.text("left bulging eye"),
    plural_name = ccb.content.text("bulging eyes"),
    opposite = "eyes_bulging_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
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
    id = "eyes_fey_left",
    parent = "eyes_fey",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_fey_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_fey_right",
    parent = "eyes_fey",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_fey_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_fey_full_left",
    parent = "eyes_fey_full",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_fey_full_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_fey_full_right",
    parent = "eyes_fey_full",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_fey_full_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_feline_left",
    parent = "eyes_feline",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_feline_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_feline_right",
    parent = "eyes_feline",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_feline_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_ceph_left",
    parent = "eyes_ceph",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_ceph_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_ceph_right",
    parent = "eyes_ceph",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_ceph_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_ursine_left",
    parent = "eyes_ursine",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_ursine_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_ursine_right",
    parent = "eyes_ursine",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_ursine_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_avian_left",
    parent = "eyes_avian",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_avian_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_avian_right",
    parent = "eyes_avian",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_avian_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_snail_left",
    parent = "eyes_snail",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_snail_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_frog_right",
    parent = "eyes_frog",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_snail_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_frog_left",
    parent = "eyes_frog",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_frog_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_snail_right",
    parent = "eyes_snail",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_frog_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_snail_good_left",
    parent = "eyes_snail_good",
    name = ccb.content.text("left eyestalk"),
    plural_name = ccb.content.text("eyestalks"),
    opposite = "eyes_snail_good_right",
    side = "left",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_snail_good_right",
    parent = "eyes_snail_good",
    name = ccb.content.text("right eyestalk"),
    plural_name = ccb.content.text("eyestalks"),
    opposite = "eyes_snail_good_left",
    side = "right",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_crab_left",
    parent = "eyes_crab",
    name = ccb.content.text("left eyestalk"),
    plural_name = ccb.content.text("eyestalks"),
    opposite = "eyes_crab_right",
    side = "left",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_crab_right",
    parent = "eyes_crab",
    name = ccb.content.text("right eyestalk"),
    plural_name = ccb.content.text("eyestalks"),
    opposite = "eyes_crab_left",
    side = "right",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_compound_left",
    parent = "eyes_compound",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_compound_right",
    side = "left",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_compound_right",
    parent = "eyes_compound",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_compound_left",
    side = "right",
    maximum_coverage = 50,
})

content.add(content.SubBodyPart {
    id = "eyes_slime_left",
    parent = "eyes_slime",
    name = ccb.content.text("left eye?"),
    plural_name = ccb.content.text("eyes?"),
    opposite = "eyes_slime_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_slime_right",
    parent = "eyes_slime",
    name = ccb.content.text("right eye?"),
    plural_name = ccb.content.text("eyes?"),
    opposite = "eyes_slime_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "muzzle_lips",
    parent = "muzzle",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "muzzle_nose",
    parent = "muzzle",
    name = ccb.content.text("nostrils"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "muzzle_cheeks",
    parent = "muzzle",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "muzzle_chin",
    parent = "muzzle",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "muzzle_bear_lips",
    parent = "muzzle_bear",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
    similar_body_part = "muzzle_lips",
})

content.add(content.SubBodyPart {
    id = "muzzle_bear_nose",
    parent = "muzzle_bear",
    name = ccb.content.text("nostrils"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 5,
    similar_body_part = "muzzle_nose",
})

content.add(content.SubBodyPart {
    id = "muzzle_bear_cheeks",
    parent = "muzzle_bear",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 40,
    similar_body_part = "muzzle_cheeks",
})

content.add(content.SubBodyPart {
    id = "muzzle_bear_chin",
    parent = "muzzle_bear",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "muzzle_chin",
})

content.add(content.SubBodyPart {
    id = "muzzle_lupine_lips",
    parent = "muzzle_lupine",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "muzzle_lips",
})

content.add(content.SubBodyPart {
    id = "muzzle_lupine_nose",
    parent = "muzzle_lupine",
    name = ccb.content.text("nostrils"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 10,
    similar_body_part = "muzzle_nose",
})

content.add(content.SubBodyPart {
    id = "muzzle_lupine_cheeks",
    parent = "muzzle_lupine",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "muzzle_cheeks",
})

content.add(content.SubBodyPart {
    id = "muzzle_lupine_chin",
    parent = "muzzle_lupine",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "muzzle_chin",
})

content.add(content.SubBodyPart {
    id = "muzzle_long_lips",
    parent = "muzzle_long",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "muzzle_lips",
})

content.add(content.SubBodyPart {
    id = "muzzle_long_nostrils",
    parent = "muzzle_long",
    name = ccb.content.text("nostrils"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 5,
    similar_body_part = "muzzle_nose",
})

content.add(content.SubBodyPart {
    id = "muzzle_long_cheeks",
    parent = "muzzle_long",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 35,
    similar_body_part = "muzzle_cheeks",
})

content.add(content.SubBodyPart {
    id = "muzzle_long_chin",
    parent = "muzzle_long",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 40,
    similar_body_part = "muzzle_chin",
})

content.add(content.SubBodyPart {
    id = "muzzle_rodent_lips",
    parent = "muzzle_rodent",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "muzzle_lips",
})

content.add(content.SubBodyPart {
    id = "muzzle_rodent_nose",
    parent = "muzzle_rodent",
    name = ccb.content.text("nostrils"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "muzzle_nose",
})

content.add(content.SubBodyPart {
    id = "muzzle_rodent_cheeks",
    parent = "muzzle_rodent",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 35,
    similar_body_part = "muzzle_cheeks",
})

content.add(content.SubBodyPart {
    id = "muzzle_rodent_chin",
    parent = "muzzle_rodent",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "muzzle_chin",
})

content.add(content.SubBodyPart {
    id = "muzzle_rabbit_lips",
    parent = "muzzle_rabbit",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "mouth_lips",
})

content.add(content.SubBodyPart {
    id = "muzzle_rabbit_nose",
    parent = "muzzle_rabbit",
    name = ccb.content.text("nostrils"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
    similar_body_part = "mouth_nose",
})

content.add(content.SubBodyPart {
    id = "muzzle_rabbit_cheeks",
    parent = "muzzle_rabbit",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
    similar_body_part = "mouth_cheeks",
})

content.add(content.SubBodyPart {
    id = "muzzle_rabbit_chin",
    parent = "muzzle_rabbit",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 35,
    similar_body_part = "mouth_chin",
})

parts.template({
    id = "beak_nares",
    parent = "beak",
    name = ccb.content.text("nares"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 5,
})

parts.template({
    id = "beak_top",
    parent = "beak",
    name = ccb.content.text("beak top"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 35,
})

parts.template({
    id = "beak_tip",
    parent = "beak",
    name = ccb.content.text("beak tip"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

parts.template({
    id = "beak_bottom",
    parent = "beak",
    name = ccb.content.text("beak bottom"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 35,
})

parts.inherit("beak_nares", {
    id = "beak_bird_nares",
    parent = "beak_bird",
    similar_body_part = "beak_nares",
})

parts.inherit("beak_top", {
    id = "beak_bird_top",
    parent = "beak_bird",
    similar_body_part = "beak_top",
})

parts.inherit("beak_tip", {
    id = "beak_bird_tip",
    parent = "beak_bird",
    similar_body_part = "beak_tip",
})

parts.inherit("beak_bottom", {
    id = "beak_bird_bottom",
    parent = "beak_bird",
    similar_body_part = "beak_bottom",
})

parts.inherit("beak_nares", {
    id = "beak_woodpecker_nares",
    parent = "beak_woodpecker",
    similar_body_part = "beak_nares",
})

parts.inherit("beak_top", {
    id = "beak_woodpecker_top",
    parent = "beak_woodpecker",
    similar_body_part = "beak_top",
})

parts.inherit("beak_tip", {
    id = "beak_woodpecker_tip",
    parent = "beak_woodpecker",
    similar_body_part = "beak_tip",
})

parts.inherit("beak_bottom", {
    id = "beak_woodpecker_bottom",
    parent = "beak_woodpecker",
    similar_body_part = "beak_bottom",
})

parts.inherit("beak_nares", {
    id = "beak_hummingbird_nares",
    parent = "beak_hummingbird",
    similar_body_part = "beak_nares",
})

parts.inherit("beak_top", {
    id = "beak_hummingbird_top",
    parent = "beak_hummingbird",
    similar_body_part = "beak_top",
})

parts.inherit("beak_tip", {
    id = "beak_hummingbird_tip",
    parent = "beak_hummingbird",
    similar_body_part = "beak_tip",
})

parts.inherit("beak_bottom", {
    id = "beak_hummingbird_bottom",
    parent = "beak_hummingbird",
    similar_body_part = "beak_bottom",
})

content.add(content.SubBodyPart {
    id = "gastropod_tongue_lips",
    parent = "gastropod_tongue",
    name = ccb.content.text("lips"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "mouth_lips",
})

content.add(content.SubBodyPart {
    id = "gastropod_tongue_nose",
    parent = "gastropod_tongue",
    name = ccb.content.text("nose"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "mouth_nose",
})

content.add(content.SubBodyPart {
    id = "gastropod_tongue_cheeks",
    parent = "gastropod_tongue",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 40,
    similar_body_part = "mouth_cheeks",
})

content.add(content.SubBodyPart {
    id = "gastropod_tongue_chin",
    parent = "gastropod_tongue",
    name = ccb.content.text("chin"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "mouth_chin",
})

content.add(content.SubBodyPart {
    id = "insect_proboscis_base",
    parent = "insect_proboscis",
    name = ccb.content.text("base", "sub_bodypart_name"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "insect_proboscis_labium",
    parent = "insect_proboscis",
    name = ccb.content.text("labium"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 35,
})

content.add(content.SubBodyPart {
    id = "insect_proboscis_cheeks",
    parent = "insect_proboscis",
    name = ccb.content.text("cheeks"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "insect_proboscis_bottom",
    parent = "insect_proboscis",
    name = ccb.content.text("bottom"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "mouth_slime_lips",
    parent = "mouth_slime",
    name = ccb.content.text("lips?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "mouth_lips",
})

content.add(content.SubBodyPart {
    id = "mouth_slime_nose",
    parent = "mouth_slime",
    name = ccb.content.text("nose?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 15,
    similar_body_part = "mouth_nose",
})

content.add(content.SubBodyPart {
    id = "mouth_slime_cheeks",
    parent = "mouth_slime",
    name = ccb.content.text("cheeks?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 30,
    similar_body_part = "mouth_cheeks",
})

content.add(content.SubBodyPart {
    id = "mouth_slime_chin",
    parent = "mouth_slime",
    name = ccb.content.text("chin?"),
    plural_name = "",
    opposite = "sub_limb_debug",
    maximum_coverage = 40,
    similar_body_part = "mouth_chin",
})

parts.inherit("torso_upper", {
    id = "torso_slime_upper",
    parent = "torso_slime",
    similar_body_part = "torso_upper",
})

parts.inherit("torso_neck", {
    id = "torso_slime_neck",
    parent = "torso_slime",
    similar_body_part = "torso_neck",
})

parts.inherit("torso_lower", {
    id = "torso_slime_lower",
    parent = "torso_slime",
    similar_body_part = "torso_lower",
})

parts.inherit("torso_hanging_front", {
    id = "torso_slime_hanging_front",
    parent = "torso_slime",
    similar_body_part = "torso_hanging_front",
})

parts.inherit("torso_hanging_back", {
    id = "torso_slime_hanging_back",
    parent = "torso_slime",
    similar_body_part = "torso_hanging_back",
})

parts.inherit("torso_waist", {
    id = "torso_slime_waist",
    parent = "torso_slime",
    similar_body_part = "torso_waist",
})

content.add(content.SubBodyPart {
    id = "crustacean_pincer_wrist_r",
    parent = "crustacean_pincer_r",
    name = ccb.content.text("crustacean pincer wrist"),
    plural_name = ccb.content.text("pincer wrists"),
    opposite = "hand_wrist_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "crustacean_pincer_claws_r",
    parent = "crustacean_pincer_r",
    name = ccb.content.text("crustacean pincer claws"),
    plural_name = ccb.content.text("pincer claws"),
    opposite = "hand_fingers_l",
    side = "right",
    maximum_coverage = 80,
})

content.add(content.SubBodyPart {
    id = "paw_default_wrist_l",
    parent = "paw_default_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_default_wrist_r",
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "paw_default_palm_l",
    parent = "paw_default_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_default_palm_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "paw_default_back_l",
    parent = "paw_default_l",
    name = ccb.content.text("left back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_default_back_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "paw_default_fingers_l",
    parent = "paw_default_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_default_fingers_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "paw_default_wrist_r",
    parent = "paw_default_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_default_wrist_l",
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "paw_default_palm_r",
    parent = "paw_default_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_default_palm_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "paw_default_back_r",
    parent = "paw_default_r",
    name = ccb.content.text("right back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_default_back_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "paw_default_fingers_r",
    parent = "paw_default_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_default_fingers_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "paw_broad_wrist_l",
    parent = "paw_broad_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_broad_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_l",
})

content.add(content.SubBodyPart {
    id = "paw_broad_palm_l",
    parent = "paw_broad_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_broad_palm_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_l",
})

content.add(content.SubBodyPart {
    id = "paw_broad_back_l",
    parent = "paw_broad_l",
    name = ccb.content.text("left back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_broad_back_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_l",
})

content.add(content.SubBodyPart {
    id = "paw_broad_fingers_l",
    parent = "paw_broad_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_broad_fingers_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_l",
})

content.add(content.SubBodyPart {
    id = "paw_broad_wrist_r",
    parent = "paw_broad_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_broad_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_r",
})

content.add(content.SubBodyPart {
    id = "paw_broad_palm_r",
    parent = "paw_broad_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_broad_palm_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_r",
})

content.add(content.SubBodyPart {
    id = "paw_broad_back_r",
    parent = "paw_broad_r",
    name = ccb.content.text("right back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_broad_back_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_r",
})

content.add(content.SubBodyPart {
    id = "paw_broad_fingers_r",
    parent = "paw_broad_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_broad_fingers_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_r",
})

content.add(content.SubBodyPart {
    id = "paw_wrist_l",
    parent = "paw_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_l",
})

content.add(content.SubBodyPart {
    id = "paw_palm_l",
    parent = "paw_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_palm_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_l",
})

content.add(content.SubBodyPart {
    id = "paw_back_l",
    parent = "paw_l",
    name = ccb.content.text("left back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_back_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_l",
})

content.add(content.SubBodyPart {
    id = "paw_fingers_l",
    parent = "paw_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_fingers_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_l",
})

content.add(content.SubBodyPart {
    id = "paw_wrist_r",
    parent = "paw_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_r",
})

content.add(content.SubBodyPart {
    id = "paw_palm_r",
    parent = "paw_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_palm_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_r",
})

content.add(content.SubBodyPart {
    id = "paw_back_r",
    parent = "paw_r",
    name = ccb.content.text("right back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_back_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_r",
})

content.add(content.SubBodyPart {
    id = "paw_fingers_r",
    parent = "paw_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_fingers_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_r",
})

content.add(content.SubBodyPart {
    id = "paw_rat_wrist_l",
    parent = "paw_rat_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_rat_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_l",
})

content.add(content.SubBodyPart {
    id = "paw_rat_palm_l",
    parent = "paw_rat_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_rat_palm_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_l",
})

content.add(content.SubBodyPart {
    id = "paw_rat_back_l",
    parent = "paw_rat_l",
    name = ccb.content.text("left back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_rat_back_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_l",
})

content.add(content.SubBodyPart {
    id = "paw_rat_fingers_l",
    parent = "paw_rat_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_rat_fingers_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_l",
})

content.add(content.SubBodyPart {
    id = "paw_rat_wrist_r",
    parent = "paw_rat_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_rat_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_r",
})

content.add(content.SubBodyPart {
    id = "paw_rat_palm_r",
    parent = "paw_rat_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_rat_palm_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_r",
})

content.add(content.SubBodyPart {
    id = "paw_rat_back_r",
    parent = "paw_rat_r",
    name = ccb.content.text("right back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_rat_back_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_r",
})

content.add(content.SubBodyPart {
    id = "paw_rat_fingers_r",
    parent = "paw_rat_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_rat_fingers_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_r",
})

content.add(content.SubBodyPart {
    id = "paw_little_wrist_l",
    parent = "paw_little_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_little_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_l",
})

content.add(content.SubBodyPart {
    id = "paw_little_palm_l",
    parent = "paw_little_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_little_palm_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_l",
})

content.add(content.SubBodyPart {
    id = "paw_little_back_l",
    parent = "paw_little_l",
    name = ccb.content.text("left back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_little_back_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_l",
})

content.add(content.SubBodyPart {
    id = "paw_little_fingers_l",
    parent = "paw_little_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_little_fingers_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_l",
})

content.add(content.SubBodyPart {
    id = "paw_little_wrist_r",
    parent = "paw_little_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "paw_little_wrist_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "paw_default_wrist_r",
})

content.add(content.SubBodyPart {
    id = "paw_little_palm_r",
    parent = "paw_little_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "paw_little_palm_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_palm_r",
})

content.add(content.SubBodyPart {
    id = "paw_little_back_r",
    parent = "paw_little_r",
    name = ccb.content.text("right back of paw"),
    plural_name = ccb.content.text("back of paws"),
    opposite = "paw_little_back_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_back_r",
})

content.add(content.SubBodyPart {
    id = "paw_little_fingers_r",
    parent = "paw_little_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "paw_little_fingers_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "paw_default_fingers_r",
})

content.add(content.SubBodyPart {
    id = "hand_slime_wrist_l",
    parent = "hand_slime_l",
    name = ccb.content.text("left wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "hand_slime_wrist_r",
    side = "left",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_l",
})

content.add(content.SubBodyPart {
    id = "hand_slime_palm_l",
    parent = "hand_slime_l",
    name = ccb.content.text("left palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "hand_slime_palm_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_l",
})

content.add(content.SubBodyPart {
    id = "hand_slime_back_l",
    parent = "hand_slime_l",
    name = ccb.content.text("left back of hand"),
    plural_name = ccb.content.text("back of hands"),
    opposite = "hand_slime_back_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "hand_back_l",
})

content.add(content.SubBodyPart {
    id = "hand_slime_fingers_l",
    parent = "hand_slime_l",
    name = ccb.content.text("left fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "hand_slime_fingers_r",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_l",
})

content.add(content.SubBodyPart {
    id = "hand_slime_wrist_r",
    parent = "hand_slime_r",
    name = ccb.content.text("right wrist"),
    plural_name = ccb.content.text("wrists"),
    opposite = "hand_slime_palm_l",
    side = "right",
    maximum_coverage = 10,
    similar_body_part = "hand_wrist_r",
})

content.add(content.SubBodyPart {
    id = "hand_slime_palm_r",
    parent = "hand_slime_r",
    name = ccb.content.text("right palm"),
    plural_name = ccb.content.text("palms"),
    opposite = "hand_slime_palm_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_palm_r",
})

content.add(content.SubBodyPart {
    id = "hand_slime_back_r",
    parent = "hand_slime_r",
    name = ccb.content.text("right back of hand"),
    plural_name = ccb.content.text("back of hands"),
    opposite = "hand_slime_back_l",
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "hand_back_r",
})

content.add(content.SubBodyPart {
    id = "hand_slime_fingers_r",
    parent = "hand_slime_r",
    name = ccb.content.text("right fingers"),
    plural_name = ccb.content.text("fingers"),
    opposite = "hand_slime_fingers_l",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "hand_fingers_r",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_shoulder_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered shoulder"),
    plural_name = ccb.content.text("feathered shoulders"),
    opposite = "arm_feathers_shoulder_r",
    side = "left",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_l",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_upper_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered upper arm"),
    plural_name = ccb.content.text("feathered upper arms"),
    opposite = "arm_feathers_upper_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "arm_upper_l",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_elbow_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered elbow"),
    plural_name = ccb.content.text("feathered elbows"),
    opposite = "arm_feathers_elbow_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_l",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_lower_l",
    parent = "arm_feathers_l",
    name = ccb.content.text("left feathered lower arm"),
    plural_name = ccb.content.text("feathered lower arms"),
    opposite = "arm_feathers_lower_r",
    side = "left",
    maximum_coverage = 45,
    similar_body_part = "arm_lower_l",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_shoulder_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered shoulder"),
    plural_name = ccb.content.text("feathered shoulders"),
    opposite = "arm_feathers_shoulder_l",
    side = "right",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_r",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_upper_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered upper arm"),
    plural_name = ccb.content.text("feathered upper arms"),
    opposite = "arm_feathers_upper_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "arm_upper_r",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_elbow_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered elbow"),
    plural_name = ccb.content.text("feathered elbows"),
    opposite = "arm_feathers_elbow_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_r",
})

content.add(content.SubBodyPart {
    id = "arm_feathers_lower_r",
    parent = "arm_feathers_r",
    name = ccb.content.text("right feathered lower arm"),
    plural_name = ccb.content.text("feathered lower arms"),
    opposite = "arm_feathers_lower_l",
    side = "right",
    maximum_coverage = 45,
    similar_body_part = "arm_lower_r",
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_shoulder_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "arm_wing_bird_shoulder_r",
    side = "left",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_l",
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_upper_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "arm_wing_bird_upper_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_elbow_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "arm_wing_bird_elbow_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_lower_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("lower left wings"),
    plural_name = ccb.content.text("lower wing"),
    opposite = "arm_wing_bird_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_fingers_l",
    parent = "arm_wing_bird_l",
    name = ccb.content.text("left wing talons"),
    plural_name = ccb.content.text("wing talons"),
    opposite = "arm_wing_bird_fingers_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_shoulder_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "arm_wing_bird_shoulder_l",
    side = "right",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_upper_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "arm_wing_bird_upper_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_elbow_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "arm_wing_bird_elbow_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_lower_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("lower right wing"),
    plural_name = ccb.content.text("lower wings"),
    opposite = "arm_wing_bird_lower_l",
    side = "right",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bird_fingers_r",
    parent = "arm_wing_bird_r",
    name = ccb.content.text("right wing talons"),
    plural_name = ccb.content.text("wing talons"),
    opposite = "arm_wing_bird_fingers_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_leathery_shoulder_l",
    parent = "arm_leathery_l",
    name = ccb.content.text("left leathery shoulder"),
    plural_name = ccb.content.text("leathery shoulders"),
    opposite = "arm_leathery_shoulder_r",
    side = "left",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_l",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_upper_l",
    parent = "arm_leathery_l",
    name = ccb.content.text("left leathery upper arm"),
    plural_name = ccb.content.text("leathery upper arms"),
    opposite = "arm_leathery_upper_r",
    side = "left",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_l",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_elbow_l",
    parent = "arm_leathery_l",
    name = ccb.content.text("left leathery elbow"),
    plural_name = ccb.content.text("leathery elbows"),
    opposite = "arm_leathery_elbow_r",
    side = "left",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_l",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_lower_l",
    parent = "arm_leathery_l",
    name = ccb.content.text("left leathery lower arms"),
    plural_name = ccb.content.text("leathery lower arms"),
    opposite = "arm_leathery_lower_r",
    side = "left",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_l",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_shoulder_r",
    parent = "arm_leathery_r",
    name = ccb.content.text("right leathery shoulder"),
    plural_name = ccb.content.text("leathery shoulders"),
    side = "right",
    maximum_coverage = 20,
    similar_body_part = "arm_shoulder_r",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_upper_r",
    parent = "arm_leathery_r",
    name = ccb.content.text("right leathery upper arm"),
    plural_name = ccb.content.text("leathery upper arms"),
    opposite = "arm_leathery_upper_l",
    side = "right",
    maximum_coverage = 40,
    similar_body_part = "arm_upper_r",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_elbow_r",
    parent = "arm_leathery_r",
    name = ccb.content.text("right leathery elbow"),
    plural_name = ccb.content.text("leathery elbows"),
    opposite = "arm_leathery_elbow_l",
    side = "right",
    maximum_coverage = 5,
    similar_body_part = "arm_elbow_r",
})

content.add(content.SubBodyPart {
    id = "arm_leathery_lower_r",
    parent = "arm_leathery_r",
    name = ccb.content.text("right leathery lower arm"),
    plural_name = ccb.content.text("leathery lower arms"),
    opposite = "arm_leathery_lower_l",
    side = "right",
    maximum_coverage = 35,
    similar_body_part = "arm_lower_r",
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_shoulder_l",
    parent = "arm_wing_bat_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "arm_wing_bat_shoulder_r",
    side = "left",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_l",
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_upper_l",
    parent = "arm_wing_bat_l",
    name = ccb.content.text("left upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "arm_wing_bat_upper_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_elbow_l",
    parent = "arm_wing_bat_l",
    name = ccb.content.text("left wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "arm_wing_bat_elbow_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_lower_l",
    parent = "arm_wing_bat_l",
    name = ccb.content.text("lower left wings"),
    plural_name = ccb.content.text("lower wing"),
    opposite = "arm_wing_bat_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_fingers_l",
    parent = "arm_wing_bat_l",
    name = ccb.content.text("left wing talons"),
    plural_name = ccb.content.text("wing talons"),
    opposite = "arm_wing_bat_fingers_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_shoulder_r",
    parent = "arm_wing_bat_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "arm_wing_bat_shoulder_l",
    side = "right",
    maximum_coverage = 15,
    similar_body_part = "arm_shoulder_r",
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_upper_r",
    parent = "arm_wing_bat_r",
    name = ccb.content.text("right upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "arm_wing_bat_upper_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_elbow_r",
    parent = "arm_wing_bat_r",
    name = ccb.content.text("right wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "arm_wing_bat_elbow_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_lower_r",
    parent = "arm_wing_bat_r",
    name = ccb.content.text("lower right wing"),
    plural_name = ccb.content.text("lower wings"),
    opposite = "arm_wing_bat_lower_l",
    side = "right",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "arm_wing_bat_fingers_r",
    parent = "arm_wing_bat_r",
    name = ccb.content.text("right wing talons"),
    plural_name = ccb.content.text("wing talons"),
    opposite = "arm_wing_bat_fingers_l",
    side = "right",
    maximum_coverage = 5,
})

parts.inherit("arm_upper_l", {
    id = "arm_insect_upper_l",
    parent = "arm_insect_l",
    maximum_coverage = 45,
})

parts.inherit("arm_elbow_l", {
    id = "arm_insect_elbow_l",
    parent = "arm_insect_l",
    maximum_coverage = 10,
})

parts.inherit("arm_lower_l", {
    id = "arm_insect_lower_l",
    parent = "arm_insect_l",
    maximum_coverage = 45,
})

parts.inherit("arm_upper_r", {
    id = "arm_insect_upper_r",
    parent = "arm_insect_r",
    maximum_coverage = 45,
})

parts.inherit("arm_elbow_r", {
    id = "arm_insect_elbow_r",
    parent = "arm_insect_r",
    maximum_coverage = 10,
})

parts.inherit("arm_lower_r", {
    id = "arm_insect_lower_r",
    parent = "arm_insect_r",
    maximum_coverage = 45,
})

parts.inherit("arm_upper_l", {
    id = "arm_insect_good_upper_l",
    parent = "arm_insect_good_l",
    maximum_coverage = 45,
    similar_body_part = "arm_insect_upper_l",
})

parts.inherit("arm_elbow_l", {
    id = "arm_insect_good_elbow_l",
    parent = "arm_insect_good_l",
    maximum_coverage = 10,
    similar_body_part = "arm_insect_elbow_l",
})

parts.inherit("arm_lower_l", {
    id = "arm_insect_good_lower_l",
    parent = "arm_insect_good_l",
    maximum_coverage = 45,
    similar_body_part = "arm_insect_lower_l",
})

parts.inherit("arm_upper_r", {
    id = "arm_insect_good_upper_r",
    parent = "arm_insect_good_r",
    maximum_coverage = 45,
    similar_body_part = "arm_insect_upper_r",
})

parts.inherit("arm_elbow_r", {
    id = "arm_insect_good_elbow_r",
    parent = "arm_insect_good_r",
    maximum_coverage = 10,
    similar_body_part = "arm_insect_elbow_r",
})

parts.inherit("arm_lower_r", {
    id = "arm_insect_good_lower_r",
    parent = "arm_insect_good_r",
    maximum_coverage = 45,
    similar_body_part = "arm_insect_lower_r",
})

content.add(content.SubBodyPart {
    id = "insect_tarsomere_l",
    parent = "insect_hand_l",
    name = ccb.content.text("left upper tarsomere"),
    plural_name = ccb.content.text("upper tarsomeres"),
    opposite = "insect_tarsomere_r",
    side = "left",
    maximum_coverage = 33,
})

content.add(content.SubBodyPart {
    id = "insect_segment_l",
    parent = "insect_hand_l",
    name = ccb.content.text("left middle tarsomere"),
    plural_name = ccb.content.text("middle tarsomeres"),
    opposite = "insect_segment_r",
    side = "left",
    maximum_coverage = 33,
})

content.add(content.SubBodyPart {
    id = "insect_terminus_l",
    parent = "insect_hand_l",
    name = ccb.content.text("left terminus"),
    plural_name = ccb.content.text("terminuses"),
    opposite = "insect_terminus_r",
    side = "left",
    maximum_coverage = 33,
})

content.add(content.SubBodyPart {
    id = "insect_tarsomere_r",
    parent = "insect_hand_r",
    name = ccb.content.text("right upper tarsomere"),
    plural_name = ccb.content.text("upper tarsomeres"),
    opposite = "insect_tarsomere_l",
    side = "right",
    maximum_coverage = 33,
})

content.add(content.SubBodyPart {
    id = "insect_segment_r",
    parent = "insect_hand_r",
    name = ccb.content.text("right middle tarsomere"),
    plural_name = ccb.content.text("middle tarsomeres"),
    side = "right",
    maximum_coverage = 33,
})

content.add(content.SubBodyPart {
    id = "insect_terminus_r",
    parent = "insect_hand_r",
    name = ccb.content.text("right terminus"),
    plural_name = ccb.content.text("terminuses"),
    side = "right",
    maximum_coverage = 33,
})

parts.inherit("arm_shoulder_l", {
    id = "arm_slime_shoulder_l",
    parent = "arm_slime_l",
    opposite = "arm_slime_shoulder_r",
    similar_body_part = "arm_shoulder_l",
})

parts.inherit("arm_upper_l", {
    id = "arm_slime_upper_l",
    parent = "arm_slime_l",
    opposite = "arm_slime_upper_r",
    similar_body_part = "arm_upper_l",
})

parts.inherit("arm_elbow_l", {
    id = "arm_slime_elbow_l",
    parent = "arm_slime_l",
    opposite = "arm_slime_elbow_r",
    similar_body_part = "arm_elbow_l",
})

parts.inherit("arm_lower_l", {
    id = "arm_slime_lower_l",
    parent = "arm_slime_l",
    opposite = "arm_slime_lower_r",
    similar_body_part = "arm_lower_l",
})

parts.inherit("arm_shoulder_r", {
    id = "arm_slime_shoulder_r",
    parent = "arm_slime_r",
    opposite = "arm_slime_shoulder_l",
    similar_body_part = "arm_shoulder_r",
})

parts.inherit("arm_upper_r", {
    id = "arm_slime_upper_r",
    parent = "arm_slime_r",
    opposite = "arm_slime_upper_l",
    similar_body_part = "arm_upper_r",
})

parts.inherit("arm_elbow_r", {
    id = "arm_slime_elbow_r",
    parent = "arm_slime_r",
    opposite = "arm_slime_elbow_l",
    similar_body_part = "arm_elbow_r",
})

parts.inherit("arm_lower_r", {
    id = "arm_slime_lower_r",
    parent = "arm_slime_r",
    opposite = "arm_slime_lower_l",
    similar_body_part = "arm_lower_r",
})

parts.inherit("hand_wrist_l", {
    id = "hand_slime_complete_wrist_l",
    parent = "hand_slime_complete_l",
    opposite = "hand_slime_complete_wrist_r",
    similar_body_part = "hand_wrist_l",
})

parts.inherit("hand_palm_l", {
    id = "hand_slime_complete_palm_l",
    parent = "hand_slime_complete_l",
    opposite = "hand_slime_complete_palm_r",
    similar_body_part = "hand_palm_l",
})

parts.inherit("hand_back_l", {
    id = "hand_slime_complete_back_l",
    parent = "hand_slime_complete_l",
    opposite = "hand_slime_complete_back_r",
    similar_body_part = "hand_back_l",
})

parts.inherit("hand_fingers_l", {
    id = "hand_slime_complete_fingers_l",
    parent = "hand_slime_complete_l",
    opposite = "hand_slime_complete_fingers_r",
    similar_body_part = "hand_fingers_l",
})

parts.inherit("hand_wrist_r", {
    id = "hand_slime_complete_wrist_r",
    parent = "hand_slime_complete_r",
    opposite = "hand_slime_complete_wrist_l",
    similar_body_part = "hand_wrist_r",
})

parts.inherit("hand_palm_r", {
    id = "hand_slime_complete_palm_r",
    parent = "hand_slime_complete_r",
    opposite = "hand_slime_complete_palm_l",
    similar_body_part = "hand_palm_r",
})

parts.inherit("hand_back_r", {
    id = "hand_slime_complete_back_r",
    parent = "hand_slime_complete_r",
    opposite = "hand_slime_complete_back_l",
    similar_body_part = "hand_back_r",
})

parts.inherit("hand_fingers_r", {
    id = "hand_slime_complete_fingers_r",
    parent = "hand_slime_complete_r",
    opposite = "hand_slime_complete_fingers_l",
    similar_body_part = "hand_fingers_r",
})

content.add(content.SubBodyPart {
    id = "vine_sublimb_ur",
    parent = "vine_limb_upper_r",
    name = ccb.content.text("vine"),
    plural_name = ccb.content.text("vines"),
    opposite = "vine_sublimb_ul",
    side = "right",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "vine_sublimb_ul",
    parent = "vine_limb_upper_l",
    name = ccb.content.text("vine"),
    plural_name = ccb.content.text("vines"),
    opposite = "vine_sublimb_ur",
    side = "left",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "vine_sublimb_lr",
    parent = "vine_limb_lower_r",
    name = ccb.content.text("vine"),
    plural_name = ccb.content.text("vines"),
    opposite = "vine_sublimb_ll",
    side = "right",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "vine_sublimb_ll",
    parent = "vine_limb_lower_l",
    name = ccb.content.text("vine"),
    plural_name = ccb.content.text("vines"),
    opposite = "vine_sublimb_lr",
    side = "left",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "wing_shoulder_l",
    parent = "wing_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_shoulder_r",
    side = "left",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "wing_shoulder_r",
    parent = "wing_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_shoulder_l",
    side = "right",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "wing_upper_l",
    parent = "wing_l",
    name = ccb.content.text("left upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "wing_upper_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "wing_upper_r",
    parent = "wing_r",
    name = ccb.content.text("right upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "wing_upper_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "wing_joint_l",
    parent = "wing_l",
    name = ccb.content.text("left wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "wing_joint_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "wing_joint_r",
    parent = "wing_r",
    name = ccb.content.text("right wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "wing_joint_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "wing_lower_l",
    parent = "wing_l",
    name = ccb.content.text("lower left wings"),
    plural_name = ccb.content.text("lower wing"),
    opposite = "wing_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "wing_lower_r",
    parent = "wing_r",
    name = ccb.content.text("lower right wing"),
    plural_name = ccb.content.text("lower wings"),
    opposite = "wing_lower_l",
    side = "right",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "wing_butterfly_basal_l",
    parent = "wing_butterfly_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_butterfly_basal_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "wing_butterfly_forewing_l",
    parent = "wing_butterfly_l",
    name = ccb.content.text("left forewing"),
    plural_name = ccb.content.text("forewings"),
    opposite = "wing_butterfly_forewing_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_butterfly_hindwing_l",
    parent = "wing_butterfly_l",
    name = ccb.content.text("left hindwing"),
    plural_name = ccb.content.text("hindwings"),
    opposite = "wing_butterfly_hindwing_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_butterfly_basal_r",
    parent = "wing_butterfly_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_butterfly_basal_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "wing_butterfly_forewing_r",
    parent = "wing_butterfly_r",
    name = ccb.content.text("right forewing"),
    plural_name = ccb.content.text("forewings"),
    opposite = "wing_butterfly_forewing_l",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_butterfly_hindwing_r",
    parent = "wing_butterfly_r",
    name = ccb.content.text("right hindwing"),
    plural_name = ccb.content.text("hindwings"),
    opposite = "wing_butterfly_hindwing_l",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_insect_costal_margin_l",
    parent = "wing_insect_l",
    name = ccb.content.text("left forewing"),
    plural_name = ccb.content.text("forewings"),
    opposite = "wing_insect_costal_margin_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_insect_posterior_margin_l",
    parent = "wing_insect_l",
    name = ccb.content.text("left hindwing"),
    plural_name = ccb.content.text("hindwings"),
    opposite = "wing_insect_posterior_margin_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_insect_apex_l",
    parent = "wing_insect_l",
    name = ccb.content.text("left wingtip"),
    plural_name = ccb.content.text("wingtips"),
    opposite = "wing_insect_apex_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "wing_insect_costal_margin_r",
    parent = "wing_insect_r",
    name = ccb.content.text("right forewing"),
    plural_name = ccb.content.text("forewings"),
    opposite = "wing_insect_costal_margin_l",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_insect_posterior_margin_r",
    parent = "wing_insect_r",
    name = ccb.content.text("right hindwing"),
    plural_name = ccb.content.text("hindwings"),
    opposite = "wing_insect_posterior_margin_l",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_insect_apex_r",
    parent = "wing_insect_r",
    name = ccb.content.text("right wingtip"),
    plural_name = ccb.content.text("wingtips"),
    opposite = "wing_insect_apex_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "leg_hip_gastropod_l",
    parent = "gastropod_foot",
    name = ccb.content.text("left hip"),
    plural_name = ccb.content.text("hips"),
    opposite = "leg_hip_gastropod_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_hip_gastropod_r",
    parent = "gastropod_foot",
    name = ccb.content.text("left hip"),
    plural_name = ccb.content.text("hips"),
    opposite = "leg_hip_gastropod_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_gastropod_draped",
    parent = "gastropod_foot",
    name = ccb.content.text("leg (draped)"),
    plural_name = ccb.content.text("legs (draped)"),
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
})

content.add(content.SubBodyPart {
    id = "leg_upper_gastropod",
    parent = "gastropod_foot",
    name = ccb.content.text("upper foot"),
    plural_name = ccb.content.text("upper feet"),
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "leg_lower_gastropod",
    parent = "gastropod_foot",
    name = ccb.content.text("lower foot"),
    plural_name = ccb.content.text("lower feet"),
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "leg_crab_basis_fl",
    parent = "leg_crab_front_l",
    name = ccb.content.text("left front basis"),
    plural_name = ccb.content.text("left front bases"),
    opposite = "leg_crab_basis_fr",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_merus_fl",
    parent = "leg_crab_front_l",
    name = ccb.content.text("left front merus"),
    plural_name = ccb.content.text("left front meri"),
    opposite = "leg_crab_merus_fr",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "leg_crab_carpus_fl",
    parent = "leg_crab_front_l",
    name = ccb.content.text("left front carpus"),
    plural_name = ccb.content.text("left front carpi"),
    opposite = "leg_crab_carpus_fr",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_manus_fl",
    parent = "leg_crab_front_l",
    name = ccb.content.text("left front manus"),
    plural_name = ccb.content.text("left front manuses"),
    opposite = "leg_crab_manus_fr",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_dactyl_fl",
    parent = "leg_crab_front_l",
    name = ccb.content.text("left front dactyl"),
    plural_name = ccb.content.text("left front dactyls"),
    opposite = "leg_crab_dactyl_fr",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_basis_fr",
    parent = "leg_crab_front_r",
    name = ccb.content.text("right front basis"),
    plural_name = ccb.content.text("right front bases"),
    opposite = "leg_crab_basis_fl",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_merus_fr",
    parent = "leg_crab_front_r",
    name = ccb.content.text("right front merus"),
    plural_name = ccb.content.text("right front meri"),
    opposite = "leg_crab_merus_fl",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "leg_crab_carpus_fr",
    parent = "leg_crab_front_r",
    name = ccb.content.text("right front carpus"),
    plural_name = ccb.content.text("right front carpi"),
    opposite = "leg_crab_carpus_fl",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_manus_fr",
    parent = "leg_crab_front_r",
    name = ccb.content.text("right front manus"),
    plural_name = ccb.content.text("right front manuses"),
    opposite = "leg_crab_manus_fl",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_dactyl_fr",
    parent = "leg_crab_front_r",
    name = ccb.content.text("right front dactyl"),
    plural_name = ccb.content.text("right front dactyls"),
    opposite = "leg_crab_dactyl_fl",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_basis_rl",
    parent = "leg_crab_rear_l",
    name = ccb.content.text("left rear basis"),
    plural_name = ccb.content.text("left rear bases"),
    opposite = "leg_crab_basis_rr",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_merus_rl",
    parent = "leg_crab_rear_l",
    name = ccb.content.text("left rear merus"),
    plural_name = ccb.content.text("left rear meri"),
    opposite = "leg_crab_merus_rr",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "leg_crab_carpus_rl",
    parent = "leg_crab_rear_l",
    name = ccb.content.text("left rear carpus"),
    plural_name = ccb.content.text("left rear carpi"),
    opposite = "leg_crab_carpus_rr",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_manus_rl",
    parent = "leg_crab_rear_l",
    name = ccb.content.text("left rear manus"),
    plural_name = ccb.content.text("left rear manuses"),
    opposite = "leg_crab_manus_rr",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_dactyl_rl",
    parent = "leg_crab_rear_l",
    name = ccb.content.text("left rear dactyl"),
    plural_name = ccb.content.text("left rear dactyls"),
    opposite = "leg_crab_dactyl_rr",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_basis_rr",
    parent = "leg_crab_rear_r",
    name = ccb.content.text("right rear basis"),
    plural_name = ccb.content.text("right rear bases"),
    opposite = "leg_crab_basis_rl",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "leg_crab_merus_rr",
    parent = "leg_crab_rear_r",
    name = ccb.content.text("right rear merus"),
    plural_name = ccb.content.text("right rear meri"),
    opposite = "leg_crab_merus_rl",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "leg_crab_carpus_rr",
    parent = "leg_crab_rear_r",
    name = ccb.content.text("right rear carpus"),
    plural_name = ccb.content.text("right rear carpi"),
    opposite = "leg_crab_carpus_rl",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_manus_rr",
    parent = "leg_crab_rear_r",
    name = ccb.content.text("right rear manus"),
    plural_name = ccb.content.text("right rear manuses"),
    opposite = "leg_crab_manus_rl",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "leg_crab_dactyl_rr",
    parent = "leg_crab_rear_r",
    name = ccb.content.text("right rear dactyl"),
    plural_name = ccb.content.text("right rear dactyls"),
    opposite = "leg_crab_dactyl_rl",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_front_base_l",
    parent = "tentacle_lower_front_l",
    name = ccb.content.text("left front tentacle base"),
    plural_name = ccb.content.text("front tentacle bases"),
    opposite = "tentacle_lower_front_base_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "tentacle_default_base_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_front_middle_l",
    parent = "tentacle_lower_front_l",
    name = ccb.content.text("left front tentacle midsection"),
    plural_name = ccb.content.text("front tentacle midsections"),
    opposite = "tentacle_lower_front_middle_r",
    side = "left",
    maximum_coverage = 45,
    similar_body_part = "tentacle_default_middle_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_front_tip_l",
    parent = "tentacle_lower_front_l",
    name = ccb.content.text("left front tentacle tip"),
    plural_name = ccb.content.text("front tentacle tips"),
    opposite = "tentacle_lower_front_tip_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "tentacle_default_tip_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_middle_base_l",
    parent = "tentacle_lower_middle_l",
    name = ccb.content.text("left middle tentacle base"),
    plural_name = ccb.content.text("middle tentacle bases"),
    opposite = "tentacle_lower_middle_base_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "tentacle_default_base_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_middle_middle_l",
    parent = "tentacle_lower_middle_l",
    name = ccb.content.text("left middle tentacle midsection"),
    plural_name = ccb.content.text("middle tentacle midsections"),
    opposite = "tentacle_lower_middle_middle_r",
    side = "left",
    maximum_coverage = 45,
    similar_body_part = "tentacle_default_middle_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_middle_tip_l",
    parent = "tentacle_lower_middle_l",
    name = ccb.content.text("left middle tentacle tip"),
    plural_name = ccb.content.text("middle tentacle tips"),
    opposite = "tentacle_lower_middle_tip_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "tentacle_default_tip_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_rear_base_l",
    parent = "tentacle_lower_rear_l",
    name = ccb.content.text("left rear tentacle base"),
    plural_name = ccb.content.text("rear tentacle bases"),
    opposite = "tentacle_lower_rear_base_r",
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "tentacle_default_base_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_rear_middle_l",
    parent = "tentacle_lower_rear_l",
    name = ccb.content.text("left rear tentacle midsection"),
    plural_name = ccb.content.text("rear tentacle midsections"),
    opposite = "tentacle_lower_rear_middle_r",
    side = "left",
    maximum_coverage = 45,
    similar_body_part = "tentacle_default_middle_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_rear_tip_l",
    parent = "tentacle_lower_rear_l",
    name = ccb.content.text("left rear tentacle tip"),
    plural_name = ccb.content.text("rear tentacle tips"),
    opposite = "tentacle_lower_rear_tip_r",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "tentacle_default_tip_l",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_front_base_r",
    parent = "tentacle_lower_front_r",
    name = ccb.content.text("right front tentacle base"),
    plural_name = ccb.content.text("front tentacle bases"),
    opposite = "tentacle_lower_front_base_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "tentacle_default_base_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_front_middle_r",
    parent = "tentacle_lower_front_r",
    name = ccb.content.text("right front tentacle midsection"),
    plural_name = ccb.content.text("front tentacle midsections"),
    opposite = "tentacle_lower_front_middle_l",
    side = "right",
    maximum_coverage = 45,
    similar_body_part = "tentacle_default_middle_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_front_tip_r",
    parent = "tentacle_lower_front_r",
    name = ccb.content.text("right front tentacle tip"),
    plural_name = ccb.content.text("front tentacle tips"),
    opposite = "tentacle_lower_front_tip_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "tentacle_default_tip_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_middle_base_r",
    parent = "tentacle_lower_middle_r",
    name = ccb.content.text("right middle tentacle base"),
    plural_name = ccb.content.text("middle tentacle bases"),
    opposite = "tentacle_lower_middle_base_l",
    side = "right",
    maximum_coverage = 30,
    similar_body_part = "tentacle_default_base_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_middle_middle_r",
    parent = "tentacle_lower_middle_r",
    name = ccb.content.text("right middle tentacle midsection"),
    plural_name = ccb.content.text("middle tentacle midsections"),
    opposite = "tentacle_lower_middle_middle_l",
    side = "right",
    maximum_coverage = 45,
    similar_body_part = "tentacle_default_middle_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_middle_tip_r",
    parent = "tentacle_lower_middle_r",
    name = ccb.content.text("right middle tentacle tip"),
    plural_name = ccb.content.text("middle tentacle tips"),
    opposite = "tentacle_lower_middle_tip_l",
    side = "right",
    maximum_coverage = 25,
    similar_body_part = "tentacle_default_tip_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_rear_base_r",
    parent = "tentacle_lower_rear_r",
    name = ccb.content.text("left rear tentacle base"),
    plural_name = ccb.content.text("rear tentacle bases"),
    side = "left",
    maximum_coverage = 30,
    similar_body_part = "tentacle_default_base_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_rear_middle_r",
    parent = "tentacle_lower_rear_r",
    name = ccb.content.text("left rear tentacle midsection"),
    plural_name = ccb.content.text("rear tentacle midsections"),
    opposite = "tentacle_lower_rear_middle_l",
    side = "left",
    maximum_coverage = 45,
    similar_body_part = "tentacle_default_middle_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_lower_rear_tip_r",
    parent = "tentacle_lower_rear_r",
    name = ccb.content.text("left rear tentacle tip"),
    plural_name = ccb.content.text("rear tentacle tips"),
    opposite = "tentacle_lower_rear_tip_l",
    side = "left",
    maximum_coverage = 25,
    similar_body_part = "tentacle_default_tip_r",
})

content.add(content.SubBodyPart {
    id = "tentacle_default_base_l",
    parent = "tentacle_default_l",
    name = ccb.content.text("left tentacle bases"),
    plural_name = ccb.content.text("left tentacle bases"),
    opposite = "tentacle_default_base_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "tentacle_default_middle_l",
    parent = "tentacle_default_l",
    name = ccb.content.text("left tentacle midsections"),
    plural_name = ccb.content.text("left tentacle midsections"),
    opposite = "tentacle_default_middle_r",
    side = "left",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "tentacle_default_tip_l",
    parent = "tentacle_default_l",
    name = ccb.content.text("left tentacle tips"),
    plural_name = ccb.content.text("left tentacle tips"),
    opposite = "tentacle_default_tip_r",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "tentacle_default_base_r",
    parent = "tentacle_default_r",
    name = ccb.content.text("right tentacle bases"),
    plural_name = ccb.content.text("right tentacle bases"),
    opposite = "tentacle_default_base_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "tentacle_default_middle_r",
    parent = "tentacle_default_r",
    name = ccb.content.text("right tentacle midsections"),
    plural_name = ccb.content.text("right tentacle midsections"),
    opposite = "tentacle_default_middle_l",
    side = "right",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "tentacle_default_tip_r",
    parent = "tentacle_default_r",
    name = ccb.content.text("right tentacle tips"),
    plural_name = ccb.content.text("right tentacle tips"),
    opposite = "tentacle_default_tip_l",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "tentacle_draped_lower_front_l",
    parent = "tentacle_lower_front_l",
    name = ccb.content.text("left front tentacle (draped)"),
    plural_name = ccb.content.text("left front tentacles (draped)"),
    opposite = "tentacle_draped_lower_front_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "tentacle_lower_front_base_l", "tentacle_lower_front_middle_l" },
})

content.add(content.SubBodyPart {
    id = "tentacle_draped_lower_middle_l",
    parent = "tentacle_lower_middle_l",
    name = ccb.content.text("left middle tentacle (draped)"),
    plural_name = ccb.content.text("left middle tentacles (draped)"),
    opposite = "tentacle_draped_lower_middle_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "tentacle_lower_middle_base_l", "tentacle_lower_middle_middle_l" },
})

content.add(content.SubBodyPart {
    id = "tentacle_draped_lower_rear_l",
    parent = "tentacle_lower_rear_l",
    name = ccb.content.text("left rear tentacle (draped)"),
    plural_name = ccb.content.text("left rear tentacles (draped)"),
    opposite = "tentacle_draped_lower_rear_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "tentacle_lower_rear_base_l", "tentacle_lower_rear_middle_l" },
})

content.add(content.SubBodyPart {
    id = "tentacle_draped_lower_front_r",
    parent = "tentacle_lower_front_r",
    name = ccb.content.text("right front tentacles (draped)"),
    plural_name = ccb.content.text("right front tentacles (draped)"),
    opposite = "tentacle_draped_lower_front_l",
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "tentacle_lower_middle_base_r", "tentacle_lower_middle_middle_r" },
})

content.add(content.SubBodyPart {
    id = "tentacle_draped_lower_middle_r",
    parent = "tentacle_lower_middle_r",
    name = ccb.content.text("right middle tentacles (draped)"),
    plural_name = ccb.content.text("right middle tentacles (draped)"),
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "tentacle_lower_middle_base_r", "tentacle_lower_middle_middle_r" },
})

content.add(content.SubBodyPart {
    id = "tentacle_draped_lower_rear_r",
    parent = "tentacle_lower_rear_r",
    name = ccb.content.text("right middle tentacles (draped)"),
    plural_name = ccb.content.text("right middle tentacles (draped)"),
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    locations_under = { "tentacle_lower_rear_base_r", "tentacle_lower_rear_middle_r" },
})

parts.inherit("leg_hip_l", {
    id = "leg_slime_hip_l",
    parent = "leg_slime_l",
    opposite = "leg_slime_hip_r",
    similar_body_part = "leg_hip_l",
})

parts.inherit("leg_upper_l", {
    id = "leg_slime_upper_l",
    parent = "leg_slime_l",
    opposite = "leg_slime_upper_r",
    similar_body_part = "leg_upper_l",
})

parts.inherit("leg_knee_l", {
    id = "leg_slime_knee_l",
    parent = "leg_slime_l",
    opposite = "leg_slime_knee_r",
    similar_body_part = "leg_knee_l",
})

parts.inherit("leg_lower_l", {
    id = "leg_slime_lower_l",
    parent = "leg_slime_l",
    opposite = "leg_slime_lower_r",
    similar_body_part = "leg_lower_l",
})

parts.inherit("leg_hip_r", {
    id = "leg_slime_hip_r",
    parent = "leg_slime_r",
    opposite = "leg_slime_hip_l",
    similar_body_part = "leg_hip_r",
})

parts.inherit("leg_upper_r", {
    id = "leg_slime_upper_r",
    parent = "leg_slime_r",
    opposite = "leg_slime_upper_l",
    similar_body_part = "leg_upper_r",
})

parts.inherit("leg_knee_r", {
    id = "leg_slime_knee_r",
    parent = "leg_slime_r",
    opposite = "leg_slime_knee_l",
    similar_body_part = "leg_knee_r",
})

parts.inherit("leg_lower_r", {
    id = "leg_slime_lower_r",
    parent = "leg_slime_r",
    opposite = "leg_slime_lower_l",
    similar_body_part = "leg_lower_r",
})

content.add(content.SubBodyPart {
    id = "leg_slime_draped_l",
    parent = "leg_slime_l",
    name = ccb.content.text("pseudopod (draped)"),
    plural_name = ccb.content.text("pseudopods (draped)"),
    opposite = "leg_slime_draped_r",
    side = "left",
    secondary = true,
    maximum_coverage = 100,
    similar_body_part = "leg_draped_l",
    locations_under = { "leg_slime_hip_l", "leg_slime_upper_l" },
})

content.add(content.SubBodyPart {
    id = "leg_slime_draped_r",
    parent = "leg_slime_r",
    name = ccb.content.text("pseudopod (draped)"),
    plural_name = ccb.content.text("pseudopods (draped)"),
    opposite = "leg_slime_draped_l",
    side = "right",
    secondary = true,
    maximum_coverage = 100,
    similar_body_part = "leg_draped_r",
    locations_under = { "leg_slime_hip_r", "leg_slime_upper_r" },
})

parts.inherit("foot_sole_l", {
    id = "foot_slime_sole_l",
    parent = "foot_slime_l",
    opposite = "foot_slime_sole_r",
    similar_body_part = "foot_sole_l",
})

parts.inherit("foot_arch_l", {
    id = "foot_slime_arch_l",
    parent = "foot_slime_l",
    opposite = "foot_slime_arch_r",
    similar_body_part = "foot_arch_l",
})

parts.inherit("foot_toes_l", {
    id = "foot_slime_toes_l",
    parent = "foot_slime_l",
    opposite = "foot_slime_toes_r",
    similar_body_part = "foot_toes_l",
})

parts.inherit("foot_ankle_l", {
    id = "foot_slime_ankle_l",
    parent = "foot_slime_l",
    opposite = "foot_slime_ankle_r",
    similar_body_part = "foot_ankle_l",
})

parts.inherit("foot_heel_l", {
    id = "foot_slime_heel_l",
    parent = "foot_slime_l",
    opposite = "foot_slime_heel_r",
    similar_body_part = "foot_heel_l",
})

parts.inherit("foot_sole_r", {
    id = "foot_slime_sole_r",
    parent = "foot_slime_r",
    opposite = "foot_slime_sole_l",
    similar_body_part = "foot_sole_r",
})

parts.inherit("foot_arch_r", {
    id = "foot_slime_arch_r",
    parent = "foot_slime_r",
    opposite = "foot_slime_arch_l",
    similar_body_part = "foot_arch_r",
})

parts.inherit("foot_toes_r", {
    id = "foot_slime_toes_r",
    parent = "foot_slime_r",
    opposite = "foot_slime_toes_l",
    similar_body_part = "foot_toes_r",
})

parts.inherit("foot_ankle_r", {
    id = "foot_slime_ankle_r",
    parent = "foot_slime_r",
    opposite = "foot_slime_ankle_l",
    similar_body_part = "foot_ankle_r",
})

parts.inherit("foot_heel_r", {
    id = "foot_slime_heel_r",
    parent = "foot_slime_r",
    opposite = "foot_slime_heel_l",
    similar_body_part = "foot_heel_r",
})

content.add(content.SubBodyPart {
    id = "hoof_sole_l",
    parent = "hoof_l",
    name = ccb.content.text("left hoof sole"),
    plural_name = ccb.content.text("hoof soles"),
    opposite = "hoof_sole_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "hoof_wall_l",
    parent = "hoof_l",
    name = ccb.content.text("left hoof wall"),
    plural_name = ccb.content.text("hoof walls"),
    opposite = "hoof_wall_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "hoof_fetlock_l",
    parent = "hoof_l",
    name = ccb.content.text("left hoof fetlock"),
    plural_name = ccb.content.text("hoof fetlocks"),
    opposite = "hoof_fetlock_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "hoof_sole_r",
    parent = "hoof_r",
    name = ccb.content.text("right hoof sole"),
    plural_name = ccb.content.text("hoof soles"),
    opposite = "hoof_sole_l",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "hoof_wall_r",
    parent = "hoof_r",
    name = ccb.content.text("right hoof wall"),
    plural_name = ccb.content.text("hoof walls"),
    opposite = "hoof_wall_l",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "hoof_fetlock_r",
    parent = "hoof_r",
    name = ccb.content.text("right hoof fetlock"),
    plural_name = ccb.content.text("hoof fetlocks"),
    opposite = "hoof_fetlock_l",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "avian_talon_bottom_l",
    parent = "avian_talon_l",
    name = ccb.content.text("left talon bottom"),
    plural_name = ccb.content.text("talon bottoms"),
    opposite = "avian_talon_bottom_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "avian_talon_top_l",
    parent = "avian_talon_l",
    name = ccb.content.text("left talon top"),
    plural_name = ccb.content.text("talon top"),
    opposite = "avian_talon_top_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "avian_talon_talons_l",
    parent = "avian_talon_l",
    name = ccb.content.text("left front talons"),
    plural_name = ccb.content.text("front talons"),
    opposite = "avian_talon_talons_r",
    side = "left",
    maximum_coverage = 35,
})

content.add(content.SubBodyPart {
    id = "avian_talon_ankle_l",
    parent = "avian_talon_l",
    name = ccb.content.text("left ankle"),
    plural_name = ccb.content.text("ankles"),
    opposite = "avian_talon_ankle_r",
    side = "left",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "avian_talon_rear_l",
    parent = "avian_talon_l",
    name = ccb.content.text("left rear talon"),
    plural_name = ccb.content.text("rear talons"),
    opposite = "avian_talon_rear_r",
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "avian_talon_bottom_r",
    parent = "avian_talon_r",
    name = ccb.content.text("right talon bottom"),
    plural_name = ccb.content.text("talon bottoms"),
    opposite = "avian_talon_bottom_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "avian_talon_top_r",
    parent = "avian_talon_r",
    name = ccb.content.text("right talon top"),
    plural_name = ccb.content.text("talon top"),
    opposite = "avian_talon_top_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "avian_talon_talons_r",
    parent = "avian_talon_r",
    name = ccb.content.text("right front talons"),
    plural_name = ccb.content.text("front talons"),
    opposite = "avian_talon_talons_l",
    side = "right",
    maximum_coverage = 35,
})

content.add(content.SubBodyPart {
    id = "avian_talon_ankle_r",
    parent = "avian_talon_r",
    name = ccb.content.text("right ankle"),
    plural_name = ccb.content.text("ankles"),
    opposite = "avian_talon_ankle_l",
    side = "right",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "avian_talon_rear_r",
    parent = "avian_talon_r",
    name = ccb.content.text("right rear talon"),
    plural_name = ccb.content.text("rear talons"),
    opposite = "avian_talon_rear_l",
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_sole_l",
    parent = "animal_paw_l",
    name = ccb.content.text("left foot bottom"),
    plural_name = ccb.content.text("foot bottoms"),
    opposite = "digitigrade_foot_sole_r",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_arch_l",
    parent = "animal_paw_l",
    name = ccb.content.text("left foot arch"),
    plural_name = ccb.content.text("foot arches"),
    opposite = "digitigrade_foot_arch_r",
    side = "left",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_toes_l",
    parent = "animal_paw_l",
    name = ccb.content.text("left toes"),
    plural_name = ccb.content.text("toes"),
    opposite = "digitigrade_foot_toes_r",
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_ankle_l",
    parent = "animal_paw_l",
    name = ccb.content.text("left ankle"),
    plural_name = ccb.content.text("ankles"),
    opposite = "digitigrade_foot_ankle_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_heel_l",
    parent = "animal_paw_l",
    name = ccb.content.text("left heel"),
    plural_name = ccb.content.text("heels"),
    opposite = "digitigrade_foot_heel_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_sole_r",
    parent = "animal_paw_r",
    name = ccb.content.text("right foot bottom"),
    plural_name = ccb.content.text("foot bottoms"),
    opposite = "digitigrade_foot_sole_l",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_arch_r",
    parent = "animal_paw_r",
    name = ccb.content.text("right foot arch"),
    plural_name = ccb.content.text("foot arches"),
    opposite = "digitigrade_foot_arch_l",
    side = "right",
    maximum_coverage = 25,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_toes_r",
    parent = "animal_paw_r",
    name = ccb.content.text("right toes"),
    plural_name = ccb.content.text("toes"),
    opposite = "digitigrade_foot_toes_l",
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_ankle_r",
    parent = "animal_paw_r",
    name = ccb.content.text("right ankle"),
    plural_name = ccb.content.text("ankles"),
    opposite = "digitigrade_foot_ankle_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "digitigrade_foot_heel_r",
    parent = "animal_paw_r",
    name = ccb.content.text("right heel"),
    plural_name = ccb.content.text("heels"),
    opposite = "digitigrade_foot_heel_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "tail_default_base",
    parent = "tail",
    name = ccb.content.text("default tail base"),
    plural_name = ccb.content.text("default bases"),
    opposite = "tail_default_tip",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "tail_default_center",
    parent = "tail",
    name = ccb.content.text("default tail center"),
    plural_name = ccb.content.text("default tail centers"),
    maximum_coverage = 60,
})

content.add(content.SubBodyPart {
    id = "tail_default_tip",
    parent = "tail",
    name = ccb.content.text("default tail tip"),
    plural_name = ccb.content.text("default tail tips"),
    opposite = "tail_default_base",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "tail_long_base",
    parent = "tail_long",
    name = ccb.content.text("long tail base"),
    plural_name = ccb.content.text("tail bases"),
    opposite = "tail_long_tip",
    maximum_coverage = 10,
    similar_body_part = "tail_default_base",
})

content.add(content.SubBodyPart {
    id = "tail_long_center",
    parent = "tail_long",
    name = ccb.content.text("long tail center"),
    plural_name = ccb.content.text("long tail centers"),
    maximum_coverage = 60,
    similar_body_part = "tail_default_center",
})

content.add(content.SubBodyPart {
    id = "tail_long_tip",
    parent = "tail_long",
    name = ccb.content.text("long tail tip"),
    plural_name = ccb.content.text("long tail tips"),
    opposite = "tail_long_base",
    maximum_coverage = 30,
    similar_body_part = "tail_default_tip",
})

content.add(content.SubBodyPart {
    id = "tail_fluffy_base",
    parent = "tail_fluffy",
    name = ccb.content.text("fluffy tail base"),
    plural_name = ccb.content.text("fluffy tail bases"),
    opposite = "tail_fluffy_tip",
    maximum_coverage = 10,
    similar_body_part = "tail_default_base",
})

content.add(content.SubBodyPart {
    id = "tail_fluffy_center",
    parent = "tail_fluffy",
    name = ccb.content.text("fluffy tail center"),
    plural_name = ccb.content.text("fluffy tail centers"),
    maximum_coverage = 60,
    similar_body_part = "tail_default_center",
})

content.add(content.SubBodyPart {
    id = "tail_fluffy_tip",
    parent = "tail_fluffy",
    name = ccb.content.text("fluffy tail tip"),
    plural_name = ccb.content.text("fluffy tail tips"),
    opposite = "tail_fluffy_base",
    maximum_coverage = 30,
    similar_body_part = "tail_default_tip",
})

content.add(content.SubBodyPart {
    id = "tail_thick_base",
    parent = "tail_thick",
    name = ccb.content.text("thick tail base"),
    plural_name = ccb.content.text("thick tail bases"),
    opposite = "tail_thick_tip",
    maximum_coverage = 10,
    similar_body_part = "tail_default_base",
})

content.add(content.SubBodyPart {
    id = "tail_thick_center",
    parent = "tail_thick",
    name = ccb.content.text("thick tail center"),
    plural_name = ccb.content.text("thick tail centers"),
    maximum_coverage = 60,
    similar_body_part = "tail_default_center",
})

content.add(content.SubBodyPart {
    id = "tail_thick_tip",
    parent = "tail_thick",
    name = ccb.content.text("thick tail tip"),
    plural_name = ccb.content.text("thick tail tips"),
    opposite = "tail_thick_base",
    maximum_coverage = 30,
    similar_body_part = "tail_default_tip",
})

content.add(content.SubBodyPart {
    id = "tail_scorpion_base",
    parent = "tail_scorpion",
    name = ccb.content.text("scorpion tail base"),
    plural_name = ccb.content.text("scorpion tail bases"),
    opposite = "tail_scorpion_stinger",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "tail_scorpion_center",
    parent = "tail_scorpion",
    name = ccb.content.text("scorpion tail center"),
    plural_name = ccb.content.text("scorpion tail centers"),
    maximum_coverage = 60,
})

content.add(content.SubBodyPart {
    id = "tail_scorpion_stinger",
    parent = "tail_scorpion",
    name = ccb.content.text("scorpion tail stinger"),
    plural_name = ccb.content.text("scorpion tail stingers"),
    opposite = "tail_scorpion_base",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "tail_club_base",
    parent = "tail_club",
    name = ccb.content.text("club tail base"),
    plural_name = ccb.content.text("club tails base"),
    opposite = "tail_club_club",
    maximum_coverage = 10,
    similar_body_part = "tail_default_base",
})

content.add(content.SubBodyPart {
    id = "tail_club_center",
    parent = "tail_club",
    name = ccb.content.text("club tail center"),
    plural_name = ccb.content.text("club tails center"),
    maximum_coverage = 60,
    similar_body_part = "tail_default_center",
})

content.add(content.SubBodyPart {
    id = "tail_club_club",
    parent = "tail_club",
    name = ccb.content.text("club tail mace"),
    plural_name = ccb.content.text("club tail mace"),
    opposite = "tail_club_base",
    maximum_coverage = 30,
    similar_body_part = "tail_default_tip",
})

content.add(content.SubBodyPart {
    id = "tail_bovine_base",
    parent = "tail_bovine",
    name = ccb.content.text("cattle tail base"),
    plural_name = ccb.content.text("cattle tails base"),
    opposite = "tail_bovine_tip",
    maximum_coverage = 10,
    similar_body_part = "tail_default_base",
})

content.add(content.SubBodyPart {
    id = "tail_bovine_center",
    parent = "tail_bovine",
    name = ccb.content.text("cattle tail center"),
    plural_name = ccb.content.text("cattle tails center"),
    maximum_coverage = 60,
    similar_body_part = "tail_default_center",
})

content.add(content.SubBodyPart {
    id = "tail_bovine_tip",
    parent = "tail_bovine",
    name = ccb.content.text("cattle tail mace"),
    plural_name = ccb.content.text("cattle tail mace"),
    opposite = "tail_bovine_base",
    maximum_coverage = 30,
    similar_body_part = "tail_default_tip",
})

content.add(content.SubBodyPart {
    id = "tail_raptor_base",
    parent = "tail_raptor",
    name = ccb.content.text("raptor tail base"),
    plural_name = ccb.content.text("raptor tail bases"),
    opposite = "tail_raptor_tip",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "tail_raptor_center",
    parent = "tail_raptor",
    name = ccb.content.text("raptor tail center"),
    plural_name = ccb.content.text("raptor tail centers"),
    maximum_coverage = 50,
})

-- Higher tip ratio due to feathers
content.add(content.SubBodyPart {
    id = "tail_raptor_tip",
    parent = "tail_raptor",
    name = ccb.content.text("raptor tail tip"),
    plural_name = ccb.content.text("raptor tail tips"),
    opposite = "tail_raptor_base",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "tail_finned_base",
    parent = "tail_finned",
    name = ccb.content.text("finned tail base"),
    plural_name = ccb.content.text("finned tail bases"),
    opposite = "tail_finned_tip",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "tail_finned_center",
    parent = "tail_finned",
    name = ccb.content.text("finned tail center"),
    plural_name = ccb.content.text("finned tail centers"),
    maximum_coverage = 50,
})

-- Higher tip ratio due to fin
content.add(content.SubBodyPart {
    id = "tail_finned_tip",
    parent = "tail_finned",
    name = ccb.content.text("finned tail tip"),
    plural_name = ccb.content.text("finned tail tips"),
    opposite = "tail_finned_base",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "tail_rat_base",
    parent = "tail_rat",
    name = ccb.content.text("rat tail base"),
    plural_name = ccb.content.text("rat tail bases"),
    opposite = "tail_rat_tip",
    maximum_coverage = 10,
    similar_body_part = "tail_default_base",
})

content.add(content.SubBodyPart {
    id = "tail_rat_center",
    parent = "tail_rat",
    name = ccb.content.text("long tail center"),
    plural_name = ccb.content.text("rat tail centers"),
    maximum_coverage = 60,
    similar_body_part = "tail_default_center",
})

content.add(content.SubBodyPart {
    id = "tail_rat_tip",
    parent = "tail_rat",
    name = ccb.content.text("rat tail tip"),
    plural_name = ccb.content.text("rat tail tips"),
    opposite = "tail_rat_base",
    maximum_coverage = 30,
    similar_body_part = "tail_default_tip",
})
