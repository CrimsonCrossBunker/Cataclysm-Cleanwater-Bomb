local ccb = require("ccb")

ccb.content.define_item {
    id = "combat_exoskeleton_medium",
    copy_from = "combat_exoskeleton_abstract",
    name = ccb.content.plural_text("combat exoskeleton mk2", "combat exoskeletons mk2"),
    description = ccb.content.text("These were the second wave of military combat exoskeleton, and got a lot of media attention, with popular Navy commercials featuring them heavily.  The exoskeleton itself is strapped on an environmental suit with an integrated life-support system.  A variety of webbing, magnets, and clips allows the attachment of special armor plating onto the frame."),
    looks_like = "combat_exoskeleton_medium",
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {},
    artifact = { enchantments = { "combat_exoskeleton_medium_active" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the exoskeleton on.\n>>Initiating boot sequence…\n//Loading DoubleOS v2.86…\n//Loading calibration profile…\n//Activating atmospheric filtration…\n//Activating liquid cooling…\n//Activating sound dampeners…\n>>Boot successful."),
            target = "combat_exoskeleton_medium_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "attach_molle", size = 10 },
        { kind = "detach_molle" },
    },
}
