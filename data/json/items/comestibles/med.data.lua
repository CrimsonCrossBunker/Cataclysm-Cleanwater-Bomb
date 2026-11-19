local ccb = require("ccb")

ccb.content.define_item {
    id = "nic_pouch",
    name = ccb.content.plural_text("nicotine pouch", "nicotine pouchs"),
    description = ccb.content.text("A pouch containing nicotine salts."),
    mass = "400 mg",
    volume = "1 ml",
    price = "38 cent",
    survival_price = "70 cent",
    symbol = "=",
    color = "white",
    flags = { "NO_INGEST", "IRREPLACEABLE_CONSUMABLE", "NO_TEMP" },
    variants = {
        {
            id = "nic_pouch_mint",
            name = ccb.content.plural_text("cool mint flavored nicotine pouch", "cool mint flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing cool mint-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_peppermint",
            name = ccb.content.plural_text("peppermint flavored nicotine pouch", "peppermint flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing peppermint-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_wintergreen",
            name = ccb.content.plural_text("wintergreen flavored nicotine pouch", "wintergreen flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing wintergreen-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_coffee",
            name = ccb.content.plural_text("coffee flavored nicotine pouch", "coffee flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing coffee-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_cinnamon",
            name = ccb.content.plural_text("cinnamon flavored nicotine pouch", "cinnamon flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing cinnamon-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_basic",
            name = ccb.content.plural_text("nicotine pouch", "nicotine pouchs"),
            description = ccb.content.text("A pouch containing nicotine salts."),
        },
        {
            id = "nic_pouch_menthol",
            name = ccb.content.plural_text("menthol-flavored nicotine pouch", "menthol-flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing menthol-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_spearmint",
            name = ccb.content.plural_text("spearmint flavored nicotine pouch", "spearmint flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing spearmint-flavored nicotine salts."),
        },
        {
            id = "nic_pouch_citrus",
            name = ccb.content.plural_text("citrus flavored nicotine pouch", "citrus flavored nicotine pouchs"),
            description = ccb.content.text("A pouch containing citrus-flavored nicotine salts."),
        },
    },
    stackable = true,
    comestible = { kind = "MED", fun = 4, addiction_potential = 30, addiction = "nicotine" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You put in a pouch."),
            vitamins = { { id = "nicotine_slow", minimum = 3 } },
        },
    },
}

ccb.content.define_item {
    id = "nicotine_patch",
    name = ccb.content.plural_text("nicotine patch", "nicotine patches"),
    description = ccb.content.text("An adhesive patch that promises to fight cravings and help smokers quit by slowly delivering nicotine into the body over the course of 16 hours as a replacement for smoking."),
    mass = "3 g",
    volume = "2 ml",
    price = "10 cent",
    survival_price = "25 cent",
    symbol = "*",
    color = "yellow",
    flags = { "NO_INGEST", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", addiction = "nicotine", addiction_potential = 75 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You apply a nicotine patch."),
            vitamins = { { id = "nicotine_slow", minimum = 24 } },
        },
    },
}

ccb.content.define_item {
    id = "birth_control",
    name = ccb.content.plural_text("birth control pill", "birth control pills"),
    description = ccb.content.text("A pill meant to regulate hormones to reduce the chance of a pregnancy.  It also has the fortunate side effect of reducing or even stopping menstruation.  As the factories producing these have died down, these have become a valuable good."),
    materials = { "drug_filler" },
    mass = "80 mg",
    volume = "1 ml",
    price = "89 cent",
    survival_price = "1 USD",
    symbol = "!",
    color = "white",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED" },
    use_actions = { { kind = "consume_drug", message = ccb.content.text("You take a %s.") } },
}

ccb.content.define_item {
    id = "estrogen",
    name = ccb.content.plural_text("estrogen pill", "estrogen pills"),
    description = ccb.content.text("A sublingual tablet of estradiol, meant to increase the level of estrogen in the body.  It is primarily used to treat estrogen deficiency in cisgender women or to artificially re-establish a menstrual cycle.  But it's a lifesaving medicine for some transgender individuals."),
    materials = { "drug_filler" },
    mass = "80 mg",
    volume = "1 ml",
    price = "50 cent",
    survival_price = "10 cent",
    symbol = "!",
    color = "white",
    flags = { "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", sensitivity = 5 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You set the pill under your tongue and let it dissolve."),
        },
    },
}

ccb.content.define_item {
    id = "testosterone",
    name = ccb.content.plural_text("testosterone injection", "testosterone injections"),
    description = ccb.content.text("A small vial of pale yellow, sterile, oily testosterone cyclopentadiate injection.  Clinically, it is primarily used to treat androgen deficiency in cisgender men and is a core drug in FTM hormone replacement therapy.  Some athletes may also use it.  It effectively maintains androgen levels in the body.  You will need a syringe to inject it."),
    materials = { "glass" },
    mass = "15 g",
    volume = "10 ml",
    price = "4500 cent",
    survival_price = "250 cent",
    symbol = "!",
    color = "yellow",
    flags = { "NO_INGEST", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", sensitivity = -3 },
    use_actions = {
        {
            kind = "consume_drug",
            tools_needed = { syringe = -1 },
            message = ccb.content.text("You inject yourself with the injector."),
        },
    },
}

ccb.content.define_item {
    id = "sunscreen",
    name = ccb.content.plural_text("sunscreen", "sunscreen"),
    description = ccb.content.text("Carcinoma may not be such a concern anymore, but sunburns are as painful as ever."),
    display_type = "BY_VOLUME",
    symbol = "~",
    color = "white",
    phase = "liquid",
    materials = { "water" },
    mass = "30 g",
    volume = "30 ml",
    survival_price = "10 cent",
    flags = { "NO_TEMP", "NO_INGEST", "NO_AUTO_CONSUME", "INEDIBLE", "IRREPLACEABLE_CONSUMABLE" },
    comestible = { kind = "MED", servings = 1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You apply some sunscreen."),
            moves = 120,
            effects = { { id = "sunscreen", duration = "2 h" } },
        },
    },
}
