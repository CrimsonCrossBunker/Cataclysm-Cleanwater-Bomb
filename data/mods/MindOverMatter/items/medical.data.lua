local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_instability_remover",
    name = ccb.content.plural_text("morphic reinforcement serum", "morphic reinforcement serum"),
    description = ccb.content.text("An extremely thick-looking liquid that will \"enhance your resilience against detrimental mutagenic alterations caused by XE037 overexposure\" if injected."),
    mass = "20 g",
    volume = "10ml",
    price = "300 kUSD",
    survival_price = "25 cent",
    symbol = "!",
    materials = { { id = "nether_crystal", portions = 15 }, { id = "alien_liquid", portions = 85 } },
    phase = "liquid",
    default_container = "test_tube",
    color = "blue",
    flags = { "NO_INGEST" },
    comestible = { kind = "MED", servings = 1, vitamins = {}, healthy = -4, freezing_point = -15 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the morphic reinforcement serum."),
            tools_needed = { syringe = -1 },
            effects = { { id = "instability_remover", duration = 86400 } },
        },
    },
}

ccb.content.define_item {
    id = "psionic_purifier_vita",
    name = ccb.content.plural_text("morphic reversion serum", "morphic reversion serum"),
    description = ccb.content.text("A faintly-glowing green liquid, the document you found told you that this would \"restore your morphology to baseline\", whatever that means."),
    mass = "20 g",
    volume = "10ml",
    price = "120 kUSD",
    survival_price = "10 cent",
    materials = { { id = "nether_crystal", portions = 15 }, { id = "alien_liquid", portions = 85 } },
    phase = "liquid",
    default_container = "test_tube",
    symbol = "!",
    color = "green",
    flags = { "SINGLE_USE", "NO_INGEST" },
    comestible = { kind = "MED", servings = 1, vitamins = {}, healthy = -4, freezing_point = -15 },
    use_actions = { "PURIFY_SMART" },
}

ccb.content.define_item {
    id = "psi_noetic_resilience_treatment",
    name = ccb.content.plural_text("noetic resilience treatment", "noetic resilience treatment"),
    description = ccb.content.text("A clear liquid, designed to alleviate some of the unpredictable effects of excessive psionic channeling."),
    mass = "20 g",
    volume = "10ml",
    price = "120 kUSD",
    survival_price = "10 cent",
    materials = { { id = "nether_crystal", portions = 5 }, { id = "alien_liquid", portions = 95 } },
    phase = "liquid",
    default_container = "test_tube",
    symbol = "!",
    color = "white",
    flags = { "NO_INGEST" },
    comestible = { kind = "MED", servings = 1, vitamins = {}, healthy = -4, freezing_point = -15 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            effects = { { id = "effect_noetic_resilience_trigger", duration = 1 } },
        },
    },
}

ccb.content.define_item {
    id = "psi_noetic_resonance_detector",
    category = "tools",
    name = ccb.content.plural_text("noetic resonance detector", "noetic resonance detectors"),
    description = ccb.content.text("A strange device, a bit like one of those eyesight testing machines you look into in an optometrist's office.  The main housing has a place to rest your chin and a pair of binocular-like tubes, but there is also a headband attached to a set of wires hanging from a hook on the side and an armband hanging from the other side."),
    mass = "11000 g",
    volume = "10 L",
    price = "50000 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "bad", length = "short", surface = "any", balance = "clumsy" },
    materials = { "steel", "glass", "nether_crystal", "alien_liquid" },
    symbol = "N",
    color = "white",
    melee_damage = { bash = 4 },
    flags = { "ELECTRONIC", "WATER_BREAK" },
    tool = { ammo_types = { "battery" } },
}
