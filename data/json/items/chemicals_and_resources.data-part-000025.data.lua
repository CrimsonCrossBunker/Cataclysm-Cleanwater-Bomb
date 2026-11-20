local ccb = require("ccb")

-- Represents all glues that can withstand >1800 psi of tensile strength, such as cyanoacrylate, polyurethane and epoxy.
-- 1 charge of strong glue should cover an area of 5mm^2
ccb.content.define_item {
    id = "glue_strong",
    copy_from = "glue_weak",
    name = ccb.content.plural_text("strong glue", "strong glue"),
    description = ccb.content.text("A strong adhesive to use for structural repairs or other high stress applications.  You can't sniff it, but you can use it to close up wounds in a pinch."),
    survival_price = "10 cents",
    ammo = {},
    use_actions = { { kind = "heal", bandages_power = 1, bleed = 4, moves = 1000 } },
}
