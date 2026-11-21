local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PRE_EYES_INSECT",
    name = ccb.content.text("Changing Eyes"),
    types = { "CHANGING_LIMB_EYES" },
    prerequisites = { "EYEBULGE" },
    secondary_prerequisites = { "CHITIN2", "CHITIN2_MOLTED" },
    description = ccb.content.text("Something is shifting painfully behind your eyeballs.  <color_red>This change will be reversible.  The next one might not be, should you continue.</color>"),
    points = 0,
    cooldown = "2 h",
    on_process = "process_pre_eyes_insect",
    categories = { "INSECT" },
}

ccb.content.define_mutation {
    id = "EYES_INSECT",
    name = ccb.content.text("Compound Eyes"),
    types = { "EYES", "CHANGING_LIMB_EYES", "CHANGING_LIMB_HEAD" },
    prerequisites = { "EYEBULGE", "PRE_EYES_INSECT" },
    secondary_prerequisites = { "CHITIN2", "CHITIN2_MOLTED" },
    points = -2,
    description = ccb.content.text("Your eyes have turned into iridescent spheres bulging out of their original sockets.  Your detail vision suffered terribly, and the expanded field of view is dizzying.  <color_red>You can still go back to how you used to be.  If you continue changing in this direction you will be permanently changed.  Progress from this state will need the matching threshold.</color>"),
    categories = { "INSECT" },
    cancels = { "PRE_EYES_INSECT" },
    replacements = { "EYES_INSECT_2" },
    cooldown = "2 h",
    on_process = "process_eyes_insect",
    valid = false,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_EYES_INSECT_0" },
}
