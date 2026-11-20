local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_fault_bonic_salvaged_reset",
    name = ccb.content.text("Reset to factory state"),
    success_message = ccb.content.text("You successfully reset the %s to its factory state."),
    duration = "45 m",
    removes = { "fault_bionic_salvaged" },
    skills = { mechanics = 3, electronics = 2, firstaid = 4 },
    requirements = { { qualities = { { id = "WRENCH_FINE", level = 1 }, { id = "SCREW_FINE", level = 1 } } } },
}
