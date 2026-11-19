local ccb = require("ccb")

-- This assigns characters a random appearance based on racial demographics in Massachusetts - numbers rounded out a bit.
ccb.content.define_trait_group {
    id = "Appearance_demographics",
    kind = "distribution",
    entries = {
        { group = "Appearance_Irish", weight = 21 },
        { group = "Appearance_Caucasian", weight = 40 },
        { group = "Appearance_Germanic", weight = 20 },
        { group = "Appearance_Latin", weight = 3 },
        { group = "Appearance_African", weight = 9 },
        { group = "Appearance_EastAsian", weight = 4 },
        { group = "Appearance_SouthAsian", weight = 3 },
        { group = "Appearance_Mixed", weight = 3 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_Irish",
    kind = "collection",
    entries = {
        { group = "Hair_Irish", weight = 100 },
        { group = "Skin_Fair", weight = 100 },
        { group = "Eye_light", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_Caucasian",
    kind = "collection",
    entries = {
        { group = "Hair_Any", weight = 100 },
        { group = "Skin_White", weight = 100 },
        { group = "Eye_any", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_Germanic",
    kind = "collection",
    entries = {
        { group = "Hair_Fair", weight = 100 },
        { group = "Skin_Fair", weight = 100 },
        { group = "Eye_light", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_Latin",
    kind = "collection",
    entries = {
        { group = "Hair_Dark", weight = 100 },
        { group = "Skin_Medium", weight = 100 },
        { group = "Eye_dark", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_African",
    kind = "collection",
    entries = {
        { group = "Hair_Dark", weight = 100 },
        { group = "Skin_Dark", weight = 100 },
        { group = "Eye_dark", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_EastAsian",
    kind = "collection",
    entries = {
        { group = "Hair_Dark", weight = 100 },
        { trait = "SKIN_TAN", weight = 100 },
        { group = "Eye_dark", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_SouthAsian",
    kind = "collection",
    entries = {
        { group = "Hair_Dark", weight = 100 },
        { trait = "SKIN_TAN", weight = 100 },
        { group = "Eye_dark", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Appearance_Mixed",
    kind = "collection",
    entries = {
        { group = "Hair_Any", weight = 100 },
        { group = "Skin_Any", weight = 100 },
        { group = "Eye_any", weight = 100 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Any",
    kind = "distribution",
    entries = {
        { group = "Hair_Red", weight = 5 },
        { group = "Hair_Blond", weight = 25 },
        { group = "Hair_Black", weight = 25 },
        { group = "Hair_Brown", weight = 25 },
        { group = "Hair_Gray", weight = 10 },
        { group = "Hair_White", weight = 10 },
        { group = "Hair_Green", weight = 2 },
        { group = "Hair_Blue", weight = 2 },
        { group = "Hair_Purple", weight = 2 },
        { group = "Hair_Pink", weight = 2 },
        { trait = "hair_bald", weight = 3 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Irish",
    kind = "distribution",
    entries = {
        { group = "Hair_Red", weight = 10 },
        { group = "Hair_Blond", weight = 10 },
        { group = "Hair_Black", weight = 25 },
        { group = "Hair_Brown", weight = 40 },
        { group = "Hair_Gray", weight = 8 },
        { group = "Hair_White", weight = 7 },
        { group = "Hair_Green", weight = 1 },
        { group = "Hair_Blue", weight = 1 },
        { group = "Hair_Purple", weight = 1 },
        { group = "Hair_Pink", weight = 1 },
        { trait = "hair_bald", weight = 3 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Fair",
    kind = "distribution",
    entries = {
        { group = "Hair_Red", weight = 1 },
        { group = "Hair_Blond", weight = 50 },
        { group = "Hair_Black", weight = 7 },
        { group = "Hair_Brown", weight = 40 },
        { group = "Hair_Gray", weight = 5 },
        { group = "Hair_White", weight = 8 },
        { group = "Hair_Green", weight = 1 },
        { group = "Hair_Blue", weight = 1 },
        { group = "Hair_Purple", weight = 1 },
        { group = "Hair_Pink", weight = 1 },
        { trait = "hair_bald", weight = 3 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Dark",
    kind = "distribution",
    entries = {
        { group = "Hair_Black", weight = 50 },
        { group = "Hair_Brown", weight = 40 },
        { group = "Hair_Gray", weight = 6 },
        { group = "Hair_White", weight = 5 },
        { group = "Hair_Green", weight = 1 },
        { group = "Hair_Blue", weight = 1 },
        { group = "Hair_Purple", weight = 1 },
        { group = "Hair_Pink", weight = 1 },
        { trait = "hair_bald", weight = 3 },
    },
}

ccb.content.define_trait_group {
    id = "Skin_Any",
    kind = "distribution",
    entries = {
        { trait = "SKIN_DARK", weight = 15 },
        { trait = "SKIN_MEDIUM", weight = 25 },
        { trait = "SKIN_TAN", weight = 25 },
        { trait = "SKIN_PINK", weight = 5 },
        { trait = "SKIN_LIGHT", weight = 10 },
    },
}

ccb.content.define_trait_group {
    id = "Skin_Fair",
    kind = "distribution",
    entries = { { trait = "SKIN_PINK", weight = 5 }, { trait = "SKIN_LIGHT", weight = 5 } },
}

ccb.content.define_trait_group {
    id = "Skin_White",
    kind = "distribution",
    entries = {
        { trait = "SKIN_MEDIUM", weight = 15 },
        { trait = "SKIN_PINK", weight = 25 },
        { trait = "SKIN_LIGHT", weight = 55 },
    },
}

ccb.content.define_trait_group {
    id = "Skin_Medium",
    kind = "distribution",
    entries = {
        { trait = "SKIN_DARK", weight = 5 },
        { trait = "SKIN_MEDIUM", weight = 50 },
        { trait = "SKIN_TAN", weight = 25 },
    },
}

ccb.content.define_trait_group {
    id = "Skin_Dark",
    kind = "distribution",
    entries = {
        { trait = "SKIN_DARK", weight = 50 },
        { trait = "SKIN_MEDIUM", weight = 5 },
        { trait = "SKIN_TAN", weight = 25 },
    },
}

ccb.content.define_trait_group {
    id = "Eye_light",
    kind = "distribution",
    entries = {
        { trait = "eye_color", variant = "blue", weight = 55 },
        { trait = "eye_color", variant = "gray", weight = 25 },
        { trait = "eye_color", variant = "green", weight = 15 },
    },
}

ccb.content.define_trait_group {
    id = "Eye_dark",
    kind = "distribution",
    entries = {
        { trait = "eye_color", variant = "brown", weight = 60 },
        { trait = "eye_color", variant = "hazel", weight = 20 },
        { trait = "eye_color", variant = "amber", weight = 20 },
    },
}

ccb.content.define_trait_group {
    id = "Eye_any",
    kind = "distribution",
    entries = {
        { trait = "eye_color", variant = "brown", weight = 70 },
        { trait = "eye_color", variant = "hazel", weight = 9 },
        { trait = "eye_color", variant = "amber", weight = 8 },
        { trait = "eye_color", variant = "blue", weight = 8 },
        { trait = "eye_color", variant = "gray", weight = 3 },
        { trait = "eye_color", variant = "green", weight = 2 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Black",
    kind = "distribution",
    entries = {
        { trait = "hair_crewcut", variant = "black", weight = 25 },
        { trait = "hair_mohawk", variant = "black", weight = 1 },
        { trait = "hair_fro", variant = "black", weight = 10 },
        { trait = "hair_short", variant = "black", weight = 35 },
        { trait = "hair_medium", variant = "black", weight = 25 },
        { trait = "hair_long", variant = "black", weight = 13 },
        { trait = "hair_buzzcut", variant = "black", weight = 25 },
        { trait = "hair_ponytail", variant = "black", weight = 10 },
        { trait = "hair_long_over_eye", variant = "black", weight = 10 },
        { trait = "hair_messy", variant = "black", weight = 13 },
        { trait = "hair_short_over_eye", variant = "black", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "black", weight = 15 },
        { trait = "hair_punk_long", variant = "black", weight = 5 },
        { trait = "hair_curls", variant = "black", weight = 15 },
        { trait = "hair_modern", variant = "black", weight = 5 },
        { trait = "hair_bun", variant = "black", weight = 15 },
        { trait = "hair_braid", variant = "black", weight = 15 },
        { trait = "hair_puff", variant = "black", weight = 15 },
        { trait = "hair_beaded", variant = "black", weight = 15 },
        { trait = "hair_detective", variant = "black", weight = 1 },
        { trait = "hair_super_princess", variant = "black", weight = 1 },
        { trait = "hair_twintails", variant = "black", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Brown",
    kind = "distribution",
    entries = {
        { trait = "hair_crewcut", variant = "brown", weight = 25 },
        { trait = "hair_mohawk", variant = "brown", weight = 1 },
        { trait = "hair_fro", variant = "brown", weight = 5 },
        { trait = "hair_short", variant = "brown", weight = 35 },
        { trait = "hair_medium", variant = "brown", weight = 25 },
        { trait = "hair_long", variant = "brown", weight = 13 },
        { trait = "hair_buzzcut", variant = "brown", weight = 25 },
        { trait = "hair_ponytail", variant = "brown", weight = 10 },
        { trait = "hair_long_over_eye", variant = "brown", weight = 10 },
        { trait = "hair_messy", variant = "brown", weight = 13 },
        { trait = "hair_short_over_eye", variant = "brown", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "brown", weight = 15 },
        { trait = "hair_punk_long", variant = "brown", weight = 10 },
        { trait = "hair_curls", variant = "brown", weight = 15 },
        { trait = "hair_modern", variant = "brown", weight = 10 },
        { trait = "hair_bun", variant = "brown", weight = 15 },
        { trait = "hair_braid", variant = "brown", weight = 15 },
        { trait = "hair_puff", variant = "brown", weight = 15 },
        { trait = "hair_beaded", variant = "brown", weight = 10 },
        { trait = "hair_detective", variant = "brown", weight = 1 },
        { trait = "hair_super_princess", variant = "brown", weight = 1 },
        { trait = "hair_twintails", variant = "brown", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Blond",
    kind = "distribution",
    entries = {
        { trait = "hair_crewcut", variant = "blond", weight = 25 },
        { trait = "hair_mohawk", variant = "blond", weight = 1 },
        { trait = "hair_fro", variant = "blond", weight = 1 },
        { trait = "hair_short", variant = "blond", weight = 35 },
        { trait = "hair_medium", variant = "blond", weight = 25 },
        { trait = "hair_long", variant = "blond", weight = 13 },
        { trait = "hair_buzzcut", variant = "blond", weight = 25 },
        { trait = "hair_ponytail", variant = "blond", weight = 10 },
        { trait = "hair_long_over_eye", variant = "blond", weight = 10 },
        { trait = "hair_messy", variant = "blond", weight = 13 },
        { trait = "hair_short_over_eye", variant = "blond", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "blond", weight = 15 },
        { trait = "hair_punk_long", variant = "blond", weight = 1 },
        { trait = "hair_curls", variant = "blond", weight = 20 },
        { trait = "hair_modern", variant = "blond", weight = 5 },
        { trait = "hair_bun", variant = "blond", weight = 20 },
        { trait = "hair_braid", variant = "blond", weight = 15 },
        { trait = "hair_puff", variant = "blond", weight = 5 },
        { trait = "hair_beaded", variant = "blond", weight = 1 },
        { trait = "hair_detective", variant = "blond", weight = 1 },
        { trait = "hair_super_princess", variant = "blond", weight = 1 },
        { trait = "hair_twintails", variant = "blond", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Red",
    kind = "distribution",
    entries = {
        { trait = "hair_crewcut", variant = "red", weight = 25 },
        { trait = "hair_mohawk", variant = "red", weight = 1 },
        { trait = "hair_fro", variant = "red", weight = 1 },
        { trait = "hair_short", variant = "red", weight = 35 },
        { trait = "hair_medium", variant = "red", weight = 25 },
        { trait = "hair_long", variant = "red", weight = 13 },
        { trait = "hair_buzzcut", variant = "red", weight = 25 },
        { trait = "hair_ponytail", variant = "red", weight = 10 },
        { trait = "hair_long_over_eye", variant = "red", weight = 10 },
        { trait = "hair_messy", variant = "red", weight = 13 },
        { trait = "hair_short_over_eye", variant = "red", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "red", weight = 15 },
        { trait = "hair_punk_long", variant = "red", weight = 1 },
        { trait = "hair_curls", variant = "red", weight = 20 },
        { trait = "hair_modern", variant = "red", weight = 5 },
        { trait = "hair_bun", variant = "red", weight = 20 },
        { trait = "hair_braid", variant = "red", weight = 15 },
        { trait = "hair_puff", variant = "red", weight = 5 },
        { trait = "hair_beaded", variant = "red", weight = 1 },
        { trait = "hair_detective", variant = "red", weight = 1 },
        { trait = "hair_super_princess", variant = "red", weight = 1 },
        { trait = "hair_twintails", variant = "red", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Gray",
    kind = "distribution",
    entries = {
        { trait = "hair_crewcut", variant = "gray", weight = 25 },
        { trait = "hair_mohawk", variant = "gray", weight = 1 },
        { trait = "hair_fro", variant = "gray", weight = 1 },
        { trait = "hair_short", variant = "gray", weight = 35 },
        { trait = "hair_medium", variant = "gray", weight = 25 },
        { trait = "hair_long", variant = "gray", weight = 13 },
        { trait = "hair_curls", variant = "gray", weight = 20 },
        { trait = "hair_braid", variant = "gray", weight = 5 },
        { trait = "hair_beaded", variant = "gray", weight = 10 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_White",
    kind = "distribution",
    entries = {
        { trait = "hair_crewcut", variant = "white", weight = 25 },
        { trait = "hair_mohawk", variant = "white", weight = 1 },
        { trait = "hair_fro", variant = "white", weight = 1 },
        { trait = "hair_short", variant = "white", weight = 35 },
        { trait = "hair_medium", variant = "white", weight = 25 },
        { trait = "hair_long", variant = "white", weight = 13 },
        { trait = "hair_buzzcut", variant = "white", weight = 25 },
        { trait = "hair_ponytail", variant = "white", weight = 10 },
        { trait = "hair_long_over_eye", variant = "white", weight = 10 },
        { trait = "hair_messy", variant = "white", weight = 13 },
        { trait = "hair_short_over_eye", variant = "white", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "white", weight = 15 },
        { trait = "hair_punk_long", variant = "white", weight = 25 },
        { trait = "hair_curls", variant = "white", weight = 10 },
        { trait = "hair_modern", variant = "white", weight = 25 },
        { trait = "hair_bun", variant = "white", weight = 1 },
        { trait = "hair_braid", variant = "white", weight = 10 },
        { trait = "hair_puff", variant = "white", weight = 1 },
        { trait = "hair_beaded", variant = "white", weight = 5 },
        { trait = "hair_detective", variant = "white", weight = 1 },
        { trait = "hair_super_princess", variant = "white", weight = 1 },
        { trait = "hair_twintails", variant = "white", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Green",
    kind = "distribution",
    entries = {
        { trait = "hair_buzzcut", variant = "green", weight = 25 },
        { trait = "hair_ponytail", variant = "green", weight = 10 },
        { trait = "hair_long_over_eye", variant = "green", weight = 10 },
        { trait = "hair_messy", variant = "green", weight = 13 },
        { trait = "hair_short_over_eye", variant = "green", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "green", weight = 15 },
        { trait = "hair_crewcut", variant = "green", weight = 25 },
        { trait = "hair_mohawk", variant = "green", weight = 1 },
        { trait = "hair_fro", variant = "green", weight = 1 },
        { trait = "hair_medium", variant = "green", weight = 25 },
        { trait = "hair_long", variant = "green", weight = 13 },
        { trait = "hair_short", variant = "green", weight = 35 },
        { trait = "hair_punk_long", variant = "green", weight = 25 },
        { trait = "hair_curls", variant = "green", weight = 10 },
        { trait = "hair_modern", variant = "green", weight = 25 },
        { trait = "hair_bun", variant = "green", weight = 1 },
        { trait = "hair_braid", variant = "green", weight = 10 },
        { trait = "hair_puff", variant = "green", weight = 1 },
        { trait = "hair_beaded", variant = "green", weight = 5 },
        { trait = "hair_detective", variant = "green", weight = 1 },
        { trait = "hair_super_princess", variant = "green", weight = 1 },
        { trait = "hair_twintails", variant = "green", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Blue",
    kind = "distribution",
    entries = {
        { trait = "hair_buzzcut", variant = "blue", weight = 25 },
        { trait = "hair_ponytail", variant = "blue", weight = 10 },
        { trait = "hair_long_over_eye", variant = "blue", weight = 10 },
        { trait = "hair_messy", variant = "blue", weight = 13 },
        { trait = "hair_short_over_eye", variant = "blue", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "blue", weight = 15 },
        { trait = "hair_crewcut", variant = "blue", weight = 25 },
        { trait = "hair_mohawk", variant = "blue", weight = 1 },
        { trait = "hair_fro", variant = "blue", weight = 1 },
        { trait = "hair_medium", variant = "blue", weight = 25 },
        { trait = "hair_long", variant = "blue", weight = 13 },
        { trait = "hair_short", variant = "blue", weight = 35 },
        { trait = "hair_punk_long", variant = "blue", weight = 25 },
        { trait = "hair_curls", variant = "blue", weight = 10 },
        { trait = "hair_modern", variant = "blue", weight = 25 },
        { trait = "hair_bun", variant = "blue", weight = 1 },
        { trait = "hair_braid", variant = "blue", weight = 10 },
        { trait = "hair_puff", variant = "blue", weight = 1 },
        { trait = "hair_beaded", variant = "blue", weight = 5 },
        { trait = "hair_detective", variant = "blue", weight = 1 },
        { trait = "hair_super_princess", variant = "blue", weight = 1 },
        { trait = "hair_twintails", variant = "blue", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Purple",
    kind = "distribution",
    entries = {
        { trait = "hair_buzzcut", variant = "purple", weight = 25 },
        { trait = "hair_ponytail", variant = "purple", weight = 10 },
        { trait = "hair_long_over_eye", variant = "purple", weight = 10 },
        { trait = "hair_messy", variant = "purple", weight = 13 },
        { trait = "hair_short_over_eye", variant = "purple", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "purple", weight = 15 },
        { trait = "hair_crewcut", variant = "purple", weight = 25 },
        { trait = "hair_mohawk", variant = "purple", weight = 1 },
        { trait = "hair_fro", variant = "purple", weight = 1 },
        { trait = "hair_medium", variant = "purple", weight = 25 },
        { trait = "hair_long", variant = "purple", weight = 13 },
        { trait = "hair_short", variant = "purple", weight = 35 },
        { trait = "hair_punk_long", variant = "purple", weight = 25 },
        { trait = "hair_curls", variant = "purple", weight = 10 },
        { trait = "hair_modern", variant = "purple", weight = 25 },
        { trait = "hair_bun", variant = "purple", weight = 1 },
        { trait = "hair_braid", variant = "purple", weight = 10 },
        { trait = "hair_puff", variant = "purple", weight = 1 },
        { trait = "hair_beaded", variant = "purple", weight = 5 },
        { trait = "hair_detective", variant = "purple", weight = 1 },
        { trait = "hair_super_princess", variant = "purple", weight = 1 },
        { trait = "hair_twintails", variant = "purple", weight = 1 },
    },
}

ccb.content.define_trait_group {
    id = "Hair_Pink",
    kind = "distribution",
    entries = {
        { trait = "hair_buzzcut", variant = "pink", weight = 25 },
        { trait = "hair_ponytail", variant = "pink", weight = 10 },
        { trait = "hair_long_over_eye", variant = "pink", weight = 10 },
        { trait = "hair_messy", variant = "pink", weight = 13 },
        { trait = "hair_short_over_eye", variant = "pink", weight = 10 },
        { trait = "hair_short_no_fringe", variant = "pink", weight = 15 },
        { trait = "hair_crewcut", variant = "pink", weight = 25 },
        { trait = "hair_mohawk", variant = "pink", weight = 1 },
        { trait = "hair_fro", variant = "pink", weight = 1 },
        { trait = "hair_medium", variant = "pink", weight = 25 },
        { trait = "hair_long", variant = "pink", weight = 13 },
        { trait = "hair_short", variant = "pink", weight = 35 },
        { trait = "hair_punk_long", variant = "pink", weight = 25 },
        { trait = "hair_curls", variant = "pink", weight = 10 },
        { trait = "hair_modern", variant = "pink", weight = 25 },
        { trait = "hair_bun", variant = "pink", weight = 1 },
        { trait = "hair_braid", variant = "pink", weight = 10 },
        { trait = "hair_puff", variant = "pink", weight = 1 },
        { trait = "hair_beaded", variant = "pink", weight = 5 },
        { trait = "hair_detective", variant = "pink", weight = 1 },
        { trait = "hair_super_princess", variant = "pink", weight = 1 },
        { trait = "hair_twintails", variant = "pink", weight = 1 },
    },
}
