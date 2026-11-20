local ccb = require("ccb")
local content = ccb.content

-- Native attack vectors
do
local definition = content.AttackVector {
    id = "vector_ravenfolk_wing_slap",
    weapon = false,
    strict_limbs = false,
    armor_bonus = true,
    encumbrance_limit = 100,
    health_percent_limit = 10,
}
definition:limb("wing_ravenfolk_l")
definition:limb("wing_ravenfolk_r")
definition:contact("wing_ravenfolk_lower_r")
definition:contact("wing_ravenfolk_lower_l")
content.add(definition)
end
