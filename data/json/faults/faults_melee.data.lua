local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_blade_rolled_edge",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Rolled edge"),
    description = ccb.content.text("Edge of the blade got rolled, making it harder to cut."),
    melee_damage = { { damage_type = "cut", multiply = 0.8 } },
}

ccb.content.define_fault {
    id = "fault_blade_chipped",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Chipped edge"),
    description = ccb.content.text("The small piece of blade edge was broken off, making it much duller."),
    melee_damage = { { damage_type = "cut", multiply = 0.8 } },
}

-- Later this should be a hidden fault and increase the likelihood of damage-type faults appearing.
ccb.content.define_fault {
    id = "interior_cracks",
    fault_type = "crafting_defect",
    severity = "minor",
    name = ccb.content.text("Interior cracks"),
    description = ccb.content.text("Although this weapon appears to have been constructed properly, there are voids and damage below the surface."),
    melee_damage = { { damage_type = "cut", multiply = 0.9 } },
}

ccb.content.define_fault {
    id = "limp_edge",
    fault_type = "crafting_defect",
    severity = "critical",
    name = ccb.content.text("Limp edge"),
    description = ccb.content.text("You've made a curved sword.  Very curved."),
    melee_damage = { { damage_type = "cut", multiply = 0.1 } },
}

ccb.content.define_fault {
    id = "fault_blade_cracked",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Crack"),
    degradation_mod = 50,
    description = ccb.content.text("There is a deep crack on the blade.  A sure sign that the entire thing will break apart sooner or later.  Any attempt to repair it would only further damage the blade, so the days for this %s are numbered."),
}

ccb.content.define_fault {
    id = "fault_blade_broken_half",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken blade"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.65 },
        { damage_type = "stab", multiply = 0.3 },
        { damage_type = "bash", multiply = 0.8 },
    },
    description = ccb.content.text("The small part of this blade broke away.  You still can use it, but it's much less effective."),
    blocks = { "fault_blade_broken_tip", "fault_blade_bent_tip" },
    affected_by_degradation = true,
}

ccb.content.define_fault {
    id = "fault_blade_broken",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken blade"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.1 },
        { damage_type = "stab", multiply = 0.1 },
        { damage_type = "bash", multiply = 0.2 },
    },
    description = ccb.content.text("The blade shattered completely, making it just a stub.  The only way to repair such damage to make a new weapon."),
    blocks = {
        "fault_blade_rolled_edge",
        "fault_blade_chipped",
        "fault_blade_cracked",
        "fault_blade_broken_half",
        "fault_blade_broken_tip",
        "fault_blade_bent_tip",
    },
    affected_by_degradation = true,
}

ccb.content.define_fault {
    id = "fault_blade_broken_tip",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Broken tip"),
    melee_damage = { { damage_type = "stab", multiply = 0.6 } },
    blocks = { "fault_blade_bent_tip" },
    description = ccb.content.text("The tip of the blade you could use to thrust is no more."),
}

ccb.content.define_fault {
    id = "fault_blade_bent_tip",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Bent tip"),
    melee_damage = { { damage_type = "stab", multiply = 0.4 } },
    description = ccb.content.text("The tip of the blade you could use to thrust rolled into a spiral."),
}

ccb.content.define_fault {
    id = "fault_spearhead_fracture",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Tip fracture"),
    description = ccb.content.text("The tip of %s snapped off, making the thrusts weaker."),
    melee_damage = { { damage_type = "stab", multiply = 0.8 } },
}

ccb.content.define_fault {
    id = "fault_spearhead_warped",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Tip warp"),
    description = ccb.content.text("The tip of %s started to warp, making the thrusts weaker."),
    melee_damage = { { damage_type = "stab", multiply = 0.8 } },
}

ccb.content.define_fault {
    id = "fault_spearhead_chipping",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Tip chipping"),
    description = ccb.content.text("Small pieces of %s started to chip off, making the thrusts less damaging."),
    melee_damage = { { damage_type = "stab", multiply = 0.9 } },
}

ccb.content.define_fault {
    id = "fault_spearhead_bent_socket",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Bent socket"),
    description = ccb.content.text("The %s's socket was bent off, making the tip not lined with a shaft, and making the weapon very hard to thrust properly."),
    item_suffix = ccb.content.text("bent"),
    melee_damage = { { damage_type = "stab", multiply = 0.7 } },
}

ccb.content.define_fault {
    id = "fault_spearhead_broken",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken head"),
    description = ccb.content.text("The head of %s is completely broken.  The only way to repair such damage is to make a new one."),
    blocks = {
        "fault_spearhead_fracture",
        "fault_spearhead_warped",
        "fault_spearhead_chipping",
        "fault_spearhead_bent_socket",
    },
    melee_damage = { { damage_type = "stab", multiply = 0.1 } },
    affected_by_degradation = true,
}

