local ccb = require("ccb")
local content = ccb.content

-- Native composable movement modes
do
local definition = content.MovementMode {
    id = "walk",
    name = ccb.content.text("walk"),
    kind = "walking",
    character_symbol = "w",
    panel_symbol = "W",
    panel_color = "white",
    symbol_color = "white",
    exertion = 4,
    riding_exertion = 2,
    stamina_multiplier = 1,
    sound_multiplier = 1,
    speed_multiplier = 1,
    mech_power_kilojoules = 2,
    swim_speed_modifier = 0,
    stop_hauling = false,
}
definition:messages("none", {
    prepare = ccb.content.text("You prepare to start walking."),
    success = ccb.content.text("You start walking."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("animal", {
    prepare = ccb.content.text("Your steed is ready to slow down to a walk."),
    success = ccb.content.text("You slow your steed to a walk."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("mech", {
    prepare = ccb.content.text("You prepare to toggle your mech's leg power to a loping fast walk."),
    success = ccb.content.text("You set your mech's leg power to a loping fast walk."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
content.add(definition)
end
do
local definition = content.MovementMode {
    id = "run",
    name = ccb.content.text("run"),
    kind = "running",
    character_symbol = "r",
    panel_symbol = "R",
    panel_color = "red",
    symbol_color = "yellow",
    exertion = 8,
    riding_exertion = 4,
    stamina_multiplier = 7,
    sound_multiplier = 1.5,
    speed_multiplier = 2,
    mech_power_kilojoules = 2,
    swim_speed_modifier = -80,
    stop_hauling = true,
}
definition:messages("none", {
    prepare = ccb.content.text("You prepare to start running."),
    success = ccb.content.text("You start running."),
    failure = ccb.content.text("You're too tired or injured to run."),
})
definition:messages("animal", {
    prepare = ccb.content.text("Your steed is ready to speed up to a steady trot."),
    success = ccb.content.text("You nudge your steed into a steady trot."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("mech", {
    prepare = ccb.content.text("You prepare to toggle your mech's leg servos to maximum."),
    success = ccb.content.text("You set the power of your mech's leg servos to maximum."),
    failure = ccb.content.text("Your mech's leg servos are unable to operate faster."),
})
content.add(definition)
end
do
local definition = content.MovementMode {
    id = "crouch",
    name = ccb.content.text("crouch"),
    kind = "crouching",
    character_symbol = "c",
    panel_symbol = "C",
    panel_color = "light_blue",
    symbol_color = "light_gray",
    exertion = 4,
    riding_exertion = 0,
    stamina_multiplier = 1,
    sound_multiplier = 0.5,
    speed_multiplier = 0.5,
    mech_power_kilojoules = 2,
    swim_speed_modifier = 50,
    stop_hauling = false,
}
definition:messages("none", {
    prepare = ccb.content.text("You prepare to crouch low."),
    success = ccb.content.text("You start crouching."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("animal", {
    prepare = ccb.content.text("If you see this, it is a bug, you can't crouch on an animal."),
    success = ccb.content.text("If you see this, it is a bug, you can't crouch on an animal."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("mech", {
    prepare = ccb.content.text("You prepare to toggle your mech's leg power to the minimum."),
    success = ccb.content.text("You reduce the power of your mech's leg servos to minimum."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
content.add(definition)
end
do
local definition = content.MovementMode {
    id = "prone",
    name = ccb.content.text("prone"),
    kind = "prone",
    character_symbol = "p",
    panel_symbol = "P",
    panel_color = "green",
    symbol_color = "blue",
    exertion = 1,
    riding_exertion = 0,
    stamina_multiplier = 1,
    sound_multiplier = 0.20000000000000001,
    speed_multiplier = 0.20000000000000001,
    mech_power_kilojoules = 2,
    swim_speed_modifier = 50,
    stop_hauling = false,
}
definition:messages("none", {
    prepare = ccb.content.text("You prepare to lay on the floor."),
    success = ccb.content.text("You lie down."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("animal", {
    prepare = ccb.content.text("If you see this, it is a bug, you can't go prone on an animal."),
    success = ccb.content.text("If you see this, it is a bug, you can't go prone on an animal."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
definition:messages("mech", {
    prepare = ccb.content.text("You prepare to toggle your mech's leg power off."),
    success = ccb.content.text("You turn off your mech's leg servos."),
    failure = ccb.content.text("You feel bugs crawl over your skin."),
})
content.add(definition)
end
