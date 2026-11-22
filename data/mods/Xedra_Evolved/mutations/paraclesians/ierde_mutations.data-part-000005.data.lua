local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_SINK_INTO_EARTH",
    name = ccb.content.text("In the Earthmother's Embrace"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to sink into the living earth, where they will heal faster, they will not need to eat or drink, and sleep will be more restful for them."),
    prerequisites = { "IERDE_REGAIN_STAMINA_UNDERGROUND", "IERDE_HEAL_FASTER_UNDERGROUND" },
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    on_activate = "ierde_sink_into_earth",
    comfort = {
        {
            conditions = { { kind = "terrain", flag = "DIGGABLE" } },
            comfort = "very_comfortable",
            try_message = { text = ccb.content.text("You settle down to rest on the living earth."), rating = "good" },
        },
        {
            conditions = { { kind = "terrain", id = "t_rock" } },
            comfort = "very_comfortable",
            try_message = { text = ccb.content.text("Encased within the living earth, you drift off to sleep."), rating = "good" },
        },
    },
    enchantments = { "INLINE_ENCH_IERDE_SINK_INTO_EARTH_0" },
}
