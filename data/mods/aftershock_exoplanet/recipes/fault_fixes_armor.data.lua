local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_armor_fault_armor_carbide",
    name = ccb.content.text("Patch Carbide Armor"),
    removes = { "fault_armor_carbide" },
    success_message = ccb.content.text("You use the patch kit to repair the worst of the damage."),
    mod_damage = -1000,
    mod_degradation = -50,
    duration = "10 minutes",
    skills = { fabrication = 1 },
    requirements = { { components = { { { "afs_ipav_patch_kit", 1 } } } } },
}
