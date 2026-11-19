local ccb = require("ccb")

ccb.content.define_trait_group {
    id = "trait_group_spider",
    kind = "collection",
    entries = {
        { trait = "FLEET", weight = 50 },
        { trait = "POISRESIST", weight = 50 },
        { trait = "NIGHTVISION3", weight = 50 },
        { trait = "INFRARED", weight = 50 },
        { trait = "WEB_WALKER", weight = 50 },
        { trait = "DEX_UP_2" },
        { trait = "TROGLO", weight = 50 },
        { trait = "CARNIVORE", weight = 50 },
        { trait = "COLDBLOOD", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_spider_nonthres",
    kind = "collection",
    entries = {
        { trait = "POISONOUS", weight = 50 },
        { trait = "MANDIBLES", weight = 50 },
        { distribution = { { trait = "CHITIN3" }, { trait = "CHITIN_FUR2" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_spider_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_SPIDER" },
        { distribution = { { trait = "ARACHNID_ARMS" }, { trait = "ARACHNID_ARMS_OK" } } },
        { trait = "CHITIN_FUR3" },
        { trait = "CF_HAIR", weight = 50 },
        { trait = "POISONOUS2", weight = 50 },
        { trait = "PRED3", weight = 50 },
        { trait = "SAPIOVORE", weight = 50 },
        { trait = "FANGS_SPIDER", weight = 50 },
        {
            distribution = {
                { trait = "WEB_SPINNER" },
                { collection = { { trait = "WEB_WEAVER" }, { trait = "WEB_RAPPEL" }, { trait = "WEB_ROPE" } } },
            },
        },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_snail",
    kind = "collection",
    entries = {
        { trait = "LIGHTEATER", weight = 50 },
        { trait = "EASYSLEEPER", weight = 50 },
        { trait = "BADHEARING", weight = 50 },
        { trait = "INFRESIST", weight = 50 },
        { trait = "THICKSKIN", weight = 50 },
        { trait = "THIRST", weight = 50 },
        { trait = "DEFORMED2", weight = 50 },
        { trait = "SLIMY" },
        { trait = "COLDBLOOD", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_snail_nonthres",
    kind = "collection",
    entries = {
        { trait = "THICKSKIN", weight = 50 },
        { trait = "SLIME_SPRAY", weight = 50 },
        { trait = "SHELL", weight = 50 },
        { distribution = { { trait = "EYESTALKS1" }, { trait = "EYESTALKS2" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_snail_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_GASTROPOD" },
        {
            distribution = {
                { trait = "GASTROPOD_EXTREMITY1" },
                { trait = "GASTROPOD_EXTREMITY2" },
                { trait = "GASTROPOD_EXTREMITY2" },
            },
        },
        { trait = "GASTROPOD_FOOT" },
        { trait = "GASTROPOD_BALANCE", weight = 50 },
        { distribution = { { trait = "MUCUS_SECRETION" }, { trait = "MUCUS_SECRETION2" } } },
        { trait = "VISCOUS", weight = 50 },
        { distribution = { { trait = "SHELL2" }, { trait = "SHELL3" } } },
        { trait = "TOXICFLESH", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_rabbit",
    kind = "collection",
    entries = {
        { trait = "FLEET", weight = 50 },
        { trait = "QUICK", weight = 50 },
        { trait = "GOODHEARING", weight = 50 },
        { trait = "EASYSLEEPER", weight = 50 },
        { trait = "DEFT", weight = 50 },
        { trait = "SLEEPY", weight = 50 },
        { trait = "PRETTY", weight = 50 },
        { trait = "FORGETFUL" },
        { trait = "ADDICTIVE", weight = 50 },
        { trait = "RABBIT_EARS", weight = 50 },
        { trait = "TAIL_RABBIT", weight = 50 },
        { trait = "RABBIT_FEET", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_rabbit_nonthres",
    kind = "collection",
    entries = {
        { trait = "ANIMALDISCORD2", weight = 50 },
        { trait = "JITTERY", weight = 50 },
        { trait = "ALBINO", weight = 50 },
        { trait = "STRONG_LEGS", weight = 50 },
        { trait = "DEX_UP_2", weight = 50 },
        { distribution = { { trait = "LIGHT_BONES" }, { trait = "LIGHTFUR" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_rabbit_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_RABBIT" },
        {
            distribution = {
                { trait = "GASTROPOD_EXTREMITY1" },
                { trait = "GASTROPOD_EXTREMITY2" },
                { trait = "GASTROPOD_EXTREMITY2" },
            },
        },
        { trait = "GOODCARDIO2" },
        { trait = "LEAPING_LEGS", weight = 50 },
        { distribution = { { trait = "BURROW" }, { trait = "SMALL" } } },
        { trait = "EASYSLEEPER2", weight = 50 },
        { distribution = { { trait = "FLIMSY" }, { trait = "MET_RAT" } } },
        { trait = "GRAZER", weight = 50 },
        { trait = "RABBIT_FUR", weight = 50 },
        { trait = "INCISORS", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_frog",
    kind = "collection",
    entries = {
        { trait = "NIGHTVISION", weight = 50 },
        { trait = "NONADDICTIVE", weight = 50 },
        { trait = "STRONGKNEES", weight = 50 },
        { trait = "FASTHEALER2", weight = 50 },
        { trait = "DEFT", weight = 50 },
        { trait = "SPOTS", weight = 50 },
        { trait = "EYEBULGE", weight = 50 },
        { trait = "WIDE_MOUTH" },
        { trait = "SMELLY2", weight = 50 },
        { trait = "VOMITOUS", weight = 50 },
        { trait = "THIRST3", weight = 50 },
        { trait = "WEBBED", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_frog_nonthres",
    kind = "collection",
    entries = {
        { trait = "DIRTSLEEPER", weight = 50 },
        { trait = "LEAPING_LEGS", weight = 50 },
        { trait = "HYPEROPIC", weight = 50 },
        { trait = "STRONG_LEGS", weight = 50 },
        { trait = "DEX_UP_2", weight = 50 },
        { trait = "COLDBLOOD3", weight = 50 },
        { trait = "UGLY", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_frog_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_BATRACHIAN" },
        { distribution = { { trait = "MEMBRANE" }, { trait = "GILLS" }, { trait = "PHEROMONE_AMPHIBIAN" } } },
        { trait = "WATERSLEEPER" },
        { trait = "VOMITSTOMACH", weight = 50 },
        { distribution = { { trait = "PRED1" }, { trait = "PER_UP_2" } } },
        { trait = "WAKEFUL2", weight = 50 },
        { distribution = { { trait = "LONG_TONGUE" }, { trait = "LONG_TONGUE2" } } },
        { trait = "LEAPING_LEGS2", weight = 50 },
        { trait = "EATPOISON", weight = 50 },
        { trait = "COLDBLOOD4", weight = 50 },
        { trait = "FROG_EYES", weight = 50 },
        { trait = "MUT_TOUGH", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_alpha",
    kind = "collection",
    entries = {
        { trait = "GOODHEARING", weight = 50 },
        { trait = "ROBUST", weight = 50 },
        { trait = "PRETTY", weight = 50 },
        { trait = "ANTIJUNK", weight = 50 },
        { trait = "NAUSEA", weight = 50 },
        { trait = "HUNGER", weight = 50 },
        { trait = "ROT3", weight = 50 },
        { trait = "STR_ALPHA" },
        { trait = "DEX_ALPHA" },
        { trait = "INT_ALPHA" },
        { trait = "PER_ALPHA" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_alpha_nonthres",
    kind = "collection",
    entries = { { trait = "WAKEFUL", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_alpha_postthres",
    kind = "collection",
    entries = { { trait = "THRESH_ALPHA" }, { trait = "WAKEFUL2", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_fish",
    kind = "collection",
    entries = {
        { trait = "GOODCARDIO", weight = 50 },
        { trait = "QUICK", weight = 50 },
        { trait = "LIGHTEATER", weight = 50 },
        { trait = "ROBUST", weight = 50 },
        { trait = "NIGHTVISION3", weight = 50 },
        { trait = "FANGS", weight = 50 },
        { trait = "MEMBRANE", weight = 50 },
        { trait = "GILLS", weight = 50 },
        { trait = "SLEEK_SCALES", weight = 50 },
        { trait = "TAIL_FIN", weight = 50 },
        { trait = "SMELLY2", weight = 50 },
        { trait = "DEFORMED", weight = 50 },
        { trait = "THIRST2", weight = 50 },
        { trait = "WEBBED", weight = 50 },
        { trait = "SLIMY", weight = 50 },
        { trait = "COLDBLOOD", weight = 50 },
        { trait = "DEX_UP_4" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_fish_nonthres",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_fish_postthres",
    kind = "collection",
    entries = { { trait = "THRESH_FISH" } },
}

ccb.content.define_trait_group {
    id = "trait_group_lupine",
    kind = "collection",
    entries = {
        { trait = "GOODCARDIO", weight = 50 },
        { trait = "SMELLY", weight = 50 },
        { distribution = { { trait = "UGLY" }, { trait = "DEFORMED" }, { trait = "PRETTY" } } },
        { trait = "ANIMALDISCORD", weight = 50 },
        { trait = "NIGHTVISION2", weight = 50 },
        { trait = "FANGS", weight = 50 },
        { trait = "LUPINE_FUR", weight = 50 },
        { trait = "PADDED_FEET", weight = 50 },
        { trait = "TAIL_FLUFFY", weight = 50 },
        { trait = "LUPINE_EARS", weight = 50 },
        { trait = "STR_UP_3" },
        { trait = "MUZZLE", weight = 50 },
        { trait = "HEAVYSLEEPER2", weight = 50 },
        { trait = "PAWS", weight = 50 },
        { trait = "GROWL", weight = 50 },
        { trait = "SHOUT3", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_lupine_nonthres",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_lupine_postthres",
    kind = "collection",
    entries = { { trait = "THRESH_LUPINE" }, { trait = "PRED3", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_bird",
    kind = "collection",
    entries = {
        { trait = "QUICK", weight = 50 },
        { trait = "LIGHTEATER", weight = 50 },
        { trait = "NIGHTVISION", weight = 50 },
        { trait = "DEFT", weight = 50 },
        { trait = "LIGHTSTEP", weight = 50 },
        { trait = "BADBACK", weight = 50 },
        { trait = "GLASSJAW", weight = 50 },
        { trait = "BIRD_EYE", weight = 50 },
        { trait = "FEATHERS", weight = 50 },
        { trait = "WINGS_BIRD", weight = 50 },
        { trait = "DEX_UP_3" },
        { trait = "HOLLOW_BONES", weight = 50 },
        { trait = "PER_UP_4" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_bird_nonthres",
    kind = "collection",
    entries = { { trait = "BEAK", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_bird_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_BIRD" },
        { trait = "DOWN", weight = 50 },
        { trait = "TALONS", weight = 50 },
        { trait = "GIZZARD", weight = 50 },
        { trait = "FLEET2", weight = 50 },
        { distribution = { { trait = "BEAK_PECK", weight = 50 }, { trait = "BEAK_HUM", weight = 50 } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_insect",
    kind = "collection",
    entries = {
        { trait = "QUICK", weight = 50 },
        { trait = "LIGHTEATER", weight = 50 },
        { trait = "NIGHTVISION", weight = 50 },
        { trait = "POISRESIST", weight = 50 },
        { trait = "TERRIFYING", weight = 50 },
        { trait = "HEAVYSLEEPER", weight = 50 },
        { trait = "NIGHTVISION2", weight = 50 },
        { trait = "INFRARED", weight = 50 },
        { trait = "CHITIN2", weight = 50 },
        { trait = "PHEROMONE_INSECT", weight = 50 },
        { trait = "COMPOUND_EYES", weight = 50 },
        { trait = "ANTENNAE", weight = 50 },
        { trait = "TAIL_STING", weight = 50 },
        { trait = "MANDIBLES", weight = 50 },
        { trait = "STR_UP", weight = 50 },
        { trait = "DEX_UP" },
        { trait = "DEFORMED", weight = 50 },
        { trait = "TROGLO", weight = 50 },
        { trait = "COLDBLOOD3", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_insect_nonthres",
    kind = "collection",
    entries = { { trait = "WINGS_INSECT", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_insect_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_INSECT" },
        {
            distribution = {
                { trait = "WINGS_BUTTERFLY", weight = 50 },
                { trait = "WINGS_INSECT", weight = 50 },
            },
        },
        { trait = "PROBOSCIS", weight = 50 },
        {
            distribution = {
                { trait = "INSECT_ARMS", weight = 50 },
                { trait = "INSECT_ARMS_OK", weight = 50 },
            },
        },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_troglobite",
    kind = "collection",
    entries = {
        { trait = "QUICK", weight = 50 },
        { trait = "LIGHTEATER", weight = 50 },
        { trait = "MYOPIC", weight = 50 },
        { trait = "NIGHTVISION3", weight = 50 },
        { trait = "INFRARED", weight = 50 },
        { trait = "REGEN", weight = 50 },
        { trait = "DISIMMUNE", weight = 50 },
        { trait = "INFRESIST", weight = 50 },
        { trait = "POISONOUS", weight = 50 },
        { trait = "ALCMET", weight = 50 },
        { trait = "SAPROVORE", weight = 50 },
        { trait = "STR_UP_3" },
        { trait = "SUNBURN", weight = 50 },
        { trait = "TROGLO3", weight = 50 },
        { trait = "SLIMY", weight = 50 },
        { trait = "STOCKY_TROGLO" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_troglobite_nonthres",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_troglobite_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_TROGLOBITE" },
        { trait = "PAINRESIST_TROGLO", weight = 50 },
        { trait = "EATPOISON", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_chimera",
    kind = "collection",
    entries = {
        { trait = "QUICK", weight = 50 },
        { trait = "THICKSKIN", weight = 50 },
        { trait = "TERRIFYING", weight = 50 },
        { trait = "ADRENALINE", weight = 50 },
        { trait = "SLEEPY", weight = 50 },
        { trait = "BADTEMPER", weight = 50 },
        { trait = "FORGETFUL", weight = 50 },
        { trait = "CHEMIMBALANCE", weight = 50 },
        { trait = "NIGHTVISION2", weight = 50 },
        { trait = "SCALES", weight = 50 },
        { trait = "LIGHTFUR", weight = 50 },
        { trait = "TALONS", weight = 50 },
        { trait = "PARAIMMUNE", weight = 50 },
        { trait = "HOOVES", weight = 50 },
        { trait = "SAPROVORE", weight = 50 },
        { trait = "HORNS_CURLED", weight = 50 },
        { trait = "TAIL_CLUB", weight = 50 },
        { trait = "CANINE_EARS", weight = 50 },
        { trait = "STR_UP_3" },
        { trait = "DEX_UP_2" },
        { trait = "PER_UP_2" },
        { trait = "MOUTH_FLAPS", weight = 50 },
        { trait = "SMELLY2", weight = 50 },
        { trait = "DEFORMED3", weight = 50 },
        { trait = "HUNGER3", weight = 50 },
        { trait = "THIRST", weight = 50 },
        { trait = "ROT2", weight = 50 },
        { distribution = { { trait = "UNSTABLE", weight = 10 }, { trait = "CHAOTIC", weight = 10 } } },
        { trait = "CARNIVORE", weight = 50 },
        { trait = "SNARL", weight = 50 },
        { trait = "SHOUT3", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_chimera_nonthres",
    kind = "collection",
    entries = { { trait = "FANGS", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_chimera_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_CHIMERA" },
        { trait = "PRED4", weight = 50 },
        { trait = "SAPIOVORE", weight = 50 },
        { trait = "MUT_JUNKIE", weight = 50 },
        { trait = "MUT_TOUGH2", weight = 50 },
        { trait = "EATPOISON", weight = 50 },
        { trait = "EATDEAD", weight = 50 },
        { trait = "SABER_TEETH", weight = 50 },
        { trait = "EATHEALTH", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_raptor",
    kind = "collection",
    entries = {
        { trait = "QUICK", weight = 50 },
        { trait = "THICKSKIN", weight = 50 },
        { trait = "DEFT", weight = 50 },
        { trait = "ANTIJUNK", weight = 50 },
        { trait = "GLASSJAW", weight = 50 },
        { trait = "ANIMALDISCORD", weight = 50 },
        { trait = "UGLY", weight = 50 },
        { trait = "LIZ_EYE", weight = 50 },
        { trait = "SCALES", weight = 50 },
        { trait = "NAILS", weight = 50 },
        { trait = "RAP_TALONS", weight = 50 },
        { trait = "TAIL_RAPTOR", weight = 50 },
        { trait = "STR_UP" },
        { trait = "DEX_UP_2" },
        { trait = "PER_UP_3" },
        { trait = "SLIT_NOSTRILS", weight = 50 },
        { trait = "FORKED_TONGUE", weight = 50 },
        { trait = "HUNGER2", weight = 50 },
        { trait = "CARNIVORE", weight = 50 },
        { trait = "COLDBLOOD2", weight = 50 },
        { trait = "HISS", weight = 50 },
        { trait = "SHOUT1", weight = 50 },
        { trait = "ARM_FEATHERS", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_raptor_nonthres",
    kind = "collection",
    entries = { { trait = "FANGS", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_raptor_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_RAPTOR" },
        { trait = "PRED4", weight = 50 },
        { trait = "SAPIOVORE", weight = 50 },
        { trait = "EATPOISON", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_medical",
    kind = "collection",
    entries = {
        { trait = "FASTHEALER", weight = 50 },
        { trait = "POISRESIST", weight = 50 },
        { trait = "DISRESISTANT", weight = 50 },
        { trait = "MASOCHIST", weight = 50 },
        { trait = "ROBUST", weight = 50 },
        { trait = "HEAVYSLEEPER", weight = 50 },
        { trait = "INSOMNIA", weight = 50 },
        { trait = "FORGETFUL", weight = 50 },
        { trait = "LIGHTWEIGHT", weight = 50 },
        { trait = "ADDICTIVE", weight = 50 },
        { trait = "CHEMIMBALANCE", weight = 50 },
        { trait = "SCHIZOPHRENIC", weight = 50 },
        { trait = "JITTERY", weight = 50 },
        { trait = "MOODSWINGS", weight = 50 },
        { trait = "RADIOGENIC", weight = 50 },
        { trait = "INFIMMUNE", weight = 50 },
        { trait = "PARAIMMUNE", weight = 50 },
        { trait = "PAINREC3", weight = 50 },
        { trait = "VOMITOUS", weight = 50 },
        { trait = "HUNGER", weight = 50 },
        { trait = "UNSTABLE", weight = 10 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_medical_nonthres",
    kind = "collection",
    entries = { { trait = "PAINRESIST", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_medical_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_MEDICAL", weight = 50 },
        { trait = "MUT_TOUGH2", weight = 50 },
        { trait = "CENOBITE", weight = 50 },
        { trait = "NOPAIN", weight = 50 },
        { trait = "MUT_JUNKIE", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_cattle",
    kind = "collection",
    entries = {
        { trait = "NIGHTVISION", weight = 50 },
        { trait = "THICKSKIN", weight = 50 },
        { trait = "DISRESISTANT", weight = 50 },
        { trait = "FUR", weight = 50 },
        { trait = "HOOVES", weight = 50 },
        { trait = "HORNS", weight = 50 },
        { trait = "TAIL_CATTLE", weight = 50 },
        { trait = "CANINE_EARS", weight = 50 },
        { trait = "STR_UP_2" },
        { trait = "DEFORMED", weight = 50 },
        { trait = "MINOTAUR", weight = 50 },
        { trait = "PONDEROUS2", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_cattle_nonthres",
    kind = "collection",
    entries = { { trait = "RUMINANT", weight = 50 }, { trait = "HUGE" } },
}

ccb.content.define_trait_group {
    id = "trait_group_cattle_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_CATTLE" },
        { trait = "GRAZER", weight = 50 },
        { trait = "HUGE_OK" },
        { trait = "MUT_TOUGH3", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_slime",
    kind = "collection",
    entries = {
        { trait = "POISRESIST", weight = 50 },
        { trait = "ROBUST", weight = 50 },
        { trait = "CHEMIMBALANCE", weight = 50 },
        { trait = "REGEN", weight = 50 },
        { trait = "RADIOGENIC", weight = 50 },
        { trait = "DISIMMUNE", weight = 50 },
        { trait = "PARAIMMUNE", weight = 50 },
        { trait = "POISONOUS", weight = 50 },
        { trait = "SLIME_HANDS", weight = 50 },
        { trait = "DEX_UP" },
        { trait = "DEFORMED3", weight = 50 },
        { trait = "HOLLOW_BONES", weight = 50 },
        { trait = "VOMITOUS", weight = 50 },
        { trait = "HUNGER2", weight = 50 },
        { trait = "THIRST2", weight = 50 },
        { trait = "SORES", weight = 50 },
        { trait = "TROGLO", weight = 50 },
        { trait = "WEBBED", weight = 50 },
        { trait = "UNSTABLE", weight = 10 },
        { trait = "RADIOACTIVE1", weight = 0 },
        { trait = "SLIMY", weight = 50 },
        { trait = "INT_SLIME" },
        { trait = "BENDY3" },
        { trait = "PER_SLIME_OK" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_slime_nonthres",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_slime_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_SLIME" },
        { trait = "VISCOUS", weight = 50 },
        { trait = "AMORPHOUS", weight = 50 },
        { trait = "SLIMESPAWNER", weight = 50 },
        { trait = "SMELLY2", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_lizard",
    kind = "collection",
    entries = {
        { trait = "THICKSKIN", weight = 50 },
        { trait = "BADTEMPER", weight = 50 },
        { trait = "LIZ_EYE", weight = 50 },
        { trait = "REGEN_LIZ", weight = 50 },
        { trait = "FANGS", weight = 50 },
        { trait = "MEMBRANE", weight = 50 },
        { trait = "TAIL_THICK", weight = 50 },
        { trait = "STR_UP_2" },
        { trait = "DEX_UP_2" },
        { trait = "SLIT_NOSTRILS", weight = 50 },
        { trait = "FORKED_TONGUE", weight = 50 },
        { trait = "MUZZLE_LONG", weight = 50 },
        { trait = "TROGLO", weight = 50 },
        { trait = "WEBBED", weight = 50 },
        { trait = "HISS", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_lizard_nonthres",
    kind = "collection",
    entries = {
        { trait = "SCALES", weight = 50 },
        { trait = "LARGE" },
        { trait = "CARNIVORE", weight = 50 },
        { trait = "COLDBLOOD3", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_lizard_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_LIZARD" },
        { trait = "THICK_SCALES", weight = 50 },
        { trait = "TALONS", weight = 50 },
        { trait = "MUT_TOUGH", weight = 50 },
        { trait = "PRED3", weight = 50 },
        { trait = "SAPIOVORE", weight = 50 },
        { trait = "LARGE_OK" },
        { trait = "COLDBLOOD4", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_beast",
    kind = "collection",
    entries = {
        { trait = "DEFT", weight = 50 },
        { trait = "ANIMALEMPATH", weight = 50 },
        { trait = "TERRIFYING", weight = 50 },
        { trait = "ADRENALINE", weight = 50 },
        { trait = "MYOPIC", weight = 50 },
        { trait = "SLEEPY", weight = 50 },
        { trait = "ANTIJUNK", weight = 50 },
        { trait = "FORGETFUL", weight = 50 },
        { trait = "ANIMALDISCORD", weight = 50 },
        { trait = "NIGHTVISION2", weight = 50 },
        { trait = "FUR", weight = 50 },
        { trait = "CLAWS", weight = 50 },
        { trait = "PADDED_FEET", weight = 50 },
        { trait = "TAIL_FLUFFY", weight = 50 },
        { trait = "CANINE_EARS", weight = 50 },
        { trait = "SMELLY2", weight = 50 },
        { trait = "DEFORMED2", weight = 50 },
        { trait = "MUZZLE", weight = 50 },
        { trait = "HUNGER2", weight = 50 },
        { trait = "HEAVYSLEEPER2", weight = 50 },
        { trait = "TROGLO", weight = 50 },
        { trait = "PAWS_LARGE", weight = 50 },
        { trait = "SNARL", weight = 50 },
        { trait = "SHOUT2", weight = 50 },
        { trait = "STR_UP_4" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_beast_nonthres",
    kind = "collection",
    entries = { { trait = "CARNIVORE", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_beast_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_BEAST" },
        { trait = "MUT_TOUGH", weight = 50 },
        { trait = "PRED4", weight = 50 },
        { trait = "SAPIOVORE", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_rat",
    kind = "collection",
    entries = {
        { trait = "DISRESISTANT", weight = 50 },
        { trait = "NIGHTVISION2", weight = 50 },
        { trait = "INCISORS", weight = 50 },
        { trait = "FUR", weight = 50 },
        { trait = "TAIL_RAT", weight = 50 },
        { trait = "WHISKERS_RAT", weight = 50 },
        { trait = "DEFORMED3", weight = 50 },
        { trait = "MUZZLE_RAT", weight = 50 },
        { trait = "VOMITOUS", weight = 50 },
        { trait = "MET_RAT", weight = 50 },
        { trait = "PAWS", weight = 50 },
        { trait = "GROWL", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_rat_nonthres",
    kind = "collection",
    entries = { { trait = "CLAWS_RAT", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_rat_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_RAT" },
        { trait = "CLAWS_ST", weight = 50 },
        { trait = "BURROW", weight = 50 },
        { trait = "INFRESIST", weight = 50 },
        { trait = "EATDEAD", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_mouse",
    kind = "collection",
    entries = {
        { trait = "DISRESISTANT", weight = 50 },
        { trait = "NIGHTVISION2", weight = 50 },
        { trait = "FELINE_FUR", weight = 50 },
        { trait = "TAIL_RAT", weight = 50 },
        { trait = "MET_RAT", weight = 50 },
        { trait = "ANIMALDISCORD2", weight = 50 },
        { trait = "WHISKERS_RAT", weight = 50 },
        { trait = "PROJUNK", weight = 50 },
        { trait = "SMALL2", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_mouse_nonthres",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_mouse_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_MOUSE" },
        { trait = "GOODCARDIO2", weight = 50 },
        { trait = "SMALL_OK", weight = 50 },
        { trait = "INFRESIST", weight = 50 },
        { trait = "PROJUNK2", weight = 50 },
        { trait = "EASYSLEEPER2", weight = 50 },
        { trait = "CRAFTY", weight = 50 },
        { trait = "EATDEAD", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_elfa",
    kind = "collection",
    entries = {
        { trait = "LIGHTSTEP", weight = 50 },
        { trait = "WEAKSCENT", weight = 50 },
        { trait = "BADBACK", weight = 50 },
        { trait = "CHEMIMBALANCE", weight = 50 },
        { trait = "ELFAEYES", weight = 50 },
        { trait = "ELFA_FNV", weight = 50 },
        { trait = "PLANTSKIN", weight = 50 },
        { trait = "LEAVES", weight = 50 },
        { trait = "PARAIMMUNE", weight = 50 },
        { trait = "ELFA_EARS", weight = 50 },
        { trait = "STR_UP" },
        { trait = "DEX_UP_3" },
        { trait = "INT_UP_3" },
        { trait = "PER_UP_3" },
        { trait = "BEAUTIFUL3", weight = 50 },
        { trait = "HOLLOW_BONES", weight = 50 },
        { trait = "VOMITOUS", weight = 50 },
        { trait = "HUNGER", weight = 50 },
        { trait = "THIRST", weight = 50 },
        { trait = "ROT1", weight = 50 },
        { trait = "RADIOACTIVE2", weight = 0 },
        { trait = "BENDY1" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_elfa_nonthres",
    kind = "collection",
    entries = { { trait = "WAKEFUL", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_elfa_postthres",
    kind = "collection",
    entries = { { trait = "THRESH_ELFA" }, { trait = "WAKEFUL3", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_feline",
    kind = "collection",
    entries = {
        { trait = "LIGHTSTEP", weight = 50 },
        { trait = "SMELLY", weight = 50 },
        { distribution = { { trait = "PRETTY" }, { trait = "DEFORMED" }, { trait = "UGLY" } } },
        { trait = "FEL_EYE", weight = 50 },
        { trait = "FEL_NV", weight = 50 },
        { trait = "FELINE_FUR", weight = 50 },
        { trait = "LYNX_FUR", weight = 50 },
        { trait = "CLAWS_RETRACT", weight = 50 },
        { trait = "PADDED_FEET", weight = 50 },
        { trait = "FELINE_EARS", weight = 50 },
        { trait = "WHISKERS", weight = 50 },
        { trait = "DEX_UP_3" },
        { trait = "SNOUT", weight = 50 },
        { trait = "SLEEPY2", weight = 50 },
        { trait = "PAWS", weight = 50 },
        { trait = "SNARL", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_feline_nonthres",
    kind = "collection",
    entries = { { trait = "FANGS", weight = 50 }, { trait = "CARNIVORE", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_feline_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_FELINE" },
        { trait = "PRED3", weight = 50 },
        { trait = "SABER_TEETH", weight = 50 },
        { trait = "TAIL_LONG", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_plant",
    kind = "collection",
    entries = {
        { trait = "HEAVYSLEEPER", weight = 50 },
        { trait = "BADHEARING", weight = 50 },
        { trait = "FASTHEALER2", weight = 50 },
        { trait = "BARK", weight = 50 },
        { trait = "THORNS", weight = 50 },
        { trait = "LEAVES", weight = 50 },
        { trait = "STR_UP_2" },
        { trait = "DEFORMED2", weight = 50 },
        { trait = "PONDEROUS3", weight = 50 },
        { trait = "SUNLIGHT_DEPENDENT", weight = 50 },
        { trait = "VINES3", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_plant_nonthres",
    kind = "collection",
    entries = {},
}

ccb.content.define_trait_group {
    id = "trait_group_plant_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_PLANT" },
        { trait = "FLOWERS", weight = 50 },
        { trait = "DISIMMUNE", weight = 50 },
        { trait = "SAPROPHAGE", weight = 50 },
        { trait = "ROOTS3", weight = 50 },
        { trait = "CHLOROMORPH", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_ursine",
    kind = "collection",
    entries = {
        { trait = "BADTEMPER", weight = 50 },
        { trait = "URSINE_EYE", weight = 50 },
        { trait = "URSINE_FUR", weight = 50 },
        { trait = "CLAWS", weight = 50 },
        { trait = "PADDED_FEET", weight = 50 },
        { trait = "TAIL_STUB", weight = 50 },
        { trait = "HIBERNATE", weight = 50 },
        { trait = "URSINE_EARS", weight = 50 },
        { trait = "FAT", weight = 50 },
        { trait = "SMELLY2", weight = 50 },
        { trait = "DEFORMED2", weight = 50 },
        { trait = "MUZZLE_BEAR", weight = 50 },
        { trait = "PAWS_LARGE", weight = 50 },
        { trait = "PONDEROUS1", weight = 50 },
        { trait = "GROWL", weight = 50 },
        { trait = "STR_UP_4" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_ursine_nonthres",
    kind = "collection",
    entries = { { trait = "HUGE" } },
}

ccb.content.define_trait_group {
    id = "trait_group_ursine_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_URSINE" },
        { trait = "MUT_TOUGH3", weight = 50 },
        { trait = "PRED4", weight = 50 },
        { trait = "SAPIOVORE", weight = 50 },
        { trait = "HUGE_OK" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_cephalopod",
    kind = "collection",
    entries = {
        { trait = "CEPH_EYES", weight = 50 },
        { trait = "CEPH_VISION", weight = 50 },
        { trait = "GILLS_CEPH", weight = 50 },
        { trait = "SLIT_NOSTRILS", weight = 50 },
        { trait = "DEFORMED", weight = 50 },
        { trait = "THIRST2", weight = 50 },
        { trait = "BEAK", weight = 50 },
        { trait = "SLIMY", weight = 50 },
        { trait = "COLDBLOOD", weight = 50 },
        { trait = "DEX_UP_4" },
        { trait = "INT_UP_4" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_cephalopod_nonthres",
    kind = "collection",
    entries = {
        { trait = "LEG_TENTACLES", weight = 50 },
        { distribution = { { trait = "ARM_TENTACLES" }, { trait = "ARM_TENTACLES_4" } }, weight = 50 },
        { trait = "SHELL", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_cephalopod_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_CEPHALOPOD" },
        { trait = "MOUTH_TENTACLES", weight = 50 },
        {
            distribution = {
                { trait = "ARM_TENTACLES" },
                { trait = "ARM_TENTACLES_4" },
                { trait = "ARM_TENTACLES_8" },
            },
        },
        { trait = "CLAWS_TENTACLE", weight = 50 },
        { trait = "LEG_TENTACLES" },
        { trait = "LEG_TENT_BRACE", weight = 50 },
        { trait = "SHELL2", weight = 50 },
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

ccb.content.define_trait_group {
    id = "trait_group_mastodon",
    kind = "collection",
    entries = {
        { trait = "PATCHFUR", weight = 50 },
        { trait = "HAULER", weight = 50 },
        { trait = "UPLIFTED" },
        { trait = "CRUSHINGFEET", weight = 50 },
        { trait = "HERBIVORE", weight = 50 },
        { trait = "FACEBUMPS", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_mastodon_nonthres",
    kind = "collection",
    entries = { { trait = "TUSKS", weight = 50 } },
}

ccb.content.define_trait_group {
    id = "trait_group_mastodon_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_MASTODON" },
        { trait = "TUSKS_POINTED", weight = 50 },
        { trait = "TRUMPET" },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_migo",
    kind = "collection",
    entries = {
        { trait = "PATCHFUR", weight = 50 },
        { trait = "HAULER", weight = 50 },
        { trait = "UPLIFTED" },
        { trait = "CRUSHINGFEET", weight = 50 },
        { trait = "HERBIVORE", weight = 50 },
        { trait = "FACEBUMPS", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_migo_nonthres",
    kind = "collection",
    entries = {
        { trait = "MIGO_BREATHE", weight = 50 },
        { trait = "SHOUT1", weight = 50 },
        { trait = "NEURAL_IMPROVEMENT", weight = 50 },
        { trait = "ENHANCED_REACTIONS", weight = 50 },
        { trait = "QUICKENING", weight = 50 },
        { distribution = { { trait = "NEURAL_IMPROVEMENT" }, { trait = "EXPANDED_CONSCIOUSNESS" } } },
        { distribution = { { trait = "WARM_NATURED" }, { trait = "MOUTH_TENDRILS" } } },
    },
}

ccb.content.define_trait_group {
    id = "trait_group_migo_postthres",
    kind = "collection",
    entries = {
        { trait = "THRESH_YUGGOTH" },
        { distribution = { { trait = "UPLIFTED" }, { trait = "ALIEN_INT" } } },
        { trait = "MIGO_HEAT_RESIST", weight = 50 },
        { trait = "OTHERWORLDLY_GRACE", weight = 20 },
        { trait = "NEW_MUSCLES", weight = 20 },
        { trait = "MUSCLE_FIBER", weight = 50 },
        {
            distribution = {
                { trait = "MIGO_EARS" },
                {
                    collection = {
                        { trait = "NEW_MUSCLES" },
                        { trait = "MUSCLE_FIBER" },
                        { trait = "DETACHMENT" },
                    },
                },
            },
        },
    },
}
