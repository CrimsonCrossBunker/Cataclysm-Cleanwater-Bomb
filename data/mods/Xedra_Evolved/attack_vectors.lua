local ccb = require("ccb")
local content = ccb.content

-- Native attack vectors
do
local definition = content.AttackVector {
    id = "vector_salamander_wing_slap",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("salamander_wing_r")
definition:limb("salamander_wing_l")
definition:contact("salamander_wing_subpart_r")
definition:contact("salamander_wing_subpart_l")
content.add(definition)
end
do
local definition = content.AttackVector {
    id = "vector_strix_wing_slap",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("wing_strix_r")
definition:limb("wing_strix_l")
definition:contact("wing_strix_lower_l")
definition:contact("wing_strix_lower_r")
content.add(definition)
end
