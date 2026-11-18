local ccb = require("ccb")
local content = ccb.content

content.add(content.SubBodyPart {
    id = "karma_hand",
    parent = "bp_null",
    name = ccb.content.text("karma hand"),
    plural_name = ccb.content.text("karma hands"),
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "stalker_eye",
    parent = "bp_null",
    name = ccb.content.text("stalker eye"),
    plural_name = ccb.content.text("stalker eyes"),
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "gracken_eye",
    parent = "bp_null",
    name = ccb.content.text("gracken eye"),
    plural_name = ccb.content.text("gracken eyes"),
    side = "right",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "devil_tail_tip",
    parent = "bp_null",
    name = ccb.content.text("devil's tail tip"),
    plural_name = ccb.content.text("devil's tail tips"),
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "assist_hand",
    parent = "bp_null",
    name = ccb.content.text("assistant's  hand"),
    plural_name = ccb.content.text("assistant's hands"),
    side = "left",
    maximum_coverage = 10,
})

content.add(content.SubBodyPart {
    id = "salamander_wing_subpart_r",
    parent = "salamander_wing_r",
    name = ccb.content.text("salamander wing"),
    plural_name = ccb.content.text("salamander wing"),
    opposite = "salamander_wing_subpart_l",
    side = "right",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "salamander_wing_subpart_l",
    parent = "salamander_wing_l",
    name = ccb.content.text("salamander wing"),
    plural_name = ccb.content.text("salamander wing"),
    opposite = "salamander_wing_subpart_r",
    side = "left",
    maximum_coverage = 100,
})

content.add(content.SubBodyPart {
    id = "eyes_arvore_left",
    parent = "fae_eyes_arvore",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_arvore_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_arvore_right",
    parent = "fae_eyes_arvore",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_arvore_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_homullus_left",
    parent = "fae_eyes_homullus",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_homullus_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_homullus_right",
    parent = "fae_eyes_homullus",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_homullus_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_ierde_left",
    parent = "fae_eyes_ierde",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_ierde_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_ierde_right",
    parent = "fae_eyes_ierde",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_ierde_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_salamander_left",
    parent = "fae_eyes_salamander",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_salamander_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_salamander_right",
    parent = "fae_eyes_salamander",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_salamander_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_sylph_left",
    parent = "fae_eyes_sylph",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_sylph_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_sylph_right",
    parent = "fae_eyes_sylph",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_sylph_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "eyes_undine_left",
    parent = "fae_eyes_undine",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_undine_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_undine_right",
    parent = "fae_eyes_undine",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_undine_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "wing_gossamer_basal_l",
    parent = "wing_gossamer_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_gossamer_basal_r",
    side = "left",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "wing_gossamer_forewing_l",
    parent = "wing_gossamer_l",
    name = ccb.content.text("left forewing"),
    plural_name = ccb.content.text("forewings"),
    opposite = "wing_gossamer_forewing_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_gossamer_hindwing_l",
    parent = "wing_gossamer_l",
    name = ccb.content.text("left hindwing"),
    plural_name = ccb.content.text("hindwings"),
    opposite = "wing_gossamer_hindwing_r",
    side = "left",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_gossamer_basal_r",
    parent = "wing_gossamer_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_gossamer_basal_l",
    side = "right",
    maximum_coverage = 20,
})

content.add(content.SubBodyPart {
    id = "wing_gossamer_forewing_r",
    parent = "wing_gossamer_r",
    name = ccb.content.text("right forewing"),
    plural_name = ccb.content.text("forewings"),
    opposite = "wing_gossamer_forewing_l",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_gossamer_hindwing_r",
    parent = "wing_gossamer_r",
    name = ccb.content.text("right hindwing"),
    plural_name = ccb.content.text("hindwings"),
    opposite = "wing_gossamer_hindwing_l",
    side = "right",
    maximum_coverage = 40,
})

content.add(content.SubBodyPart {
    id = "wing_strix_shoulder_l",
    parent = "wing_strix_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_strix_shoulder_r",
    side = "left",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "wing_strix_shoulder_r",
    parent = "wing_strix_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_strix_shoulder_l",
    side = "right",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "wing_strix_upper_l",
    parent = "wing_strix_l",
    name = ccb.content.text("left upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "wing_strix_upper_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "wing_strix_upper_r",
    parent = "wing_strix_r",
    name = ccb.content.text("right upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "wing_strix_upper_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "wing_strix_joint_l",
    parent = "wing_strix_l",
    name = ccb.content.text("left wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "wing_strix_joint_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "wing_strix_joint_r",
    parent = "wing_strix_r",
    name = ccb.content.text("right wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "wing_strix_joint_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "wing_strix_lower_l",
    parent = "wing_strix_l",
    name = ccb.content.text("lower left wings"),
    plural_name = ccb.content.text("lower wing"),
    opposite = "wing_strix_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "wing_strix_lower_r",
    parent = "wing_strix_r",
    name = ccb.content.text("lower right wing"),
    plural_name = ccb.content.text("lower wings"),
    opposite = "wing_strix_lower_l",
    side = "right",
    maximum_coverage = 45,
})
