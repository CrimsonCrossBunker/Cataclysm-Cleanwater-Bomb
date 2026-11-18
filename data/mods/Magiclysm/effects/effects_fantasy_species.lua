local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "mutagen_species_dwarf",
    name = ccb.content.text("Dwarven Purification"),
    description = ccb.content.text("You consumed purifier."),
    blood_analysis_description = ccb.content.text("Dwarven Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Dwarven Reversion"))
    :name(ccb.content.text("Dwarven Regression"))
    :description(ccb.content.text("You consumed a large amount of purifier.  Why does it feel so strange?"))
    :description(ccb.content.text("You consumed a huge amount of purifier, and you can tell that something isn't right."))
    :modifier("strength", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("perception", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("dexterity", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("intelligence", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_species_elf",
    name = ccb.content.text("Elven Purification"),
    description = ccb.content.text("You consumed purifier."),
    blood_analysis_description = ccb.content.text("Elven Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Elven Reversion"))
    :name(ccb.content.text("Elven Regression"))
    :description(ccb.content.text("You consumed a large amount of purifier.  Why does it feel so strange?"))
    :description(ccb.content.text("You consumed a huge amount of purifier, and you can tell that something isn't right."))
    :modifier("strength", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("perception", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("dexterity", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("intelligence", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_species_goblin",
    name = ccb.content.text("Goblin Purification"),
    description = ccb.content.text("You consumed purifier."),
    blood_analysis_description = ccb.content.text("Goblin Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Goblin Reversion"))
    :name(ccb.content.text("Goblin Regression"))
    :description(ccb.content.text("You consumed a large amount of purifier.  Why does it feel so strange?"))
    :description(ccb.content.text("You consumed a huge amount of purifier, and you can tell that something isn't right."))
    :modifier("strength", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("perception", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("dexterity", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("intelligence", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_species_lizardfolk",
    name = ccb.content.text("Lizardfolk Purification"),
    description = ccb.content.text("You consumed purifier."),
    blood_analysis_description = ccb.content.text("Lizardfolk Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Lizardfolk Reversion"))
    :name(ccb.content.text("Lizardfolk Regression"))
    :description(ccb.content.text("You consumed a large amount of purifier.  Why does it feel so strange?"))
    :description(ccb.content.text("You consumed a huge amount of purifier, and you can tell that something isn't right."))
    :modifier("strength", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("perception", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("dexterity", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("intelligence", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "mutagen_species_ravenfolk",
    name = ccb.content.text("Ravenfolk Purification"),
    description = ccb.content.text("You consumed purifier."),
    blood_analysis_description = ccb.content.text("Ravenfolk Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Ravenfolk Reversion"))
    :name(ccb.content.text("Ravenfolk Regression"))
    :description(ccb.content.text("You consumed a large amount of purifier.  Why does it feel so strange?"))
    :description(ccb.content.text("You consumed a huge amount of purifier, and you can tell that something isn't right."))
    :modifier("strength", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("perception", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("dexterity", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 })
    :modifier("intelligence", "amount", { resisted_base = -2, resisted_per_intensity = -2.5 }))

content.add(content.EffectType {
    id = "effect_vitamin_elven_wilderness",
    name = ccb.content.text("The Longing"),
    description = ccb.content.text("You miss the wind through the trees."),
    maximum_intensity = 4,
    rating = "bad",
}
    :name(ccb.content.text("The Longing"))
    :name(ccb.content.text("The Longing"))
    :name(ccb.content.text("The Longing"))
    :description(ccb.content.text("You're dragging; all this civilization is getting you down."))
    :description(ccb.content.text("You feel run down and achy.  You need to get out to the forests."))
    :description(ccb.content.text("Every movement is an effort.  Every time you close your eyes you imagine yourself walking beneath the boughs of ancient trees."))
    :enchantment("INLINE_ENCH_effect_vitamin_elven_wilderness_0")
    :enchantment("INLINE_ENCH_effect_vitamin_elven_wilderness_1")
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 8, per_intensity = -1 })
    :modifier("health", "tick", { base = 3600, per_intensity = -300 }))

content.add(content.EffectType {
    id = "effect_vitamin_elven_wilderness_bonus",
    name = ccb.content.text("Under the Boughs"),
    description = ccb.content.text("Your time in the wilderness is rejuvenating you."),
    maximum_intensity = 1,
    rating = "good",
}
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 5 })
    :modifier("health", "tick", { base = 3600 }))

content.add(content.EffectType {
    id = "effect_elven_wilderness_bonus_lose_vitamin",
    name = "",
    description = "",
}
    :vitamin("vitamin_elven_wilderness", {
        rates = { { minimum = -1, maximum = -2 } },
        tick_turns = { 3600 },
    }))

content.add(content.EffectType {
    id = "effect_elven_wilderness_bonus_gain_vitamin",
    name = "",
    description = "",
}
    :vitamin("vitamin_elven_wilderness", {
        rates = { { minimum = 1, maximum = 2 } },
        tick_turns = { 7200 },
    }))

content.add(content.EffectType {
    id = "effect_elven_wilderness_bonus_steady_state",
    name = "",
    description = "",
}
    :removes_effect("effect_elven_wilderness_bonus_lose_vitamin")
    :removes_effect("effect_elven_wilderness_bonus_gain_vitamin"))
