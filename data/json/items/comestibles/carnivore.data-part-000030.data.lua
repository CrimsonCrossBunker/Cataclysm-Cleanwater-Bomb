local ccb = require("ccb")

ccb.content.define_item {
    id = "bone_mi-go",
    category = "other",
    name = ccb.content.plural_text("mi-go bone", "mi-go bones"),
    mass = "350 g",
    color = "light_green",
    symbol = "%",
    description = ccb.content.text("An unrecognized structural element from inside a mi-go.  It's strong and springy, somewhat like cartilage, but a bit stiffer.  It's also a deep green color, and might possibly serve a scaffolding role, like bone."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "mi-go_bone" },
    volume = "250 ml",
    stackable = true,
    comestible = { kind = "FOOD", calories = 0, fun = -10 },
    use_actions = { "POISON" },
}
