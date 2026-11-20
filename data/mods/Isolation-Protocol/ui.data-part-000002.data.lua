local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    id = "mana_for_last_scion",
    style = "text",
    label = ccb.content.text("Mana"),
    flags = { "W_DISABLED_WHEN_EMPTY" },
    clauses = {
        {
            id = "mana_numbers",
            text = ccb.content.text("<color_pink><u_val:last_scion_mana></color>         Max: <color_pink><u_val:last_scion_max_mana></color>        %: <color_pink><u_val:last_scion_max_percent></color>"),
            parse_tags = true,
            when = predicate.has_trait("speaker", "iso_eldritch_sorcery"),
        },
    },
    padding = 0,
}
