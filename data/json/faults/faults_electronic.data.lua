local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_electronic_blown_fuse",
    fault_type = "shorted",
    name = ccb.content.text("Blown fuse"),
    description = ccb.content.text("Required for closing a protected electronic circuit."),
    item_prefix = ccb.content.text("shorted"),
    flags = { "ITEM_BROKEN" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_electronic_blown_fuse",
    name = ccb.content.text("Replace blown fuse"),
    success_message = ccb.content.text("You replace the blown fuse of the %s."),
    duration = "5 m",
    removes = { "fault_electronic_blown_fuse" },
    skills = { electronics = 3 },
    requirements = {
        {
            qualities = { { id = "SCREW", level = 1 } },
            components = { { { "e_scrap", 1 } }, { { "copper_wire", 1 }, { "cable", 1 } } },
        },
    },
}

ccb.content.define_fault {
    id = "fault_electronic_blown_capacitor",
    fault_type = "shorted",
    name = ccb.content.text("Blown capacitor"),
    description = ccb.content.text("Required for storing charge in an electronic circuit."),
    item_prefix = ccb.content.text("shorted"),
    flags = { "ITEM_BROKEN" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_electronic_blown_capacitor",
    name = ccb.content.text("Replace blown fuse"),
    success_message = ccb.content.text("You replace the blown capacitor of the %s."),
    duration = "10 m",
    removes = { "fault_electronic_blown_capacitor" },
    skills = { electronics = 4 },
    requirements = {
        { id = "soldering_standard", count = 5 },
        { qualities = { { id = "SCREW", level = 1 } }, components = { { { "e_scrap", 1 } } } },
    },
}

ccb.content.define_fault {
    id = "fault_electronic_shorted_circuit",
    fault_type = "shorted",
    name = ccb.content.text("Shorted electronic circuit"),
    description = ccb.content.text("An electronic circuit has been destroyed by overvoltage."),
    item_prefix = ccb.content.text("shorted"),
    flags = { "ITEM_BROKEN" },
}

ccb.content.define_fault_fix {
    id = "mend_fault_electronic_shorted_circuit",
    name = ccb.content.text("Replace shorted circuit"),
    success_message = ccb.content.text("You replace the shorted circuit of the %s."),
    duration = "70 m",
    removes = { "fault_electronic_shorted_circuit" },
    skills = { electronics = 5 },
    requirements = {
        { id = "soldering_standard", count = 5 },
        { qualities = { { id = "SCREW", level = 1 } }, components = { { { "circuit", 1 } } } },
    },
}

ccb.content.define_fault {
    id = "fault_emp_reboot",
    name = ccb.content.text("rebooting"),
    description = ccb.content.text("This device is rebooting after being shorted by an EMP."),
    item_prefix = ccb.content.text("rebooting"),
    flags = { "ITEM_BROKEN" },
}
