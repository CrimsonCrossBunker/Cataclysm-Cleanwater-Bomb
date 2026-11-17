local content = require("ccb").content

-- recipes/requirements.json

content.merge_requirement(
    content.Requirement { id = "smelting_standard" }
        :tool_charges("forge", 1)
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
        }
        :tool_any {
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 },
        }
        :tool("casting_mold", 1)
)

-- Tools and components for writing.
content.merge_requirement(
    content.Requirement { id = "writing_standard", name = content.text("Writing") }
        :tool_any {
            { id = "survival_marker", count = 1 },
            { id = "feather", count = 1 },
        }
        :tool_charges("homemade_ink", 2)
)

content.merge_requirement(
    content.Requirement { id = "magical_herbs", name = content.text("Magical herbs") }
        :component_any {
            { id = "harfry_root", count = 1 },
            { id = "morningflower_leaves", count = 1 },
            { id = "corpsefire_cap", count = 1 },
            { id = "tanglevine_root", count = 1 },
            { id = "dryad_bark", count = 1 },
        }
)

-- Tools and components for writing beginner spells.
content.merge_requirement(
    content.Requirement { id = "writing_formulae_apprentice_standard", name = content.text("Apprentice occult writing") }
        :tool_any {
            { id = "survival_marker", count = 1 },
            { id = "feather", count = 1 },
        }
        :tool_charges("magical_ink_simple", 2)
)

content.merge_requirement(
    content.Requirement { id = "eggs_bird" },
    content.Requirement {}
        :component("eggs_dragon_bird_small", 1, true)
)

content.merge_requirement(
    content.Requirement { id = "eggs_dragon_bird_small" }
        :component_any {
            { id = "egg_claw_runner", count = 1 },
            { id = "egg_claw_hunter", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "meat_nofish" },
    content.Requirement {}
        :component("insect_meat", 1)
)

content.merge_requirement(
    content.Requirement { id = "meat_cooked" },
    content.Requirement {}
        :component("insect_meat", 1)
)

content.merge_requirement(
    content.Requirement { id = "edible_fat" },
    content.Requirement {}
        :component("insect_fat", 1)
)

-- magic/forest_magic/forest_components.json

-- Sticks to turn into a bramble spear
content.merge_requirement(
    content.Requirement { id = "spell_components_bramble_spear" }
        :component_any {
            { id = "stick", count = 1 },
            { id = "stick_long", count = 1 },
        }
)

-- magic/hedge_magic/hedge_spell_components_override.json

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_luck_spell" }
        :component("copper", 1)
        :component("paper", 1)
        :tool("candle_lit", 1)
        :tool_charges("survival_marker", 8)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_clairvoyance_cone" }
        :tool_any {
            { id = "sharp_rock", count = 1 },
            { id = "primitive_knife", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_raziel_amulet_protection" }
        :component("hard_liquor", 3, true)
        :component("eggs_bird", 1, true)
        :component_any {
            { id = "apple", count = 1 },
            { id = "lemon", count = 1 },
        }
        :component("copper_necklace", 1)
        :quality("CUT_FINE", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_prevent_wild_animal_attacks" }
        :component_any {
            { id = "feces_roach", count = 3 },
            { id = "feces_manure", count = 3 },
            { id = "feces_dog", count = 3 },
            { id = "feces_cow", count = 3 },
            { id = "feces_bird", count = 3 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_extinguish_fire_spell" }
        :component("ash", 2)
        :component("morningflower_leaves_smoked", 2)
)
