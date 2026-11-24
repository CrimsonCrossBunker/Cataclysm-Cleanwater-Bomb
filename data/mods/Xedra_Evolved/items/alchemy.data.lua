local ccb = require("ccb")

ccb.content.define_item {
    id = "blackout_rage_drink",
    looks_like = "cola",
    name = ccb.content.plural_text("Bored, the blackout rage drink", "Bored, the blackout rage drink"),
    mass = "250 g",
    color = "magenta",
    default_container = "jug_plastic",
    symbol = "~",
    description = ccb.content.text("An incredibly alcoholic and caffeinated drink.  This probably isn't healthy."),
    price = "1 USD 70 cent",
    survival_price = "50 cent",
    materials = { { id = "water", portions = 10 }, { id = "alcohol", portions = 1 } },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "SINGLE_USE" },
    comestible = {
        addiction = "alcohol",
        vitamins = { { id = "ethanol", amount = 20 }, { id = "caffeine", amount = 255 } },
        kind = "DRINK",
        quench = 15,
        healthy = -4,
        addiction_potential = 6,
        calories = 157,
        servings = 1,
        fun = 5,
    },
    use_actions = { { kind = "cast_spell", spell = "blackout_rage_drink", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "sixdust",
    name = ccb.content.plural_text("sixdust", "sixdust"),
    description = ccb.content.text("Sixdust, for when you must scorch the earth.  A sprayable anti-fungal/anti-insecticidal ammo for the chemical thrower.  Best used with some kind of mask or mouth protection."),
    mass = "3 g",
    volume = "250 ml",
    price = "6 USD",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "=",
    color = "yellow_red",
    default_container = "bottle_plastic",
    sealed_container = false,
    phase = "liquid",
    ammunition = {
        type = "chemical_spray",
        range = 4,
        count = 100,
        effects = {
            "GAS_FUNGICIDAL",
            "STREAM_GAS_FUNGICIDAL",
            "GAS_INSECTICIDAL",
            "STREAM_GAS_INSECTICIDAL",
            "JET",
        },
    },
}

ccb.content.define_item {
    id = "small_blessing_brigit",
    name = ccb.content.plural_text("small blessing of Brigit", "small blessing of Brigit"),
    description = ccb.content.text("A small pill made from royal jelly, ash, and poppies.  Blessed with prayers to Brigit over several hours.  Will end any cold or flu instantaneously."),
    mass = "1 g",
    volume = "1 ml",
    price = "2 USD",
    survival_price = "16 USD",
    materials = { "veggy" },
    symbol = "!",
    color = "green",
    flags = { "NPC_SAFE", "IRREPLACEABLE_CONSUMABLE", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", healthy = 15, vitamins = { { id = "veggy_allergen", amount = 1 } } },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You feel better almost instantly."),
            effects = { { id = "curesome" } },
        },
    },
}

ccb.content.define_item {
    id = "prophets_lsd",
    name = ccb.content.plural_text("prophet's LSD", "prophet's LSD"),
    description = ccb.content.text("A windowpane worth of Rainbow Skull LSD tabs.  These tabs are said to grant the consumer the ability to see several seconds into the future."),
    mass = "1 g",
    volume = "2 ml",
    price = "1 USD",
    survival_price = "25 cent",
    symbol = "!",
    color = "pink",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE", "SINGLE_USE" },
    comestible = { kind = "MED", stimulation = 20, fun = 25 },
    use_actions = { { kind = "cast_spell", spell = "future_sight", no_fail = true, level = 25 } },
}

ccb.content.define_item {
    id = "abyssal_coffee",
    looks_like = "coffee",
    copy_from = "coffee",
    name = ccb.content.plural_text("abyssal coffee", "abyssal coffee"),
    description = ccb.content.text("The morning ritual of the pre-apocalyptic world, created from coffee cherries through a complex process of seed removal, roasting, grinding, and brewing.  Well, that's true for regular coffee, but this doesn't look regular.  It's so coffee is so dark it seems to dim the light around it and its aroma fills the entire room."),
    price = "100 USD",
    survival_price = "3 USD50 cent",
    comestible = { fun = 0, on_consume = "consume_abyssal_coffee" },
}

