local ccb = require("ccb")

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
