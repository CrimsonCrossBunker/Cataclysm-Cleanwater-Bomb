local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electro_spawn_robot_interface",
    name = ccb.content.text_without_extraction("[Ψ]Create Robotic Interface"),
    description = ccb.content.text_without_extraction("Creates a tool used to hack robots.  It's a bug if you have it."),
    valid_targets = { "self" },
    skill = "metaphysics",
    flags = { "PSIONIC", "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX", "PERMANENT" },
    effect = "spawn_item",
    effect_data = "electro_robot_interface",
    shape = "blast",
    min_duration = 0,
    max_duration = 0,
}
