local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_afs_motion_sensor_wield_active", function(ctx)
    return ctx.character_inputs.character_variables["flag_motion_sensor_afs_motion_sensor_ping"] >= 1
end)

content.add(content.Enchantment {
    id = "afs_motion_sensor_wield",
    has = "WIELD",
    name = content.text("Active Motion Detector"),
    description = content.text("Actively detects nearby movement."),
    condition_handler = "enchantment_afs_motion_sensor_wield_active",
    load_character_inputs = { character_variables = { "flag_motion_sensor_afs_motion_sensor_ping" } },
}
    :vision({ distance = 24, precise = true, descriptions = { { id = "moving_creature", color = "c_white", symbol = "?", text = content.text("You sense something moving here.") } } }))
