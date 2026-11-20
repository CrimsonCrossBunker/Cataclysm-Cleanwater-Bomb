local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_handle_chipping",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Chipping handle"),
    degradation_mod = 50,
    description = ccb.content.text("Small pieces of the handle are chipping off."),
}

ccb.content.define_fault {
    id = "fault_handle_cracked",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Cracked handle"),
    degradation_mod = 50,
    description = ccb.content.text("There is a nasty crack on a handle.  Better fix it before the entire shaft snaps in half!"),
}

ccb.content.define_fault {
    id = "fault_handle_broken",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken handle"),
    description = ccb.content.text("Instead of a handle, there is just a small piece of wood that is left."),
    item_suffix = ccb.content.text("no handle"),
    blocks = { "fault_handle_chipping", "fault_handle_cracked", "fault_handle_off" },
    melee_damage = {
        { damage_type = "cut", multiply = 0.1 },
        { damage_type = "stab", multiply = 0.1 },
        { damage_type = "bash", multiply = 0.1 },
    },
    affected_by_degradation = true,
}

ccb.content.define_fault {
    id = "fault_handle_off",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("No handle"),
    description = ccb.content.text("The handle that was here before snapped away."),
    item_suffix = ccb.content.text("no handle"),
    blocks = { "fault_handle_chipping", "fault_handle_cracked", "fault_handle_broken" },
    melee_damage = {
        { damage_type = "cut", multiply = 0.1 },
        { damage_type = "stab", multiply = 0.1 },
        { damage_type = "bash", multiply = 0.1 },
    },
    affected_by_degradation = true,
}

ccb.content.define_fault {
    id = "fault_handle_long_chipping",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Chipping handle"),
    degradation_mod = 50,
    description = ccb.content.text("Small pieces of the handle are chipping off."),
}

ccb.content.define_fault {
    id = "fault_handle_long_cracked",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Cracked handle"),
    degradation_mod = 50,
    description = ccb.content.text("There is a nasty crack on a handle.  Better fix it before the entire shaft snaps in half!"),
}

ccb.content.define_fault {
    id = "fault_handle_long_broken_half",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Broken handle"),
    description = ccb.content.text("The handle is snapped in half.  You can still use it, albeit less effectively."),
    blocks = {
        "fault_handle_long_chipping",
        "fault_handle_long_cracked",
        "fault_handle_long_broken",
        "fault_handle_long_off",
    },
    item_suffix = ccb.content.text("snapped"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.7 },
        { damage_type = "stab", multiply = 0.7 },
        { damage_type = "bash", multiply = 0.7 },
    },
    affected_by_degradation = true,
}

ccb.content.define_fault {
    id = "fault_handle_long_broken",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken handle"),
    description = ccb.content.text("The handle is completely broken."),
    blocks = {
        "fault_handle_long_chipping",
        "fault_handle_long_cracked",
        "fault_handle_long_broken_half",
        "fault_handle_long_off",
    },
    item_suffix = ccb.content.text("no handle"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.1 },
        { damage_type = "stab", multiply = 0.1 },
        { damage_type = "bash", multiply = 0.3 },
    },
    affected_by_degradation = true,
}

ccb.content.define_fault {
    id = "fault_handle_long_off",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("No handle"),
    description = ccb.content.text("The head of the tool completely separated from the shaft."),
    blocks = {
        "fault_handle_long_chipping",
        "fault_handle_long_cracked",
        "fault_handle_long_broken_half",
        "fault_handle_long_broken",
    },
    item_suffix = ccb.content.text("no handle"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.1 },
        { damage_type = "stab", multiply = 0.1 },
        { damage_type = "bash", multiply = 0.3 },
    },
    affected_by_degradation = true,
}

-- This fault is meant for tools and weapons whose handle resembles a steel pipe.  Examples are pipe, makeshift crowbar, sharpened pipe.
ccb.content.define_fault {
    id = "fault_steel_pipe_bent",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Bent"),
    degradation_mod = 50,
    description = ccb.content.text("The %s has been bent."),
    item_suffix = ccb.content.text("bent"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.8 },
        { damage_type = "stab", multiply = 0.7 },
        { damage_type = "bash", multiply = 0.8 },
    },
}

-- This fault is supposed to be a followup of fault_steel_pipe_bent if it isn't mended quickly
ccb.content.define_fault {
    id = "fault_steel_pipe_bent_heavy",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Heavily bent"),
    description = ccb.content.text("The %s has been heavily bent."),
    blocks = { "fault_steel_pipe_bent" },
    item_suffix = ccb.content.text("heavily bent"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.5 },
        { damage_type = "stab", multiply = 0.4 },
        { damage_type = "bash", multiply = 0.5 },
    },
    affected_by_degradation = true,
}
