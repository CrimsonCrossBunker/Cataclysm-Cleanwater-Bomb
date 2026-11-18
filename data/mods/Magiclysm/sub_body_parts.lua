local ccb = require("ccb")
local content = ccb.content

content.add(content.SubBodyPart {
    id = "eyes_goblin_left",
    parent = "eyes_goblin",
    name = ccb.content.text("left eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_goblin_right",
    side = "left",
    maximum_coverage = 50,
    similar_body_part = "eyes_left",
})

content.add(content.SubBodyPart {
    id = "eyes_goblin_right",
    parent = "eyes_goblin",
    name = ccb.content.text("right eye"),
    plural_name = ccb.content.text("eyes"),
    opposite = "eyes_goblin_left",
    side = "right",
    maximum_coverage = 50,
    similar_body_part = "eyes_right",
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_shoulder_l",
    parent = "wing_ravenfolk_l",
    name = ccb.content.text("left wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_ravenfolk_shoulder_r",
    side = "left",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_shoulder_r",
    parent = "wing_ravenfolk_r",
    name = ccb.content.text("right wing shoulder"),
    plural_name = ccb.content.text("wing shoulders"),
    opposite = "wing_ravenfolk_shoulder_l",
    side = "right",
    maximum_coverage = 15,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_upper_l",
    parent = "wing_ravenfolk_l",
    name = ccb.content.text("left upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "wing_ravenfolk_upper_r",
    side = "left",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_upper_r",
    parent = "wing_ravenfolk_r",
    name = ccb.content.text("right upper wing"),
    plural_name = ccb.content.text("upper wings"),
    opposite = "wing_ravenfolk_upper_l",
    side = "right",
    maximum_coverage = 30,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_joint_l",
    parent = "wing_ravenfolk_l",
    name = ccb.content.text("left wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "wing_ravenfolk_joint_r",
    side = "left",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_joint_r",
    parent = "wing_ravenfolk_r",
    name = ccb.content.text("right wing joint"),
    plural_name = ccb.content.text("wing joints"),
    opposite = "wing_ravenfolk_joint_l",
    side = "right",
    maximum_coverage = 5,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_lower_l",
    parent = "wing_ravenfolk_l",
    name = ccb.content.text("lower left wings"),
    plural_name = ccb.content.text("lower wing"),
    opposite = "wing_ravenfolk_lower_r",
    side = "left",
    maximum_coverage = 45,
})

content.add(content.SubBodyPart {
    id = "wing_ravenfolk_lower_r",
    parent = "wing_ravenfolk_r",
    name = ccb.content.text("lower right wing"),
    plural_name = ccb.content.text("lower wings"),
    opposite = "wing_ravenfolk_lower_l",
    side = "right",
    maximum_coverage = 45,
})
