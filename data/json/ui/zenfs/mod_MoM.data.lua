local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_nether_meter",
    style = "text",
    width = 29,
    clauses = {
        {
            id = "invisible",
            text = "",
            color = "c_black",
            when = predicate.negate(predicate.has_effect("speaker", "effect_disease_psionic_drain")),
        },
        {
            id = "visible_1",
            text = ccb.content.text("      <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 15, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 35, "vitamin_psionic_drain") },
        },
        {
            id = "visible_2",
            text = ccb.content.text("     <color_dark_gray>₍<color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 35, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 55, "vitamin_psionic_drain") },
        },
        {
            id = "visible_3",
            text = ccb.content.text("    <color_dark_gray>ₒ₊<color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊ₒ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 55, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 75, "vitamin_psionic_drain") },
        },
        {
            id = "visible_4",
            text = ccb.content.text("    <color_dark_gray>₍₊<color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 75, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 95, "vitamin_psionic_drain") },
        },
        {
            id = "visible_5",
            text = ccb.content.text("   <color_dark_gray>ₒ₊₊<color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊ₒ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 95, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 115, "vitamin_psionic_drain") },
        },
        {
            id = "visible_6",
            text = ccb.content.text("   <color_dark_gray>₍₊₊<color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 115, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 135, "vitamin_psionic_drain") },
        },
        {
            id = "visible_7",
            text = ccb.content.text("  <color_light_gray>ₒ₊₊₊<color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊ₒ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 135, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 155, "vitamin_psionic_drain") },
        },
        {
            id = "visible_8",
            text = ccb.content.text("  <color_light_gray>₍₊₊₊<color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 155, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 175, "vitamin_psionic_drain") },
        },
        {
            id = "visible_9",
            text = ccb.content.text(" <color_light_gray>ₒ₊₊₊₊<color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊ₒ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 175, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 195, "vitamin_psionic_drain") },
        },
        {
            id = "visible_10",
            text = ccb.content.text(" <color_light_gray>₍₊₊₊₊<color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 195, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 215, "vitamin_psionic_drain") },
        },
        {
            id = "visible_11",
            text = ccb.content.text("<color_light_gray>ₒ₊₊₊₊₊<color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊ₒ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 215, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 235, "vitamin_psionic_drain") },
        },
        {
            id = "visible_12",
            text = ccb.content.text("<color_white>₍₊₊₊₊₊ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ<color_white> ₊₊₊₊₊₎</color>"),
            when = reading.compare("vitamin", ">=", 235, "vitamin_psionic_drain"),
        },
    },
    padding = 0,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_nether_meter_wide",
    style = "text",
    width = 64,
    clauses = {
        {
            id = "invisible",
            text = "",
            color = "c_black",
            when = predicate.negate(predicate.has_effect("speaker", "effect_disease_psionic_drain")),
        },
        {
            id = "visible_1",
            text = ccb.content.text("                        <color_light_gray>ₙ</color>ₑₜₕₑᵣ<color_light_gray>ₐ</color>ₜₜᵤₙₑₘₑₙₜ"),
            color = "c_dark_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 15, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 35, "vitamin_psionic_drain") },
        },
        {
            id = "visible_2",
            text = ccb.content.text("                    ₍₋₊ <color_light_gray>ₙ</color>ₑₜₕₑᵣ<color_light_gray>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₎"),
            color = "c_dark_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 35, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 55, "vitamin_psionic_drain") },
        },
        {
            id = "visible_3",
            text = ccb.content.text("                  ₍₋₊₋₊ <color_light_gray>ₙ</color>ₑₜₕₑᵣ<color_light_gray>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₎"),
            color = "c_dark_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 55, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 75, "vitamin_psionic_drain") },
        },
        {
            id = "visible_4",
            text = ccb.content.text("                ₍₋₊₋₊₋₊ <color_light_gray>ₙ</color>ₑₜₕₑᵣ<color_light_gray>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₎"),
            color = "c_dark_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 75, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 95, "vitamin_psionic_drain") },
        },
        {
            id = "visible_5",
            text = ccb.content.text("              ₍₋₊₋₊₋₊₋₊ <color_light_gray>ₙ</color>ₑₜₕₑᵣ<color_light_gray>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₎"),
            color = "c_dark_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 95, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 115, "vitamin_psionic_drain") },
        },
        {
            id = "visible_6",
            text = ccb.content.text("            ₍₋₊₋₊₋₊₋₊₋₊ <color_light_gray>ₙ</color>ₑₜₕₑᵣ<color_light_gray>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_dark_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 115, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 135, "vitamin_psionic_drain") },
        },
        {
            id = "visible_7",
            text = ccb.content.text("          ₍₋₊₋₊₋₊₋₊₋₊₋₊ <color_white>ₙ</color>ₑₜₕₑᵣ<color_white>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_light_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 135, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 155, "vitamin_psionic_drain") },
        },
        {
            id = "visible_8",
            text = ccb.content.text("        ₍₋₊₋₊₋₊₋₊₋₊₋₊₋₊ <color_white>ₙ</color>ₑₜₕₑᵣ<color_white>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_light_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 155, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 175, "vitamin_psionic_drain") },
        },
        {
            id = "visible_9",
            text = ccb.content.text("      ₍₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊ <color_white>ₙ</color>ₑₜₕₑᵣ<color_white>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_light_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 175, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 195, "vitamin_psionic_drain") },
        },
        {
            id = "visible_10",
            text = ccb.content.text("    ₍₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊ <color_white>ₙ</color>ₑₜₕₑᵣ<color_white>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_light_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 195, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 215, "vitamin_psionic_drain") },
        },
        {
            id = "visible_11",
            text = ccb.content.text("  ₍₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊ <color_white>ₙ</color>ₑₜₕₑᵣ<color_white>ₐ</color>ₜₜᵤₙₑₘₑₙₜ ₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_light_gray",
            when = predicate.all { reading.compare("vitamin", ">=", 215, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 235, "vitamin_psionic_drain") },
        },
        {
            id = "visible_12",
            text = ccb.content.text("₍₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊ ₙ<color_light_gray>ₑₜₕₑᵣ</color>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ</color> ₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₊₋₎"),
            color = "c_white",
            when = reading.compare("vitamin", ">=", 235, "vitamin_psionic_drain"),
        },
    },
    padding = 0,
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_nether_meter_wide_alt",
    style = "text",
    width = 56,
    clauses = {
        {
            id = "invisible",
            text = "",
            color = "c_black",
            when = predicate.negate(predicate.has_effect("speaker", "effect_disease_psionic_drain")),
        },
        {
            id = "visible_1",
            text = ccb.content.text("                    <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 15, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 35, "vitamin_psionic_drain") },
        },
        {
            id = "visible_2",
            text = ccb.content.text("                 <color_dark_gray>₍₊ <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 35, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 55, "vitamin_psionic_drain") },
        },
        {
            id = "visible_3",
            text = ccb.content.text("                <color_dark_gray>₍₊₊ <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 55, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 75, "vitamin_psionic_drain") },
        },
        {
            id = "visible_4",
            text = ccb.content.text("               <color_dark_gray>₍₊₊₊ <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 75, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 95, "vitamin_psionic_drain") },
        },
        {
            id = "visible_5",
            text = ccb.content.text("              <color_dark_gray>₍₊₊₊₊ <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 95, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 115, "vitamin_psionic_drain") },
        },
        {
            id = "visible_6",
            text = ccb.content.text("             <color_dark_gray>₍₊₊₊₊₊ <color_light_gray>ₙ<color_dark_gray>ₑₜₕₑᵣ<color_light_gray>ₐ<color_dark_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 115, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 135, "vitamin_psionic_drain") },
        },
        {
            id = "visible_7",
            text = ccb.content.text("            <color_light_gray>₍₊₊₊₊₊₊ <color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 135, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 155, "vitamin_psionic_drain") },
        },
        {
            id = "visible_8",
            text = ccb.content.text("           <color_light_gray>₍₊₊₊₊₊₊₊ <color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 155, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 175, "vitamin_psionic_drain") },
        },
        {
            id = "visible_9",
            text = ccb.content.text("          <color_light_gray>₍₊₊₊₊₊₊₊₊ <color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 175, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 195, "vitamin_psionic_drain") },
        },
        {
            id = "visible_10",
            text = ccb.content.text("         <color_light_gray>₍₊₊₊₊₊₊₊₊₊ <color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 195, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 215, "vitamin_psionic_drain") },
        },
        {
            id = "visible_11",
            text = ccb.content.text("        <color_light_gray>₍₊₊₊₊₊₊₊₊₊₊ <color_white>ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ ₊₊₊₊₊₊₊₊₊₊₎</color>"),
            when = predicate.all { reading.compare("vitamin", ">=", 215, "vitamin_psionic_drain"), reading.compare("vitamin", "<", 235, "vitamin_psionic_drain") },
        },
        {
            id = "visible_12",
            text = ccb.content.text("       <color_white>₍₊₊₊₊₊₊₊₊₊₊₊ ₙ<color_light_gray>ₑₜₕₑᵣ<color_white>ₐ<color_light_gray>ₜₜᵤₙₑₘₑₙₜ<color_white> ₊₊₊₊₊₊₊₊₊₊₊₎</color>"),
            when = reading.compare("vitamin", ">=", 235, "vitamin_psionic_drain"),
        },
    },
    padding = 0,
    flags = { "W_LABEL_NONE" },
}
