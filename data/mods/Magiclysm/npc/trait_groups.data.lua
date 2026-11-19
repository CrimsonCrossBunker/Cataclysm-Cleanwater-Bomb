local ccb = require("ccb")

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

ccb.content.define_trait_group {
    id = "trait_group_manatouched",
    kind = "collection",
    entries = {
        { trait = "FEYHEARING", weight = 50 },
        { trait = "FASTREADER", weight = 50 },
        { trait = "FASTLEARNER", weight = 50 },
        { trait = "GOODMEMORY", weight = 50 },
        { trait = "SPIRITUAL", weight = 50 },
        { trait = "LOVES_BOOKS" },
        { trait = "BADCARDIO", weight = 50 },
        { trait = "SLOWHEALER", weight = 50 },
        { trait = "ASTHMA", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_manatouched_nonthres",
    kind = "collection",
    entries = {
        { trait = "MANA_ADD_MANATOUCHED", weight = 50 },
        { trait = "MANA_REGEN_MANATOUCHED", weight = 50 },
        { trait = "MANA_LUM", weight = 50 },
        { trait = "WEAK", weight = 50 },
        { trait = "ROT2", weight = 25 },
        { trait = "BIOLUM0", weight = 65 },
        { distribution = { { trait = "MANA_MULT3" }, { trait = "MANA_MULT_MANATOUCHED" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_manatouched_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_MANA" },
        { distribution = { { trait = "MANA_SIPHON_1" }, { trait = "MANA_SIPHON_2" } } },
        { trait = "MANA_SEEKER_BOLTS" },
        { trait = "ALBINO", weight = 50 },
        { trait = "MANA_CRYST_MANA", weight = 50 },
        { trait = "MANA_SUBTLE_SPELL", weight = 50 },
        { trait = "MANA_SILENT_SPELL", weight = 50 },
        { trait = "MANA_REGEN_MANATOUCHED", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_bdragon",
    kind = "collection",
    entries = {
        { trait = "GOODHEARING", weight = 50 },
        { distribution = { { trait = "DRAGON_STR" }, { trait = "DRAGON_STR2" }, { trait = "DRAGON_STR3" } } },
        { trait = "PAINRESIST", weight = 50 },
        { trait = "ANTIJUNK", weight = 50 },
        { trait = "NAUSEA", weight = 50 },
        { trait = "HUNGER", weight = 50 },
        { trait = "ADDICTIVE", weight = 50 },
        { trait = "CLUMSY", weight = 50 },
        { trait = "HOARDER", weight = 50 },
        { trait = "LIZ_EYE", weight = 50 },
        { trait = "LARGE_DRAGON", weight = 20 },
        { trait = "SCALES", weight = 30 },
        { trait = "THIRST2", weight = 40 },
        { trait = "CARNIVORE", weight = 70 },
        { trait = "DRAGONBLOOD", weight = 40 },
        { trait = "HISS", weight = 60 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_bdragon_nonthres",
    kind = "collection",
    entries = {
        { trait = "TERRIFYING", weight = 50 },
        { trait = "BADTEMPER", weight = 50 },
        { trait = "CHEMIMBALANCE", weight = 50 },
        { trait = "POISRESIST", weight = 50 },
        { trait = "TOE_CLAWS", weight = 50 },
        { trait = "SCALES", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_bdragon_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_DRAGON_BLACK" },
        { trait = "LIZ_IR", weight = 50 },
        { trait = "REGEN_LIZ", weight = 50 },
        { trait = "DRAGON_SCALES_BLACK", weight = 50 },
        { trait = "DRAGON_FEET", weight = 50 },
        { trait = "LARGE_OK_DRAGON", weight = 50 },
        { trait = "DRAGON_BREATH_BLACK", weight = 50 },
    },
}

-- 50% chance of an NPC to be an elf, dwarf, lizardfolk, etc.  It's a magical world.
ccb.content.define_trait_group {
    id = "NPC_starting_traits",
    kind = "collection",
    entries = {
        { group = "trait_group_fantasy_species", weight = 50 },
        { group = "trait_group_MANA_REGEN", weight = 15 },
        { group = "trait_group_MANA_MULT", weight = 5 },
        { group = "trait_group_MANA_ADD", weight = 10 },
        { group = "trait_group_SCHOOL_DEFICIENCY_SINGLE", weight = 15 },
        { group = "trait_group_SCHOOL_DEFICIENCY_MULTIPLE", weight = 2 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_fantasy_species",
    kind = "distribution",
    entries = {
        { group = "trait_group_elf_npc", weight = 2 },
        { group = "trait_group_dwarf_npc", weight = 3 },
        { group = "trait_group_goblin_npc", weight = 4 },
        { group = "trait_group_lizardfolk_npc", weight = 1 },
        { group = "trait_group_ravenfolk_npc", weight = 3 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_elf_npc",
    kind = "collection",
    entries = {
        { trait = "THRESH_SPECIES_ELF" },
        { trait = "ANIMALEMPATH2" },
        { trait = "ELVEN_BUILD" },
        { trait = "ELFA_NV" },
        { trait = "ELVEN_BEAUTY" },
        { trait = "ELVEN_SLEEP" },
        { trait = "ELFA_EARS" },
        { trait = "ELVEN_HEARING" },
        { trait = "LIGHTSTEP" },
        { trait = "WILDWALKER" },
        { trait = "ANTIJUNK" },
        { trait = "WEAKSTOMACH" },
        { trait = "DISIMMUNE" },
        { trait = "PICKYEATER" },
        { trait = "IRON_ALLERGY", weight = 15 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_dwarf_npc",
    kind = "collection",
    entries = {
        { trait = "THRESH_SPECIES_DWARF" },
        { trait = "DARKSIGHT" },
        { trait = "NIGHTVISION2" },
        { trait = "DWARVEN_BUILD" },
        { trait = "PAINRESIST" },
        { trait = "INFRESIST" },
        { trait = "DISRESISTANT" },
        { trait = "BORN_ARTISAN" },
        { trait = "ALCMET" },
        { trait = "TOLERANCE" },
        { trait = "GOODCARDIO" },
        { trait = "DENSE_BONES" },
        { trait = "TUNNEL_FIGHTER" },
        { trait = "TROGLO" },
        { trait = "HIRSUTE" },
        { trait = "GOURMAND" },
        { trait = "SMELLY" },
        { trait = "HEAVYSLEEPER2" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_goblin_npc",
    kind = "collection",
    entries = {
        { trait = "THRESH_SPECIES_GOBLIN" },
        { trait = "DARKSIGHT" },
        { trait = "GOBLIN_BUILD" },
        { trait = "GOBLIN_TEETH" },
        { trait = "NIGHTVISION3" },
        { trait = "SAPROVORE" },
        { trait = "SNOUT" },
        { trait = "NAILS" },
        { trait = "THICKSKIN" },
        { trait = "PAINREC2" },
        { trait = "GOODCARDIO" },
        { trait = "EATPOISON" },
        { trait = "TUNNEL_FIGHTER" },
        { trait = "NOCTURNAL" },
        { trait = "TROGLO2" },
        { trait = "MOODSWINGS" },
        { trait = "IRON_ALLERGY", weight = 5 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_lizardfolk_npc",
    kind = "collection",
    entries = {
        { trait = "THRESH_SPECIES_LIZARDFOLK" },
        { trait = "LIZARDFOLK_BUILD" },
        { trait = "SCALES" },
        { trait = "MEMBRANE" },
        { trait = "COLDBLOOD4_LIZ" },
        { trait = "FORKED_TONGUE" },
        { trait = "HISS" },
        { trait = "GILLS" },
        { trait = "ANTIWHEAT" },
        { trait = "ANTIJUNK" },
        { trait = "TAIL_THICK" },
        { trait = "RESISTWARM" },
        { trait = "LIZ_EYE" },
        { trait = "REGEN_LIZ" },
        { trait = "MUZZLE_LONG" },
        { trait = "WEBBED_LIZ_FEET" },
        { trait = "TALONS" },
        { trait = "SLIT_NOSTRILS" },
        { trait = "PRED_LIZ" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_ravenfolk_npc",
    kind = "collection",
    entries = {
        { trait = "THRESH_SPECIES_RAVENFOLK" },
        { trait = "RAVENFOLK_BUILD" },
        { trait = "RAVENFOLK_WINGS" },
        { trait = "DOWN" },
        { trait = "BEAK_RAVEN" },
        { trait = "RAVENFOLK_LEGS" },
        { trait = "RAVENFOLK_EYES" },
        { trait = "PER_UP_3" },
        { trait = "FLEET" },
        { trait = "FEATHERS" },
        { trait = "GOODMEMORY" },
        { trait = "EAGLEEYED" },
        { trait = "TALONS" },
        { trait = "LIGHT_BONES" },
        { trait = "RAVEN_BONES" },
        { trait = "NOMAD" },
        { trait = "HOARDER" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_MANA_REGEN",
    kind = "distribution",
    entries = {
        { trait = "MANA_REGEN1", weight = 100 },
        { trait = "MANA_REGEN2", weight = 15 },
        { trait = "BAD_MANA_REGEN1", weight = 100 },
        { trait = "BAD_MANA_REGEN2", weight = 15 },
        { trait = "BAD_MANA_REGEN3", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_MANA_MULT",
    kind = "distribution",
    entries = {
        { trait = "MANA_MULT1", weight = 100 },
        { trait = "MANA_MULT2", weight = 15 },
        { trait = "MANA_MULT3", weight = 1 },
        { trait = "BAD_MANA_MULT1", weight = 100 },
        { trait = "BAD_MANA_MULT2", weight = 15 },
        { trait = "BAD_MANA_MULT3", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_MANA_ADD",
    kind = "distribution",
    entries = {
        { trait = "MANA_ADD1", weight = 100 },
        { trait = "MANA_ADD2", weight = 15 },
        { trait = "MANA_ADD3", weight = 1 },
        { trait = "MANA_SUB1", weight = 100 },
        { trait = "MANA_SUB2", weight = 15 },
        { trait = "MANA_SUB3", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_SCHOOL_DEFICIENCY_SINGLE",
    kind = "distribution",
    entries = {
        { trait = "NO_CASTING_CHANNELING_SPELLS", weight = 1 },
        { trait = "NO_CASTING_EVOCATION_SPELLS", weight = 1 },
        { trait = "NO_CASTING_CONJURATION_SPELLS", weight = 1 },
        { trait = "NO_CASTING_ENHANCEMENT_SPELLS", weight = 1 },
        { trait = "NO_CASTING_ENERVATION_SPELLS", weight = 1 },
        { trait = "NO_CASTING_CONVEYANCE_SPELLS", weight = 1 },
        { trait = "NO_CASTING_RESTORATION_SPELLS", weight = 1 },
        { trait = "NO_CASTING_TRANSFORMATION_SPELLS", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_SCHOOL_DEFICIENCY_MULTIPLE",
    kind = "collection",
    entries = {
        { trait = "NO_CASTING_CHANNELING_SPELLS", weight = 25 },
        { trait = "NO_CASTING_EVOCATION_SPELLS", weight = 25 },
        { trait = "NO_CASTING_CONJURATION_SPELLS", weight = 25 },
        { trait = "NO_CASTING_ENHANCEMENT_SPELLS", weight = 25 },
        { trait = "NO_CASTING_ENERVATION_SPELLS", weight = 25 },
        { trait = "NO_CASTING_CONVEYANCE_SPELLS", weight = 25 },
        { trait = "NO_CASTING_RESTORATION_SPELLS", weight = 25 },
        { trait = "NO_CASTING_TRANSFORMATION_SPELLS", weight = 25 },
    },
}
