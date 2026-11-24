local ccb = require("ccb")

-- NO_I18N
-- Not commercially traded, in case there was any question.
ccb.content.define_item {
    id = "mutagen_flavor",
    abstract = true,
    name = ccb.content.text_without_extraction("abstract mutagen flavor", "abstract mutagen flavor"),
    description = ccb.content.text("A rare substance of uncertain origins.  Causes you to mutate."),
    display_type = "BY_VOLUME",
    price = "2500 USD",
    survival_price = "50 cent",
    category = "mutagen",
    mass = "250 g",
    volume = "250 ml",
    phase = "liquid",
    default_container = "flask_glass",
    symbol = "~",
    color = "light_green",
    flags = { "NO_INGEST", "NUTRIENT_OVERRIDE" },
    materials = { "water" },
    comestible = {
        kind = "MED",
        servings = 1,
        healthy = -2,
        addiction_potential = 2,
        addiction = "mutagen",
        vitamins = {},
        freezing_point = -8,
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "iv_mutagen_flavor",
    abstract = true,
    copy_from = "mutagen_flavor",
    name = ccb.content.text_without_extraction("abstract IV mutagen flavor", "abstract IV mutagen flavor"),
    description = ccb.content.text("A processed mutagenic primer."),
    price = "3000 USD",
    survival_price = "1 USD",
    mass = "10 g",
    volume = "10 ml",
    symbol = "!",
    color = "green",
    default_container = "test_tube",
    flags = { "NO_INGEST", "MUTAGEN_PRIMER" },
    comestible = { healthy = -6, stimulation = -5, addiction_potential = 6, tool = "syringe" },
}

ccb.content.define_item {
    id = "iv_mutagen",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("mutagenic catalyst", "mutagenic catalyst"),
    description = ccb.content.text("A processed, purified, and condensed dose of mutagenic drugs.  When combined with mutagenic primer, this will cause mutations over time."),
    inheritance = { add = { flags = { "MUTAGEN_CATALYST" } }, remove = { flags = { "MUTAGEN_PRIMER" } } },
    comestible = { healthy = -10, stimulation = -10, addiction_potential = 12 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen", minimum = 750, maximum = 850 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_alpha",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("alpha mutagenic primer", "alpha mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer strongly resembling blood."),
    price = "25000 USD",
    looks_like = "iv_mutagen",
    color = "red",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_alpha", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_beast",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("beast mutagenic primer", "beast mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer as red as a matador's cape."),
    looks_like = "iv_mutagen",
    color = "red",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_beast", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_bird",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("bird mutagenic primer", "bird mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer the color of the pre-Cataclysmic skies."),
    looks_like = "iv_mutagen",
    color = "cyan",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_bird", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_cattle",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("cattle mutagenic primer", "cattle mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer the color of grass."),
    looks_like = "iv_mutagen",
    color = "light_green",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_cattle", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_cephalopod",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("cephalopod mutagenic primer", "cephalopod mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer as black as ink."),
    looks_like = "iv_mutagen",
    color = "dark_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_cephalopod", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_chimera",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("chimera mutagenic primer", "chimera mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that churns with iridescence."),
    price = "4 kUSD",
    looks_like = "iv_mutagen",
    color = "red",
    comestible = { healthy = -15, stimulation = -10, addiction_potential = 4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_chimera", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_elfa",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("Elf-A mutagenic primer", "Elf-A mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that's a striking sylvan green."),
    price = "4 kUSD",
    looks_like = "iv_mutagen",
    color = "light_green",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_elfa", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_feline",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("feline mutagenic primer", "feline mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer, yellow and highly reflective."),
    looks_like = "iv_mutagen",
    color = "yellow",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_feline", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_fish",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("fish mutagenic primer", "fish mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer the color of the ocean, with white foam at the top."),
    looks_like = "iv_mutagen",
    color = "light_blue",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_fish", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_insect",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("insect mutagenic primer", "insect mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that's a beautiful amber color."),
    looks_like = "iv_mutagen",
    color = "yellow",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_insect", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_lizard",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("lizard mutagenic primer", "lizard mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that shifts between various shades of green."),
    looks_like = "iv_mutagen",
    color = "light_green",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_lizard", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_lupine",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("lupine mutagenic primer", "lupine mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer as white as a full moon."),
    looks_like = "iv_mutagen",
    color = "white",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_lupine", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_medical",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("medical mutagenic primer", "medical mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that looks like a mixture of bodily fluids."),
    price = "3000 USD",
    looks_like = "iv_mutagen",
    color = "light_red",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_medical", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_plant",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("plant mutagenic primer", "plant mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that looks like pureed spinach."),
    looks_like = "iv_mutagen",
    color = "green",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_plant", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_raptor",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("raptor mutagenic primer", "raptor mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that seems to shift slightly whenever you look at it."),
    price = "4 kUSD",
    looks_like = "iv_mutagen",
    color = "green",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_raptor", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_rat",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("rat mutagenic primer", "rat mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that's a rather unappealing beige."),
    looks_like = "iv_mutagen",
    color = "brown",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_rat", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_chiropteran",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("chiropteran mutagenic primer", "chiropteran mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer, black as night."),
    looks_like = "iv_mutagen",
    color = "dark_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_chiropteran", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_slime",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("slime mutagenic primer", "slime mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer, oily and viscous."),
    looks_like = "iv_mutagen",
    color = "dark_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_slime", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_spider",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("spider mutagenic primer", "spider mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer with pale filaments suspended in it."),
    looks_like = "iv_mutagen",
    color = "light_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_spider", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_snail",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("snail mutagenic primer", "snail mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer with the consistency of snot."),
    looks_like = "iv_mutagen",
    color = "light_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_gastropod", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_batrachian",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("batrachian mutagenic primer", "batrachian mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that looks like pond water… are the shadows in it moving?"),
    looks_like = "iv_mutagen",
    color = "light_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_batrachian", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_troglobite",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("troglobite mutagenic primer", "troglobite mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that seems to recoil from the light."),
    looks_like = "iv_mutagen",
    color = "dark_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_troglobite", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_ursine",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("ursine mutagenic primer", "ursine mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer that's the color of honey, and is just as thick."),
    looks_like = "iv_mutagen",
    color = "yellow",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_ursine", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_mouse",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("mouse mutagenic primer", "mouse mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer resembling liquefied metal."),
    looks_like = "iv_mutagen",
    color = "light_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_mouse", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_rabbit",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("rabbit mutagenic primer", "rabbit mutagenic primer"),
    description = ccb.content.text("An orange colored mutagenic primer."),
    looks_like = "iv_mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_rabbit", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_crustacean",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("crustacean mutagenic primer", "crustacean mutagenic primer"),
    description = ccb.content.text("A red colored mutagenic primer."),
    color = "red",
    looks_like = "iv_mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_crustacean", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("mutagenic slurry", "mutagenic slurry"),
    description = ccb.content.text("A slurry of organic chemicals and compounds, used as the foundation for making primers and mutagenic catalyst.  In this baseline form, it is highly toxic, and dangerous to consume on its own."),
    comestible = { addiction_potential = 6 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagenic_slurry", minimum = 25 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_jabberblood",
    copy_from = "mutagen",
    name = ccb.content.plural_text("congealed blood", "congealed blood"),
    description = ccb.content.text("A thick, soupy red liquid.  It looks and smells disgusting, and seems to bubble with an intelligence of its own…"),
    looks_like = "mutagen",
    color = "red",
    mass = "50 g",
    comestible = { addiction_potential = 0, servings = 5, fun = -10 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You choke down the congealed blood."),
            vitamins = { { id = "mutagen_beast", minimum = 160 }, { id = "mutagen", minimum = 160 } },
        },
    },
}

-- *May* have gotten a dose smuggled out.
ccb.content.define_item {
    id = "mutagen_alpha",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("alpha mutagen", "alpha mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail."),
    price = "5000 USD",
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_alpha", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_beast",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("beast mutagen", "beast mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_beast", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_bird",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("bird mutagen", "bird mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_bird", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_cattle",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("cattle mutagen", "cattle mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_cattle", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_cephalopod",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("cephalopod mutagen", "cephalopod mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_cephalopod", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_chimera",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("chimera mutagen", "chimera mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail."),
    price = "2000 USD",
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_chimera", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_elfa",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Elf-A mutagen", "Elf-A mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail."),
    price = "2000 USD",
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_elfa", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_feline",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("feline mutagen", "feline mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_feline", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_fish",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("fish mutagen", "fish mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_fish", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_insect",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("insect mutagen", "insect mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_insect", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_lizard",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("lizard mutagen", "lizard mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_lizard", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_lupine",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("lupine mutagen", "lupine mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_lupine", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

-- *May* have been considered for commercial trading.
ccb.content.define_item {
    id = "mutagen_medical",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("medical mutagen", "medical mutagen"),
    price = "1 kUSD 500 USD",
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_medical", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_plant",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("plant mutagen", "plant mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_plant", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_raptor",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("raptor mutagen", "raptor mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail."),
    price = "2000 USD",
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_raptor", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_rat",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("rat mutagen", "rat mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_rat", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_chiropteran",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("chiropteran mutagen", "chiropteran mutagen"),
    description = ccb.content.text("A murky black liquid that smells of blood."),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_chiropteran", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_slime",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("slime mutagen", "slime mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_slime", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_spider",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("spider mutagen", "spider mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_spider", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_batrachian",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("batrachian mutagen", "batrachian mutagen"),
    description = ccb.content.text("A shadowy mutagen that looks like it might be full of tiny swimming tadpoles."),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_batrachian", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_interstice",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("perfectly clear water", "perfectly clear water"),
    description = ccb.content.text("Everything about this liquid screams that it's water.  However, it's so clear that you can barely perceive it unless in motion."),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_interstice", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_snail",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("snail mutagen", "snail mutagen"),
    description = ccb.content.text("A mutagen that looks awfully like the slime from an old children's network."),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_gastropod", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_troglobite",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("troglobite mutagen", "troglobite mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_troglobite", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_ursine",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("ursine mutagen", "ursine mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_ursine", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_mouse",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("mouse mutagen", "mouse mutagen"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_mouse", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_rabbit",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("rabbit mutagen", "rabbit mutagen"),
    description = ccb.content.text("A white, clear colored mutagen.  You can drink it… if you really want to?"),
    looks_like = "mutagen",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_rabbit", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_crustacean",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("crustacean mutagen", "crustacean mutagen"),
    description = ccb.content.text("A crustacean mutagen."),
    looks_like = "mutagen",
    color = "red",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_crustacean", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "purifier",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("purifier", "purifier"),
    description = ccb.content.text("This thick, flesh-hued liquid helps revert the mutated to baseline humanity, but cannot remove mutagen present in the bloodstream.  Not for use on animals."),
    price = "6000 USD",
    survival_price = "250 cent",
    color = "pink",
    comestible = { healthy = -3, addiction_potential = 8 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_human", minimum = 225 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_purifier",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("purifier primer", "purifier primer"),
    description = ccb.content.text("This chunky, flesh-hued injection does wonders for returning mutants to humanity, but perhaps counter-intuitively, it requires regular mutagen to function.  Do not use on animals."),
    price = "9000 USD",
    survival_price = "5 USD",
    color = "pink",
    comestible = { addiction_potential = 8 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_human", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_chelator",
    name = ccb.content.plural_text("mutagen chelator", "mutagen chelator"),
    description = ccb.content.text("A dangerous treatment that binds to mutagen present in the bloodstream and allows it to be excreted."),
    price = "2500 USD",
    survival_price = "35 USD",
    category = "mutagen",
    mass = "10 g",
    volume = "10 ml",
    phase = "liquid",
    default_container = "test_tube",
    symbol = "?",
    color = "white",
    flags = { "NUTRIENT_OVERRIDE" },
    materials = { "water" },
    comestible = { kind = "MED", servings = 1, healthy = -30, freezing_point = -8, tool = "syringe" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_chelator", minimum = 250 } },
        },
    },
}

ccb.content.define_item {
    id = "purifier_smart_shot",
    category = "mutagen",
    name = ccb.content.plural_text("purifier smart shot", "purifier smart shots"),
    description = ccb.content.text("An experimental stem cell treatment, offering limited control over which mutations are purified.  The liquid sloshes strangely inside of this syringe."),
    mass = "12 g",
    volume = "10ml",
    price = "12 kUSD",
    survival_price = "30 USD",
    materials = { "plastic" },
    symbol = "!",
    color = "magenta",
    flags = { "NPC_SAFE", "TRADER_AVOID", "NUTRIENT_OVERRIDE", "NO_INGEST" },
    comestible = { kind = "MED", healthy = -6, stimulation = -5 },
    use_actions = { "PURIFY_SMART" },
}

ccb.content.define_item {
    id = "fetus",
    category = "other",
    name = ccb.content.plural_text("misshapen fetus", "misshapen fetuses"),
    mass = "760 g",
    color = "pink",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    symbol = "%",
    description = ccb.content.text("A deformed human fetus.  Eating this would be the most vile thing you can think of, and just might cause you to mutate."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh" },
    volume = "250 ml",
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        healthy = -12,
        calories = 156,
        fun = -60,
        vitamins = { { id = "mutagenic_slurry", amount = 15 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "arm",
    category = "other",
    name = ccb.content.text("mutated arm"),
    mass = "3767 g",
    color = "brown",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    symbol = "%",
    description = ccb.content.text("A misshapen human arm.  Eating this would be incredibly disgusting and probably cause you to mutate."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh" },
    volume = "4500 ml",
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        healthy = -8,
        calories = 278,
        fun = -20,
        vitamins = { { id = "mutagenic_slurry", amount = 10 }, { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "leg",
    category = "other",
    name = ccb.content.text("mutated leg"),
    mass = "11071 g",
    color = "brown",
    flags = { "TRADER_AVOID", "NUTRIENT_OVERRIDE" },
    symbol = "%",
    description = ccb.content.text("A malformed human leg.  This would be gross to eat, and probably cause mutations."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "hflesh" },
    volume = "12 L",
    comestible = {
        shelf_life = "2 days",
        kind = "FOOD",
        healthy = -8,
        calories = 399,
        fun = -20,
        vitamins = { { id = "mutagenic_slurry", amount = 10 }, { id = "meat_allergen", amount = 1 } },
    },
}
