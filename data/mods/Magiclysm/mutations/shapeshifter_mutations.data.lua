local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DRUID_SHIFTER_BEAR_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Bear Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a bear.  This provides the actual effects of bear form.  Should not be player-visible"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_0", "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_1",
        "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_2", "INLINE_ENCH_DRUID_SHIFTER_BEAR_FORM_TRAITS_3",
    },
    flags = {
        "MUTE", "NO_SPELLCASTING", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_HUGE", "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_bear", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "DRUID_SHIFTER_COUGAR_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Cougar Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a cougar.  This provides the actual effects of cougar form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_0",
        "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_1",
        "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_2",
        "INLINE_ENCH_DRUID_SHIFTER_COUGAR_FORM_TRAITS_3",
    },
    flags = {
        "MUTE", "NO_SPELLCASTING", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_cougar", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "DRUID_SHIFTER_DEER_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Deer Form"),
    points = 98,
    description = ccb.content.text_without_extraction("You are a deer.  This provides the actual effects of deer form.  Should not be player-visible"),
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_0", "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_1",
        "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_2", "INLINE_ENCH_DRUID_SHIFTER_DEER_FORM_TRAITS_3",
    },
    integrated_armor = { "integrated_feline_fur" },
    flags = {
        "MUTE", "NO_SPELLCASTING", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_deer", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "DRUID_SHIFTER_FISH_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Fish Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a fish.  This provides the actual effects of fish form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_0", "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_1",
        "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_2", "INLINE_ENCH_DRUID_SHIFTER_FISH_FORM_TRAITS_3",
    },
    flags = {
        "EYE_MEMBRANE", "ITEM_WATERPROOFING", "GILLS", "HARDTOHIT", "MUTE", "NO_SPELLCASTING",
        "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_TINY", "TEMPORARY_SHAPESHIFT_NO_HANDS",
        "WALK_UNDERWATER", "WEBBED_HANDS",
    },
    wet_protection = {
        { part = "head", ignored = 100 },
        { part = "leg_l", ignored = 100 },
        { part = "leg_r", ignored = 100 },
        { part = "foot_l", ignored = 100 },
        { part = "foot_r", ignored = 100 },
        { part = "arm_l", ignored = 100 },
        { part = "arm_r", ignored = 100 },
        { part = "hand_l", ignored = 100 },
        { part = "hand_r", ignored = 100 },
        { part = "torso", ignored = 100 },
    },
    appearance = { id = "mon_fish_carp", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "DRUID_SHIFTER_RAVEN_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Raven Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a raven.  This provides the actual effects of raven form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    body_temperature = { 300, 800 },
    enchantments = {
        "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_0", "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_1",
        "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_2", "INLINE_ENCH_DRUID_SHIFTER_RAVEN_FORM_TRAITS_3",
    },
    flags = {
        "LEVITATION", "MUTE", "NO_SPELLCASTING", "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_TINY",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_raven", tile_category = "monster" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "DRUID_SHIFTER_MANA_REDUCER",
    name = ccb.content.text_without_extraction("Mana Reducer Druid Forms"),
    points = 0,
    description = ccb.content.text_without_extraction("Prevents you from regenerating mana while in druid shapeshifting form.  You should never actually see this."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_DRUID_SHIFTER_MANA_REDUCER_0" },
}

ccb.content.define_mutation {
    id = "DEMON_HORNS",
    name = ccb.content.text("Demon Horns"),
    description = ccb.content.text("Large ram horns curl around your ears on each side of your head.  Gives you a headbutt attack and head protection."),
    valid = false,
    starting_trait = false,
    mixed_effect = true,
    points = 0,
    types = { "HORNS" },
    visibility = 8,
    ugliness = 3,
    restricts_gear = { "head" },
    attacks = {
        {
            player_message = ccb.content.text("You headbutt %s with your horns!"),
            npc_message = ccb.content.text("%1$s headbutts %2$s with their horns!"),
            chance = 20,
            base_damage = { { type = "bash", amount = 20 } },
        },
    },
    armor = { { parts = { "head" }, resistances = { bash = 1, cut = 4 } } },
}

ccb.content.define_mutation {
    id = "DEMON_HOOVES",
    name = ccb.content.text("Demon Hooves"),
    description = ccb.content.text("Your toes have merged into cloven hooves, like that of a goat.  You also have coarse brown fur from the waist down."),
    valid = false,
    starting_trait = false,
    mixed_effect = true,
    points = 0,
    types = { "LEGS" },
    visibility = 3,
    ugliness = 4,
    wet_protection = { { part = "foot_l", neutral = 10 }, { part = "foot_r", neutral = 10 } },
    restricts_gear = { "foot_l", "foot_r" },
    armor = {
        { parts = { "foot_l", "foot_r" }, resistances = { bash = 1 } },
        { parts = { "leg_l", "leg_r" }, resistances = { cut = 1 } },
    },
    attacks = {
        {
            player_message = ccb.content.text("You kick %s with your hooves!"),
            npc_message = ccb.content.text("%1$s kicks %2$s with their hooves!"),
            chance = 15,
            strength_damage = { type = "bash", amount = 3 },
        },
    },
}

ccb.content.define_mutation {
    id = "DEMON_POSSES",
    name = ccb.content.text("Demonic Possession"),
    description = ccb.content.text("You are possessed by a greater demon, giving you great strength and combat abilities but reducing your fine motor control skills.  This gives you a slower crafting speed and the inability to cast spells."),
    valid = false,
    starting_trait = false,
    mixed_effect = true,
    points = 0,
    enchantments = { "INLINE_ENCH_DEMON_POSSES_0" },
    flags = { "NO_SPELLCASTING" },
}

-- Identical to HUGE_OK but uses the flag for temporary sizeshifting.
-- I am not using the biomancer version, as it has more bonuses than HUGE_OK and I want to keep the spell's balance identical while fixing the bug.
ccb.content.define_mutation {
    id = "DEMON_HUGE",
    flags = { "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_HUGE" },
    name = ccb.content.text("Huge"),
    points = 2,
    visibility = 4,
    ugliness = 3,
    valid = false,
    starting_trait = false,
    mixed_effect = true,
    description = ccb.content.text("Your cardiovascular system has caught up with your muscular physique, so who needs pathetic human cars?  Strength +4."),
    types = { "SIZE" },
    enchantments = { "INLINE_ENCH_DEMON_HUGE_0" },
    restricts_gear = { "torso", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l", "foot_r" },
    destroys_gear = true,
}

ccb.content.define_mutation {
    id = "DEMON_CLAWS",
    name = ccb.content.text("Demon Claws"),
    points = 2,
    visibility = 4,
    ugliness = 4,
    valid = false,
    starting_trait = false,
    mixed_effect = true,
    restricts_gear = { "hand_l", "hand_r" },
    integrated_armor = { "integrated_demon_claws" },
    description = ccb.content.text("Your index fingers have grown into huge talons.  After a bit of practice, you find that this does not affect your dexterity, but allows for a deadly unarmed attack.  They also prevent wearing gloves."),
    types = { "CLAWS" },
    cancels = { "ARM_TENTACLES", "ARM_TENTACLES_4", "ARM_TENTACLES_8" },
}

ccb.content.define_mutation {
    id = "DEMON_SKIN",
    name = ccb.content.text("Demon Skin"),
    points = 0,
    visibility = 3,
    ugliness = 2,
    description = ccb.content.text("Your skin is crimson."),
    types = { "skin_tone" },
    cancels = { "SPOTS" },
}

ccb.content.define_mutation {
    id = "DEMON_TAIL",
    name = ccb.content.text("Goat Tail"),
    points = 0,
    visibility = 1,
    ugliness = 2,
    description = ccb.content.text("You have a short, stubby goat tail."),
    types = { "TAIL" },
}

ccb.content.define_mutation {
    id = "BIOMANCER_NPC_WRETCH_POLYMORPH",
    name = ccb.content.text("Fleshwarped Wretch"),
    points = 0,
    visibility = 30,
    ugliness = 30,
    description = ccb.content.text("You have been transformed into a horrific pile of random parts."),
    valid = false,
    craft_skill_bonuses = { electronics = -20, tailor = -20, mechanics = -20, fabrication = -20 },
    encumbrance = { arm_l = 50, arm_r = 50, leg_l = 50, leg_r = 50, mouth = 50, eyes = 50, torso = 50, head = 50 },
    enchantments = { "INLINE_ENCH_BIOMANCER_NPC_WRETCH_POLYMORPH_0" },
    flags = {
        "MUTE",
        "HYPEROPIC",
        "MYOPIC_SUPERNATURAL",
        "NO_SPELLCASTING",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_baleful_polymorph_crawler", tile_category = "monster" },
}