ccb.content.define_item {
    id = "truckers_stamina_pills",
    name = "alchemically altered trucker pill",
    description = "When you began the sinister path into occultism, you never imagined you'd be alchemically altering truckstop Viagra into combat drugs.  But here you are, no sleep til Boston.",
    symbol = "!",
    color = "light_cyan",
    default_container = "bag_zipper",
    mass = "1 g",
    volume = "2 ml",
    price = "150 cent",
    survival_price = "50 cent",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN" },
    materials = { "powder" },
    use_actions = {
        {
            kind = "consume_drug",
            message = "You swallow a couple of the large green pills.",
            vitamins = {
                { id = "cheval", minimum = 1000 },
            },
        },
    },
    comestible = {
        kind = "MED",
        fun = 30,
        quench = -2,
        healthy = -7,
        stimulation = 20,
        addiction_potential = 15,
        addictions = {
            "amphetamine",
            { id = "opiate", potential = 10 },
        },
        vitamins = {
            { id = "vit_mme", amount = 200 },
        },
    },
}

ccb.content.define_item {
    id = "spiritshow_dust",
    name = ccb.content.plural_text("spirit show dust", "spirit show dust"),
    description = ccb.content.text("A key ingredient for Victorian seances led by actual occultists.  This dust summons spirits from beyond to walk the earth again for a short time.  The spirits it summons are mindless and disappear upon being touched."),
    mass = "20 g",
    volume = "250 ml",
    symbol = "~",
    default_container = "flask_glass",
    color = "light_blue",
    flags = { "EATEN_COLD", "NO_AUTO_CONSUME", "NUTRIENT_OVERRIDE", "SINGLE_USE" },
    materials = { "powder" },
    price = "25 USD",
    comestible = { quench = -1, calories = 0, fun = -1, kind = "MED" },
    use_actions = { { kind = "cast_spell", spell = "ghost_inflatable", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "nether_snare",
    name = "snaring pentagram trap",
    description = "A metallic pentagram full of mystic symbols.  Will trap creatures from other dimensions if they wander into it.",
    symbol = "*",
    color = "dark_gray",
    category = "traps",
    mass = "1 kg",
    volume = "1000 ml",
    length = "60 cm",
    price = "250 USD",
    survival_price = "5 USD",
    flags = { "SINGLE_USE" },
    materials = { "lead" },
    properties = { capture_species = "NETHER" },
    use_actions = {
        {
            kind = "place_trap",
            trap = "tr_nether_snare",
            moves = 150,
            practice = 2,
            done_message = "You set the pentagram snare.",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "xe_alchemy_powder_of_revelation",
    name = ccb.content.plural_text("powder of revelation", "handfuls of powder of revelation"),
    description = ccb.content.text("A dull grayish powder with a slight shimmering opalescence.  When thrown it will fill the air and reveal the true form and existence of any creature whose form it coats."),
    mass = "50 g",
    volume = "250 ml",
    symbol = ":",
    default_container = "flask_glass",
    color = "light_gray",
    materials = { "powder" },
    price = "2 USD",
    drop_action = { kind = "emit_actor", emissions = { "emit_powder_of_revelation" }, scale_quantity = false },
}

ccb.content.define_item {
    id = "charm_of_marzanna",
    copy_from = "garnet_silver_pendant_necklace",
    name = ccb.content.plural_text("charm of Marzanna", "charms of Marzanna"),
    description = ccb.content.text("A tiny effigy of a woman with singed extremities and a waterlogged face."),
    color = "light_blue",
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_control_marzanna" } },
}

ccb.content.define_item {
    id = "feline_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("feline periapta", "feline periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a cat with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_feline" } },
}

ccb.content.define_item {
    id = "lupine_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("lupine periapta", "lupine periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a wolf with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_lupine" } },
}

ccb.content.define_item {
    id = "cephalopod_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("cephalopod periapta", "cephalopod periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of an octopus with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_cephalopod" } },
}

ccb.content.define_item {
    id = "plant_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("tree periapta", "tree periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a tree with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_plant" } },
}

ccb.content.define_item {
    id = "scorpion_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("scorpion periapta", "scorpion periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a scorpion with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_scorpion" } },
}

ccb.content.define_item {
    id = "butterfly_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("butterfly periapta", "butterfly periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a butterfly with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_butterfly" } },
}

ccb.content.define_item {
    id = "spider_periapta",
    copy_from = "diamond_gold_pendant_necklace",
    name = ccb.content.plural_text("spider periapta", "spider periaptas"),
    description = ccb.content.text("A shiny, gold necklace adorned with an image of a spider with strange runes on it and diamond eyes."),
    materials = { { id = "gold", portions = 9 }, { id = "diamond" } },
    color = "white",
    inheritance = { remove = { flags = { "NO_WEAR_EFFECT" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_climate_periapta_spider" } },
}

ccb.content.define_item {
    id = "life_extension_potion",
    name = ccb.content.plural_text("life extension potion", "life extension potions"),
    description = ccb.content.text("A source of considerable wealth for the few alchemists talented enough to distill them, these potions are capable of adding decades to the lifespan of those who can afford the price of the rare and expensive ingredients they require.  They are however not able to prolong a life indefinitely beyond its natural years, and you will need to find other means to achieve immortality, if that is your goal."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_life_extension" },
}

ccb.content.define_item {
    id = "gender_potion",
    name = ccb.content.plural_text("gender change potion", "gender change potions"),
    description = ccb.content.text("This is a potion of change.  It will turn you into the opposite gender.  Turn into your true self, or otherwise experience what lies within the opposite gender."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "5 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 3, fun = -1, on_consume = "drink_gender_potion" },
}

ccb.content.define_item {
    id = "potion_dex",
    name = ccb.content.plural_text("potion of wicked quick hands", "potions of wicked quick hands"),
    description = ccb.content.text("This is a potion of wicked quick hands.  It will increase your dexterity for 50 minutes."),
    copy_from = "life_extension_potion",
    color = "green",
    price = "30 USD",
    comestible = { calories = 25 },
    use_actions = { { kind = "cast_spell", spell = "wicked_quick_hands", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "potion_strength",
    name = ccb.content.plural_text("potion of terrible strength", "potions of terrible strength"),
    description = ccb.content.text("This is a potion of terrible strength.  It will increase your strength for 50 minutes."),
    color = "red",
    copy_from = "life_extension_potion",
    comestible = { calories = 50 },
    use_actions = { { kind = "cast_spell", spell = "terrible_strength", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "hares_leap_potion",
    name = ccb.content.plural_text("potion of hare's leap", "potions of hare's leap"),
    description = ccb.content.text("This is a potion of hare's leap.  It allows you to jump afar from danger."),
    color = "green_yellow",
    copy_from = "life_extension_potion",
    comestible = { calories = 50 },
    use_actions = { { kind = "cast_spell", spell = "spell_hare_leap", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "hyde_formula",
    name = ccb.content.plural_text("Hyde Formula", "Hyde Formula"),
    description = ccb.content.text("This is a transmutation potion that will bring your best attributes to the forefront."),
    color = "green_yellow",
    copy_from = "life_extension_potion",
    comestible = { calories = 50, on_consume = "drink_hyde_formula" },
}

ccb.content.define_item {
    id = "plant_imbuement",
    name = ccb.content.plural_text("Imbuement of the Trees", "Imbuement of the Trees"),
    description = ccb.content.text("In a wooden bowl, Faewild and Dreamdross are mixed together along with ground-up leaves.  The mixture has fae and human blood added to it and parts from the plant fae and then all mixed again until it's a uniform blend.  The resulting mixture will eventually dissolve into a deep green liquid."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_plant_imbuement" },
}

ccb.content.define_item {
    id = "earth_imbuement",
    name = ccb.content.plural_text("Imbuement of the Earth", "Imbuement of the Earth"),
    description = ccb.content.text("."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_earth_imbuement" },
}

ccb.content.define_item {
    id = "water_imbuement",
    name = ccb.content.plural_text("Imbuement of the Waters", "Imbuement of the Waters"),
    description = ccb.content.text("."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_water_imbuement" },
}

ccb.content.define_item {
    id = "air_imbuement",
    name = ccb.content.plural_text("Imbuement of the Winds", "Imbuement of the Winds"),
    description = ccb.content.text("."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_air_imbuement" },
}

ccb.content.define_item {
    id = "fire_imbuement",
    name = ccb.content.plural_text("Imbuement of the Flames", "Imbuement of the Flames"),
    description = ccb.content.text("Heat Faewild and Dreamdross over a roaring fire and the mix in the ashes until you have a thick paste.  That paste is mixed with parts taken from the Fair Folk and united with a dollop of fae, and human blood.  The resulting mixture will eventually dissolve into a scarlet liquid that shines with its own light."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    light = 5,
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_fire_imbuement" },
}

ccb.content.define_item {
    id = "doll_imbuement",
    name = ccb.content.plural_text("Imbuement of Parchment", "Imbuement of Parchment"),
    description = ccb.content.text("While looking in a mirror, Faewild and Dreamdross are ground to dust.  That dust is mixed with parts taken from the Fair Folk and united with a dollop of fae, and human blood.  The resulting mixture will eventually dissolve into what almost looks like liquid porcelain."),
    mass = "50 g",
    volume = "250 ml",
    price = "150 cent",
    survival_price = "200 USD",
    materials = { "water" },
    symbol = "!",
    color = "light_cyan",
    default_container = "flask_glass",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN", "SINGLE_USE" },
    comestible = { kind = "MED", quench = 2, healthy = 7, fun = -30, on_consume = "drink_doll_imbuement" },
}
