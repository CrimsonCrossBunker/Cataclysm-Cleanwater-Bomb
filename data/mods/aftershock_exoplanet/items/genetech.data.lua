local ccb = require("ccb")

ccb.content.define_trait_group {
    id = "GENETECH_TRAITS",
    kind = "distribution",
    entries = {
        { group = "GENETECH_TAILS", weight = 100 },
        { group = "GENETECH_EARS", weight = 100 },
        { group = "GENETECH_LOOKS", weight = 50 },
        { group = "GENETECH_SKIN", weight = 100 },
        { group = "GENETECH_COMBAT", weight = 50 },
        { group = "GENETECH_WORKER", weight = 100 },
    },
}

-- Used in more accesible locations where Genetech can be found such as on shelves in Genetech-vaults. Weighted so that the most useful traits will spawn at a greatly reduced rate. Highly valuable or military grade traits should not end up in here.
ccb.content.define_trait_group {
    id = "GENETECH_TRAITS_LOW_TIER",
    kind = "distribution",
    entries = {
        { group = "GENETECH_TAILS", weight = 100 },
        { group = "GENETECH_EARS", weight = 100 },
        { group = "GENETECH_LOOKS", weight = 50 },
        { group = "GENETECH_SKIN", weight = 100 },
        { group = "GENETECH_WORKER", weight = 30 },
        { group = "GENETECH_COMBAT", weight = 10 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_TAILS",
    kind = "distribution",
    entries = {
        { trait = "TAIL_RABBIT", weight = 100 },
        { trait = "TAIL_FIN", weight = 50 },
        { trait = "TAIL_LONG", weight = 100 },
        { trait = "TAIL_CATTLE", weight = 50 },
        { trait = "TAIL_THICK", weight = 50 },
        { trait = "TAIL_FLUFFY", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_EARS",
    kind = "distribution",
    entries = {
        { trait = "MOUSE_EARS", weight = 100 },
        { trait = "ELFA_EARS", weight = 100 },
        { trait = "CANINE_EARS", weight = 100 },
        { trait = "LUPINE_EARS", weight = 100 },
        { trait = "FELINE_EARS", weight = 100 },
        { trait = "LEAVES", weight = 100 },
        { trait = "ROSEBUDS", weight = 50 },
        { trait = "URSINE_EARS", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_LOOKS",
    kind = "distribution",
    entries = {
        { trait = "UGLY", weight = 100 },
        { trait = "DEFORMED3", weight = 100 },
        { trait = "BEAUTIFUL3", weight = 100 },
        { trait = "DEFORMED", weight = 100 },
        { trait = "BEAUTIFUL", weight = 100 },
        { trait = "PRETTY", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_SKIN",
    kind = "distribution",
    entries = {
        { trait = "LIGHTFUR", weight = 50 },
        { trait = "SCALES", weight = 50 },
        { trait = "SPARSE_SCALES", weight = 50 },
        { trait = "PADDED_FEET", weight = 50 },
        { trait = "THICK_SCALES", weight = 50 },
        { trait = "FUR", weight = 50 },
        { trait = "FEATHERS", weight = 50 },
        { trait = "LIGHTFUR", weight = 50 },
        { trait = "LUPINE_FUR", weight = 50 },
        { trait = "FELINE_FUR", weight = 50 },
        { trait = "PATCHSKIN1", weight = 25 },
        { trait = "SLEEK_SCALES", weight = 50 },
        { trait = "QUILLS", weight = 25 },
        { trait = "PLANTSKIN", weight = 50 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_COMBAT",
    kind = "distribution",
    entries = {
        { trait = "WINGS_INSECT", weight = 50 },
        { trait = "FANGS_SPIDER", weight = 50 },
        { trait = "CHITIN3", weight = 100 },
        { trait = "CLAWS_ST", weight = 50 },
        { trait = "COMPOUND_EYES", weight = 100 },
        { trait = "PAINREC2", weight = 100 },
        { trait = "MUT_TOUGH2", weight = 100 },
        { trait = "NOPAIN", weight = 100 },
        { trait = "PRED1", weight = 100 },
        { trait = "LARGE_OK", weight = 100 },
        { trait = "FLEET2", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_COMBAT_BRUTE_TRAITS",
    kind = "distribution",
    entries = {
        { trait = "AFS_QUICK", weight = 15 },
        { trait = "INFRESIST", weight = 15 },
        { trait = "AFS_INFIMMUNE", weight = 15 },
        { trait = "AFS_GOODCARDIO", weight = 15 },
        { trait = "AFS_PAINRESIST", weight = 15 },
        { trait = "AFS_UNCARING", weight = 15 },
        { trait = "DISIMMUNE", weight = 15 },
        { trait = "DISRESISTANT", weight = 15 },
        { trait = "AFS_NIGHTVISION", weight = 15 },
        { trait = "AFS_COMBAT_DRUG_PRODUCTION", weight = 50 },
        { trait = "AFS_HYPERMETABOLISM", weight = 50 },
        { trait = "AFS_FAST_BLOOD_PRODUCTION", weight = 50 },
        { trait = "AFS_REDUNDANT_ORGANS", weight = 50 },
        { trait = "AFS_WAR_BUILD", weight = 100 },
        { trait = "AFS_THROWING_STRENGTH", weight = 100 },
        { trait = "AFS_STRONG", weight = 100 },
        { trait = "AFS_GOOD_HEAD", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "GENETECH_WORKER",
    kind = "distribution",
    entries = {
        { trait = "DENSE_BONES", weight = 100 },
        { trait = "ACIDPROOF", weight = 50 },
        { trait = "TOUGH_MEDICAL", weight = 100 },
        { trait = "STRONGER_RESISTCHILL", weight = 50 },
        { trait = "AFS_GOODCARDIO", weight = 100 },
        { trait = "LIGHTEATER", weight = 100 },
        { trait = "AFS_PAINRESIST", weight = 100 },
        { trait = "BOVINE_BULK2", weight = 50 },
        { trait = "THICKSKIN", weight = 100 },
        { trait = "TOLERANCE", weight = 100 },
        { trait = "STRONGSTOMACH", weight = 100 },
        { trait = "VOMITSTOMACH", weight = 50 },
        { trait = "DISRESISTANT", weight = 100 },
        { trait = "WAKEFUL", weight = 100 },
        { trait = "RADIOPHILE", weight = 50 },
        { trait = "THICKSKIN", weight = 100 },
        { trait = "FASTHEALER", weight = 100 },
    },
}
