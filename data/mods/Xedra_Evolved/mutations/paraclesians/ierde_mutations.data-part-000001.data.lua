local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_NO_SLEEP_MEDITATE",
    name = ccb.content.text("Unsleeping Earth Vigil"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to, while underground, rest and recover energy as though sleeping.  Activate to begin the vigil."),
    prerequisites = { "IERDE_EYES" },
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    on_activate = "ierde_no_sleep_meditate",
}

ccb.content.define_mutation {
    id = "IERDE_DETECT_NEARBY_MONSTERS_EARTH",
    name = ccb.content.text("The Soil Knows Those Who Tread Upon It"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to sense the movements of nearby creatures, as long as they maintains contact with natural earth or stone, or are underground."),
    prerequisites = { "IERDE_EYES" },
    secondary_prerequisites = { "IERDE_EARS" },
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = true,
    active = true,
    on_activate = "ierde_detect_monsters_on",
    on_deactivate = "ierde_detect_monsters_off",
}
