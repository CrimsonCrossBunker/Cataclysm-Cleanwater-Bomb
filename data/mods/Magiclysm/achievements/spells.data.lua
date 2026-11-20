local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_learn_any_spell",
    name = ccb.content.text("Would-be Wizard"),
    requirements = { { statistic = "num_spells_learned", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_learn_any_spell_3",
    hidden_by = { "achievement_learn_any_spell" },
    name = ccb.content.text("Wizard's Apprentice"),
    requirements = { { statistic = "num_spells_learned", comparison = ">=", target = 5 } },
}

ccb.content.define_achievement {
    id = "achievement_learn_any_spell_10",
    hidden_by = { "achievement_learn_any_spell_3" },
    name = ccb.content.text("Journeyman Wizard"),
    description = ccb.content.text("You have learned enough spells that in more reasonable times you would have graduated from your apprenticeship."),
    requirements = { { statistic = "num_spells_learned", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_learn_any_spell_20",
    hidden_by = { "achievement_learn_any_spell_10" },
    name = ccb.content.text("Archmage"),
    description = ccb.content.text("You have learned a large number of spells, and would be qualified for the Archmage title."),
    requirements = { { statistic = "num_spells_learned", comparison = ">=", target = 20 } },
}

ccb.content.define_achievement {
    id = "achievement_learn_any_spell_50",
    hidden_by = { "achievement_learn_any_spell_20" },
    name = ccb.content.text("Master Archmage"),
    description = ccb.content.text("You have learned so many spells, that you would have been a major source of knowledge for many wizards.  Also known as a Sage, Master Archmages enjoy a wide variety of perks due to their lifelong commitment to learning and helping others learn."),
    requirements = { { statistic = "num_spells_learned", comparison = ">=", target = 50 } },
}

ccb.content.define_achievement {
    id = "achievement_forget_any_spell",
    name = ccb.content.text("Senile Wizard"),
    requirements = { { statistic = "num_spells_forgotten", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_1",
    name = ccb.content.text("Cast a Spell"),
    description = ccb.content.text("The first great milestone to becoming a full-fledged wizard is to cast a spell.  Some mages simply study the spell in the spellbook until they think they understand it as well as they can, but you can't beat practice over theory."),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_5",
    hidden_by = { "achievement_max_spell_level_1" },
    name = ccb.content.text("Spell Level 5"),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 5 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_10",
    hidden_by = { "achievement_max_spell_level_5" },
    name = ccb.content.text("Spell Level 10"),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_15",
    hidden_by = { "achievement_max_spell_level_10" },
    name = ccb.content.text("Spell Level 15"),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 15 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_20",
    hidden_by = { "achievement_max_spell_level_15" },
    name = ccb.content.text("Spell Level 20"),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 20 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_25",
    hidden_by = { "achievement_max_spell_level_20" },
    name = ccb.content.text("Spell Level 25"),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 25 } },
}

ccb.content.define_achievement {
    id = "achievement_max_spell_level_30",
    hidden_by = { "achievement_max_spell_level_25" },
    name = ccb.content.text("Spell Level 30"),
    requirements = { { statistic = "avatar_max_spell_level", comparison = ">=", target = 30 } },
}