-- staff faults are just handle faults, but for weapon that is entirely made of handle, like sticks, staffs and 2-by-sword variations
-- `short` is less than 120 cm, `long` is 120+ cm
ccb.content.define_fault {
    id = "fault_staff_short_chipping",
    copy_from = "fault_handle_chipping",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Chipping"),
    description = ccb.content.text("Small pieces of %s are chipping off."),
}

ccb.content.define_fault {
    id = "fault_staff_short_cracked",
    copy_from = "fault_handle_cracked",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Cracks"),
    degradation_mod = 50,
    description = ccb.content.text("There is a nasty crack on this %s.  Better to fix it before the entire thing snaps in half!"),
}

ccb.content.define_fault {
    id = "fault_staff_short_broken",
    copy_from = "fault_handle_broken",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken"),
    description = ccb.content.text("The entire %s just snapped, leaving only long splinters."),
    item_suffix = ccb.content.text("broken"),
    blocks = { "fault_staff_short_chipping", "fault_staff_short_cracked" },
    melee_damage = { { damage_type = "bash", multiply = 0.25 } },
}

ccb.content.define_fault {
    id = "fault_staff_long_chipping",
    copy_from = "fault_handle_long_chipping",
    fault_type = "mechanical_damage",
    severity = "minor",
    name = ccb.content.text("Chipping"),
    description = ccb.content.text("Small pieces of %s are chipping off."),
}

ccb.content.define_fault {
    id = "fault_staff_long_cracked",
    copy_from = "fault_handle_long_cracked",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Cracks"),
    description = ccb.content.text("There is a nasty crack on this %s.  Better to fix it before the entire shaft snaps in half!"),
}

ccb.content.define_fault {
    id = "fault_staff_long_broken_half",
    copy_from = "fault_handle_long_broken_half",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Broken"),
    description = ccb.content.text("This %s is snapped in half.  You still can use it, albeit much less effectively."),
    blocks = { "fault_staff_long_chipping", "fault_staff_long_cracked" },
    melee_damage = { { damage_type = "bash", multiply = 0.5 } },
}

ccb.content.define_fault {
    id = "fault_staff_long_broken",
    copy_from = "fault_handle_long_broken",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Broken"),
    description = ccb.content.text("This %s is completely broken."),
    blocks = { "fault_staff_long_chipping", "fault_staff_long_cracked", "fault_staff_long_broken_half" },
    melee_damage = { { damage_type = "bash", multiply = 0.1 } },
}

-- This fault is meant for weapons that have a long handle made out of steel pipes (120cm +) (so mostly spear type weapons)
ccb.content.define_fault {
    id = "fault_steel_pipe_staff_bent",
    fault_type = "mechanical_damage",
    severity = "major",
    name = ccb.content.text("Bent"),
    degradation_mod = 50,
    description = ccb.content.text("The %s has been bent."),
    item_suffix = ccb.content.text("bent"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.6 },
        { damage_type = "stab", multiply = 0.5 },
        { damage_type = "bash", multiply = 0.6 },
    },
}

ccb.content.define_fault {
    id = "fault_steel_pipe_staff_bent_heavy",
    fault_type = "mechanical_damage",
    severity = "critical",
    name = ccb.content.text("Heavily bent"),
    description = ccb.content.text("The %s has been heavily bent."),
    blocks = { "fault_steel_pipe_staff_bent" },
    item_suffix = ccb.content.text("heavily bent"),
    melee_damage = {
        { damage_type = "cut", multiply = 0.2 },
        { damage_type = "stab", multiply = 0.1 },
        { damage_type = "bash", multiply = 0.2 },
    },
    affected_by_degradation = true,
}

-- This fault is meant for aluminum bats.
ccb.content.define_fault {
    id = "fault_aluminum_bat_bent",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Bent"),
    degradation_mod = 20,
    description = ccb.content.text("The %s has been bent."),
    item_suffix = ccb.content.text("bent"),
    melee_damage = { { damage_type = "bash", multiply = 0.8 } },
}

-- This fault is meant for aluminum bats.
ccb.content.define_fault {
    id = "fault_aluminum_bat_bent_heavy",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Collapsed"),
    degradation_mod = 50,
    description = ccb.content.text("The %1$s has collapsed, a part of the once hollow bat is now touching inside of it due to heavy bending.  It is usable still but significantly less effective."),
    item_suffix = ccb.content.text("collapsed"),
    melee_damage = { { damage_type = "bash", multiply = 0.5 } },
}

