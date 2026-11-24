local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_STR_UP",
    name = ccb.content.text("Stronger"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been working out?  +1 Strength."),
    replacements = { "perk_STR_UP_2" },
    enchantments = { "INLINE_ENCH_perk_STR_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_STR_UP_2",
    name = ccb.content.text("Even Stronger"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been working out.  +2 Strength."),
    prerequisites = { "perk_STR_UP" },
    enchantments = { "INLINE_ENCH_perk_STR_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_DEX_UP",
    name = ccb.content.text("Faster"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been doing cardio?  +1 Dexterity."),
    replacements = { "perk_DEX_UP_2" },
    enchantments = { "INLINE_ENCH_perk_DEX_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_DEX_UP_2",
    name = ccb.content.text("Even Faster"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been doing cardio.  +2 Dexterity."),
    prerequisites = { "perk_DEX_UP" },
    enchantments = { "INLINE_ENCH_perk_DEX_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_INT_UP",
    name = ccb.content.text("Smarter"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been reading?  +1 Intelligence."),
    replacements = { "perk_INT_UP_2" },
    enchantments = { "INLINE_ENCH_perk_INT_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_INT_UP_2",
    name = ccb.content.text("Even Smarter"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been reading.  +2 Intelligence."),
    prerequisites = { "perk_INT_UP" },
    enchantments = { "INLINE_ENCH_perk_INT_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_PER_UP",
    name = ccb.content.text("Sharper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Have you been staring out into the middle distance?  +1 Perception."),
    replacements = { "perk_PER_UP_2" },
    enchantments = { "INLINE_ENCH_perk_PER_UP_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_PER_UP_2",
    name = ccb.content.text("Even Sharper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You HAVE been staring out into the middle distance.  +2 Perception."),
    prerequisites = { "perk_PER_UP" },
    enchantments = { "INLINE_ENCH_perk_PER_UP_2_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_sight_beyond_sight",
    name = ccb.content.text("Sight Beyond Sight"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have an instinctive sense for the uncanny and unearthy.  Activate this perk to close your eyes and become aware of nearby Nether creatures."),
    activation_setup_only = true,
    active = true,
    flags = { "PERK" },
    on_activate = "toggle_sight_beyond_sight",
    on_deactivate = "toggle_sight_beyond_sight",
}

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

ccb.content.define_mutation {
    id = "perk_grit_your_teeth",
    name = ccb.content.text("Grit Your Teeth"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("When you have to you can wipe the blood off your chin, grit your teeth, and get it done.  Use to reduce your pain by 30 or half (whichever is greater) for 3 minutes.\n\nThe cooldown on this perk scales based on your pain at the time you used it."),
    active = true,
    activation_setup_only = false,
    on_activate = "perk_grit_your_teeth",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_slippery_escape",
    name = ccb.content.text("Slippery Escape"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your joints are flexible enough that you can twist out of nearly anything when given a mind, though that doesn't make it hurt any less.  At the cost of some pain, you can twist out of enemy grabs."),
    active = true,
    activation_setup_only = false,
    activation_message = ccb.content.text("You twist out of the grab with a wrench!"),
    on_activate = "perk_slippery_escape",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_surgical_strikes",
    name = ccb.content.text("Surgical Strikes"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Careful aim allows you to take down game with little tissue damage.  Enemies you kill tend to stay intact."),
    enchantments = { "INLINE_ENCH_perk_surgical_strikes_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_bloody_mess",
    name = ccb.content.text("Bloody Mess"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("For whatever reason you seem to always make a real mess of things.  Enemies you kill tend to explode into a mess of viscera."),
    enchantments = { "INLINE_ENCH_perk_bloody_mess_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_perfect_time",
    name = ccb.content.text("Perfect Timing"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You used to annoy your friends before the Cataclysm by always being *exactly* on time and you've maintained that characteristic to this day.  You always know what time it is and can set alarms even without a watch or a phone."),
    flags = { "PERK", "WATCH", "ALARMCLOCK" },
}

ccb.content.define_mutation {
    id = "perk_all_terrain",
    name = ccb.content.text("All Terrain"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have a persistent sense of how to move around in sharp and rough terrain.  You'll never accidently snag or cut yourself on protrusions from the ground."),
    flags = { "PERK", "ALL_TERRAIN_NAVIGATION" },
}

ccb.content.define_mutation {
    id = "perk_situational_uncanny_dodge",
    name = ccb.content.text("Evasion"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You're so good at dodging that almost nothing can touch you as long as you're on your game.  You have passive Uncanny Dodge until you take damage, after which it takes a few minutes for you to recover your poise."),
    enchantments = { "INLINE_ENCH_perk_situational_uncanny_dodge_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_safety_squint",
    name = ccb.content.text("The Safety Squint"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("They told it to you as a joke, but you always knew it was real and now you've figured out how to do it.  With the proper squinting technique, you can safely weld without any external protection, though you won't be able to see much of your surroundings.  Activate to toggle."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You squint your eyes just right."),
    on_activate = "safety_squint_on",
    on_deactivate = "safety_squint_off",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_bedtime_reader",
    name = ccb.content.text("Bedtime Stories"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always loved reading, especially before you fall asleep, and have gotten very good at tearing through books as a way to wind down.  You read books 50% faster, but only when you read them between 8 p.m. and 1 a.m."),
    enchantments = { "INLINE_ENCH_perk_bedtime_reader_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_tingly",
    name = ccb.content.text("Tingly"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Ever since the apocalypse you get a funny feeling during storms and have trouble trusting small appliances.  You usually have a pretty good idea where they are though."),
    enchantments = { "INLINE_ENCH_perk_tingly_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_static_stockpile",
    name = ccb.content.text("Static Stockpile"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You can't touch a door without zapping yourself.  Whenever there is a shocker or a robot within 15 squares, or you are outside during a storm, you gain 500J of bionic power per second and your melee attacks will do a small amount of extra electrical damage."),
    enchantments = { "INLINE_ENCH_perk_static_stockpile_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_jumpy",
    name = ccb.content.text("Jumpy"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've not been the same since the apocalypse, almost everything makes you jump.  You are just a bit quicker to act though."),
    enchantments = { "INLINE_ENCH_perk_jumpy_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_quick_recovery",
    name = ccb.content.text("Quick Recovery"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You get knocked down, but you get up again.  There is a 75% chance when you are downed that you will stand up again immediately."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_sleepy",
    name = ccb.content.text("Easy Sleeper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always been able to fall asleep within a few minutes of closing your eyes, no matter what else is going on around you.  You have a much easier time falling asleep."),
    enchantments = { "INLINE_ENCH_perk_sleepy_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_running_in_heels",
    name = ccb.content.text("Running in Heels"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have mastered the ways of the 90s action heroine.  Heels only encumber you as much as normal shoes."),
    enchantments = { "INLINE_ENCH_perk_running_in_heels_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_early_to_rise",
    name = ccb.content.text("Early to Rise"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("That health, wealth, and wisdom is coming any day now.  When you wake up between 4 and 7 a.m., you gain a mood boost for that morning."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_duck_and_weave",
    name = ccb.content.text("Duck and Weave"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Run without rhythm.  After a short wind-up period, you gain 5 effective dodge and +1 bonus dodge attempt as long as you keep running."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_hobbyist",
    name = ccb.content.text("Hobbyist"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("No work, no social obligations, lots of time to focus on your hobbies.  You feel like you've been picking up skills faster recently."),
    enchantments = { "INLINE_ENCH_perk_hobbyist_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_non_combatant",
    name = ccb.content.text("Non-Combatant"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Hey, that's against the Geneva Convention!  When completely unarmed, you take -25% reduced damage."),
    enchantments = { "INLINE_ENCH_perk_non_combatant_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_recycler",
    name = ccb.content.text("Recycler"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Even with no one around you feel obligated to clean up the streets.  You find full cans of soda in the weirdest places."),
    active = true,
    activation_setup_only = true,
    on_activate = "can_finder_on",
    on_deactivate = "can_finder_off",
    on_process = "can_hunting",
    cooldown = 24000,
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_second_wind",
    name = ccb.content.text("Second Wind"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Anyone can pause and catch their breath but you're extremely good at doing so.  You can regenerate one-third of your stamina over ten seconds, once every fifteen minutes.  Being hit will interrupt the regeneration."),
    active = true,
    activation_message = "",
    on_activate = "perk_second_wind",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_troubleseeker",
    name = "Trouble Seeker",
    description = "As if the apocalypse itself wasn't enough, you are constantly looking for some trouble.  Zombies somehow sometimes sense your presence and approach you.  Fortunately, they always appear at a good distance from you.  Activate to toggle.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    cooldown = 20000,
    flags = { "PERK" },
    on_activate = "w16b_mut_activate_bombasticperks_ad215ed3fc3d",
    on_deactivate = "w16b_mut_deactivate_bombasticperks_8c184449b0e1",
    on_process = "w16b_mut_process_bombasticperks_d1deb6f5758f",
}

ccb.content.define_mutation {
    id = "perk_blood_drinker",
    name = ccb.content.text("Hemophage"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You do not drink…wine.  You are immune to the negative consequences of drinking blood, such as parasitic infection."),
    flags = { "PERK", "HEMOVORE" },
}

ccb.content.define_mutation {
    id = "perk_blood_drinking_heal",
    name = ccb.content.text("The Blood is the Life"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Drinking blood makes you feel really good.  REALLY good.  So good that all your aches and pains just seem to fade away.  Every time you drink blood, you heal a bit of damage and lose a bit of pain."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_popeye",
    name = ccb.content.text("Of Sailors and Spinach"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You spent several years on the high sea and now your muscles visibly swell and clench when you eat raw spinach."),
    active = true,
    on_activate = "spinach_consumption",
    flags = { "PERK" },
}

-- The beginning of this description is a reference to the Looney Tunes short 'Robin Hood Daffy'
ccb.content.define_mutation {
    id = "perk_fencing_footwork",
    name = ccb.content.text("Fancy Footwork"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Ho!  Ha-Ha!  Guard!  Turn!  Parry!  Dodge!  Spin!  Ha!  Thrust!  When wielding a fencing weapon, you gain +1 bonus dodge and slightly reduced move cost on flat terrain."),
    enchantments = { "INLINE_ENCH_perk_fencing_footwork_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_fish_in_water",
    name = ccb.content.text("Like a Fish in the Water"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("So unremarkable that there's no proverb about it.  When in deep water, your stamina regeneration is doubled, and you can swim 25% faster."),
    enchantments = { "INLINE_ENCH_perk_fish_in_water_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_artifact_resonance_detection",
    name = "Nether Resonator",
    description = "You get a tingling feeling when you hold the objects that the Cataclysm seems to have given anomalous properties to.  Activate to determine roughly how much resonance an artifact has.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    flags = { "PERK" },
    activation_message = "You close your eyes for a moment and look for the inner hum.",
    on_activate = "w16b_mut_activate_bombasticperks_51b0edbfc83d",
}

ccb.content.define_mutation {
    id = "perk_artifact_resonance_reduction",
    name = ccb.content.text("Relic Wielder"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your frequent handling of artifacts has allowed you to bleed off some of the side effects of their presence.  Your accumulated artifact resonance is reduced by 1500."),
    enchantments = { "INLINE_ENCH_perk_artifact_resonance_reduction_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_artifact_resonance_exploitation",
    name = ccb.content.text("Resonating Empowerment"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your frequent handling of artifacts has allowed you to redirect some of the otherworldly power they carry.  When suffering from resonance effects, you gain a variety of minor bonuses such as resistance to fire, electricity, or cold, increased dodge, or increased stamina regeneration."),
    enchantments = { "INLINE_ENCH_perk_artifact_resonance_exploitation_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_frakenstein",
    name = ccb.content.text("Playing God"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've been dissecting critters since high school.  Last night a voice gave you an idea for how to bring them back to life.  Activate the perk to gain insight into the nature of life itself!"),
    active = true,
    flags = { "PERK" },
    on_activate = "frankenstein_insight",
}

ccb.content.define_mutation {
    id = "perk_safety_net",
    name = ccb.content.text("Safety Net"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always felt like someone was looking out for you upstairs.  When you are attacked there is a 5% chance the attack will deal no damage."),
    enchantments = { "INLINE_ENCH_perk_safety_net_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_lucky_dodge",
    name = ccb.content.text("Lucky Dodge"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have a habit of always ducking at the right time.  You have a 5% chance to dodge any incoming attack."),
    enchantments = { "INLINE_ENCH_perk_lucky_dodge_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_long_shot",
    name = ccb.content.text("Long Shot"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You always ate your carrots, that good eyesight is paying off.  You can use ranged weapons effectively up to 4 more tiles away."),
    enchantments = { "INLINE_ENCH_perk_long_shot_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_firstest_aid",
    name = ccb.content.text("Firstest Aid"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("It's called \"First Aid\", right, so obviously it's better the faster you apply it.  Your bandages are 50% better at stopping bleeding, but only if you apply them within 2 minutes of taking damage."),
    enchantments = { "INLINE_ENCH_perk_firstest_aid_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_absit_invidia",
    name = ccb.content.text("Absit Invidia"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your Nana told you about the evil eye and how to protect yourself when you were a small child.  You don't remember her telling you the evil eye was giant, disembodied, and on fire, but some of the things she taught you work all the same.  You are immune to the Tainted Mind effect as long as you're wearing a holy symbol necklace, and can use some salt to remove it if you do acquire it."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_metamagic_quicken",
    name = ccb.content.text("Metamagic: Quicken Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells in a way that is much quicker, but also more wasteful.  -95% cast time, +100% cast cost.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your quicken metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_extended",
    name = ccb.content.text("Metamagic: Extended Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to make the effects of your spells last much longer for the same amount of mana with a more challenging invocation.  +100% duration, +4 difficulty.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your extended metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_widen",
    name = ccb.content.text("Metamagic: Widen Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells that affects a larger area.  +100% area of effect, +50% cast cost.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your widen metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_reach",
    name = ccb.content.text("Metamagic: Reach Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells from a longer distance.  +100% reach, +50% cast cost.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your reach metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_silent",
    name = ccb.content.text("Metamagic: Silent Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells quietly.  -100% noise, +20% cast cost, ignores mouth encumbrance.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your silent metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_still",
    name = ccb.content.text("Metamagic: Still Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You have learned to cast spells without moving.  +20% cast cost, ignores arm, leg, and hand encumbrance.  Can cast spells while holding items.  Can be toggled on or of by activating this trait.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your still metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_careful",
    name = ccb.content.text("Metamagic: Careful Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You take your time when casting spells in order to get it right.  +200% cast time, -5 difficulty.  Can be toggled on or of by activating this trait."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your careful metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_efficient",
    name = ccb.content.text("Metamagic: Efficient Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You can cast your spells more efficiently at the cost of a more difficult cast.  *75% casting cost, +5 difficulty.  Can be toggled on or of by activating this trait."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your efficient metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_metamagic_intuitive",
    name = ccb.content.text("Metamagic: Intuitive Spell"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Casting spells comes more naturally for you.  You don't have to think as much when casting.  Focus no longer affects casting, +20% cast cost.  Can be toggled on or of by activating this trait.  Only affects spells that are affected by focus.  Does not work on spells that consumes runes."),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You activate your intuitive metamagic."),
    flags = { "PERK" },
    on_activate = "metamagic_enable",
    on_deactivate = "metamagic_disable",
}

ccb.content.define_mutation {
    id = "perk_crafty_hands",
    name = ccb.content.text("Crafty Hands"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You really like to do stuff with your own hands.  +10% for crafting speed."),
    enchantments = { "INLINE_ENCH_perk_crafty_hands_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_chainsmoker",
    name = ccb.content.text("Chainsmoker"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Smoking is bad, but damn it's badass.  You deal more damage and shoot more accurately when you smoke."),
    enchantments = { "INLINE_ENCH_perk_chainsmoker_0", "INLINE_ENCH_perk_chainsmoker_1" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_praise",
    name = ccb.content.text("Complimentary Remarks"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The way you take care of the enemies is commendable, so much so that someone or something seems to praise your ways of fighting.  For every kills you have made, a praise may be given in the message log."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_belowthebelt",
    name = ccb.content.text("Below the Belt"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("After some time surviving in the apocalypse, you realized that you don't have to fight fair in melee combat.  Now you can hit below the belt on most humanoid monsters."),
    flags = { "PERK" },
}

-- An obvious pun on the word `hirsute`
ccb.content.define_mutation {
    id = "perk_hairsuit",
    name = ccb.content.text("Hairsuit"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've gained the ability to weave your long and luxurious hair into a protective and form-fitting bodysuit.  High heels and handgun skills sold separately."),
    integrated_armor = { "hair_suit_off" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_empath",
    name = ccb.content.text("Empath"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always had a passion for people, and a deep understanding of their thoughts and feelings.  Now that almost everyone's dead that has to extend to other things too!  When you kill a creature gain some of its abilities temporarily."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_jugg",
    name = ccb.content.text("Iron Arm"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always been a bit of a bull in a china shop; people used to call you heavy handed but now they aren't saying much at all.  You deal extra damage based on how protective your right arm is."),
    enchantments = { "INLINE_ENCH_perk_jugg_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_skeleton",
    name = ccb.content.text("Skin and Bones"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("People always used to tell you that you should eat more.  It seems you needed their reminders because you can see your bones at this point.  You have skeletal armor."),
    integrated_armor = { "skeleton_plate" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_eating_window",
    name = ccb.content.text("Compressed Eating Window"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You're so used to squeezing all your meals into a short time that your body has adapted to it.  You gain 2.5 times as many calories and vitamins from any meals eaten between noon and 6 p.m., but 0 calories and vitamins for any meals eaten outside that time period."),
    enchantments = { "INLINE_ENCH_perk_eating_window_0", "INLINE_ENCH_perk_eating_window_1" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_chainsaw",
    name = ccb.content.text("The Great Communicator"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always had something to say about ripping apart things with chainsaws.  You can swing powered blades faster."),
    enchantments = { "INLINE_ENCH_perk_chainsaw_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_olde_guns",
    name = ccb.content.text("Olde Reliables"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always had a bit of a fondness for the older firearms.  Post apocalypse, this has translated into a damage boost when using WWII and older weapons."),
    enchantments = { "INLINE_ENCH_perk_olde_guns_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_dice_addition_damage",
    name = ccb.content.text("Damage Dice"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Before Cataclysm, you always used dice to determine the damage in the game.  Now, the power of fate allows you to use dice to deal additional mysterious damage.  Throwing dice using a sling or similar weapon deals additional damage, which depends on the number of sides of the dice."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_moonstruck",
    name = ccb.content.text("Moonstruck"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've always been greatly affected by the phases of the moon.  During a full moon, you gain a +3 bonus to all stats.  During a waxing moon, you gain a +1 bonus to all stats, and during a new moon, you suffer a -2 penalty to all stats."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_rage_against_unnatural",
    name = ccb.content.text("In a Crimson Mist"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Far from being terrified or even unnerved by the creatures of the Nether, their presence fills you with atavistic killing fury.  You do +35% melee damage when in melee combat with Nether beings and take 15% less damage from all sources, but if you attack any other target when there is a Nether-beast to slay, you suffer a large penalty to your accuracy."),
    enchantments = { "INLINE_ENCH_perk_rage_against_unnatural_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_soup_healing",
    name = ccb.content.text("Soup for the Soul"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Just like mama used to make and it tastes just as good too.  When you eat chicken noodle soup, you heal a small amount of HP on all limbs and cure any cold, flu, and poisoning you're suffering from."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_kevlard",
    name = ccb.content.text("Kevlard"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Conventional wisdom says it's not healthy to be fat, but you're nothing if not unconventional.  Your natural padding acts as a ballistic vest, and the fatter you are, the more protection you'll get.  You must be at least Obese to receive any benefit."),
    enchantments = { "INLINE_ENCH_perk_kevlard_0", "INLINE_ENCH_perk_kevlard_1", "INLINE_ENCH_perk_kevlard_2" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_nocturnal",
    name = ccb.content.text("Nocturnal"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Darkness is your ally.  Others have merely adopted the dark, but you were born in it, molded by it.  You gain +2 Perception and +1 Intelligence at night, and have a much easier time sleeping during the day.  However, you also suffer -2 Perception when outdoors during the day and have a harder time sleeping at night."),
    enchantments = {
        "INLINE_ENCH_perk_nocturnal_0",
        "INLINE_ENCH_perk_nocturnal_1",
        "INLINE_ENCH_perk_nocturnal_2",
    },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_second_chance",
    name = ccb.content.text("Second Chance"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Something is watching over you, though whether for good or ill you cannot tell.  The first time you suffer fatal damage, you will heal slightly, remove all pain, and gain a speed bonus, temperature immunity, and immunity to damage for a very short time.  After that expires, though, you're on your own to resolve whatever problem you're in.  This perk <color_red>only works once</color>."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_gunslinger",
    name = ccb.content.text("Gunslinger"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("I do not aim with my hand.  He who aims with his hand has…uh, you forget what comes next.  When using pistols, you aim 75% faster and reload 45% faster."),
    enchantments = { "INLINE_ENCH_perk_gunslinger_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_ascetic_empowerment",
    name = ccb.content.text("Ascetic Empowerment"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("People talk about getting a high from fasting and for you that's true on a more visceral level.  You gain bonuses to all stats that scale with how hungry, thirsty, and tired you are."),
    enchantments = {
        "INLINE_ENCH_perk_ascetic_empowerment_0", "INLINE_ENCH_perk_ascetic_empowerment_1",
        "INLINE_ENCH_perk_ascetic_empowerment_2", "INLINE_ENCH_perk_ascetic_empowerment_3",
        "INLINE_ENCH_perk_ascetic_empowerment_4",
    },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_thickblood",
    name = ccb.content.text("Thick-blooded"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your blood has always been thicker than most, making you lose less of it when bleeding."),
    enchantments = { "INLINE_ENCH_perk_thickblood_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_dream_armor",
    name = ccb.content.text("Armor of Dreams"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("People often say that they feel safer when they sleep, but in your case you are literally safer when asleep.  As long as you sleep, most attacks won't injure you."),
    enchantments = { "INLINE_ENCH_perk_dream_armor_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_redrage",
    name = ccb.content.text("Red Rage"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You hate the feeling of your blood leaking so much that it empowers you.  You deal more melee damage the more you are bleeding."),
    enchantments = { "INLINE_ENCH_perk_redrage_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_peer_pressure",
    name = ccb.content.text("Peer Pressure"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You know how to leverage your allies' presence when talking with others, granting you a small boost to lying, persuading and intimidating for each nearby ally."),
    enchantments = { "INLINE_ENCH_perk_peer_pressure_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_poison_painkill",
    name = ccb.content.text("Numb from the Toxin"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Poisons tend to make you feel numb.  When poisoned, feel 80% less pain."),
    enchantments = { "INLINE_ENCH_perk_poison_painkill_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_unopenable_grip",
    name = ccb.content.text("Unopenable Grip"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("After having things you held in your hands stolen countless times, your grip became strong enough to keep anything in your hands as long as you will it.  Activate to toggle the ability to drop your held item."),
    categories = { "perk" },
    active = true,
    activation_setup_only = false,
    on_activate = "unopenable_grip",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_boomstick_blast",
    name = ccb.content.text("Boomstick Blast"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("People hit by shotgun blasts always seem to go flying in actions movies, but it doesn't work that way in real life.  At least, it didn't.\n\nWhen you damage a target within 2 squares using a shotgun and do at least 15 damage, your target will suffer knockback."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_radio_infusion",
    name = ccb.content.text("Radioactive Infusion"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You somehow learned to focus on an item to make it emit radiation forever.  You still have trouble understanding how this could ever be useful, but maybe you might find a use for it.  Activate to use."),
    active = true,
    activation_setup_only = false,
    on_activate = "radio_infusion",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_smash_boost",
    name = ccb.content.text("Smashing for Wimps"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Strong you might not be, but you can still break things down by hitting them the right way.  You get a bonus to your smashing ability that increases the weaker you are."),
    enchantments = { "INLINE_ENCH_perk_smash_boost_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_speedballing",
    name = ccb.content.text("Speedballing"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You love the rush of taking different drugs at once, and now this rush is much more impactful than before.  You gain +3 speed for each recreational or combat-enhancing drug currently affecting you."),
    enchantments = { "INLINE_ENCH_perk_speedballing_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_flawless_memory",
    name = ccb.content.text("Flawless Memory"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You cannot forget anything at all, ever.  This grants you the ability to memorize books for you to read in your head later and makes you able to store mental images so detailled it's almost as if you were taking pictures with your mind."),
    integrated_armor = { "integrated_memory" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_forge_blood",
    name = ccb.content.text("Blood of the Forge"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your blood might not be able to make weapons, but it still can make anything coated with sturdier but unable to be repaired.  Activate to use."),
    active = true,
    activation_setup_only = false,
    on_activate = "forge_blood",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_dexterous_speed",
    name = ccb.content.text("Dexterous Speed"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You've found that you can move just a little bit quicker the more dexterous you are.  Unfortunately, this applies comes at a loss to your max carry weight.  Gain 2 speed for every point of DEX away from 8.  You lose 4% of your max carry weight for each point between 8 and 20 DEX, and 2% for each point beyond 20."),
    enchantments = {
        "INLINE_ENCH_perk_dexterous_speed_0", "INLINE_ENCH_perk_dexterous_speed_1",
        "INLINE_ENCH_perk_dexterous_speed_2",
    },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_bird",
    name = ccb.content.text("Stormwrought: Bird"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_feline",
    name = ccb.content.text("Stormwrought: Feline"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_insect",
    name = ccb.content.text("Stormwrought: Insect"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_lupine",
    name = ccb.content.text("Stormwrought: Lupine"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_plant",
    name = ccb.content.text("Stormwrought: Plant"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_portal_storm_mutator_spider",
    name = ccb.content.text("Stormwrought: Spider"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Exposure to portal storms and related phenomena causes your body change along predictable lines.  When out in a portal storm without any protection, you periodically have a chance to mutate."),
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "revolvers_are_cool",
    name = ccb.content.text("Double Action Action"),
    description = ccb.content.text("You always knew nothing can beat the good old six shooters.  You have a minor bonus using revolvers."),
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_revolvers_are_cool_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "22_is_cool",
    name = ccb.content.text("Rimfire Rebel"),
    description = ccb.content.text("You always appreciated the size of this little fella named \"Dot Two Two Long Rifle\", but they laughed at you.  Not anymore!  You found that the size of a bullet that small is perfect to hit into little spots between armor or narrow places.  .22 weapons have additional armor penetration and quadrupled chance to hit a weakpoint."),
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_22_is_cool_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_yeoman",
    name = ccb.content.text("Yeoman"),
    description = ccb.content.text("In a world of guns, you were born to string a bow.  With such weapons you draw back further, increasing damage and range, and your arrows strike true with unerring accuracy."),
    points = 0,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_perk_yeoman_0" },
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_secret_closet_storage",
    name = "Closetland",
    description = "When you were little you remember thinking that your closet was a portal to a secret realm and if you just knew the way to open the path, you could find your way through to another world.  Well, you've found the way.\n\nWhen in a closet (walls on all sides except for one closed door), activate this perk to transport you to a secret realm.  Deactivate this perk to transport you back to your entrance point.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    flags = { "PERK" },
    on_activate = "w16b_mut_activate_bombasticperks_a528f34cf943",
    on_deactivate = "w16b_mut_deactivate_bombasticperks_f5e8854074ae",
    on_process = "w16b_mut_process_bombasticperks_cbe683736288",
}

ccb.content.define_mutation {
    id = "perk_secret_closet_teleporter_paths",
    name = "Closetland Paths",
    description = "Your experience with Closetland has grown and you think you can find your way back to other places you've been, not just the most recent place you left from\n\nWhen in a closet, you can memorize it and, when in Closetland, return there instead of the place you left from.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    flags = { "PERK" },
    on_activate = "w16b_mut_activate_bombasticperks_ce72a600ecd9",
}

ccb.content.define_mutation {
    id = "perk_ewwww_de_zombie",
    name = ccb.content.text("Ewwww de Zombie"),
    description = ccb.content.text("The zombies have some way to distinguish between the living and the dead, and you're sure that smell is a big part of it.  That's why they don't attack the ferals, because they're dirty and covered in zombie blood.  If you covered yourself in zombie blood, you bet you could sneak past them.\n\nYou can make Ewwww de Zombie from tainted blood and flesh.  Coat yourself with it and zombies will ignore you."),
    points = 0,
    purifiable = false,
    valid = false,
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_soothing_the_savage_beast",
    name = ccb.content.text("Soothing the Savage Beast"),
    description = ccb.content.text("Disney princesses stand back!  You have learned the secret tongues of bird and beast, or at least, you can howl or chirp in such a way that they consider it an offer of friendship.  Activate this perk to charm any nearby mammals, birds, amphibians, reptiles, or fish (not insects or spiders)."),
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    on_activate = "soothing_the_savage_beast",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_perk_menu",
    name = ccb.content.text("Open Perk Menu"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Direct access to the perk menu."),
    active = true,
    on_activate = "open_perk_menu",
    flags = { "PERK" },
}

ccb.content.define_mutation {
    id = "perk_hive_queen",
    name = ccb.content.text("Hive Queen"),
    description = ccb.content.text("The insects have accepted you as one of their own.  You are neutral with eusocial insects, including giant ones, but your presence is a little unnerving to animals and people."),
    points = 0,
    purifiable = false,
    valid = false,
    species_anger = { MAMMAL = 5, BIRD = 5 },
    enchantments = { "INLINE_ENCH_perk_hive_queen_0", "INLINE_ENCH_perk_hive_queen_1" },
    flags = { "PERK", "ANIMALDISCORD" },
}
