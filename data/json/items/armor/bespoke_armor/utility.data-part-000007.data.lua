local ccb = require("ccb")

ccb.content.define_item {
    id = "nomad_papr_blower_magpouch_on",
    copy_from = "nomad_papr_blower_magpouch_off",
    name = ccb.content.plural_text("nomad utility belt (on)", "nomad utility belts (on)"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has three pouches made to snugly and securely hold 26-round PA md. 68 box magazines, although anything that size or smaller will fit.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  The blower is active and draining power.  Activate it to turn it off."),
    revert_to = "nomad_papr_blower_magpouch_off",
    inheritance = { add = { flags = { "PAPR_BLOWER", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "armor", "tool" },
    armor = {},
    tool = { power_draw = "4000 mW" },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the PAPR blower on the %s off."),
            target = "nomad_papr_blower_magpouch_off",
            ammo_scale = 0,
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_type = "movement",
            message = ccb.content.text("whooooo…"),
            sound_id = "humming",
            sound_variant = "machinery",
            volume = 12,
        },
    },
}
