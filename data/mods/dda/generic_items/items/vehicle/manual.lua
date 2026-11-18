local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "hand_rims",
        name = ccb.content.plural_text("set of hand rims", "sets of hand rims"),
        description = ccb.content.text("A set of hand rims for use on a wheelchair."),
        mass_milligrams = 816000,
        melee_to_hit = -1,
        color = "light_gray",
        symbol = ":",
        volume_ml = 500,
        category = "veh_parts",
        price_cents = 9000,
        price_postapoc_cents = 100,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    -- Steel grade is a guess: its load is similar to wheel axles that are made out of medium steel
    local item = content.Item {
        id = "foot_crank",
        copy_from = "hand_rims",
        looks_like = "hand_rims",
        name = ccb.content.plural_text("foot crank", "foot cranks"),
        description = ccb.content.text("A pedal and gear assembly from a bicycle."),
    }
    item:material("mc_steel", 1)
    content.add(item)
end
