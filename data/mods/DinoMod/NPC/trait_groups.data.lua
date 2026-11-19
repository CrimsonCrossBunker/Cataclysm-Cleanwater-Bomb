local ccb = require("ccb")

ccb.content.define_trait_group {
    id = "trait_group_dino",
    kind = "collection",
    entries = {
        { trait = "TOUGH_FEET", weight = 50 },
        { trait = "THICKSKIN", weight = 50 },
        { trait = "PAINRESIST", weight = 50 },
        { trait = "ANTIJUNK", weight = 50 },
        { trait = "THICKSKIN2", weight = 40 },
        { trait = "UGLY", weight = 60 },
        { trait = "LIZ_EYE", weight = 50 },
        { trait = "SCALES", weight = 50 },
        { trait = "NAILS", weight = 50 },
        { trait = "CLAWS", weight = 20 },
        { trait = "STRONGBACKDINO", weight = 50 },
        { trait = "TAIL_LONG", weight = 50 },
        { trait = "STR_UP" },
        { trait = "SLIT_NOSTRILS", weight = 50 },
        { trait = "FORKED_TONGUE", weight = 50 },
        { trait = "HUNGER2", weight = 50 },
        { trait = "LARGE", weight = 50 },
        { trait = "COLDBLOOD2", weight = 50 },
        { trait = "HISS", weight = 50 },
        { trait = "SHOUT1", weight = 50 },
        { trait = "PONDEROUS2", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_stego_nonthres",
    kind = "collection",
    entries = {
        { trait = "FANGS", weight = 50 },
        { trait = "TOUGH", weight = 70 },
        { trait = "ANIMALEMPATH", weight = 50 },
        { trait = "HUGE", weight = 50 },
        { trait = "VEGETARIAN", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_stego_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_STEGO" },
        { distribution = { { trait = "TOUGH3" }, { trait = "TOUGH2" } } },
        { trait = "COLDBLOOD4", weight = 50 },
        { distribution = { { trait = "MUT_TOUGH3" }, { trait = "MUT_TOUGH2" }, { trait = "MUT_TOUGH" } } },
        { trait = "PER_UP_3" },
        { trait = "GRAZER", weight = 50 },
        { trait = "HUGE_OK", weight = 20 },
        { trait = "LARGE_OK", weight = 40 },
        { trait = "TAIL_HORNED", weight = 40 },
        { trait = "THICKSKIN3", weight = 50 },
        { distribution = { { trait = "GRAZER" }, { trait = "RUMINANT" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_tyrant_nonthres",
    kind = "collection",
    entries = {
        { trait = "FANGS", weight = 50 },
        { trait = "QUICK", weight = 50 },
        { trait = "DEX_UP_2" },
        { trait = "CARNIVORE", weight = 50 },
        { trait = "ANIMALDISCORD", weight = 50 },
        { trait = "HUGE", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_tyrant_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_TYRANT" },
        {
            distribution = {
                { trait = "PRED3" },
                { trait = "PRED2" },
                { trait = "PRED4" },
                { trait = "PRED1" },
            },
        },
        { trait = "SAPIOVORE", weight = 50 },
        { trait = "GLASSJAW", weight = 50 },
        { trait = "ANIMALDISCORD", weight = 50 },
        { trait = "HUGE_OK", weight = 20 },
        { trait = "LARGE_OK", weight = 40 },
        { trait = "TYRANT_TEETH", weight = 40 },
        { trait = "COLDBLOOD4", weight = 50 },
        { distribution = { { trait = "MUT_TOUGH2" }, { trait = "MUT_TOUGH" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_mutant_npc_common",
    kind = "collection",
    entries = {
        { distribution = { { trait = "FASTLEARNER" }, { trait = "SLOWLEARNER" } }, weight = 10 },
        {
            distribution = {
                { trait = "FASTREADER" },
                { trait = "SLOWREADER" },
                { trait = "ILLITERATE", weight = 5 },
            },
            weight = 10,
        },
        { distribution = { { trait = "GOODCARDIO" }, { trait = "BADKNEES" } }, weight = 10 },
        { distribution = { { trait = "LIAR" }, { trait = "TRUTHTELLER" } }, weight = 10 },
        {
            distribution = {
                { trait = "MARTIAL_ARTS" },
                { trait = "MARTIAL_ARTS2" },
                { trait = "MARTIAL_ARTS3" },
                { trait = "MARTIAL_ARTS4" },
                { trait = "MARTIAL_ARTS5" },
            },
            weight = 10,
        },
        { trait = "DEFT", weight = 10 },
        { trait = "ADRENALINE", weight = 10 },
        { trait = "OUTDOORSMAN", weight = 10 },
        { trait = "PAINRESIST", weight = 10 },
        { trait = "QUICK", weight = 10 },
        { trait = "ROBUST", weight = 10 },
        { trait = "SPIRITUAL", weight = 10 },
        { trait = "ALBINO", weight = 5 },
        { trait = "ASTHMA", weight = 5 },
        { trait = "CHEMIMBALANCE", weight = 10 },
        { trait = "HOARDER", weight = 10 },
        { trait = "JITTERY", weight = 10 },
        { trait = "MOODSWINGS", weight = 10 },
        { trait = "SAVANT", weight = 10 },
        { trait = "SCHIZOPHRENIC", weight = 10 },
        { trait = "SQUEAMISH", weight = 10 },
        { group = "Appearance_demographics", weight = 100 },
    },
}
