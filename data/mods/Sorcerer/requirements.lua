local content = require("ccb").content

-- requirements/spell_components.json

content.merge_requirement(
    content.Requirement { id = "spell_components_rune_animist" }
        :component_any {
            { id = "rune_animist", count = 1 },
            { id = "rune_sorcerer", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_rune_animist_3" }
        :component_any {
            { id = "rune_animist", count = 3 },
            { id = "rune_sorcerer", count = 3 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_samsara" }
        :component_any {
            { id = "rune_druid", count = 1 },
            { id = "rune_sorcerer", count = 1 },
        }
)
