local ccb = require("ccb")

ccb.content.define_field_type {
    id = "fd_gum_web",
    legacy_enum_id = 5,
    immune_monsters = { "mon_spider_gum" },
    decrease_intensity_on_contact = true,
    levels = {
        {
            name = ccb.content.text("flimsy gum webs"),
            symbol = "#",
            color = "light_red",
            effects = {
                {
                    effect = "gummed",
                    intensity = 2,
                    min_duration = "2 seconds",
                    immune_in_vehicle = true,
                    environmental = false,
                    message = ccb.content.text("Some gum sticks to you."),
                    npc_message = ccb.content.text("Some gum sticks to <npcname>."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text(" gum webs"),
            effects = {
                {
                    effect = "gummed",
                    intensity = 4,
                    min_duration = "20 seconds",
                    immune_in_vehicle = true,
                    environmental = false,
                    message = ccb.content.text("The gum sticks to you!"),
                    npc_message = ccb.content.text("The gum sticks to <npcname>!"),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("thick gum webs"),
            transparent = false,
            effects = {
                {
                    effect = "gummed",
                    intensity = 6,
                    min_duration = "40 seconds",
                    immune_in_vehicle = true,
                    environmental = false,
                    message = ccb.content.text("The gum sticks to you!"),
                    npc_message = ccb.content.text("The gum sticks to <npcname>!"),
                    message_type = "bad",
                },
            },
        },
    },
    description_affix = "covered_in",
    priority = 2,
    phase = "solid",
    bash = {
        minimum_strength = 1,
        maximum_strength = 3,
        volume = 2,
        failure_volume = 2,
        sound = ccb.content.text_without_extraction("shwip"),
        failure_sound = ccb.content.text_without_extraction("shwomp"),
        success_message = ccb.content.text("You brush the gum web aside."),
    },
    display_items = false,
    display_field = true,
}