-- This fault is meant for aluminum bats.
ccb.content.define_fault {
    id = "fault_aluminum_bat_handle_broken",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Broken handle"),
    degradation_mod = 50,
    description = ccb.content.text("The handle of the %1$s has completely broken and separated from it."),
    item_suffix = ccb.content.text("no handle"),
    melee_damage = { { damage_type = "bash", multiply = 0.1 } },
}

-- This fault is meant for batons.
-- Ideally this would make it so you can't retract it anymore, this is not possible currently.
ccb.content.define_fault {
    copy_from = "fault_aluminum_bat_bent",
    id = "fault_baton_bent",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Bent"),
    description = ccb.content.text("The shaft of the %1$s has been bent."),
    melee_damage = { { damage_type = "bash", multiply = 0.7 } },
}

-- This fault is meant for batons.
-- Ideally this would make it so you can't retract it anymore, maybe, this is not possible currently.
ccb.content.define_fault {
    id = "fault_baton_bent_tip",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Bent tip"),
    degradation_mod = 50,
    description = ccb.content.text("The tip of the %1$s has been bent."),
    melee_damage = { { damage_type = "bash", multiply = 0.7 } },
}

-- This fault is meant for batons.
ccb.content.define_fault {
    id = "fault_baton_broken_tip",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Broken tip"),
    degradation_mod = 50,
    description = ccb.content.text("The tip of the %1$s has broken off"),
    blocks = { "fault_baton_bent_tip" },
    melee_damage = { { damage_type = "bash", multiply = 0.5 } },
}

-- This fault is meant for batons.
-- Ideally this would make it so you can't retract it anymore, this is not possible currently.
ccb.content.define_fault {
    id = "fault_baton_handle_broken",
    copy_from = "fault_handle_broken",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Broken handle"),
    description = ccb.content.text("The handle of the %1$s has separated from the shaft, rendering it nigh unusable."),
}

-- This fault is meant for tonfas.
ccb.content.define_fault {
    id = "fault_tonfa_handle_broken",
    copy_from = "fault_handle_broken",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Broken handle"),
    degradation_mod = 60,
    description = ccb.content.text("The handle of the %1$s has broken off."),
    melee_damage = { { damage_type = "bash", multiply = 0.6 } },
}

-- This fault is meant for tonfas.
ccb.content.define_fault {
    id = "fault_tonfa_broken",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Broken"),
    description = ccb.content.text("The %1$s is broken in half."),
    melee_damage = { { damage_type = "bash", multiply = 0.1 } },
}

-- This fault is meant for the ax_sheets variants.
ccb.content.define_fault {
    id = "fault_pipe_shaft_broken",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Broken shaft"),
    degradation_mod = 100,
    description = ccb.content.text("The pipe shaft of the %1$s has broken in half, you can still wield by holding onto the second pipe though, albeit it's very awkward and unwieldy."),
    item_suffix = ccb.content.text("broken shaft"),
    melee_damage = { { damage_type = "bash", multiply = 0.4 }, { damage_type = "cut", multiply = 0.4 } },
}

-- This fault is meant for the ax_sheets variants.
ccb.content.define_fault {
    id = "fault_sheets_detached",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Detached sheets"),
    degradation_mod = 100,
    description = ccb.content.text("The sheets of the %1$s have detached from the pipe shaft."),
    melee_damage = { { damage_type = "bash", multiply = 0.5 }, { damage_type = "cut", multiply = 0 } },
}

-- This fault is meant for bullwhips.
ccb.content.define_fault {
    id = "fault_ripped_thong",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Ripped thong"),
    degradation_mod = 100,
    description = ccb.content.text("The thong of the %1$s has ripped in half due to repeated use."),
    melee_damage = { { damage_type = "bash", multiply = 0.4 }, { damage_type = "cut", multiply = 0.3 } },
}

-- This fault is meant for bullwhips.
ccb.content.define_fault {
    id = "fault_ripped_tip",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Ripped tip"),
    degradation_mod = 40,
    description = ccb.content.text("The tip of the %1$s has ripped off."),
    melee_damage = { { damage_type = "bash", multiply = 0.8 }, { damage_type = "cut", multiply = 0.9 } },
}

-- This fault is meant for knuckles.
ccb.content.define_fault {
    id = "fault_shattered",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Shattered"),
    degradation_mod = 100,
    description = ccb.content.text("The %1$s has shattered."),
    melee_damage = { { damage_type = "bash", multiply = 0.2 } },
}

-- This fault is meant for knuckles.
ccb.content.define_fault {
    id = "fault_cracked",
    fault_type = "mechanical_damage",
    name = ccb.content.text("Shattered"),
    degradation_mod = 40,
    description = ccb.content.text("The %1$s is cracked."),
    melee_damage = { { damage_type = "bash", multiply = 0.8 } },
}
