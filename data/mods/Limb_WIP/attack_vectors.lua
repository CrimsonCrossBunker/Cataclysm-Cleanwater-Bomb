local ccb = require("ccb")
local content = ccb.content

-- Native attack vectors
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
content.replace(definition)
end
