local ccb = require("ccb")

ccb.content.define_item {
    id = "combat_exoskeleton_light",
    copy_from = "combat_exoskeleton_abstract",
    name = ccb.content.plural_text("combat exoskeleton mk3", "combat exoskeletons mk3"),
    description = ccb.content.text("The final iteration of military power armor before the fall of civilization, this version was designed for actual widespread combat use and was seen on the front lines during the last days of the Cataclysm, unfortunately, the world ended before it could roll out in significant numbers.  The exoskeleton itself is strapped on an environmental suit with an integrated life-support system.  A variety of webbing, magnets, and clips allows the attachment of special armor plating onto the frame."),
    looks_like = "power_armor_light",
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {},
    artifact = { enchantments = { "combat_exoskeleton_light_active" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You turn the exoskeleton on.\n>>Initiating boot sequence…\n//Loading DoubleOS v3.51…\n//Loading calibration profile…\n//Activating atmospheric filtration…\n//Activating liquid cooling…\n//Activating sound dampeners…\n>>Boot successful."),
            target = "combat_exoskeleton_light_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        { kind = "attach_molle", size = 10 },
        { kind = "detach_molle" },
    },
}
