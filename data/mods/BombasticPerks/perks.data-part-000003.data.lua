local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_mighty_thews",
    name = ccb.content.text("Mighty Thews"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your rippling muscles enable you to split the skulls of your enemies.  +5% to Lifting, Grip, and Manipulator limb scores."),
    enchantments = { "INLINE_ENCH_perk_mighty_thews_0" },
}

ccb.content.define_mutation {
    id = "perk_pantherish_grace",
    name = ccb.content.text("Pantherish Grace"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your movements bring to mind a multitude of cat-based metaphors.  +5% to Balance, Footing, and Reaction limb scores."),
    enchantments = { "INLINE_ENCH_perk_pantherish_grace_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_eagle_eyes",
    name = ccb.content.text("Eagle Eyes"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your sharp gazes misses little.  +25% to Vision and Night Vision limb scores."),
    enchantments = { "INLINE_ENCH_perk_eagle_eyes_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_percussive_entry",
    name = ccb.content.text("Percussive Entry"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("If one kick doesn't open the door, just try another.  Or a few more.  How about another dozen or so?  You can up to double your strength for the purposes of smashing terrain; this bonus gradually increases over the course of multiple smashes."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_holdout_pocket",
    name = ccb.content.text("Holdout Pocket"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Never leave home without it!  You have a secret pocket no one knows about that can easily store a weapon."),
    integrated_armor = { "integrated_holdout_pocket" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_built_tough",
    name = ccb.content.text("Built Tough"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You're like a walking tank!  Take 5% less damage from all sources."),
    enchantments = { "INLINE_ENCH_perk_built_tough_0" },
    flags = { "PERK" },
}

-- The flesh material also protects against cut and bullets, so we need an enchant to do bash only
ccb.content.define_mutation {
    id = "perk_thick_skin",
    name = ccb.content.text("Thick Skin"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("All the beatings you've taken have toughened you up.  You can walk barefoot with no penalty, develop blisters in heat much more slowly, and take slightly less bash damage."),
    enchantments = { "INLINE_ENCH_perk_thick_skin_0" },
    flags = { "PERK", "BARKY", "TOUGH_FEET" },
}

ccb.content.define_mutation {
    id = "perk_hauler",
    name = ccb.content.text("Hauler"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("All that hauling has paid off.  You can carry 10kg of additional items."),
    enchantments = { "INLINE_ENCH_perk_hauler_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_vacationer",
    name = ccb.content.text("Vacationer"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Every day in the apocalypse is just like the beach.  You are more comfortable in cold and warm weather."),
    enchantments = { "INLINE_ENCH_perk_vacationer_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_gymrat",
    name = ccb.content.text("Gym Rat"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your time exercising has gotten you used to being drenched in your own sweat.  Being wet doesn't bother you as much anymore."),
    wet_protection = {
        { part = "head", neutral = 6 },
        { part = "leg_l", neutral = 8 },
        { part = "leg_r", neutral = 8 },
        { part = "foot_l", neutral = 2 },
        { part = "foot_r", neutral = 2 },
        { part = "arm_l", neutral = 8 },
        { part = "arm_r", neutral = 8 },
        { part = "hand_l", neutral = 12 },
        { part = "hand_r", neutral = 12 },
        { part = "torso", neutral = 10 },
    },
    flags = { "PERK" },
}

--  'To have your bell rung' means to be hit on the head.
ccb.content.define_mutation {
    id = "perk_bellringer",
    name = ccb.content.text("Bellringer"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You're very good at the follow-through when your enemies are reeling.  When in melee combat with an enemy that is dazed or stunned, you do +33% extra bash damage."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_thick_skull",
    name = ccb.content.text("Thick Skull"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've taken so many blows to the head you've lost count.  You've got additional skull armor."),
    integrated_armor = { "integrated_thick_skull" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_way_openpalm",
    name = ccb.content.text("Way of the Open Palm"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've dealt enough blows that your hands have callused, and your knifehand strikes are sharp enough to draw blood."),
    integrated_armor = { "integrated_hand_openpalm" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_way_closedfist",
    name = ccb.content.text("Way of the Closed Fist"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've dealt enough blows that your hands have callused, and your hammerfist strikes are as strong as a real hammer."),
    integrated_armor = { "integrated_hand_closedfist" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_way_pinchedfingers",
    name = ccb.content.text("Way of the Pinched Fingers"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've dealt enough blows that your hands have callused, your spearhand strikes can pierce armor, and your grip can turn bolts barehanded."),
    integrated_armor = { "integrated_hand_pinchedfingers" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_quickdraw",
    name = ccb.content.text("Quickdraw"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Practicing with handguns has improved your draw speed with pretty much everything.  Retrieve objects 25% faster from containers."),
    enchantments = { "INLINE_ENCH_perk_quickdraw_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_animal_friend",
    name = ccb.content.text("Animal Friend"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Even with everything that's happened, you still find solace in nature.  Natural animals are less likely to attack you."),
    flags = { "PERK", "ANIMALEMPATH" },
}

ccb.content.define_mutation {
    id = "perk_vengeful",
    name = ccb.content.text("Vengeful"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Oh, they're not getting away with THAT.  You do +15% damage for two turns after you're hit."),
    enchantments = { "perk_ench_vengeful" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_twice_shy",
    name = ccb.content.text("Twice Shy"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Pain is really painful; best to avoid it.  For five turns after you are hit, you gain +1 bonus dodge and +2 dodge skill."),
    flags = { "PERK" },
}

-- This is a pun, based on undying literally meaning 'does not die' but also the figurative meaning of an emotion that lasts forever.
ccb.content.define_mutation {
    id = "perk_undying_loyalty",
    name = ccb.content.text("Undying Loyalty"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You inspire your allies to protect you when you're seriously injured.  If attacked when your head or torso health are at 50% or lower, all allies within 15 meters will take 20% reduced damage for one minute.  This effect can only trigger once every five minutes."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_ghost_stealth",
    name = ccb.content.text("Ghost"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've gotten pretty good at sneaking up on people.  When you have no allies within 20 squares, enemies' vision detection range is reduced by 15%."),
    enchantments = { "INLINE_ENCH_perk_ghost_stealth_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_big_eater",
    name = ccb.content.text("Big Eater"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You can really put it away.  You eat food 10% faster and can eat 33% more food at a time."),
    enchantments = { "INLINE_ENCH_perk_big_eater_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_tuck_and_roll",
    name = ccb.content.text("Tuck and Roll"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("At some point you got really good at falling off rooftops.  Take 40% less fall damage."),
    enchantments = { "INLINE_ENCH_perk_tuck_and_roll_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_reduced_falling_damage",
    name = ccb.content.text("Catfall"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You always land on your feet and look graceful when doing it.  Reduce the number of stories by 1 when calculating fall damage."),
    flags = { "PERK", "ONE_STORY_FALL" },
}
