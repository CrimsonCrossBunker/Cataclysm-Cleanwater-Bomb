local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_SHADOW_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Shadow Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are shrouded in shadows.  This provides the actual effects of Shadow form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_SHADOW_FORM_TRAITS_0" },
    flags = { "MUTE", "NO_SPELLCASTING ", "NO_PSIONICS" },
    appearance = { id = "mon_darkman", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_LAST_BREATH_MIST",
    points = 11,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Last Breath's Mist"),
    description = ccb.content.text("Your mastery over your mist form has increased to the point that you can now instinctively activate it should you be about to die.  It requires you to have a lot of stolen blood in your body and can't trigger more than once a week but might save your life."),
}

-- There is no difference between this and the Ierde version, so I use that one instead of making a new one to avoid duplicates.  The player isn't supposed to see this anyway.
ccb.content.define_mutation {
    id = "VAMPIRE_IRON_MIND",
    points = 8,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Immortal Iron Mind"),
    description = ccb.content.text("Your vampiric potency has reinforced your mind beyond anything a mortal could ever hope.  You are immune to anything that could negatively impact your mind."),
    enchantments = { "ench_ierde_no_mind_problems" },
}
