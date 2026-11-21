local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PRE_ARM_FEATHERS",
    name = ccb.content.text("Changing Arms"),
    types = { "ARMS" },
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your arms feel…different.  Occasionally something shifts under the skin - sometimes it does so without pain.  Whatever is happening in there, it's far from done.  <color_red>This change will be reversible.  The next one might not be, should you continue.</color>"),
    cooldown = "2 h",
    replacements = { "ARM_FEATHERS" },
    prerequisites = { "FEATHERS", "SPARSE_SCALES" },
    on_process = "process_pre_arm_feathers",
    categories = { "BIRD", "RAPTOR" },
}

ccb.content.define_mutation {
    id = "ARM_FEATHERS",
    name = ccb.content.text("Feathered Arms"),
    types = { "ARMS" },
    points = 2,
    visibility = 8,
    mixed_effect = true,
    description = ccb.content.text("Your forearms are covered by long, stiff feathers.  While they are impressive to look at and resistant to water and other contaminants, they always get in the way and you hate it when they get filthy.  <color_red>You can still go back to how you used to be.  If you continue changing in this direction you will be permanently changed.  Progress from this state will need the matching threshold.</color>"),
    categories = { "RAPTOR", "BIRD" },
    prerequisites = { "FEATHERS", "SPARSE_SCALES" },
    secondary_prerequisites = { "PRE_ARM_FEATHERS" },
    valid = false,
    replacements = { "WINGS_BIRD" },
    cooldown = "2 h",
    on_process = "process_arm_feathers",
    vitamin_cost = 150,
    enchantments = { "INLINE_ENCH_ARM_FEATHERS_0" },
}
