local ccb = require("ccb")
local content = ccb.content

-- Native climbing-aid definitions
do
local definition = content.ClimbingAid {
    id = "null",
}
definition:available_when {
    category = "special",
    flag = "null",
}
definition:descent {
    menu_text = ccb.content.text("Climb down by lowering yourself from the ledge."),
    hotkey = "c",
    confirm_text = ccb.content.text("Climb down the ledge?"),
    after_message = ccb.content.text("You lower yourself from the ledge."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "default",
}
definition:available_when {
    category = "special",
    flag = "",
}
definition:descent {
    menu_text = ccb.content.text("Climb down by lowering yourself from the ledge."),
    hotkey = "c",
    confirm_text = ccb.content.text("Climb down the ledge?"),
    after_message = ccb.content.text("You lower yourself from the ledge."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "vehicle",
    slip_chance_modifier = -8,
}
definition:available_when {
    category = "vehicle",
    flag = "INITIAL_PART",
}
definition:descent {
    menu_text = ccb.content.text("Climb down onto the vehicle here."),
    confirm_text = ccb.content.text("Climb down onto the vehicle?"),
    after_message = ccb.content.text("You climb down onto the vehicle."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "veh_LADDER",
    slip_chance_modifier = -20,
}
definition:available_when {
    category = "vehicle",
    flag = "LADDER",
}
definition:descent {
    max_height = 999,
    easy_climb_back_up = 999,
    menu_text = ccb.content.text("Climb down the vehicle ladder."),
    confirm_text = ccb.content.text("Climb down the vehicle ladder?"),
    after_message = ccb.content.text("You climb down the vehicle ladder."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "furn_CLIMBABLE",
    slip_chance_modifier = -5,
}
definition:available_when {
    category = "terrain_or_furniture",
    flag = "CLIMBABLE",
}
definition:descent {
    menu_text = ccb.content.text("Climb down %s here."),
    confirm_text = ccb.content.text("Climb down %s?"),
    after_message = ccb.content.text("You climb down."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "furn_CLIMB_SIMPLE",
    slip_chance_modifier = -40,
}
definition:available_when {
    category = "terrain_or_furniture",
    flag = "CLIMB_SIMPLE",
}
definition:descent {
    menu_text = ccb.content.text("Clamber down onto %s here."),
    confirm_text = ccb.content.text("Clamber down onto %s?"),
    after_message = ccb.content.text("You clamber down onto %s."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "furn_LADDER",
    slip_chance_modifier = -20,
}
definition:available_when {
    category = "terrain_or_furniture",
    flag = "LADDER",
}
definition:descent {
    menu_text = ccb.content.text("Climb down %s here."),
    confirm_text = ccb.content.text("Climb down %s?"),
    after_message = ccb.content.text("You climb down the ladder."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "item_stepladder",
    slip_chance_modifier = -20,
}
definition:available_when {
    category = "item",
    flag = "stepladder",
    uses = 1,
}
definition:descent {
    easy_climb_back_up = 1,
    allow_remaining_height = false,
    menu_text = ccb.content.text("Place your wooden stepladder below and climb down."),
    unavailable_text = ccb.content.text("Can't place your stepladder (needs open space one story below)."),
    hotkey = "l",
    confirm_text = ccb.content.text("Climb down with your stepladder?"),
    after_message = ccb.content.text("You lower the ladder into place and climb down."),
}
definition:deploy("f_ladder")
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "item_aluminum_stepladder",
    slip_chance_modifier = -20,
}
definition:available_when {
    category = "item",
    flag = "aluminum_stepladder",
    uses = 1,
}
definition:descent {
    easy_climb_back_up = 1,
    allow_remaining_height = false,
    menu_text = ccb.content.text("Place your aluminum stepladder below and climb down."),
    unavailable_text = ccb.content.text("Can't place your stepladder (needs open space one story below)."),
    hotkey = "l",
    confirm_text = ccb.content.text("Climb down with your stepladder?"),
    after_message = ccb.content.text("You lower the ladder into place and climb down."),
}
definition:deploy("f_aluminum_stepladder")
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "furn_ROPE",
    slip_chance_modifier = -12,
}
definition:available_when {
    category = "terrain_or_furniture",
    flag = "DIFFICULT_Z",
}
definition:descent {
    menu_text = ccb.content.text("Rappel down with the %s here."),
    confirm_text = ccb.content.text("Rappel down with the %s?"),
    before_message = ccb.content.text("You grasp the rope firmly and rappel down."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "item_grapnel",
    slip_chance_modifier = -12,
}
definition:available_when {
    category = "item",
    flag = "grapnel",
    uses = 1,
}
definition:descent {
    easy_climb_back_up = 1,
    menu_text = ccb.content.text("Attach your grappling hook and rappel down."),
    unavailable_text = ccb.content.text("Can't attach your grappling hook (something is in the way)."),
    hotkey = "g",
    confirm_text = ccb.content.text("Use your grappling hook to rappel down?"),
    before_message = ccb.content.text("You tie the rope around your waist and begin to rappel down."),
}
definition:deploy("f_rope_up")
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_WALL_CLING",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "character",
    flag = "WALL_CLING",
}
definition:descent {
    menu_text = ccb.content.text("Crawl down the wall."),
    confirm_text = ccb.content.text("Crawl down the wall?"),
    after_message = ccb.content.text("You crawl down the wall."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_WEB_RAPPEL",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "trait",
    flag = "WEB_RAPPEL",
}
definition:descent {
    max_height = 999,
    easy_climb_back_up = 999,
    menu_text = ccb.content.text("Spin your webs to descend."),
    unavailable_text = ccb.content.text("Can't spin your webs (something is in the way)."),
    hotkey = "w",
    confirm_text = ccb.content.text("Use your webs to descend?"),
    before_message = ccb.content.text("You affix a long, sticky strand on the ledge and begin your descent."),
    after_message = ccb.content.text("You descend effortlessly."),
}
definition:cost {
    kilocalories = 87,
    thirst = 10,
}
definition:deploy("f_web_up")
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_INSECT_ARMS_OK",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "trait",
    flag = "INSECT_ARMS_OK",
}
definition:descent {
    max_height = 2,
    menu_text = ccb.content.text("Crawl down using all your arms."),
    confirm_text = ccb.content.text("Crawl down?"),
    after_message = ccb.content.text("You crawl down using all your arms."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_VINES2",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "trait",
    flag = "VINES2",
}
definition:descent {
    menu_text = ccb.content.text("Climb down using your vines."),
    confirm_text = ccb.content.text("Use your vines to descend?"),
    after_message = ccb.content.text("You gingerly descend using your vines."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_VINES2_deploy",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "trait",
    flag = "VINES2",
}
definition:descent {
    easy_climb_back_up = 1,
    menu_text = ccb.content.text("Detach a vine so you can climb back up (<color_yellow>this will hurt</color>)."),
    unavailable_text = ccb.content.text("Can't detach a vine (something is in the way)."),
    hotkey = "v",
    confirm_text = ccb.content.text("Detach a vine to descend?"),
    after_message = ccb.content.text("You descend on your vines, though leaving a part of you behind stings."),
}
definition:cost {
    pain = 5,
    damage = 5,
    kilocalories = 87,
    thirst = 10,
}
definition:deploy("f_vine_up")
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_VINES3",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "trait",
    flag = "VINES3",
}
definition:descent {
    menu_text = ccb.content.text("Climb down using your vines."),
    confirm_text = ccb.content.text("Use your vines to descend?"),
    after_message = ccb.content.text("You effortlessly descend using your vines."),
}
content.add(definition)
end
do
local definition = content.ClimbingAid {
    id = "ability_VINES3_deploy",
    slip_chance_modifier = -100,
}
definition:available_when {
    category = "trait",
    flag = "VINES3",
}
definition:descent {
    easy_climb_back_up = 1,
    menu_text = ccb.content.text("Detach a vine so you can climb back up (this is harmless)."),
    unavailable_text = ccb.content.text("Can't detach a vine (something is in the way)."),
    hotkey = "v",
    confirm_text = ccb.content.text("Detach a vine to descend?"),
    after_message = ccb.content.text("You effortlessly lower yourself and leave a vine rooted for future use."),
}
definition:cost {
    kilocalories = 87,
    thirst = 10,
}
definition:deploy("f_vine_up")
content.add(definition)
end
