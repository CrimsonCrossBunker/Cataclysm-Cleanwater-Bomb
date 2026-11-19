local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Exit_Controls",
    line = ccb.content.text("&You see a strangely mundane black computer screen, with a blinking green cursor awaiting input.\n\n<color_light_green> @User > _</color>"),
    replies = {
        {
            text = ccb.content.text("<color_yellow>Activate exit protocol: Home ᵃʷᵃʸ ᶠʳᵒᵐ ʰᵒᵐᵉ"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_safehouse_to_labyrinth" } }),
            next_topic = "COMP_LS_Exit_Controls2_safehouse",
        },
        {
            text = ccb.content.text("<color_red>Activate exit protocol: Earth gate"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_home_to_labyrinth" } }),
            next_topic = "COMP_LS_Exit_Controls2_home",
        },
        {
            text = ccb.content.text("<color_red>Activate exit protocol: KÁ gate"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "traveled_string_dimension_to_labyrinth" } }),
            next_topic = "COMP_LS_Exit_Controls2_string_dimension",
        },
        { text = ccb.content.text("<color_light_green>Log off"), next_topic = "TALK_DONE" },
    },
}
