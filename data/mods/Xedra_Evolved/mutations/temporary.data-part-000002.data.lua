local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HEDGE_FOREST_BUSH_SHAPE",
    name = ccb.content.text_without_extraction("To Vanish Amidst the Leaves"),
    points = 99,
    description = ccb.content.text_without_extraction("You are a bush and no one can see you."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    appearance = { id = "t_shrub", tile_category = "terrain" },
    flags = { "INVISIBLE", "NO_SCENT" },
}

ccb.content.define_mutation {
    id = "TURN_INTO_BEAR_TRAITS",
    name = ccb.content.text_without_extraction("Bear Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a bear.  This provides the actual effects of bear form.  Should not be player-visible"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_0", "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_1",
        "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_2", "INLINE_ENCH_TURN_INTO_BEAR_TRAITS_3",
    },
    flags = {
        "MUTE", "NO_SPELLCASTING", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_HUGE", "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_bear", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "TURN_INTO_DEER_TRAITS",
    name = ccb.content.text_without_extraction("Deer Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a deer.  This provides the actual effects of deer form.  Should not be player-visible"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_TURN_INTO_DEER_TRAITS_0", "INLINE_ENCH_TURN_INTO_DEER_TRAITS_1",
        "INLINE_ENCH_TURN_INTO_DEER_TRAITS_2", "INLINE_ENCH_TURN_INTO_DEER_TRAITS_3",
    },
    integrated_armor = { "integrated_antlers", "integrated_feline_fur" },
    flags = {
        "MUTE", "NO_SPELLCASTING", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_deer", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "TURN_INTO_COUGAR_TRAITS",
    name = ccb.content.text_without_extraction("Cougar Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a cougar.  This provides the actual effects of cougar form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_0", "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_1",
        "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_2", "INLINE_ENCH_TURN_INTO_COUGAR_TRAITS_3",
    },
    flags = {
        "MUTE", "NO_SPELLCASTING", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_cougar", tile_category = "monster" },
}

-- override below is because apparently we have no owls in the game
ccb.content.define_mutation {
    id = "TURN_INTO_OWL_TRAITS",
    name = ccb.content.text_without_extraction("Owl Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are an owl.  This provides the actual effects of owl form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    body_temperature = { 500, 1200 },
    enchantments = {
        "INLINE_ENCH_TURN_INTO_OWL_TRAITS_0", "INLINE_ENCH_TURN_INTO_OWL_TRAITS_1",
        "INLINE_ENCH_TURN_INTO_OWL_TRAITS_2", "INLINE_ENCH_TURN_INTO_OWL_TRAITS_3",
    },
    flags = {
        "LEVITATION", "MUTE", "NO_SPELLCASTING", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_TINY", "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_albino_penguin", tile_category = "monster" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "LILIN_WAR_OWL_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Strix Form"),
    points = 98,
    ugliness = 30,
    visibility = 30,
    description = ccb.content.text_without_extraction("You are in strix form.  This provides the actual effects of strix form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    body_temperature = { 500, 1200 },
    enchantments = { "INLINE_ENCH_LILIN_WAR_OWL_FORM_TRAITS_0" },
    flags = { "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_LARGE" },
}

ccb.content.define_mutation {
    id = "WINGS_STRIX",
    name = ccb.content.text("Strix's Wings"),
    points = 98,
    ugliness = 0,
    visibility = 0,
    description = ccb.content.text("An enormous pair of dark-feathered wings have erupted from your back.  You can't fly, but you can glide or break your falls and make prodigious leaps with them."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_WINGS_STRIX_0" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "STRIX_SKIN",
    name = ccb.content.text_without_extraction("Strix's Skin"),
    points = 98,
    description = ccb.content.text_without_extraction("This exists only to carry a sprite ID"),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
}

-- NO_I18N
ccb.content.define_mutation {
    id = "TALONS_STRIX",
    copy_from = "TALONS",
    name = ccb.content.text_without_extraction("Talons"),
    points = 98,
    ugliness = 0,
    visibility = 0,
    description = ccb.content.text("Huge talons have erupted from your fingers, ready to rend your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    categories = { "LILIN" },
    integrated_armor = { "integrated_talons" },
    remove = { prerequisites = { "NAILS" } },
}

ccb.content.define_mutation {
    id = "TURN_INTO_RAVEN_TRAITS",
    name = ccb.content.text_without_extraction("Raven Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a raven.  This provides the actual effects of raven form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    body_temperature = { 300, 800 },
    enchantments = {
        "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_0", "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_1",
        "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_2", "INLINE_ENCH_TURN_INTO_RAVEN_TRAITS_3",
    },
    flags = {
        "LEVITATION", "MUTE", "NO_SPELLCASTING", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_TINY", "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_raven", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE_BUSH",
    name = ccb.content.text_without_extraction("Changeling Bush disguise"),
    points = 99,
    description = ccb.content.text_without_extraction("You are a bush and no one can see you."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    appearance = { id = "t_shrub", tile_category = "terrain" },
    flags = { "INVISIBLE", "NO_SCENT" },
}

-- NO_I18N
ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE_TREE",
    copy_from = "CHANGELING_DISGUISE_AS_NATURE_BUSH",
    name = ccb.content.text_without_extraction("Changeling Tree disguise"),
    appearance = { id = "t_tree", tile_category = "terrain" },
}

-- NO_I18N
ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE_POND",
    copy_from = "CHANGELING_DISGUISE_AS_NATURE_BUSH",
    name = ccb.content.text_without_extraction("Changeling Pond disguise"),
    appearance = { id = "t_water_sh", tile_category = "terrain" },
}

-- NO_I18N
ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE_GRASS",
    copy_from = "CHANGELING_DISGUISE_AS_NATURE_BUSH",
    name = ccb.content.text_without_extraction("Changeling Grass disguise"),
    appearance = { id = "t_grass_long", tile_category = "terrain" },
}

-- NO_I18N
ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE_ROCK",
    copy_from = "CHANGELING_DISGUISE_AS_NATURE_BUSH",
    name = ccb.content.text_without_extraction("Changeling Rock disguise"),
    appearance = { id = "f_boulder_medium", tile_category = "furniture" },
}

ccb.content.define_mutation {
    id = "GOBLIN_FRUIT_ANIMAL_IGNORE",
    name = ccb.content.text_without_extraction("Effect of furry fruit"),
    description = ccb.content.text_without_extraction("What makes the furry fruit work.  You should never see this."),
    valid = false,
    player_display = false,
    points = 0,
    ignored_by = {
        "MAMMAL", "AMPHIBIAN", "BIRD", "REPTILE", "FISH", "KRAKEN", "INSECT", "CENTIPEDE",
        "INSECT_FLYING", "SPIDER",
    },
}

-- Also used by vampires
ccb.content.define_mutation {
    id = "WINTER_FEIGN_DEATH_TRAITS",
    name = ccb.content.text_without_extraction("Stillness of the Tomb"),
    description = ccb.content.text_without_extraction("You are feigning death.  Shhhhhhh!"),
    valid = false,
    player_display = false,
    points = 0,
    ignored_by = {
        "MAMMAL", "AMPHIBIAN", "MUTANT", "CYBORG", "REPTILE", "FISH", "KRAKEN", "MIGO", "SLIME",
        "LEECH_PLANT", "INSECT", "CENTIPEDE", "INSECT_FLYING", "SPIDER", "BIRD", "MOLLUSK", "WORM",
        "ZOMBIE", "NETHER", "PLANT", "FERAL", "ROBOT", "HORROR", "ABERRATION", "HUMAN", "VAMPIRE",
        "NIGHTMARE", "CHANGELING", "ARVORE", "HOMULLUS", "IERDE", "SALAMANDER", "SYLPH", "UNDINE",
    },
    flags = { "NO_BODY_HEAT" },
}

ccb.content.define_mutation {
    id = "ASTRAL_PROJECTION_APPEARANCE",
    name = ccb.content.text_without_extraction("Astral Form"),
    description = ccb.content.text_without_extraction("You're a disembodied spirit so you're all glowy and blue.  Spooky!"),
    points = 0,
    valid = false,
    player_display = false,
    appearance = { id = "mon_hologram", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "CRAFTING_ASSISTANT_ARMS",
    name = ccb.content.text("Assistant's Arms"),
    points = 1,
    visibility = 10,
    description = ccb.content.text("Two arms emerge from your assistant, ready to help you with all crafting tasks."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_CRAFTING_ASSISTANT_ARMS_0", "INLINE_ENCH_CRAFTING_ASSISTANT_ARMS_1" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "MUTATION_COSMETIC_BUTTERFLY_WINGS",
    name = ccb.content.text_without_extraction("Butterfly Wings Sprite Mutation"),
    description = ccb.content.text_without_extraction("This exists only to tie a sprite to."),
    points = 0,
    valid = false,
    player_display = false,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "MUTATION_NO_RIGID_TORSO_ARMOR",
    name = ccb.content.text_without_extraction("No Rigid Torso Armor"),
    description = ccb.content.text_without_extraction("This exists only to prevent rigid armor on the torso."),
    points = 0,
    valid = false,
    player_display = false,
    restricts_gear = { "torso" },
    allow_soft_gear = true,
}
