local ccb = require("ccb")

local function mounted_charge_available(context)
    return context.mounted
        and context.mount_kind == "animal"
        and context.moves > 0
        and (
            not context.activity_active
            or (
                context.phase ~= "menu"
                and context.activity_id == "ACT_MOUNTED_CHARGE"
            )
        )
        and not context.grabbed
        and not context.auto_moving
        and not context.hauling
        and not context.in_vehicle
        and not context.controlling_vehicle
        and not context.crouching
        and not context.prone
        and not context.in_shell
        and not context.phase_movement
        and context.can_attack
        and context.can_move
end

ccb.runtime.handler(
    "ccb_mounted_charge_available",
    mounted_charge_available,
    1
)

local mounted_charge = ccb.content.Technique {
    id = "MOUNTED_CHARGE",
    name = ccb.content.text("Mounted Charge"),
    description = ccb.content.text(
        "Charge forward while mounted and strike the first creature in your path."
    ),
    avatar_message = ccb.content.text("You charge into %s"),
    npc_message = ccb.content.text("<npcname> charges into %s"),
    manual_activation = true,
    melee_allowed = true,
    active_when = "ccb_mounted_charge_available",
}
mounted_charge:attack_vector("vector_null")
ccb.content.replace(mounted_charge)
