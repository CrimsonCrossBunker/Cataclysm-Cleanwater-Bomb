local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_SKIN_1",
    name = ccb.content.text("Clay of the Earth"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned the color of manganese stained soil.  Your skin is now a purplish black.  This has no gameplay effects."),
    types = { "skin_tone" },
    additions = { "IERDE_SKIN_2" },
    categories = { "IERDE", "FAIR_FOLK_COMMONER_TROW" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "IERDE_SKIN_2",
    name = ccb.content.text("Pebbled Skin"),
    points = 2,
    visibility = 4,
    ugliness = 3,
    description = ccb.content.text("Your skin has toughened and formed pebble-like growths in some places, acting as natural armor.  Somewhat reduces wet effects."),
    types = { "SKIN" },
    categories = { "IERDE", "FAIR_FOLK_COMMONER_TROW" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1" },
    replacements = { "IERDE_SKIN_3" },
    wet_protection = {
        { part = "head", ignored = 2 },
        { part = "leg_l", ignored = 5 },
        { part = "leg_r", ignored = 5 },
        { part = "foot_l", ignored = 2 },
        { part = "foot_r", ignored = 2 },
        { part = "arm_l", ignored = 4 },
        { part = "arm_r", ignored = 4 },
        { part = "hand_l", ignored = 1 },
        { part = "hand_r", ignored = 1 },
        { part = "torso", ignored = 6 },
    },
    integrated_armor = { "integrated_pebbled" },
    enchantments = { "INLINE_ENCH_IERDE_SKIN_2_0" },
    flags = { "TOUGH_FEET", "BARKY" },
}

ccb.content.define_mutation {
    id = "IERDE_SKIN_3",
    name = ccb.content.text("Stone Skin"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin has developed into strong granite-like covering that retains some flexibility and has grown to cover most of your body, acting as natural armor.  While difficult to penetrate, it also limits your flexibility.  Greatly reduces wet effects."),
    types = { "skin_tone" },
    prerequisites = { "IERDE_SKIN_2" },
    threshold_requirements = { "THRESH_IERDE" },
    categories = { "IERDE" },
    purifiable = false,
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "leg_l", ignored = 16 },
        { part = "leg_r", ignored = 16 },
        { part = "foot_l", ignored = 5 },
        { part = "foot_r", ignored = 5 },
        { part = "arm_l", ignored = 14 },
        { part = "arm_r", ignored = 14 },
        { part = "hand_l", ignored = 4 },
        { part = "hand_r", ignored = 4 },
        { part = "torso", ignored = 30 },
    },
    integrated_armor = { "integrated_granite_skin" },
    enchantments = { "INLINE_ENCH_IERDE_SKIN_3_0" },
    flags = { "TOUGH_FEET", "BARKY" },
}

ccb.content.define_mutation {
    id = "IERDE_EYES",
    name = ccb.content.text("Ierde Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde's eyes begin reflecting their mood: a pale white streaked with rose when happy; pale green or grey when calm, and pure obsidian black when angry.  Glare no longer impacts them and they are not bothered by light levels when sleeping.  In addition, they have much better night vision."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_EYES_0" },
}

ccb.content.define_mutation {
    id = "IERDE_EARS",
    name = ccb.content.text("Ierde Ears"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("The Ierde's ears are longer and pointed, like the peak of a high mountain.  They can hear slightly better and are unphased by loud sounds."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_EARS_0" },
    flags = { "IMMUNE_HEARING_DAMAGE" },
}

ccb.content.define_mutation {
    id = "IERDE_STONE_FISTS",
    name = ccb.content.text("Fists of Stone"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde's stony skin makes their fists hit like hammers.  Though their attacks are slower, the Ierde does more bashing damage with punches and can use their hands to replace some simple tools."),
    types = { "CLAWS" },
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    categories = { "IERDE" },
    purifiable = false,
    integrated_armor = { "integrated_ierde_fists" },
}

ccb.content.define_mutation {
    id = "IERDE_STRONG_EQUIPMENT",
    name = ccb.content.text("Stone-Hardened Panoply"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Just as their body is now one with the stone, the Ierde can infuse the strength of the earth into their equipment, rendering it more resilient.  While on natural earth or stone or underground, the Ierde's equipment is twice as difficult to damage."),
    prerequisites = { "IERDE_STONE_FISTS" },
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_STRONG_EQUIPMENT_0" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_SLEEP_MEDITATE",
    name = ccb.content.text("Unsleeping Earth Vigil"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to, while underground, rest and recover energy as though sleeping.  Activate to begin the vigil."),
    prerequisites = { "IERDE_EYES" },
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    on_activate = "ierde_no_sleep_meditate",
}

ccb.content.define_mutation {
    id = "IERDE_DETECT_NEARBY_MONSTERS_EARTH",
    name = ccb.content.text("The Soil Knows Those Who Tread Upon It"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to sense the movements of nearby creatures, as long as they maintains contact with natural earth or stone, or are underground."),
    prerequisites = { "IERDE_EYES" },
    secondary_prerequisites = { "IERDE_EARS" },
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = true,
    active = true,
    on_activate = "ierde_detect_monsters_on",
    on_deactivate = "ierde_detect_monsters_off",
}

ccb.content.define_mutation {
    id = "IERDE_CRAFT_IN_DARKNESS",
    name = ccb.content.text("Sense the Smallest Tremor"),
    points = 3,
    description = ccb.content.text("The Ierde's ability to sense small movements is heightened to such a degree that with small movements of their fingers, they can sense the exact shape and position of objects nearby.  They can craft in darkness, as long as \"The Soil Knows Those Who Tread Upon It\" is active."),
    prerequisites = { "IERDE_DETECT_NEARBY_MONSTERS_EARTH" },
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_CRAFT_IN_DARKNESS_0" },
}

ccb.content.define_mutation {
    id = "IERDE_SMASHING_PUNCH",
    name = ccb.content.text("Avalanche Blow"),
    points = 3,
    description = ccb.content.text("With a brief moment to stabilize themselves, the Ierde strikes a wall, door, or other terrain feature with the force of a falling boulder, doing many times their normal damage."),
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    on_activate = "ierde_smashing_punch",
}

ccb.content.define_mutation {
    id = "IERDE_STOMP_GROUND_SMASH",
    name = ccb.content.text("Earthquake Stomp"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to stomp on the ground and cause a minor local earthquake."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_NO_KNOCKBACK" },
    secondary_prerequisites = { "IERDE_SMASHING_PUNCH" },
    spells_learned = { ierde_stomp_ground_smash_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_KNOCKBACK_PUNCH",
    name = ccb.content.text("Mountain-Toppling Punch"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to strike an enemy with a blow that does extra damage and knocks them backwards."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SMASHING_PUNCH" },
    spells_learned = { ierde_knockback_punch_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_REVEAL_EARTH_MAP",
    name = ccb.content.text("Knowing Every Furrow"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to learn the terrain layout in a large area around themselves."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_PER_BONUS" },
    spells_learned = { ierde_reveal_earth_map_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_CREATE_PITS",
    name = ccb.content.text("Earthen Grasp"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to create large pits on diggable ground, dumping their enemies into them."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_RESHAPE_THE_EARTH" },
    spells_learned = { ierde_create_pits_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_SLOW_ENEMIES",
    name = ccb.content.text("Rigidity of Stone"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde may infuse the rigidity of stone into their enemies, slowing their movements."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_RESHAPE_THE_EARTH" },
    spells_learned = { ierde_slow_enemies_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_RESHAPE_THE_EARTH",
    name = ccb.content.text("Reshape the Living Earth"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde may reshape the earth, raising or lowering earth or stone or turning the one into the other."),
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_reshape_the_earth_spell = 1 },
}

-- Eventually add further spells in this area with more powerful elementals.
ccb.content.define_mutation {
    id = "IERDE_SUMMON_EARTH_ELEMENTAL",
    name = ccb.content.text("Calling the Children of the Stones"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Ierde to summon a minor earth elemental to support them in the world for a short time."),
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_summon_earth_spirit = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_IRON_ARMOR",
    name = ccb.content.text("Invulnerable Iron Skin"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Stone endures but armor is made of metal.  While standing on natural earth or stone, the Ierde can infuse their skin with metal, slowing their movement and encumbering them but rendering them much harder to damage."),
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_iron_armor_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_EARTH_SHIELD",
    name = ccb.content.text("Impenetrable Earthen Shield"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("While standing on natural earth or stone, the Ierde can summon up an earthen shield to protect themselves.  They will be invulnerable until the shield breaks."),
    prerequisites = { "IERDE_IRON_ARMOR" },
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_earthen_shield_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_BUFF_ARMOR_ALLIES",
    name = ccb.content.text("Skin of the Mountains"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("When gaining this ability, the Ierde gains the ability to infuse the resilience of the earth into one of their allies."),
    prerequisites = { "IERDE_IRON_ARMOR" },
    secondary_prerequisites = { "IERDE_STRONG_EQUIPMENT" },
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_buff_armor_allies_spell = 1 },
}

-- The name is a reference to Chapter 63 of Bleak House by Charles Dickens
ccb.content.define_mutation {
    id = "IERDE_NO_SCENT_AND_IRON",
    name = ccb.content.text("An Iron Taste and an Iron Smell"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde has taken the essence of iron into themselves.  They no longer smell anything like a human, smelling only like a faint whiff of iron if they have any scent at all, and can produce all their iron their body needs themselves."),
    prerequisites = { "IERDE_IRON_ARMOR" },
    categories = { "IERDE" },
    purifiable = false,
    vitamin_intervals = { iron = -1200 },
    flags = { "NO_SCENT" },
}

ccb.content.define_mutation {
    id = "IERDE_CARDIO",
    name = ccb.content.text("Tireless Strength of the Earth"),
    points = 2,
    description = ccb.content.text("The Ierde can draw on the boundless strength of the earth, increasing their stamina."),
    replacements = { "IERDE_CARDIO2" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_CARDIO_0" },
}

ccb.content.define_mutation {
    id = "IERDE_CARDIO2",
    name = ccb.content.text("Unceasing Strength of the Earth"),
    points = 5,
    description = ccb.content.text("The Ierde can draw even deeper on the boundless strength of the earth, greatly increasing their stamina."),
    replacements = { "IERDE_CARDIO3" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_CARDIO2_0" },
}

ccb.content.define_mutation {
    id = "IERDE_CARDIO3",
    name = ccb.content.text("Inexhaustible Strength of the Earth"),
    points = 8,
    description = ccb.content.text("The Ierde can draw from boundless strength of the very depths of the earth, enormously increasing their stamina."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_CARDIO3_0" },
}

ccb.content.define_mutation {
    id = "IERDE_REGAIN_STAMINA_UNDERGROUND",
    name = ccb.content.text("Stone Does Not Grow Weary"),
    points = 5,
    description = ccb.content.text("When underground or on natural earth, the Ierde recovers Stamina 50% faster."),
    categories = { "IERDE" },
    purifiable = false,
    replacements = { "IERDE_HEAL_FASTER_UNDERGROUND" },
    prerequisites = { "IERDE_CARDIO2", "IERDE_CARDIO3" },
    enchantments = { "INLINE_ENCH_IERDE_REGAIN_STAMINA_UNDERGROUND_0" },
}

ccb.content.define_mutation {
    id = "IERDE_HEAL_FASTER_UNDERGROUND",
    name = ccb.content.text("The Stone Endures"),
    points = 7,
    description = ccb.content.text("When underground or on natural earth, the Ierde recovers Stamina 50% faster and heals 33% faster."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_CARDIO2", "IERDE_CARDIO3" },
    secondary_prerequisites = { "IERDE_REGAIN_STAMINA_UNDERGROUND" },
    enchantments = { "INLINE_ENCH_IERDE_HEAL_FASTER_UNDERGROUND_0" },
}

ccb.content.define_mutation {
    id = "IERDE_FEEL_HALF_PAIN",
    name = ccb.content.text("Stone Does Not Cry Out"),
    points = 5,
    description = ccb.content.text("Like the stone, the Ierde suffers little from blows.  All pain is halved."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_REGAIN_STAMINA_UNDERGROUND", "IERDE_HEAL_FASTER_UNDERGROUND" },
    enchantments = { "INLINE_ENCH_IERDE_FEEL_HALF_PAIN_0" },
}

ccb.content.define_mutation {
    id = "IERDE_SINK_INTO_EARTH",
    name = ccb.content.text("In the Earthmother's Embrace"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to sink into the living earth, where they will heal faster, they will not need to eat or drink, and sleep will be more restful for them."),
    prerequisites = { "IERDE_REGAIN_STAMINA_UNDERGROUND", "IERDE_HEAL_FASTER_UNDERGROUND" },
    categories = { "IERDE" },
    purifiable = false,
    activation_setup_only = false,
    active = true,
    on_activate = "ierde_sink_into_earth",
    comfort = {
        {
            conditions = { { kind = "terrain", flag = "DIGGABLE" } },
            comfort = "very_comfortable",
            try_message = { text = ccb.content.text("You settle down to rest on the living earth."), rating = "good" },
        },
        {
            conditions = { { kind = "terrain", id = "t_rock" } },
            comfort = "very_comfortable",
            try_message = { text = ccb.content.text("Encased within the living earth, you drift off to sleep."), rating = "good" },
        },
    },
    enchantments = { "INLINE_ENCH_IERDE_SINK_INTO_EARTH_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STONE_SLEEP",
    name = ccb.content.text_without_extraction("Sleeping in the Earth"),
    description = ccb.content.text_without_extraction("You are resting in the depths of the earth.  You should never actually see this."),
    player_display = false,
    points = 0,
    enchantments = { "INLINE_ENCH_IERDE_STONE_SLEEP_0" },
}

-- Ideally there'd be a flag to let them bleed oil, but there doesn't currently seem to be
ccb.content.define_mutation {
    id = "IERDE_SLOW_BLEEDING",
    name = ccb.content.text("Blood of the Earth"),
    points = 2,
    description = ccb.content.text("The Ierde's blood has turned black and grown thick and tar-like.  They will bleed much more slowly."),
    categories = { "IERDE" },
    purifiable = false,
    replacements = { "IERDE_STOP_BLEEDING" },
    prerequisites = { "IERDE_HEAL_FASTER_UNDERGROUND" },
    enchantments = { "INLINE_ENCH_IERDE_SLOW_BLEEDING_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STOP_BLEEDING",
    name = ccb.content.text("Black Blood of the Earth"),
    points = 8,
    description = ccb.content.text("The Ierde's blood has turned into a black sludge that barely flows.  They no longer bleed at all."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_SLOW_BLEEDING" },
    flags = { "BLEED_IMMUNE" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_KNOCKBACK",
    name = ccb.content.text("The Mountain Does Not Move"),
    points = 4,
    description = ccb.content.text("Though the earth shivers and shakes, the mountain stands tall.  The Ierde is immune to knockback and can block attacks from a target of any size."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_STR_BONUS_1", "IERDE_STR_BONUS_2", "IERDE_STR_BONUS_3", "IERDE_STR_BONUS_4" },
    enchantments = { "INLINE_ENCH_IERDE_NO_KNOCKBACK_0" },
    flags = { "BLOCK_HUGE_ATTACKS" },
}

ccb.content.define_mutation {
    id = "IERDE_ROOTED_IN_PLACE",
    name = ccb.content.text("The Root of the Mountain"),
    points = 8,
    description = ccb.content.text("When standing on the living earth or underground, the Ierde can root themselves in place.  While doing so, they cannot move, but they are immune to being stunned, dazed, or downed, and gain additional armor."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_NO_KNOCKBACK" },
    secondary_prerequisites = { "IERDE_STR_BONUS_3", "IERDE_STR_BONUS_4" },
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 10,
    activation_message = ccb.content.text("You merge with the ground beneath your feet."),
    on_activate = "ierde_rooted_in_place_on",
    on_deactivate = "ierde_rooted_in_place_off",
}

ccb.content.define_mutation {
    id = "IERDE_TOUGH",
    name = ccb.content.text("Durability of the Earth"),
    points = 2,
    description = ccb.content.text("The Ierde has some of the toughness of the earth.  +15% hit points."),
    replacements = { "IERDE_TOUGH2" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_TOUGH_0" },
}

ccb.content.define_mutation {
    id = "IERDE_TOUGH2",
    name = ccb.content.text("Durability of the Stone"),
    points = 5,
    description = ccb.content.text("The Ierde has some of the toughness of the stone.  +30% hit points."),
    replacements = { "IERDE_TOUGH3" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_TOUGH" },
    enchantments = { "INLINE_ENCH_IERDE_TOUGH2_0" },
}

ccb.content.define_mutation {
    id = "IERDE_TOUGH3",
    name = ccb.content.text("Durability of the Mountain"),
    points = 9,
    description = ccb.content.text("The Ierde has the toughness of the enduring mountains.  +45% hit points."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SKIN_3" },
    secondary_prerequisites = { "IERDE_TOUGH2" },
    enchantments = { "INLINE_ENCH_IERDE_TOUGH3_0" },
}

ccb.content.define_mutation {
    id = "IERDE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to grow a goblin fruit from a earth or stone."),
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_1",
    name = ccb.content.text("Vigor of the Soil"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    replacements = { "IERDE_STR_BONUS_2" },
    description = ccb.content.text("Like the bountiful soil, the Ierde is filled with power.  +3 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_2",
    name = ccb.content.text("Vigor of the Stone"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_1" },
    secondary_prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    replacements = { "IERDE_STR_BONUS_3" },
    description = ccb.content.text("Like the stone, the Ierde can withstand any punishment.  +5 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_3",
    name = ccb.content.text("Vigor of the Mountain"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_2" },
    secondary_prerequisites = { "IERDE_CARDIO2" },
    replacements = { "IERDE_STR_BONUS_4" },
    description = ccb.content.text("Like the mountain, the Ierde is unmoved by calamity.  +7 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_3_0" },
}

ccb.content.define_mutation {
    id = "IERDE_STR_BONUS_4",
    name = ccb.content.text("Vigor of the Bedrock"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_3" },
    secondary_prerequisites = { "IERDE_HEAL_FASTER_UNDERGROUND" },
    description = ccb.content.text("Like the bedrock, the Ierde's might can support the entire world.  +9 Strength."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "INLINE_ENCH_IERDE_STR_BONUS_4_0" },
}

ccb.content.define_mutation {
    id = "IERDE_PER_BONUS",
    name = ccb.content.text("The Hills Overlook the Valleys"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_EYES" },
    description = ccb.content.text("Like an observer on a mountaintop, the Ierde sees more than most.  +3 Perception."),
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_PER_BONUS_0" },
}

ccb.content.define_mutation {
    id = "IERDE_FEEL_NO_PAIN",
    name = ccb.content.text("The Mountain Is Unflinching"),
    points = 12,
    description = ccb.content.text("While on living earth or stone or underground, the Ierde is as impassive as the mountains and feels no pain at all."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_FEEL_HALF_PAIN" },
    enchantments = { "INLINE_ENCH_IERDE_FEEL_NO_PAIN_0" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_DISEASE_OR_PARA",
    name = ccb.content.text("The Stone Does Not Rot"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_STR_BONUS_3", "IERDE_STR_BONUS_4" },
    description = ccb.content.text("The stones do not rot as the trees or humans do, and neither is the Ierde affected by the frailties of the flesh.  They are immune to disease and cannot suffer from parasites."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    flags = { "PARAIMMUNE", "NO_DISEASE" },
}

ccb.content.define_mutation {
    id = "IERDE_NO_MIND_PROBLEMS",
    name = ccb.content.text("Mind of Iron"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "IERDE_PER_BONUS" },
    secondary_prerequisites = { "IERDE_CARDIO3" },
    description = ccb.content.text("The Ierde's mind has the resilience of iron, and they cannot be affected by delusions, hallucinations, or other mental problems."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "ench_ierde_no_mind_problems" },
}

ccb.content.define_mutation {
    id = "IERDE_STONE_MEDITATIONS",
    name = ccb.content.text("Stone Meditations"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde meditates on the nature of stone and removes themselves from the highs and lows of mortal emotions."),
    categories = { "IERDE" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = 5000,
    activation_message = ccb.content.text("Your feelings calcify."),
    on_activate = "ierde_full_morale_neutralization",
}

ccb.content.define_mutation {
    id = "IERDE_TUNNEL_TRANSLOCATION",
    name = ccb.content.text("Traveling the Veins of the Earth"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to travel through stone to another underground location they have previously been to."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SINK_INTO_EARTH" },
    secondary_prerequisites = { "IERDE_STOP_BLEEDING" },
    spells_learned = { ierde_tunnel_translocation_spell = 1, ierde_tunnel_translocation_attune = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_STONE_FORM",
    name = ccb.content.text("Form of the Solid Earth"),
    points = 8,
    description = ccb.content.text("The Ierde may transform into rock and earth.  They become incredibly resilient and nearly immune to some forms of damage, but will be much, much slower."),
    prerequisites = { "IERDE_NO_KNOCKBACK" },
    secondary_prerequisites = { "IERDE_FEEL_NO_PAIN" },
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 2,
    consumes_mana = true,
    on_activate = "enable_trait_form",
    on_deactivate = "disable_trait_form",
}

ccb.content.define_mutation {
    id = "IERDE_STONE_FORM_TRAITS",
    name = ccb.content.text("Earthen Form"),
    description = ccb.content.text("You are a mass of stone and earth.  You are incredibly resilient, but you are extremely slow."),
    points = 10,
    valid = false,
    enchantments = { "ench_ierde_stone_form" },
    appearance = { id = "mon_stonegolem", tile_category = "monster" },
    flags = {
        "ACID_IMMUNE", "BIO_IMMUNE", "COLD_IMMUNE", "STAB_IMMUNE", "BULLET_IMMUNE", "SUFFOCATION_IMMUNE",
        "INHALED_TOXIN_IMMUNE", "MYCUS_IMMUNE", "GILLS", "CANNOT_CONSUME_DRUGS",
    },
}

ccb.content.define_mutation {
    id = "IERDE_NO_BROKEN_BONES",
    name = ccb.content.text("Body of Adamant"),
    points = 12,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde is so infused with the power of stone they are approaching invincibility.  There is a small chance that attacks against them simply rebound off their rocky skin, and their limbs are so resilient that they will never break."),
    prerequisites = { "IERDE_STONE_FORM" },
    secondary_prerequisites = { "IERDE_STOP_BLEEDING" },
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    enchantments = { "INLINE_ENCH_IERDE_NO_BROKEN_BONES_0", "INLINE_ENCH_IERDE_NO_BROKEN_BONES_1" },
}
