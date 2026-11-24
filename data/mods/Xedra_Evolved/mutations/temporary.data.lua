local ccb = require("ccb")

-- Mostly copied from Huge with some Tough mixed in.  Strength bonus includes improvements from STR_UP mutation that's normally required for LARGE
ccb.content.define_mutation {
    id = "GOBLIN_FRUIT_GIANT_GROWTH",
    name = ccb.content.text("Giant-sized"),
    points = 2,
    visibility = 10,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Eating that goblin fruit has made you grow to enormous size!"),
    flags = { "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_HUGE" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    social_modifiers = { intimidate = 15 },
    enchantments = { "ench_giant_growth_size_bonuses", "INLINE_ENCH_GOBLIN_FRUIT_GIANT_GROWTH_1" },
}

-- Until the day EOCs can spawn equiped items, the fruit will give a mutation that holds the music player.
ccb.content.define_mutation {
    id = "GOBLIN_FRUIT_MUSIC",
    name = ccb.content.text_without_extraction("The fruit's song"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text_without_extraction("Gives the integrated music player.  Should not be player-visible."),
    integrated_armor = { "internal_mp3_fruit" },
}

-- No body part is intentional.  The wings should not be attackable by enemies or get in the way of clothes or armor.  These are also intended as less of a wide stat boost than the other dream toggleable mutations and instead specifically allow flight and carry weight.
ccb.content.define_mutation {
    id = "ethereal_wings",
    name = ccb.content.text("Ethereal Wings"),
    active = true,
    points = 1,
    visibility = 10,
    description = ccb.content.text("A wide set of ethereal wings sprouts from your back.  Despite them phasing through every form of matter you've encountered, they still somehow lift you off the ground.  Their mere appearance makes you feel lighter"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_ethereal_wings",
    enchantments = {
        "INLINE_ENCH_ethereal_wings_0",
        "INLINE_ENCH_ethereal_wings_1",
    },
    flags = { "GLIDE", "FEATHER_FALL" },
}

ccb.content.define_mutation {
    id = "karma_arms",
    name = ccb.content.text("Karma"),
    active = true,
    points = 1,
    visibility = 10,
    description = ccb.content.text("Ethereal hands appear behind your back, making you looks like an ancient god."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_karma_arms",
    enchantments = {
        "INLINE_ENCH_karma_arms_0",
        "INLINE_ENCH_karma_arms_1",
    },
}

ccb.content.define_mutation {
    id = "devil_tail",
    name = ccb.content.text("Devil's Tail"),
    active = true,
    points = 1,
    visibility = 6,
    description = ccb.content.text("While not actually a devil's, this long, triangular pointed tail can stretch very far, allowing it to easily kill someone nearby."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_devil_tail",
    enchantments = {
        "INLINE_ENCH_devil_tail_0",
        "INLINE_ENCH_devil_tail_1",
    },
}

ccb.content.define_mutation {
    id = "stalker_eyes",
    name = ccb.content.text("Stalker's Vision"),
    active = true,
    points = 1,
    visibility = 1,
    description = ccb.content.text("Your eyes transform into the orbits of an unknown creature.  You now see much better in the light and dark."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "dismiss_stalker_eyes",
    enchantments = {
        "INLINE_ENCH_stalker_eyes_0",
        "INLINE_ENCH_stalker_eyes_1",
    },
}

ccb.content.define_mutation {
    id = "LUCID_DREAM",
    name = ccb.content.text("Sleeper"),
    active = true,
    points = 99,
    description = ccb.content.text("You still sleep, yet your dreams still can impact the world.  Activate to wake up."),
    valid = false,
    starting_trait = false,
    purifiable = false,
    on_activate = "end_lucid_dream",
}

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

-- Tracker to save you from being a tree for too long.  Normally wouldn't need to display it but that throws an error about undisplayed active mutations
ccb.content.define_mutation {
    id = "CHANGELING_SPRING_TURN_INTO_TREE_TRACKER",
    name = ccb.content.text("Branch of Yggdrasil"),
    description = ccb.content.text("You are in the form of a tree."),
    points = 0,
    valid = false,
    mixed_effect = true,
    player_display = true,
    active = true,
    starts_active = true,
    wet_protection = {
        { part = "head", ignored = 40 },
        { part = "leg_l", ignored = 40 },
        { part = "leg_r", ignored = 40 },
        { part = "foot_l", ignored = 40 },
        { part = "foot_r", ignored = 40 },
        { part = "arm_l", ignored = 40 },
        { part = "arm_r", ignored = 40 },
        { part = "hand_l", ignored = 40 },
        { part = "hand_r", ignored = 40 },
        { part = "torso", ignored = 40 },
    },
    ignored_by = {
        "MAMMAL", "AMPHIBIAN", "MUTANT", "CYBORG", "REPTILE", "FISH", "KRAKEN", "MIGO", "SLIME",
        "LEECH_PLANT", "INSECT", "CENTIPEDE", "INSECT_FLYING", "SPIDER", "BIRD", "MOLLUSK", "WORM",
        "ZOMBIE", "NETHER", "PLANT", "FERAL", "ROBOT", "HORROR", "ABERRATION", "HUMAN", "VAMPIRE",
        "NIGHTMARE", "HOMULLUS",
    },
    appearance = { id = "t_tree", tile_category = "terrain" },
    on_process = "track_changeling_tree_healing",
}
