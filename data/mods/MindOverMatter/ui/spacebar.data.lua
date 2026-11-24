local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "spacebar_nether_attunement_block",
    style = "layout",
    label = ccb.content.text("Nether Attunement"),
    arrange = "minimum_columns",
    width = 58,
    widgets = { "spacebar_separator_2", "spacebar_nether_attunement_meter" },
}

ccb.content.define_widget {
    id = "spacebar_nether_attunement_meter",
    style = "text",
    label = ccb.content.text("Attune"),
    width = 56,
    clauses = {
        {
            id = "invisible",
            text = "",
            color = "c_black",
            when = predicate.all { predicate.negate(predicate.has_effect("speaker", "effect_disease_psionic_drain")), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_1",
            text = "<color_green>Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 15, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 35, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_2",
            text = "<color_green>Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 35, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 55, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_3",
            text = "<color_light_green>Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 55, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 75, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_4",
            text = "<color_light_green>Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 75, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 95, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_5",
            text = "<color_yellow>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 95, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 115, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_6",
            text = "<color_yellow>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 115, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 135, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_7",
            text = "<color_light_red>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 135, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 155, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_8",
            text = "<color_light_red>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 155, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 175, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_9",
            text = "<color_red>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 175, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 195, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_10",
            text = "<color_red>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 195, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 215, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_11",
            text = "<color_pink>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 215, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 235, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_12",
            text = "<color_pink>Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 235, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.negate(predicate.has_any_trait("speaker", { "PSI_TORRENTIAL_CHANNELING_active" })) },
        },
        {
            id = "visible_torrential_1",
            text = "<color_white>T Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 15, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 35, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_2",
            text = "<color_white>T Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 35, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 55, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_3",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 55, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 75, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_4",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 75, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 95, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_5",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 95, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 115, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_6",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 115, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 135, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_7",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 135, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 155, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_8",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { reading.compare("vitamin", ">=", 155, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 175, "vitamin_psionic_drain"), predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_9",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), reading.compare("vitamin", "<=", 194, "vitamin_psionic_drain"), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_10",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), reading.compare("vitamin", ">=", 195, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 215, "vitamin_psionic_drain"), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_11",
            text = "<color_white>T  Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), reading.compare("vitamin", ">=", 215, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 235, "vitamin_psionic_drain"), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_torrential_12",
            text = "<color_white>T Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ≔≕Ψ T</color>",
            when = predicate.all { predicate.negate(predicate.has_effect("speaker", "effect_noetic_resilience")), reading.compare("vitamin", ">=", 235, "vitamin_psionic_drain"), predicate.has_trait("speaker", "PSI_TORRENTIAL_CHANNELING_active") },
        },
        {
            id = "visible_extended",
            text = "<color_light_gray>R Ψ≔≕Ψ R</color>",
            when = predicate.has_effect("speaker", "effect_noetic_resilience"),
        },
    },
    padding = 0,
}
