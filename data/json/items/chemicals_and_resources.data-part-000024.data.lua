local ccb = require("ccb")

-- Represents all glues that can withstand <1800 psi of tensile strength, such as PVA, bone glue and rubber cement.
-- 1 charge of weak glue should cover an area of 5mm^2
ccb.content.define_item {
    id = "glue_weak",
    category = "spare_parts",
    name = ccb.content.plural_text("weak glue", "weak glue"),
    description = ccb.content.text("A weak adhesive to use in arts & crafts or other low stress applications.  You can't eat it."),
    symbol = "~",
    color = "white",
    materials = { "epoxy" },
    mass = "1 g",
    volume = "100 ml",
    survival_price = "5 cents",
    phase = "liquid",
    flags = { "UNRECOVERABLE", "NO_SALVAGE" },
    display_type = "BY_VOLUME",
    ammunition = { type = "components", count = 100 },
}
