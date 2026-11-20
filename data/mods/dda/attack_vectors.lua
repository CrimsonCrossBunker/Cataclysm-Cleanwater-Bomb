local ccb = require("ccb")
local content = ccb.content

-- Native attack vectors
do
local definition = content.AttackVector {
    id = "test_test",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 33,
    health_percent_limit = 75,
}
definition:limb("debug_tail")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_headbutt",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 50,
}
definition:limb("head")
definition:contact("head_forehead")
definition:contact("head_slime_forehead")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_bite",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("mouth")
definition:contact("mouth_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_punch",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hand_l")
definition:limb("hand_r")
definition:contact("hand_fingers_l")
definition:contact("hand_fingers_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_wrist",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hand_l")
definition:limb("hand_r")
definition:contact("hand_wrist_l")
definition:contact("hand_wrist_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_palm",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hand_l")
definition:limb("hand_r")
definition:contact("hand_palm_l")
definition:contact("hand_palm_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_grasp",
    weapon = false,
    strict_limbs = false,
    armor_bonus = false,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hand_l")
definition:limb("hand_r")
definition:contact("hand_palm_l")
definition:contact("hand_palm_r")
definition:requires_limb("arm", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_backhand",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hand_l")
definition:limb("hand_r")
definition:contact("hand_back_l")
definition:contact("hand_back_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_shoulder",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("arm_l")
definition:limb("arm_r")
definition:contact("arm_shoulder_l")
definition:contact("arm_shoulder_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_arm",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("arm_l")
definition:limb("arm_r")
definition:contact("arm_upper_r")
definition:contact("arm_elbow_r")
definition:contact("arm_lower_r")
definition:contact("arm_upper_l")
definition:contact("arm_elbow_l")
definition:contact("arm_lower_l")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_arm_grapple",
    weapon = false,
    strict_limbs = false,
    armor_bonus = false,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("arm_l")
definition:limb("arm_r")
definition:contact("arm_upper_r")
definition:contact("arm_elbow_r")
definition:contact("arm_lower_r")
definition:contact("arm_upper_l")
definition:contact("arm_elbow_l")
definition:contact("arm_lower_l")
definition:requires_limb("arm", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_elbow",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("arm_l")
definition:limb("arm_r")
definition:contact("arm_elbow_l")
definition:contact("arm_elbow_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_foot_toes",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("foot_l")
definition:limb("foot_r")
definition:contact("foot_toes_l")
definition:contact("foot_toes_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_foot_sole",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("foot_l")
definition:limb("foot_r")
definition:contact("foot_sole_l")
definition:contact("foot_sole_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_foot_heel",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("foot_l")
definition:limb("foot_r")
definition:contact("foot_heel_l")
definition:contact("foot_heel_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_knee",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("leg_l")
definition:limb("leg_r")
definition:contact("leg_knee_l")
definition:contact("leg_knee_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_shin",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 50,
}
definition:limb("leg_l")
definition:limb("leg_r")
definition:contact("leg_lower_l")
definition:contact("leg_lower_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_bear_bite",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("muzzle_bear")
definition:contact("muzzle_bear_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_lupine_bite",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("muzzle_lupine")
definition:contact("muzzle_lupine_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_reptile_bite",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("muzzle_long")
definition:contact("muzzle_long_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_rodent_bite",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("muzzle_rodent")
definition:contact("muzzle_rodent_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_rabbit_bite",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("muzzle_rabbit")
definition:contact("mouth_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_bird_peck",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("beak_bird")
definition:contact("beak_tip")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_bird_woodpecker_peck",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("beak_woodpecker")
definition:contact("beak_woodpecker_tip")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_gastropod_tongue",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 1,
    health_percent_limit = 10,
}
definition:limb("gastropod_tongue")
definition:contact("gastropod_tongue_chin")
definition:contact("gastropod_tongue_lips")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_crab_pincer",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("crustacean_pincer_r")
definition:contact("crustacean_pincer_claws_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_slime_punch",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hand_slime_l")
definition:limb("hand_slime_r")
definition:limb("hand_slime_complete_l")
definition:limb("hand_slime_complete_r")
definition:contact("hand_slime_fingers_l")
definition:contact("hand_slime_fingers_r")
definition:contact("hand_slime_complete_fingers_l")
definition:contact("hand_slime_complete_fingers_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_broad_paw_punch",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("paw_broad_l")
definition:limb("paw_broad_r")
definition:contact("paw_broad_fingers_l")
definition:contact("paw_broad_fingers_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_paw_punch",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("paw_l")
definition:limb("paw_r")
definition:contact("paw_fingers_l")
definition:contact("paw_fingers_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_paw_rat_punch",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("paw_rat_l")
definition:limb("paw_rat_r")
definition:contact("paw_rat_fingers_l")
definition:contact("paw_rat_fingers_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_little_paw_punch",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("paw_little_l")
definition:limb("paw_little_r")
definition:contact("paw_little_fingers_l")
definition:contact("paw_little_fingers_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_wing_slap",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("arm_wing_bird_l")
definition:limb("arm_wing_bird_r")
definition:contact("arm_wing_bird_lower_r")
definition:contact("arm_wing_bird_lower_l")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_vine_limb",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("vine_limb_upper_r")
definition:limb("vine_limb_upper_l")
definition:limb("vine_limb_lower_r")
definition:limb("vine_limb_lower_l")
definition:contact("vine_sublimb_ur")
definition:contact("vine_sublimb_ul")
definition:contact("vine_sublimb_lr")
definition:contact("vine_sublimb_ll")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_hoof_kick",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("hoof_l")
definition:limb("hoof_r")
definition:contact("hoof_sole_l")
definition:contact("hoof_sole_r")
definition:contact("hoof_wall_l")
definition:contact("hoof_wall_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_avian_talons",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("avian_talon_l")
definition:limb("avian_talon_r")
definition:contact("avian_talon_talons_l")
definition:contact("avian_talon_talons_r")
definition:contact("avian_talon_bottom_l")
definition:contact("avian_talon_bottom_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_slime_kick",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("foot_slime_l")
definition:limb("foot_slime_r")
definition:contact("foot_slime_sole_l")
definition:contact("foot_slime_arch_l")
definition:contact("foot_slime_toes_l")
definition:contact("foot_slime_ankle_l")
definition:contact("foot_slime_heel_l")
definition:contact("foot_slime_sole_r")
definition:contact("foot_slime_arch_r")
definition:contact("foot_slime_toes_r")
definition:contact("foot_slime_ankle_r")
definition:contact("foot_slime_heel_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_digitigrade_paws",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("animal_paw_l")
definition:limb("animal_paw_r")
definition:contact("digitigrade_foot_toes_l")
definition:contact("digitigrade_foot_toes_r")
definition:requires_limb("leg", 2)
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_avian_talons_rear",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("avian_talon_l")
definition:limb("avian_talon_r")
definition:contact("avian_talon_rear_l")
definition:contact("avian_talon_rear_r")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_tail_sting",
    weapon = false,
    strict_limbs = true,
    armor_bonus = true,
    encumbrance_limit = 2,
    health_percent_limit = 50,
}
definition:limb("tail_scorpion")
definition:contact("tail_scorpion_stinger")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_tail_thick",
    weapon = false,
    strict_limbs = true,
    armor_bonus = true,
    encumbrance_limit = 4,
    health_percent_limit = 50,
}
definition:limb("tail_thick")
definition:contact("tail_thick_center")
definition:contact("tail_thick_tip")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_tail_club",
    weapon = false,
    strict_limbs = true,
    armor_bonus = true,
    encumbrance_limit = 4,
    health_percent_limit = 50,
}
definition:limb("tail_club")
definition:contact("tail_club_center")
definition:contact("tail_club_club")
content.add(definition)
end
