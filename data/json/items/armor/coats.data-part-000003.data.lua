local ccb = require("ccb")

ccb.content.define_item {
    id = "grim_reaper_robe",
    name = ccb.content.plural_text("grim reaper's robe", "grim reaper's robes"),
    description = ccb.content.text("A black hooded grim reaper's robe with a face cover to hide the user's lack of facial skin.  It pairs nicely with a scythe.  Use it to remove the face cover and show yourself before your victims."),
    mass = "225 g",
    volume = "550 ml",
    price = "35 USD",
    survival_price = "90 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "cloak",
    color = "dark_gray",
    flags = {
        "UNRESTRICTED", "OUTER", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT",
        "ALLOWS_LEG_TENTACLES", "COSPLAY_COSTUME",
    },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 4 },
            { covers = { "mouth", "eyes" }, coverage = 100, encumbrance = 5 },
            { covers = { "torso" }, coverage = 100, encumbrance = 2 },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 92,
                encumbrance = 2,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 80,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
                encumbrance = 2,
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 80,
                encumbrance = 2,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 90,
            },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 80,
                encumbrance = { 2, 2 },
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 60,
                encumbrance = 4,
                layers = { "BELTED" },
            },
        },
        warmth = 10,
        thickness = 0.1,
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The darkness surrounding your face lightens."),
            target = "grim_reaper_robe_faceless",
            menu_text = ccb.content.text("Remove face cover"),
        },
    },
}

-- 'Faceless' as in 'face cover'less and because, without the cover of darkness (A black face cover) a real grim reaper would really be faceless
ccb.content.define_item {
    id = "grim_reaper_robe_faceless",
    copy_from = "grim_reaper_robe",
    name = ccb.content.plural_text("grim reaper's robe (faceless)", "grim reaper's robes (faceless)"),
    description = ccb.content.text("A black hooded grim reaper's robe with the face cover removed to show the user's lack of facial skin.  It pairs nicely with a scythe.  Use it to hide your lack of facial features."),
    armor = {
        portions = {
            { covers = { "head" }, coverage = 100, encumbrance = 4 },
            { covers = { "torso" }, coverage = 100, encumbrance = 2 },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 92,
                encumbrance = 2,
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "gastropod_foot" },
                coverage = 80,
                subparts = { "leg_hip_gastropod_l", "leg_hip_gastropod_r", "leg_upper_gastropod" },
                encumbrance = 2,
                layers = { "BELTED" },
            },
            {
                covers = {
                    "tentacle_lower_front_l", "tentacle_lower_middle_l", "tentacle_lower_rear_l",
                    "tentacle_lower_front_r", "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
                coverage = 80,
                encumbrance = 2,
                subparts = {
                    "tentacle_draped_lower_front_l", "tentacle_draped_lower_middle_l",
                    "tentacle_draped_lower_rear_l", "tentacle_draped_lower_front_r",
                    "tentacle_draped_lower_middle_r", "tentacle_draped_lower_rear_r",
                },
                layers = { "BELTED" },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 90,
            },
            {
                covers = { "tail_long", "tail_fluffy", "tail_bovine", "tail_rat" },
                coverage = 80,
                encumbrance = { 2, 2 },
                layers = { "BELTED" },
            },
            {
                covers = { "tail_thick", "tail_club" },
                coverage = 60,
                encumbrance = 4,
                layers = { "BELTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You shroud your face in darkness."),
            target = "grim_reaper_robe",
            menu_text = ccb.content.text("Adjust face cover"),
        },
    },
}
