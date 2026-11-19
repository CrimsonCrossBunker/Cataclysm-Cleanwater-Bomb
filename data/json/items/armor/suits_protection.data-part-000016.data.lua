local ccb = require("ccb")

ccb.content.define_item {
    id = "robofac_resonance_suit_on",
    copy_from = "robofac_resonance_suit",
    name = ccb.content.plural_text("Hub 01 hazardous materials suit (on)", "Hub 01 hazardous materials suits (on)"),
    description = ccb.content.text("A hefty environmental suit incorporating Kevlar-lined boots and gloves, worn by Hub personnel in their rare forays aboveground.  This one has a large battery pack and otherworldly electronics snaking the entire exterior, making it substantially more cumbersome to wear than its base model.  Colored brown and blue, the white seal of Hub 01 is embroidered on both of its upper arms.  It requires a separate gas mask for full protection.  A tiny green LED on the chest is illuminated."),
    revert_to = "robofac_resonance_suit",
    flags = {
        "WATERPROOF", "RAINPROOF", "GAS_PROOF", "RAD_PROOF", "PSYSHIELD_PARTIAL", "PORTAL_PROOF",
        "ELECTRIC_IMMUNE", "STURDY", "NO_REPAIR", "NANOFAB_REPAIR", "TRADER_AVOID", "SPAWN_ACTIVE",
    },
    subtype_order = { "armor", "tool" },
    armor = {},
    tool = { turns_per_charge = 100 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The LED on the %s flicks off."),
            target = "robofac_resonance_suit",
        },
    },
}

ccb.content.define_item {
    id = "xedra_enviro_suit",
    copy_from = "robofac_enviro_suit",
    name = ccb.content.plural_text("activity suit", "activity suits"),
    description = ccb.content.text("A single-piece brown and orange environmental suit, tailored in a way that slightly recalls a military flight suit.  The letters \"X.E.D.R.A\" are inscribed on its back, and a white shoulder patch on the right arm shows an arrow reaching within rings of concentric circles.  It requires a separate gas mask for full protection."),
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear casually"),
            message = ccb.content.text("You slip out of the top of the suit and tie the sleeves around your waist."),
            target = "xedra_enviro_suit_casual",
        },
    },
}

ccb.content.define_item {
    id = "xedra_enviro_suit_casual",
    copy_from = "robofac_enviro_suit_casual",
    name = ccb.content.plural_text("activity suit (casual)", "activity suits (casual)"),
    description = ccb.content.text("A single-piece brown and orange environmental suit, tailored in a way that slightly recalls a military flight suit.  The upper portion has been tied around the waist casually."),
    armor = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Wear normally"),
            message = ccb.content.text("You untie the sleeves and put back on the top of the suit."),
            target = "xedra_enviro_suit",
        },
    },
}
