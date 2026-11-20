local ccb = require("ccb")

ccb.content.define_item {
    id = "prophylactic_antivenom",
    name = ccb.content.plural_text("injectable prophylactic antivenom", "injectable prophylactic antivenom"),
    description = ccb.content.text("An experimental, cutting-edge antivenom in the form of a small amber vial, designed to be injected a few hours before venom exposure.  It was developed in top secret by the military in response to increasing biological/chemical warfare."),
    display_type = "BY_VOLUME",
    materials = { "plastic" },
    mass = "40 g",
    volume = "75 ml",
    price = "10 USD",
    survival_price = "25 USD",
    symbol = "!",
    color = "brown",
    flags = { "NO_INGEST", "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE" },
    stackable = true,
    comestible = { kind = "MED", healthy = -1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject a vial of prophylactic antivenom into your arm.  You feel a bit queasy."),
            tools_needed = { syringe = -1 },
            effects = {
                { id = "prophylactic_antivenom", duration = "120 m" },
                { id = "nausea", duration = "5 m" },
            },
        },
    },
}

-- Don't have a cite for this one.
ccb.content.define_item {
    id = "prozac",
    name = ccb.content.plural_text("antidepressant", "antidepressant"),
    description = ccb.content.text("A common and popular antidepressant.  It will elevate mood, and can profoundly alter the effects of other drugs.  It is only rarely habit-forming, though adverse reactions are not uncommon."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "45 cent",
    survival_price = "50 cent",
    symbol = "!",
    color = "light_green",
    default_container = "bottle_plastic_pill_prescription",
    variant_kind = "drug",
    variants = {
        {
            id = "prozac",
            name = ccb.content.plural_text("Prozac", "Prozac"),
            append = true,
            description = ccb.content.text("Its generic name is fluoxetine."),
        },
    },
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", stimulation = -5, addiction_potential = 5, addiction = "amphetamine" },
    use_actions = { "PROZAC" },
}

ccb.content.define_item {
    id = "prussian_blue",
    name = ccb.content.plural_text("Prussian blue tablet", "Prussian blue tablets"),
    description = ccb.content.text("A tablet containing oxidized ferrous ferrocyanide salts.  Capable of purging nuclear contaminants from the body if taken after radiation exposure."),
    mass = "1 g",
    volume = "1 ml",
    price = "15 cent",
    survival_price = "1 USD",
    materials = { "drug_filler" },
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    symbol = "!",
    color = "blue",
    default_container = "bottle_plastic_pill_supplement",
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            effects = { { id = "pblue", duration = 3600 } },
        },
    },
}
