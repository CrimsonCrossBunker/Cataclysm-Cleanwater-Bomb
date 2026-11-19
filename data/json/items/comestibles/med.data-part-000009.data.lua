local ccb = require("ccb")

ccb.content.define_item {
    id = "tobacco",
    name = ccb.content.plural_text("rolling tobacco", "rolling tobacco"),
    description = ccb.content.text("Loose, fine-cut tobacco leaves.  Popular in Europe and among hipsters.  Highly addictive and hazardous to health.\nCan either be rolled into a cigarette with some rolling papers or smoked through a pipe."),
    display_type = "BY_WEIGHT",
    mass = "1 g",
    volume = "4 ml",
    price = "18 cent",
    survival_price = "25 cent",
    symbol = "!",
    color = "brown",
    default_container = "bag_plastic_small",
    flags = { "NO_INGEST", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", healthy = -2, fun = 5, addiction_potential = 50, addiction = "nicotine" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You smoke some tobacco."),
            vitamins = { { id = "nicotine", minimum = 2 } },
            fields_produced = { fd_cigsmoke = 2 },
            charges_needed = { fire = 1 },
            tools_needed = { apparatus = -1 },
            moves = 250,
        },
    },
}

-- 60mg Ultram
ccb.content.define_item {
    id = "tramadol",
    name = ccb.content.plural_text("tramadol", "tramadol"),
    description = ccb.content.text("A painkiller used to manage moderate pain.  The effects last for several hours, but are relatively subdued for an opioid."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "122 cent",
    survival_price = "1 USD",
    symbol = "!",
    color = "yellow",
    default_container = "bottle_plastic_pill_prescription",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        fun = 6,
        vitamins = { { id = "vit_mme", amount = 600 } },
        addiction_potential = 6,
        addiction = "opiate",
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill_l", duration = 27000 } },
        },
    },
}

-- Yes, the vitamins are intentionally duplicated here. The consume/use/iteminfo UI needs them in use_action, but to actually pass on the vitamins they need to be in the comestible data, as below.
-- TODO: Fix this...
ccb.content.define_item {
    id = "vitamins",
    name = ccb.content.plural_text("multivitamin", "multivitamin"),
    description = ccb.content.text("Essential dietary nutrients conveniently packaged in pill form.  An option of last resort when a balanced diet is not possible.  Excess use can cause hypervitaminosis."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "5 ml",
    price = "90 cent",
    survival_price = "30 cent",
    symbol = "!",
    color = "magenta",
    default_container = "bottle_plastic_pill_supplement",
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        vitamins = {
            { id = "calcium", amount = 36 },
            { id = "iron", amount = 36 },
            { id = "vitC", amount = 36 },
        },
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = {
                { id = "calcium", minimum = 24, maximum = 48 },
                { id = "iron", minimum = 24, maximum = 48 },
                { id = "vitC", minimum = 24, maximum = 48 },
            },
        },
    },
}

ccb.content.define_item {
    id = "calcium_tablet",
    name = ccb.content.plural_text("calcium tablet", "calcium tablets"),
    description = ccb.content.text("A white calcium tablet.  Widely used by elderly people with osteoporosis as a method to supplement calcium before the apocalypse."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "5 ml",
    price = "20 cent",
    survival_price = "9 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    symbol = "!",
    color = "magenta",
    default_container = "bottle_plastic_pill_supplement",
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = { { id = "calcium", minimum = 75 } },
        },
    },
}

ccb.content.define_item {
    id = "bonemeal_tablet",
    name = ccb.content.plural_text("bone meal tablet", "bone meal tablets"),
    description = ccb.content.text("A homemade calcium supplement made out of bone meal.  Tastes horrible and is hard to swallow but it does its job."),
    materials = { "bone" },
    mass = "2 g",
    volume = "12 ml",
    price = "1 cent",
    survival_price = "2 cent",
    symbol = "!",
    color = "white",
    looks_like = "calcium_tablet",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", fun = -8, healthy = -2, vitamins = { { id = "meat_allergen", amount = 1 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = { { id = "calcium", minimum = 24 } },
        },
    },
}

ccb.content.define_item {
    id = "flavored_bonemeal_tablet",
    name = ccb.content.plural_text("flavored bone meal tablet", "flavored bone meal tablets"),
    description = ccb.content.text("A homemade calcium supplement made out of bone meal.  Due to some sweeteners mixed in to counteract the powdery texture and the taste of ash, it's almost as palatable as the pre-Cataclysm tablets."),
    materials = { "bone" },
    mass = "2 g",
    volume = "11 ml",
    price = "7 cent",
    survival_price = "3 cent",
    symbol = "!",
    color = "yellow",
    looks_like = "calcium_tablet",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", fun = -2, healthy = -2, vitamins = { { id = "meat_allergen", amount = 1 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = { { id = "calcium", minimum = 23 } },
        },
    },
}

ccb.content.define_item {
    id = "vitc_tablet",
    name = ccb.content.plural_text("vitamin C supplement", "vitamin C supplements"),
    description = ccb.content.text("A small white tablet promising more vitamin C than a human can conceivably absorb."),
    materials = { "drug_filler" },
    mass = "1000 mg",
    volume = "5 ml",
    price = "7 cent",
    survival_price = "15 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    symbol = "!",
    color = "magenta",
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = { { id = "vitC", minimum = 556 } },
        },
    },
}

ccb.content.define_item {
    id = "vitc_fragment",
    name = ccb.content.plural_text("vitamin C supplement fragment", "vitamin C supplement fragments"),
    description = ccb.content.text("a small slice of a vitamin C supplement, providing as much vitamin C as a human can conceivably absorb."),
    materials = { "drug_filler" },
    mass = "165 mg",
    volume = "1 ml",
    price = "0 cent",
    survival_price = "2 cent",
    flags = { "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    symbol = "!",
    color = "magenta",
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = { { id = "vitC", minimum = 92 } },
        },
    },
}
