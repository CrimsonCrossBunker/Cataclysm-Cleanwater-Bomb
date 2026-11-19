local ccb = require("ccb")

ccb.content.define_item {
    id = "badge_deputy",
    copy_from = "badge_abstract",
    name = ccb.content.text("deputy badge"),
    description = ccb.content.text("A tarnished silver star gives an air of authority to the wearer."),
    ascii_picture = "badge_deputy",
    armor = {},
}

ccb.content.define_item {
    id = "badge_detective",
    copy_from = "badge_abstract",
    name = ccb.content.text("detective badge"),
    description = ccb.content.text("A tarnished golden shield gives an air of authority to the wearer."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_marshal",
    copy_from = "badge_abstract",
    name = ccb.content.text("marshal badge"),
    description = ccb.content.text("A bright silver star strikes fear into the eyes of ne'er-do-wells."),
    armor = {},
    inheritance = { scale = { price = 2 } },
}

ccb.content.define_item {
    id = "badge_swat",
    copy_from = "badge_abstract",
    name = ccb.content.text("SWAT badge"),
    description = ccb.content.text("A matte-finish silver shield identifies the wearer as an authority who goes in when the cops just aren't enough."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_fbi",
    copy_from = "badge_abstract",
    name = ccb.content.text("FBI badge"),
    description = ccb.content.text("A gold-filled brass shield with an eagle perched atop it and Lady Justice emblazoned on its center.  In large, engraved lettering it reads, \"FEDERAL BUREAU OF INVESTIGATION-US DEPARTMENT OF JUSTICE\".  It identifies the wearer as an agent with federal authority throughout all the United States and her territories; that is, whatever is left of them."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_doctor",
    copy_from = "badge_abstract",
    name = ccb.content.text("doctor badge"),
    materials = { "plastic" },
    mass = "50 g",
    volume = "50 ml",
    survival_price = "10 cent",
    description = ccb.content.text("A plastic name tag marking the wearer as a real doctor of the medical kind."),
    armor = {},
}

ccb.content.define_item {
    id = "badge_foodkid",
    copy_from = "badge_abstract",
    name = ccb.content.text("Foodkid badge"),
    materials = { "plastic" },
    survival_price = "10 cent",
    mass = "50 g",
    volume = "50 ml",
    description = ccb.content.text("A star-shaped plastic badge.  \"Foodkid\" is printed on it in bold letters.  This badge marks its wearer as Foodperson's trusty sidekick, and comes included with every kid's meal at Foodplace."),
    armor = {},
}

-- Measured my own pin.  Hopefully the NB ones are universal.
ccb.content.define_item {
    id = "pin_badge",
    copy_from = "badge_abstract",
    name = ccb.content.text("pin"),
    materials = { "steel" },
    price = "5 USD",
    survival_price = "10 cent",
    mass = "4 g",
    volume = "10 ml",
    description = ccb.content.text("A small piece of metal with a pin, meant to affix itself to an article of clothing.  It's mainly used on jackets or backpacks, as a way to show off what bands you listen to, or other things like your pronouns."),
    max_worn = 2147483647,
    variant_kind = "generic",
    armor = {},
}

ccb.content.define_item {
    id = "fur_cat_ears",
    name = ccb.content.plural_text("fuzzy cat ears (pair)", "fuzzy cat ears (pair)"),
    description = ccb.content.text("A fuzzy pair of brownish cat ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    mass = "100 g",
    volume = "100 ml",
    price = "15 USD",
    survival_price = "10 cent",
    materials = { "fur", "plastic" },
    symbol = "^",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "faux_fur_cat_ears",
    copy_from = "fur_cat_ears",
    name = ccb.content.plural_text("faux fur cat ears (pair)", "faux fur cat ears (pair)"),
    description = ccb.content.text("A fuzzy pair of garishly colored cat ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    materials = { "faux_fur" },
    color = "pink",
    variant_kind = "generic",
    variants = {
        { id = "faux_fur_cat_ears", color = "pink" },
        {
            id = "bunny_ears_white",
            name = ccb.content.plural_text("white bunny ears (pair)", "white bunny ears (pair)"),
            description = ccb.content.text("A fuzzy pair of white bunny ears.  It does nothing, but there's no reason not to look good even if no one's looking."),
            color = "light_gray",
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "fur_cat_tail",
    name = ccb.content.text("fuzzy cat tail"),
    description = ccb.content.text("A fuzzy tawny tail weighted down with tiny beads of plastic.  Sways behind you when you walk."),
    mass = "250 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "fur", "plastic" },
    symbol = "s",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    melee_damage = { bash = 4 },
    armor = {},
}

ccb.content.define_item {
    id = "faux_fur_cat_tail",
    copy_from = "fur_cat_tail",
    name = ccb.content.text("faux fur cat tail"),
    description = ccb.content.text("A fuzzy garishly colored tail weighted down with tiny beads of plastic.  Sways behind you when you walk."),
    materials = { "faux_fur", "plastic" },
    color = "pink",
    armor = {},
}

ccb.content.define_item {
    id = "fur_collar",
    name = ccb.content.text("fur kitty collar"),
    description = ccb.content.text("A decorative 'collar' made out of fur, complete with a little bell hanging from the front.  Don't worry, it's silent."),
    mass = "100 g",
    volume = "100 ml",
    price = "10 USD",
    survival_price = "10 cent",
    materials = { "fur" },
    symbol = "-",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "faux_fur_collar",
    copy_from = "fur_collar",
    name = ccb.content.text("faux fur kitty collar"),
    description = ccb.content.text("A decorative 'collar' made out of faux fur, complete with a little bell hanging from the front.  Don't worry, it's silent."),
    materials = { "faux_fur" },
    color = "pink",
    armor = {},
}

ccb.content.define_item {
    id = "leather_cat_ears",
    name = ccb.content.plural_text("leather cat ears (pair)", "leather cat ears (pair)"),
    description = ccb.content.text("A shiny pair of black cat ears on a headband.  It does nothing, but there's no reason not to look good even if no one's looking."),
    mass = "100 g",
    volume = "100 ml",
    price = "30 USD",
    survival_price = "10 cent",
    materials = { "leather", "plastic" },
    symbol = "^",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "leather_cat_tail",
    name = ccb.content.text("leather cat tail"),
    description = ccb.content.text("A glossy black leather tail weighted down with tiny beads of plastic.  Sways behind you when you walk."),
    mass = "250 g",
    volume = "250 ml",
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "leather", "plastic" },
    symbol = "s",
    color = "dark_gray",
    flags = { "NO_WEAR_EFFECT" },
    melee_damage = { bash = 4 },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("diamond and gold earrings (pair)", "diamond and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny diamond and gold earrings."),
    price = "130 USD",
    survival_price = "50 cent",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_earring",
    name = ccb.content.plural_text("garnet and gold earrings (pair)", "garnet and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny garnet and gold earrings."),
    mass = "18 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "75 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_ear",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("amethyst and gold earrings (pair)", "amethyst and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny amethyst and gold earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("aquamarine and gold earrings (pair)", "aquamarine and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny aquamarine and gold earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("emerald and gold earrings (pair)", "emerald and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny emerald and gold earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("alexandrite and gold earrings (pair)", "alexandrite and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny alexandrite and gold earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("ruby and gold earrings (pair)", "ruby and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny ruby and gold earrings."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("peridot and gold earrings (pair)", "peridot and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny peridot and gold earrings."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("sapphire and gold earrings (pair)", "sapphire and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny sapphire and gold earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("tourmaline and gold earrings (pair)", "tourmaline and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny tourmaline and gold earrings."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("citrine and gold earrings (pair)", "citrine and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny citrine and gold earrings."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("blue topaz and gold earrings (pair)", "blue topaz and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny blue topaz and gold earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("opal and gold earrings (pair)", "opal and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny opal and gold earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("pearl and gold earrings (pair)", "pearl and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny pearl and gold earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_earring",
    copy_from = "garnet_gold_earring",
    name = ccb.content.plural_text("onyx and gold earrings (pair)", "onyx and gold earrings (pair)"),
    description = ccb.content.text("A pair of shiny onyx and gold earrings."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("diamond and silver earrings (pair)", "diamond and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny diamond and silver earrings."),
    price = "80 USD",
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_earring",
    name = ccb.content.plural_text("garnet and silver earrings (pair)", "garnet and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny garnet and silver earrings."),
    mass = "10 mg",
    volume = "1 ml",
    price = "60 USD",
    survival_price = "45 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_ear",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("amethyst and silver earrings (pair)", "amethyst and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny amethyst and silver earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("aquamarine and silver earrings (pair)", "aquamarine and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny aquamarine and silver earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("emerald and silver earrings (pair)", "emerald and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny emerald and silver earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("alexandrite and silver earrings (pair)", "alexandrite and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny alexandrite and silver earrings."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("ruby and silver earrings (pair)", "ruby and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny ruby and silver earrings."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_earring", weight = 99 },
        {
            id = "vampire_earring",
            name = ccb.content.plural_text("vampire earrings (pair)", "vampire earrings (pair)"),
            description = ccb.content.text("A pair of blood-red ruby and silver earrings, adorned with sinister motifs."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("peridot and silver earrings (pair)", "peridot and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny peridot and silver earrings."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("sapphire and silver earrings (pair)", "sapphire and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny sapphire and silver earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("tourmaline and silver earrings (pair)", "tourmaline and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny tourmaline and silver earrings."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("citrine and silver earrings (pair)", "citrine and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny citrine and silver earrings."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("blue topaz and silver earrings (pair)", "blue topaz and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny blue topaz and silver earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("opal and silver earrings (pair)", "opal and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny opal and silver earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("pearl and silver earrings (pair)", "pearl and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny pearl and silver earrings."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_earring",
    copy_from = "garnet_silver_earring",
    name = ccb.content.plural_text("onyx and silver earrings (pair)", "onyx and silver earrings (pair)"),
    description = ccb.content.text("A pair of shiny onyx and silver earrings."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_earring", weight = 99 },
        {
            id = "dark_earring",
            name = ccb.content.plural_text("dark earrings (pair)", "dark earrings (pair)"),
            description = ccb.content.text("A pair of dark silver earrings featuring onyx in the shape of two dark hearts."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("diamond and platinum earrings (pair)", "diamond and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny diamond and platinum earrings."),
    price = "120 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_earring",
    name = ccb.content.plural_text("garnet and platinum earrings (pair)", "garnet and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny garnet and platinum earrings."),
    mass = "19 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_ear",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("amethyst and platinum earrings (pair)", "amethyst and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny amethyst and platinum earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("aquamarine and platinum earrings (pair)", "aquamarine and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny aquamarine and platinum earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("emerald and platinum earrings (pair)", "emerald and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny emerald and platinum earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("alexandrite and platinum earrings (pair)", "alexandrite and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny alexandrite and platinum earrings."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("ruby and platinum earrings (pair)", "ruby and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny ruby and platinum earrings."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("peridot and platinum earrings (pair)", "peridot and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny peridot and platinum earrings."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("sapphire and platinum earrings (pair)", "sapphire and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny sapphire and platinum earrings."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("tourmaline and platinum earrings (pair)", "tourmaline and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny tourmaline and platinum earrings."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("citrine and platinum earrings (pair)", "citrine and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny citrine and platinum earrings."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("blue topaz and platinum earrings (pair)", "blue topaz and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny blue topaz and platinum earrings."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("opal and platinum earrings (pair)", "opal and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny opal and platinum earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("pearl and platinum earrings (pair)", "pearl and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny pearl and platinum earrings."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_earring",
    copy_from = "garnet_platinum_earring",
    name = ccb.content.plural_text("onyx and platinum earrings (pair)", "onyx and platinum earrings (pair)"),
    description = ccb.content.text("A pair of shiny onyx and platinum earrings."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_ring",
    name = ccb.content.text("garnet and gold ring"),
    description = ccb.content.text("A gold ring with a garnet mounted on top of it."),
    mass = "18 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "75 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_ring",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("amethyst and gold ring"),
    description = ccb.content.text("A gold ring with an amethyst mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("aquamarine and gold ring"),
    description = ccb.content.text("A gold ring with an aquamarine mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("emerald and gold ring"),
    description = ccb.content.text("A gold ring with an emerald mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("alexandrite and gold ring"),
    description = ccb.content.text("A gold ring with an alexandrite mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("ruby and gold ring"),
    description = ccb.content.text("A gold ring with a ruby mounted on top of it."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("peridot and gold ring"),
    description = ccb.content.text("A gold ring with a peridot mounted on top of it."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("sapphire and gold ring"),
    description = ccb.content.text("A gold ring with a sapphire mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("tourmaline and gold ring"),
    description = ccb.content.text("A gold ring with a tourmaline mounted on top of it."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("citrine and gold ring"),
    description = ccb.content.text("A gold ring with a citrine mounted on top of it."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("blue topaz and gold ring"),
    description = ccb.content.text("A gold ring with a blue topaz mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("opal and gold ring"),
    description = ccb.content.text("A gold ring with an opal mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("pearl and gold ring"),
    description = ccb.content.text("A gold ring with a pearl mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_ring",
    copy_from = "garnet_gold_ring",
    name = ccb.content.text("onyx and gold ring"),
    description = ccb.content.text("A gold ring with an onyx mounted on top of it."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("diamond and silver ring"),
    description = ccb.content.text("A silver ring with a diamond mounted on top of it."),
    price = "120 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_ring",
    name = ccb.content.text("garnet and silver ring"),
    description = ccb.content.text("A silver ring with a garnet mounted on top of it."),
    mass = "10 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_ring",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("amethyst and silver ring"),
    description = ccb.content.text("A silver ring with an amethyst mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("aquamarine and silver ring"),
    description = ccb.content.text("A silver ring with an aquamarine mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("emerald and silver ring"),
    description = ccb.content.text("A silver ring with an emerald mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("alexandrite and silver ring"),
    description = ccb.content.text("A silver ring with an alexandrite mounted on top of it."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("ruby and silver ring"),
    description = ccb.content.text("A silver ring with a ruby mounted on top of it."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_ring", weight = 99 },
        {
            id = "vampire_ring",
            name = ccb.content.text("vampire ring"),
            description = ccb.content.text("A silver ring with a sinister claw clutching a blood-red ruby mounted on top of it."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("peridot and silver ring"),
    description = ccb.content.text("A silver ring with a peridot mounted on top of it."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("sapphire and silver ring"),
    description = ccb.content.text("A silver ring with a sapphire mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("tourmaline and silver ring"),
    description = ccb.content.text("A silver ring with a tourmaline mounted on top of it."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("citrine and silver ring"),
    description = ccb.content.text("A silver ring with a citrine mounted on top of it."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("blue topaz and silver ring"),
    description = ccb.content.text("A silver ring with a blue topaz mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("opal and silver ring"),
    description = ccb.content.text("A silver ring with an opal mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("pearl and silver ring"),
    description = ccb.content.text("A silver ring with a pearl mounted on top of it."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_ring",
    copy_from = "garnet_silver_ring",
    name = ccb.content.text("onyx and silver ring"),
    description = ccb.content.text("A silver ring with an onyx mounted on top of it."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_ring", weight = 99 },
        {
            id = "dark_ring",
            name = ccb.content.text("dark ring"),
            description = ccb.content.text("A dark silver ring with skull decorations and a pitch-black onyx mounted on top of it."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("diamond and platinum ring"),
    description = ccb.content.text("A platinum ring with a diamond mounted on top of it."),
    price = "120 USD",
    survival_price = "50 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_ring",
    name = ccb.content.text("garnet and platinum ring"),
    description = ccb.content.text("A platinum ring with a garnet mounted on top of it."),
    mass = "19 mg",
    volume = "1 ml",
    price = "100 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_ring",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("amethyst and platinum ring"),
    description = ccb.content.text("A platinum ring with an amethyst mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("aquamarine and platinum ring"),
    description = ccb.content.text("A platinum ring with an aquamarine mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("emerald and platinum ring"),
    description = ccb.content.text("A platinum ring with an emerald mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("alexandrite and platinum ring"),
    description = ccb.content.text("A platinum ring with an alexandrite mounted on top of it."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("ruby and platinum ring"),
    description = ccb.content.text("A platinum ring with a ruby mounted on top of it."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("peridot and platinum ring"),
    description = ccb.content.text("A platinum ring with a peridot mounted on top of it."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("sapphire and platinum ring"),
    description = ccb.content.text("A platinum ring with a sapphire mounted on top of it."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("tourmaline and platinum ring"),
    description = ccb.content.text("A platinum ring with a tourmaline mounted on top of it."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("citrine and platinum ring"),
    description = ccb.content.text("A platinum ring with a citrine mounted on top of it."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("blue topaz and platinum ring"),
    description = ccb.content.text("A platinum ring with a blue topaz mounted on top of it."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("opal and platinum ring"),
    description = ccb.content.text("A platinum ring with an opal mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("pearl and platinum ring"),
    description = ccb.content.text("A platinum ring with a pearl mounted on top of it."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_ring",
    copy_from = "garnet_platinum_ring",
    name = ccb.content.text("onyx and platinum ring"),
    description = ccb.content.text("A platinum ring with an onyx mounted on top of it."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("diamond and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling diamonds."),
    price = "2 kUSD",
    looks_like = "gold_bracelet",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_bracelet",
    name = ccb.content.text("garnet and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling garnets."),
    mass = "190 mg",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_bracelet",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("amethyst and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("aquamarine and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("emerald and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("alexandrite and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("ruby and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("peridot and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("sapphire and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("tourmaline and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("citrine and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("blue topaz and gold bracelet"),
    description = ccb.content.text("A gold bracelet with sparkling blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("opal and gold bracelet"),
    description = ccb.content.text("A gold bracelet with beautiful opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("pearl and gold bracelet"),
    description = ccb.content.text("A gold bracelet with beautiful pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_bracelet",
    copy_from = "garnet_gold_bracelet",
    name = ccb.content.text("onyx and gold bracelet"),
    description = ccb.content.text("A gold bracelet with striking onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("diamond and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling diamonds."),
    price = "2 kUSD",
    looks_like = "silver_bracelet",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_bracelet",
    name = ccb.content.text("garnet and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling garnets."),
    mass = "100 mg",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_bracelet",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("amethyst and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("aquamarine and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("emerald and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("alexandrite and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling alexandrites."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("ruby and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling rubies."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_bracelet", weight = 99 },
        {
            id = "vampire_bracelet",
            name = ccb.content.text("vampire bracelet"),
            description = ccb.content.text("A dark silver bracelet with blood-red rubies in the shape of two sinister-looking hearts."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("peridot and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("sapphire and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("tourmaline and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("citrine and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("blue topaz and silver bracelet"),
    description = ccb.content.text("A silver bracelet with sparkling blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("opal and silver bracelet"),
    description = ccb.content.text("A silver bracelet with beautiful opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("pearl and silver bracelet"),
    description = ccb.content.text("A silver bracelet with beautiful pearls."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_bracelet",
    copy_from = "garnet_silver_bracelet",
    name = ccb.content.text("onyx and silver bracelet"),
    description = ccb.content.text("A silver bracelet with striking onyx."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_bracelet", weight = 99 },
        {
            id = "dark_bracelet",
            name = ccb.content.text("dark bracelet"),
            description = ccb.content.text("A dark silver bracelet with occult decorations and one single onyx as the center of a dark eye."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("diamond and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling diamonds."),
    price = "2 kUSD",
    looks_like = "platinum_bracelet",
    survival_price = "50 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_bracelet",
    name = ccb.content.text("garnet and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling garnets."),
    mass = "190 g",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_bracelet",
    symbol = "[",
    color = "red",
    flags = { "BELTED", "NO_WEAR_EFFECT", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "amethyst_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("amethyst and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("aquamarine and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("emerald and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("alexandrite and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("ruby and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("peridot and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("sapphire and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("tourmaline and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("citrine and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("blue topaz and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with sparkling blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("opal and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with beautiful opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("pearl and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with beautiful pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_bracelet",
    copy_from = "garnet_platinum_bracelet",
    name = ccb.content.text("onyx and platinum bracelet"),
    description = ccb.content.text("A platinum bracelet with striking onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_pendant_necklace",
    name = ccb.content.text("garnet and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a garnet pendant."),
    mass = "70 g",
    volume = "15 ml",
    price = "500 USD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "gold_necklace",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("diamond and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a diamond pendant."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("amethyst and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an amethyst pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("aquamarine and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an aquamarine pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("emerald and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an emerald pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("alexandrite and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an alexandrite pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("ruby and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a ruby pendant."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("peridot and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a peridot pendant."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("sapphire and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a sapphire pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("tourmaline and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a tourmaline pendant."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("citrine and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a citrine pendant."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("blue topaz and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a blue topaz pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("opal and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an opal pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("pearl and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with a pearl pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_pendant_necklace",
    copy_from = "garnet_gold_pendant_necklace",
    name = ccb.content.text("onyx and gold pendant necklace"),
    description = ccb.content.text("A shiny, gold necklace adorned with an onyx pendant."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_pendant_necklace",
    name = ccb.content.text("garnet and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a garnet pendant."),
    mass = "70 g",
    volume = "15 ml",
    price = "500 USD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "silver_necklace",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("diamond and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a diamond pendant."),
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("amethyst and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an amethyst pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("aquamarine and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an aquamarine pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("emerald and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an emerald pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("alexandrite and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an alexandrite pendant."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("ruby and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a ruby pendant."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_pendant_necklace", weight = 99 },
        {
            id = "vampire_necklace",
            name = ccb.content.text("vampire necklace"),
            description = ccb.content.text("A sinister silver necklace adorned with a blood-red ruby pendant."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("peridot and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a peridot pendant."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("sapphire and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a sapphire pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("tourmaline and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a tourmaline pendant."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("citrine and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a citrine pendant."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("blue topaz and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a blue topaz pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("opal and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an opal pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("pearl and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with a pearl pendant."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_pendant_necklace",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.text("onyx and silver pendant necklace"),
    description = ccb.content.text("A shiny, silver necklace adorned with an onyx pendant."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_pendant_necklace", weight = 99 },
        {
            id = "dark_necklace",
            name = ccb.content.text("dark necklace"),
            description = ccb.content.text("A dark silver necklace with an onyx pendant in the shape of a dark heart."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("garnet and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a garnet pendant."),
    mass = "70 g",
    volume = "15 ml",
    price = "500 USD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "platinum_necklace",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "diamond_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("diamond and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a diamond pendant."),
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("amethyst and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an amethyst pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("aquamarine and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an aquamarine pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("emerald and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an emerald pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("alexandrite and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an alexandrite pendant."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("ruby and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a ruby pendant."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("peridot and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a peridot pendant."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("sapphire and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a sapphire pendant."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("tourmaline and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a tourmaline pendant."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("citrine and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a citrine pendant."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("blue topaz and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a blue topaz pendant."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("opal and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an opal pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("pearl and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with a pearl pendant."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_pendant_necklace",
    copy_from = "garnet_platinum_pendant_necklace",
    name = ccb.content.text("onyx and platinum pendant necklace"),
    description = ccb.content.text("A shiny, platinum necklace adorned with an onyx pendant."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_platinum_tiara",
    name = ccb.content.text("garnet and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with garnets."),
    mass = "200 g",
    volume = "100 ml",
    price = "5 kUSD",
    survival_price = "25 cent",
    materials = { { id = "platinum", portions = 9 }, { id = "gemstone" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
}

ccb.content.define_item {
    id = "diamond_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("diamond and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with diamonds."),
    materials = { { id = "platinum", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("amethyst and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("aquamarine and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("emerald and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("alexandrite and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("ruby and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("peridot and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("sapphire and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("tourmaline and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("citrine and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("blue topaz and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("opal and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("pearl and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_platinum_tiara",
    copy_from = "garnet_platinum_tiara",
    name = ccb.content.text("onyx and platinum tiara"),
    description = ccb.content.text("A shiny, platinum tiara adorned with onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_gold_tiara",
    name = ccb.content.text("garnet and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with garnets."),
    mass = "190 g",
    volume = "100 ml",
    price = "4 kUSD",
    survival_price = "25 cent",
    materials = { { id = "gold", portions = 9 }, { id = "gemstone" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
}

ccb.content.define_item {
    id = "diamond_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("diamond and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with diamonds."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("amethyst and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("aquamarine and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("emerald and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("alexandrite and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with alexandrites."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "ruby_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("ruby and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with rubies."),
    armor = {},
}

ccb.content.define_item {
    id = "peridot_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("peridot and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("sapphire and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("tourmaline and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("citrine and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("blue topaz and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("opal and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("pearl and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with pearls."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "onyx_gold_tiara",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.text("onyx and gold tiara"),
    description = ccb.content.text("A shiny, gold tiara adorned with onyx."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "gold_hair_beads",
    copy_from = "garnet_gold_tiara",
    name = ccb.content.plural_text("gold hair beads", "sets of gold hair beads"),
    description = ccb.content.text("An assortment of gold beads used to decorate locs or braids."),
    mass = "15 g",
    volume = "25 ml",
    materials = { "gold" },
    symbol = ".",
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "garnet_silver_tiara",
    name = ccb.content.text("garnet and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with garnets."),
    mass = "130 g",
    volume = "100 ml",
    price = "2 kUSD",
    survival_price = "25 cent",
    materials = { { id = "silver", portions = 9 }, { id = "gemstone" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
}

ccb.content.define_item {
    id = "diamond_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("diamond and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with diamonds."),
    materials = { { id = "silver", portions = 9 }, { id = "diamond" } },
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "amethyst_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("amethyst and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with amethysts."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "aquamarine_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("aquamarine and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with aquamarines."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "emerald_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("emerald and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with emeralds."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "alexandrite_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("alexandrite and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with alexandrites."),
    color = "green",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "ruby_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("ruby and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with rubies."),
    variant_kind = "generic",
    variants = {
        { id = "generic_ruby_silver_tiara", weight = 99 },
        {
            id = "vampire_tiara",
            name = ccb.content.text("vampire tiara"),
            description = ccb.content.text("A sinister dark silver tiara adorned with blood-red rubies."),
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "peridot_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("peridot and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with peridots."),
    color = "light_green",
    armor = {},
}

ccb.content.define_item {
    id = "sapphire_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("sapphire and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with sapphires."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "tourmaline_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("tourmaline and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with tourmaline."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "citrine_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("citrine and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with citrines."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "blue_topaz_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("blue topaz and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with blue topaz."),
    color = "light_blue",
    armor = {},
}

ccb.content.define_item {
    id = "opal_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("opal and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with opals."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "pearl_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("pearl and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with pearls."),
    color = "white",
    armor = {},
}

-- inherit name and description from item
ccb.content.define_item {
    id = "onyx_silver_tiara",
    copy_from = "garnet_silver_tiara",
    name = ccb.content.text("onyx and silver tiara"),
    description = ccb.content.text("A shiny, silver tiara adorned with onyx."),
    variant_kind = "generic",
    variants = {
        { id = "generic_onyx_silver_tiara", weight = 99 },
        {
            id = "dark_tiara",
            name = ccb.content.text("dark tiara"),
            description = ccb.content.text("A dark silver tiara adorned with onyx."),
        },
    },
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "gold_anklet",
    name = ccb.content.text("gold anklet"),
    description = ccb.content.text("An anklet made from tiny chain links of gold."),
    mass = "6 g",
    volume = "10 ml",
    price = "200 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_anklet",
    name = ccb.content.text("silver anklet"),
    description = ccb.content.text("An anklet made from tiny chain links of silver."),
    mass = "6 g",
    volume = "10 ml",
    price = "150 USD",
    survival_price = "20 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "bat_anklet",
    name = ccb.content.text("bat charm anklet"),
    description = ccb.content.text("An anklet with tiny charms in the shape of bats and blood drops."),
    mass = "6 g",
    volume = "10 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    color = "red",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "flower_anklet",
    name = ccb.content.text("flower charm anklet"),
    description = ccb.content.text("An anklet with tiny charms in the shape of flowers in an array of colors."),
    mass = "6 g",
    volume = "10 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "plastic", "cotton" },
    symbol = "[",
    color = "pink",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "woven_anklet",
    name = ccb.content.text("woven anklet"),
    description = ccb.content.text("An anklet made from brightly colored cord woven into a repeating pattern."),
    mass = "5 g",
    volume = "10 ml",
    price = "2 USD",
    survival_price = "2 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "green",
    flags = { "NO_WEAR_EFFECT", "BELTED", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gold_lip_ring_loop",
    name = ccb.content.text("gold lip ring loop"),
    description = ccb.content.text("An expensive gold lip ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "o",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_lip_ring_stud",
    name = ccb.content.text("gold lip ring stud"),
    description = ccb.content.text("An expensive gold lip ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = ".",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_lip_ring_loop",
    name = ccb.content.text("silver lip ring loop"),
    description = ccb.content.text("An expensive silver lip ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = "o",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_lip_ring_stud",
    name = ccb.content.text("silver lip ring stud"),
    description = ccb.content.text("An expensive silver lip ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = ".",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_nose_ring_loop",
    name = ccb.content.text("gold nose ring loop"),
    description = ccb.content.text("An expensive gold nose ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "gold" },
    symbol = "o",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_nose_ring_stud",
    name = ccb.content.text("gold nose ring stud"),
    description = ccb.content.text("An expensive gold nose ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = ".",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_nose_ring_loop",
    name = ccb.content.text("silver nose ring loop"),
    description = ccb.content.text("An expensive silver nose ring loop."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = "o",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "silver_nose_ring_stud",
    name = ccb.content.text("silver nose ring stud"),
    description = ccb.content.text("An expensive silver nose ring stud."),
    mass = "18 mg",
    volume = "1 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = ".",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}

ccb.content.define_item {
    id = "gold_toe_ring",
    name = ccb.content.text("gold toe ring"),
    description = ccb.content.text("An expensive gold toe ring."),
    mass = "3 g",
    volume = "3 ml",
    price = "250 USD",
    survival_price = "25 cent",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_toe_ring",
    name = ccb.content.text("silver toe ring"),
    description = ccb.content.text("An expensive silver toe ring."),
    mass = "3 g",
    volume = "3 ml",
    price = "150 USD",
    survival_price = "15 cent",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    flags = { "NO_WEAR_EFFECT", "SKINTIGHT" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
            },
        },
    },
}
