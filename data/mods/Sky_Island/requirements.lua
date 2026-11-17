local content = require("ccb").content

-- itemgroups/requirements.json

-- For when a recipe calls for a flag.
content.merge_requirement(
    content.Requirement { id = "any_flag_landing_upgradekey" }
        :component_any {
            { id = "national_flag", count = 1 },
            { id = "american_flag", count = 1 },
            { id = "state_flag", count = 1 },
        }
)

-- For when a recipe calls for a badge.
content.merge_requirement(
    content.Requirement { id = "any_badge" }
        :component_any {
            { id = "badge_fbi", count = 1 },
            { id = "badge_swat", count = 1 },
            { id = "badge_deputy", count = 1 },
            { id = "badge_doctor", count = 1 },
            { id = "badge_marshal", count = 1 },
            { id = "badge_foodkid", count = 1 },
            { id = "badge_detective", count = 1 },
            { id = "badge_cardboard", count = 1 },
            { id = "badge_detective", count = 1 },
        }
)

-- For when a recipe calls for a tiara.
content.merge_requirement(
    content.Requirement { id = "any_tiara" }
        :component_any {
            { id = "ruby_silver_tiara", count = 1 },
            { id = "onyx_silver_tiara", count = 1 },
            { id = "opal_gold_tiara", count = 1 },
            { id = "ruby_gold_tiara", count = 1 },
            { id = "onyx_gold_tiara", count = 1 },
            { id = "pearl_gold_tiara", count = 1 },
            { id = "opal_silver_tiara", count = 1 },
            { id = "garnet_gold_tiara", count = 1 },
            { id = "peridot_gold_tiara", count = 1 },
            { id = "pearl_silver_tiara", count = 1 },
            { id = "emerald_gold_tiara", count = 1 },
            { id = "citrine_gold_tiara", count = 1 },
            { id = "diamond_gold_tiara", count = 1 },
            { id = "onyx_platinum_tiara", count = 1 },
            { id = "ruby_platinum_tiara", count = 1 },
            { id = "opal_platinum_tiara", count = 1 },
            { id = "garnet_silver_tiara", count = 1 },
            { id = "sapphire_gold_tiara", count = 1 },
            { id = "amethyst_gold_tiara", count = 1 },
            { id = "pearl_platinum_tiara", count = 1 },
            { id = "citrine_silver_tiara", count = 1 },
            { id = "peridot_silver_tiara", count = 1 },
            { id = "emerald_silver_tiara", count = 1 },
            { id = "diamond_silver_tiara", count = 1 },
            { id = "blue_topaz_gold_tiara", count = 1 },
            { id = "tourmaline_gold_tiara", count = 1 },
            { id = "sapphire_silver_tiara", count = 1 },
            { id = "aquamarine_gold_tiara", count = 1 },
            { id = "garnet_platinum_tiara", count = 1 },
            { id = "amethyst_silver_tiara", count = 1 },
            { id = "diamond_platinum_tiara", count = 1 },
            { id = "citrine_platinum_tiara", count = 1 },
            { id = "alexandrite_gold_tiara", count = 1 },
            { id = "emerald_platinum_tiara", count = 1 },
            { id = "peridot_platinum_tiara", count = 1 },
            { id = "blue_topaz_silver_tiara", count = 1 },
            { id = "tourmaline_silver_tiara", count = 1 },
            { id = "amethyst_platinum_tiara", count = 1 },
            { id = "sapphire_platinum_tiara", count = 1 },
            { id = "aquamarine_silver_tiara", count = 1 },
            { id = "alexandrite_silver_tiara", count = 1 },
            { id = "blue_topaz_platinum_tiara", count = 1 },
            { id = "aquamarine_platinum_tiara", count = 1 },
            { id = "tourmaline_platinum_tiara", count = 1 },
            { id = "alexandrite_platinum_tiara", count = 1 },
        }
)
