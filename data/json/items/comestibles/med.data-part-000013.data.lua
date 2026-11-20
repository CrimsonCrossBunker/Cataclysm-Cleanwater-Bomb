local ccb = require("ccb")

ccb.content.define_item {
    id = "saline",
    name = ccb.content.plural_text("saline solution", "saline solution"),
    description = ccb.content.text("A solution of sterilized water and salt for intravenous infusion or washing contaminants from one's eyes."),
    display_type = "BY_VOLUME",
    materials = { { id = "water", portions = 991 }, { id = "salt", portions = 9 } },
    mass = "51 g",
    volume = "250 ml",
    price = "5 USD",
    survival_price = "1 USD 25 cent",
    symbol = "~",
    color = "light_cyan",
    phase = "liquid",
    default_container = "bottle_plastic_small",
    flags = { "NO_INGEST", "NPC_SAFE" },
    comestible = { kind = "MED", servings = 5 },
    use_actions = { "EYEDROPS" },
}

ccb.content.define_item {
    id = "thorazine",
    name = ccb.content.plural_text("antipsychotic", "antipsychotic"),
    description = ccb.content.text("Anti-psychotic medication.  Used to stabilize brain chemistry, it can arrest hallucinations and other symptoms of psychosis.  Carries a sedative effect."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "25 cent",
    survival_price = "50 cent",
    symbol = "!",
    color = "light_red",
    default_container = "bottle_plastic_pill_prescription",
    variant_kind = "drug",
    variants = {
        {
            id = "thorazine",
            name = ccb.content.plural_text("Thorazine", "Thorazine"),
            append = true,
            description = ccb.content.text("Its generic name is chlorpromazine."),
        },
    },
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", stimulation = -30 },
    use_actions = { "THORAZINE" },
}
