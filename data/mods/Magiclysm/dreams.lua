local ccb = require("ccb")
local content = ccb.content

-- Native dream definitions
do
local definition = content.Dream {
    category = "DRAGON_BLACK",
    strength = 1,
}
definition:message("You have a strange dream about dragons.")
definition:message("Your dreams give you a strange scaly feeling.")
content.add(definition)
end
do
local definition = content.Dream {
    category = "DRAGON_BLACK",
    strength = 2,
}
definition:message("You have a disturbing dream of rampaging in a village.")
definition:message("While dreaming, you see a distinctively dragon-like reflection of yourself.")
content.add(definition)
end
do
local definition = content.Dream {
    category = "DRAGON_BLACK",
    strength = 3,
}
definition:message("You blissfully dream of soaring over a human village.  The thought of destroying it and abducting the chiefs daughter is somewhat disturbing.")
definition:message("You have a disturbingly lifelike dream of living as a dragon.")
content.add(definition)
end
do
local definition = content.Dream {
    category = "DRAGON_BLACK",
    strength = 4,
}
definition:message("In your dream you are the nightmare of a human.")
definition:message("You have a disturbingly satisfying dream of ravaging a human village.")
definition:message("You dream of raiding a castle and abducting the princess.")
content.add(definition)
end
