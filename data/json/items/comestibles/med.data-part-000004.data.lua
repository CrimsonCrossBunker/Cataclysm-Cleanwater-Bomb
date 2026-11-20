local ccb = require("ccb")

ccb.content.define_item {
    id = "skunk_spray_neutralizing_solution",
    name = ccb.content.plural_text("skunk spray neutralizing solution", "skunk spray neutralizing solution"),
    description = ccb.content.text("A combination of hydrogen peroxide, baking soda, and dish soap that works together to transform skunk spray thiocetates into odorless acids."),
    display_type = "BY_VOLUME",
    mass = "28 g",
    volume = "250 ml",
    price = "1 USD",
    survival_price = "5 USD",
    symbol = "~",
    color = "white",
    phase = "liquid",
    default_container = "bottle_plastic_small",
    flags = { "NO_INGEST", "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 10 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You cover yourself in the solution everywhere the spray touched your body."),
            effects = { { id = "skunk_spray_neutralizer" } },
        },
    },
}

ccb.content.define_item {
    id = "cig",
    name = ccb.content.plural_text("cigarette", "cigarettes"),
    description = ccb.content.text("A mixture of dried tobacco leaf, pesticides, and chemical additives, rolled into a filtered paper tube.  Stimulates mental acuity and reduces appetite.  Highly addictive and hazardous to health, but lung cancer is kind of the least of your concerns at this point."),
    mass = "1 g",
    volume = "4 ml",
    price = "13 cent",
    survival_price = "29 cent",
    symbol = "!",
    color = "dark_gray",
    default_container = "box_cigarette",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    variants = {
        {
            id = "cig_basic",
            name = ccb.content.plural_text("cigarette", "cigarettes"),
            description = ccb.content.text("A mixture of dried tobacco leaf, pesticides, and chemical additives, rolled into a filtered paper tube.  Stimulates mental acuity and reduces appetite.  Highly addictive and hazardous to health, but lung cancer is kind of the least of your concerns at this point."),
            color = "dark_gray",
        },
        {
            id = "cig_menthol",
            name = ccb.content.plural_text("menthol cigarette", "menthol cigarettes"),
            description = ccb.content.text("A cigarette with a menthol flavor, the only type of flavored cigarette permitted for sale in the US.  The FDA had previously proposed a ban on them, but the world ended before it could be implemented.  It feels somewhat nicer to smoke than a regular cigarette."),
            color = "cyan",
        },
        {
            id = "cig_light",
            name = ccb.content.plural_text("\"light\" cigarette", "\"light\" cigarettes"),
            description = ccb.content.text("A cigarette with reduced tar and nicotine content, designed to appeal to quitters and health-conscious smokers.  While not actually less harmful than regular cigarettes, the amount of nicotine absorbed per cigarette is indeed lower.  Marketing cigarettes as \"light\" has been illegal since 2007, but the term has persisted as a shorthand."),
            color = "white",
        },
        {
            id = "cig_gold",
            name = ccb.content.plural_text("quality cigarette", "quality cigarettes"),
            description = ccb.content.text("A premium brand cigarette rolled from strong, high-quality tobacco.  While discerning smokers may prefer its flavor to that of average cigarettes, the higher tar and nicotine content won't do you any favors.  Then again, you probably have bigger concerns than lung cancer."),
            color = "yellow",
        },
        {
            id = "cig_little_cigar",
            name = ccb.content.plural_text("little cigar", "little cigars"),
            description = ccb.content.text("A compact, slim cigar in the form of a cigarette.  It's a popular choice for those who want a taste of luxury without the time commitment of a full-sized cigar.  Addictive and hazardous to health."),
            color = "brown",
        },
    },
    stackable = true,
    comestible = { kind = "MED", healthy = -2, fun = 5, addiction_potential = 50, addiction = "nicotine" },
    use_actions = { "SMOKING" },
}

ccb.content.define_item {
    id = "cigar",
    name = ccb.content.plural_text("cigar", "cigars"),
    description = ccb.content.text("Rolled, cured tobacco leaf, addictive and hazardous to health."),
    mass = "9 g",
    volume = "50 ml",
    price = "2 USD",
    survival_price = "5 USD",
    symbol = "!",
    color = "brown",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    variants = {
        {
            id = "handrolled",
            name = ccb.content.plural_text("hand-rolled cigar", "hand-rolled cigars"),
            description = ccb.content.text("A proper cigar rolled by hand from loose tobacco and leaves."),
        },
        {
            id = "premium",
            name = ccb.content.plural_text("premium cigar", "premium cigars"),
            description = ccb.content.text("Select long-filler tobacco hand-rolled by a professional with care.  Smooth draw and even burn.  Now THIS is a real cigar!"),
        },
        {
            id = "cheap",
            name = ccb.content.plural_text("cheap cigar", "cheap cigars"),
            description = ccb.content.text("Cheap, machine-made cigar.  While not as luxurious as hand-rolled cigars, it's still enjoyable."),
        },
    },
    stackable = true,
    comestible = { kind = "MED", healthy = -4, fun = 15, addiction_potential = 60, addiction = "nicotine" },
    use_actions = { "SMOKING" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "debug_chloroform_rag",
    name = ccb.content.text_without_extraction("debug chloroform soaked rag"),
    description = ccb.content.text_without_extraction("A debug item that lets you put NPCs (or yourself) to sleep."),
    mass = "125 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "cotton" },
    symbol = "!",
    color = "red",
    flags = { "NO_INGEST" },
    comestible = { kind = "MED" },
    use_actions = {
        {
            kind = "consume_drug",
            moves = 100,
            effects = { { id = "sleep", duration = 1000 } },
            used_up_item = "cotton_patchwork",
        },
    },
}

-- Based on 30mg Codeine Sulfate Tablets.
ccb.content.define_item {
    id = "codeine",
    name = ccb.content.plural_text("codeine", "codeine"),
    description = ccb.content.text("A mild opiate used in the suppression of pain, cough, and other ailments.  While relatively weak for a narcotic, it is still addictive, with a potential for overdose."),
    materials = { "drug_filler" },
    mass = "1 g",
    volume = "1 ml",
    price = "6 cent",
    survival_price = "15 cent",
    symbol = "!",
    color = "cyan",
    default_container = "bottle_plastic_pill_painkiller",
    flags = { "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        stimulation = -2,
        fun = 10,
        addiction_potential = 10,
        vitamins = { { id = "vit_mme", amount = 450 } },
        addiction = "opiate",
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take some %s."),
            effects = { { id = "pkill2", duration = 1080 }, { id = "cough_suppress", duration = 1000 } },
        },
    },
}

ccb.content.define_item {
    id = "coke",
    name = ccb.content.plural_text("cocaine", "cocaine"),
    description = ccb.content.text("Crystalline extract of the coca leaf, or at least, a white powder with some of that in it.  A topical analgesic, it is more commonly used for its stimulatory properties.  Highly addictive."),
    display_type = "BY_WEIGHT",
    mass = "100 mg",
    volume = "1 ml",
    stack_size = 8,
    price = "1 USD",
    survival_price = "50 cent",
    materials = { "powder" },
    symbol = "!",
    color = "white",
    default_container = "bag_zipper",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = {
        kind = "MED",
        stimulation = 20,
        healthy = -2,
        fun = 25,
        addiction_potential = 50,
        addiction = "cocaine",
    },
    use_actions = { "COKE" },
}
