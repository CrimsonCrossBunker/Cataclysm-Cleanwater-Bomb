local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MELEE_PERK_FEINT",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Feint drills"),
    description = ccb.content.text("Perform a feint whenever an attack would miss."),
    flags = { "MELEE_PERK_FEINT" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_STAGGER_STRIKE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Staggering Strikes"),
    description = ccb.content.text("Attacks with bashing weapons are likely to stun their target if the full combat tempo bonus is active."),
    flags = { "MELEE_PERK_STAGGER_STRIKE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_FORE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Fore!"),
    description = ccb.content.text("Hah, just watch this.\nCritical strikes with bashing weapons can knock your targets backwards.  You are guaranteed to knock back stunned targets."),
    flags = { "MELEE_PERK_FORE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_MAKE_WAY",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Make Way"),
    description = ccb.content.text("Perform an overhead attack with a polearm or staff.  The attack will knock back all targets hit."),
    flags = { "MELEE_PERK_MAKE_WAY" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_STAFF_KICK",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Fulcrum Kick"),
    description = ccb.content.text("Deliver a powerful flying kick using a polearm as a springboard.  The kick will knock back humanoid targets of similar or smaller size."),
    flags = { "MELEE_PERK_STAFF_KICK" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_COILING_STRIKE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Coiling Strikes"),
    description = ccb.content.text("Perform a quick reach attack with a polearm or staff if you have at least 1 momentum stack.  The attack will heavily scale with perception."),
    flags = { "MELEE_PERK_COILING_STRIKE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_KNIFE_COUNTER_DODGE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Snap slash"),
    description = ccb.content.text("If you dodge an attack with a knife or dagger, you'll counterattack with a quick slash."),
    flags = { "MELEE_PERK_KNIFE_COUNTER_DODGE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_KNIFE_FINISHER",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Slaying strike"),
    description = ccb.content.text("Perform a finishing attack with a knife or dagger when reaching 3 tempo stacks.  The attack will prioritize enemy weak points."),
    flags = { "MELEE_PERK_KNIFE_FINISHER" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_JUST_HIT_IT",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Vulgar Opening"),
    description = ccb.content.text("If you have no combat buffs active, perform an opening attack with armor penetration increased by 225% of your strength.  Just hit them with the damn thing."),
    flags = { "MELEE_PERK_JUST_HIT_IT" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_ESTOCADA",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Estocada"),
    description = ccb.content.text("Perform a quick lunging thrust with a long sword, thrusting sword or quarterstaff.  You must have exactly 1 momentum stack to perform this attack."),
    flags = { "MELEE_PERK_ESTOCADA" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_DUELIST_COMBO",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Compound finisher"),
    description = ccb.content.text("If your third attack against the same target coincides with the full combat tempo bonus, you will perform a fast and powerful finishing attack."),
    flags = { "MELEE_PERK_DUELIST_COMBO" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_DUELIST_LUNGE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Timed lunge"),
    description = ccb.content.text("Perform a ranged lunge attack with fencing and thrusting swords.  The attack will move you adjacent to the target or move you away from the target if you are already adjacent to them.  You must have exactly 1 momentum stack to perform this attack."),
    flags = { "MELEE_PERK_DUELIST_LUNGE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_TACKLE",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Charging Tackle"),
    description = ccb.content.text("Your first attack after acquiring at least 3 momentum stacks will be replaced by a shoulder tackle.  The tackle will ground humanoid targets of similar or smaller size and consume all momentum stacks."),
    flags = { "MELEE_PERK_TACKLE" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_EXECUTION",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Execution"),
    description = ccb.content.text("Whenever you attack a human-sized target with a great axe, great sword or great hammer if the target has less health than the base attack rating of your weapon, you will execute them instead.  Execution attacks ignore armor and will restore 10% of your max stamina."),
    flags = { "MELEE_PERK_EXECUTION" },
}

ccb.content.define_mutation {
    id = "MELEE_PERK_BRUTALITY",
    copy_from = "MELEE_PERK_BASE",
    name = ccb.content.text("Brutal Execution"),
    description = ccb.content.text("You perform executions with such brutality that all minded enemies that witness them will become stunned for 2 turns."),
    flags = { "MELEE_PERK_BRUTALITY" },
}
