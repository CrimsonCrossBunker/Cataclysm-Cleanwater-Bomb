local ccb = require("ccb")

ccb.content.define_item {
    id = "melatonin_tablet",
    name = ccb.content.plural_text("melatonin tablet", "melatonin tablets"),
    description = ccb.content.text("An over-the-counter sleep hormone.  Melatonin can help you fall asleep faster and stay asleep longer.  Using it may help restore your sleep schedule, but you might wake up feeling groggy."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "8 ml",
    price = "13 cent",
    survival_price = "33 cent",
    symbol = "!",
    color = "yellow",
    default_container = "bottle_plastic_pill_supplement",
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            effects = { { id = "melatonin", duration = "14 h" } },
        },
    },
}

ccb.content.define_item {
    id = "adderall",
    name = ccb.content.plural_text("prescription stimulant", "prescription stimulant"),
    description = ccb.content.text("Medical-grade amphetamine salts mixed with dextroamphetamine salts, commonly prescribed to treat hyperactive attention deficits.  It suppresses the appetite, and is quite addictive."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "72 cent",
    survival_price = "7 cent",
    symbol = "!",
    color = "light_red",
    default_container = "bottle_plastic_pill_prescription",
    variant_kind = "drug",
    variants = {
        {
            id = "adderall",
            name = ccb.content.plural_text("Adderall", "Adderall"),
            description = ccb.content.text("Medical-grade amphetamine salts mixed with dextroamphetamine salts, commonly prescribed to treat hyperactive attention deficits.  It suppresses the appetite, and is quite addictive."),
        },
    },
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        stimulation = 24,
        fun = 10,
        addiction_potential = 10,
        addiction = "amphetamine",
    },
    use_actions = { { kind = "consume_drug", message = ccb.content.text("You take some %s.") } },
}

ccb.content.define_item {
    id = "adrenaline_injector",
    name = ccb.content.plural_text("epinephrine autoinjector", "epinephrine autoinjectors"),
    description = ccb.content.text("A syringe filled with a shot of epinephrine, also called adrenalin.  It serves as a powerful stimulant when you inject yourself with it.  Asthmatics can use it in an emergency to clear an asthma attack."),
    looks_like = "flu_shot",
    mass = "12 g",
    volume = "10ml",
    price = "34 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "!",
    color = "pink",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE" },
    stackable = true,
    comestible = { kind = "MED", stimulation = 29 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject yourself with the injector."),
            effects = { { id = "pkill2", duration = 480 } },
        },
    },
}

ccb.content.define_item {
    id = "antibiotics",
    name = ccb.content.plural_text("antibiotics", "antibiotics"),
    description = ccb.content.text("Antibacterial medication designed to prevent or stop the spread of infection.  It's the safest way to cure any infections you might have.  One dose lasts twelve hours."),
    materials = { "drug_filler" },
    mass = "611 mg",
    volume = "1 ml",
    price = "45 cent",
    survival_price = "2 USD",
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = { "ANTIBIOTIC" },
}

ccb.content.define_item {
    id = "antifungal",
    name = ccb.content.plural_text("antifungal drug", "antifungal drug"),
    description = ccb.content.text("A powerful chemical tablet designed to eliminate fungal infections in living creatures.  One dose lasts four hours."),
    mass = "1 g",
    volume = "2 ml",
    price = "10 cent",
    survival_price = "2 USD",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = { "ANTIFUNGAL" },
}

ccb.content.define_item {
    id = "antiparasitic",
    name = ccb.content.plural_text("antiparasitic drug", "antiparasitic drug"),
    description = ccb.content.text("A broad-spectrum chemical tablet designed to eliminate parasitic infestations in living creatures.  Though designed for use on pets and livestock, it will likely work on humans as well."),
    mass = "1 g",
    volume = "2 ml",
    price = "32 cent",
    survival_price = "2 USD",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -5 },
    use_actions = { "ANTIPARASITIC" },
}

ccb.content.define_item {
    id = "aspirin",
    name = ccb.content.plural_text("aspirin", "aspirins"),
    description = ccb.content.text("Acetylsalicylic acid, a mild anti-inflammatory and blood thinner.  Take to relieve pain and swelling.  Careful - it can increase bleeding."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 cent",
    survival_price = "20 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -1, vitamins = { { id = "vit_bloodthinner", amount = 4320 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill1_nsaid", duration = 9000 } },
        },
    },
}

ccb.content.define_item {
    id = "ibuprofen",
    name = ccb.content.plural_text("ibuprofen", "ibuprofen"),
    description = ccb.content.text("Ibuprofen, a mild NSAID-based painkiller.  Take to relieve pain and swelling."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 cent",
    survival_price = "30 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -1, vitamins = { { id = "vit_ibuprofen", amount = 216 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill1_nsaid", duration = 9000 } },
        },
    },
}

ccb.content.define_item {
    id = "naproxen",
    name = ccb.content.plural_text("naproxen", "naproxen"),
    description = ccb.content.text("Naproxen, a mild long-lasting NSAID-based painkiller.  Take to relieve pain and swelling."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 cent",
    survival_price = "50 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -1, vitamins = { { id = "vit_ibuprofen", amount = 432 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill1_nsaid", duration = 18000 } },
        },
    },
}

ccb.content.define_item {
    id = "acetaminophen",
    name = ccb.content.plural_text("acetaminophen", "acetaminophen"),
    description = ccb.content.text("Acetaminophen, a mild painkiller that works well in conjunction with NSAID-based painkillers like aspirin.  Take to relieve pain and swelling."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 cent",
    survival_price = "30 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill1_acetaminophen", duration = 9000 } },
        },
    },
}

ccb.content.define_item {
    id = "metaprolol",
    name = ccb.content.plural_text("metaprolol", "metaprolol"),
    description = ccb.content.text("Metaprolol, a classic beta blocker.  It lowers blood pressure and decouples heart rate from stressful events such as anxiety or pain."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 cent",
    survival_price = "50 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "white",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -1, vitamins = { { id = "vit_betablocker", amount = 864 } } },
    use_actions = { { kind = "consume_drug", message = ccb.content.text("You take some %s.") } },
}
