local ccb = require("ccb")

ccb.content.define_mutation {
    id = "RENFIELD",
    name = ccb.content.text("Renfield"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("This person is now a renfield, a human obsessed with serving their vampire masters.  This obsession impedes their cognition as they struggle to think about anything but serving said vampire masters."),
    mixed_effect = true,
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "CANNIBAL" },
    enchantments = { "INLINE_ENCH_RENFIELD_0" },
}

-- NO_I18N
-- NO_I18N
-- Until NPC_DEATH can work, I'm using a forcefield so they can't perma-die before vanishing forever.  I tried to use an evasion effect so the message would be more fitting but it interfered with the hit_me.
-- <npcname> and %1$s both failed to work for dialogue-based vanishing, so until it is fixed these messages will refer to the mentor's title.
ccb.content.define_mutation {
    id = "MENTOR_PEACE",
    points = 0,
    name = ccb.content.text_without_extraction("Mentor's peace"),
    description = ccb.content.text_without_extraction("Intended to be hidden.  Prevent the mentor from being killed by vampires and renfields and makes them react to attacks by vanishing in mist."),
    starting_trait = false,
    player_display = false,
    purifiable = false,
    valid = false,
    ignored_by = { "VAMPIRE", "RENFIELD" },
    enchantments = { "INLINE_ENCH_MENTOR_PEACE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_MORE_BLOOD",
    name = ccb.content.text("Vampiric weakness: blood drain"),
    points = -1,
    description = ccb.content.text("You thirst for blood is more intense than usual.  You now need much more blood to prevent blood starvation."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    vitamin_intervals = { human_blood_vitamin = 120 },
}

-- You have to convince those you talk to that you're not just a smarter zombie, hence the intimidate malus.
ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_GROTESQUE",
    name = ccb.content.text("Vampiric weakness: revolting appearance"),
    points = -1,
    description = ccb.content.text("Your body brings to mind a rotting corpse.  Social interactions will be much harder for you."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    visibility = 30,
    ugliness = 30,
    social_modifiers = { lie = -30, persuade = -30, intimidate = -30 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_EARTH_SLEEP",
    name = ccb.content.text("Vampiric weakness: earth-sleeper"),
    points = -1,
    description = ccb.content.text("You now depend on the proximity to the earth to sleep well.  Should you sleep or torpor aboveground or not surrounded by earth, you will suffer penalties for the next day."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

-- Unsafe: churches, cathedrals, synagogues, rural churches, eventual other holy places.
-- Safe: Vampire-filled holy places, the New England Community Church, anywhere not unsafe.
-- The desired behavior is that carrying holy symbols and books (WARDING_SYMBOL and INSPIRATIONAL flags) is sufficient to cause pain.  Since there's no way to do this without constantly scanning the player's inventory, the full implementation will wait.
ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_HOLY_BURN",
    name = ccb.content.text("Vampiric weakness: rebuked by the holy"),
    points = -1,
    description = ccb.content.text("Your flesh will burn should you ever enter a sanctified area.  Only places that are holy will burn you, so holy places filled with vampires or unholy humans are safe for you to enter.  Holy symbols won't burn you, but wearing them will cause you severe pain."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_WEAKNESS_HOLY_BURN_0" },
}

-- Unsafe: rivers, lakes, oceans.
-- Safe: anywhere else.
ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_VAST_WATER_BURN",
    name = ccb.content.text("Vampiric weakness: melted by vast water"),
    points = -1,
    description = ccb.content.text("Your flesh will melt should you ever try to cross a large body of water or get too close to them.  Only rivers, lakes and oceans have enough water to trigger this weakness, but it will take effect even if floating or water-walking."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_ANIMAL_HATE",
    name = ccb.content.text("Vampiric weakness: hated by animals"),
    points = -1,
    description = ccb.content.text("Animals cannot tolerate your wicked presence.  Expect any animal you encounter to either flee or attack you on sight."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    species_anger = {
        MAMMAL = 50,
        AMPHIBIAN = 50,
        BIRD = 50,
        REPTILE = 50,
        FISH = 50,
        KRAKEN = 50,
        INSECT = 50,
        CENTIPEDE = 50,
        INSECT_FLYING = 50,
        SPIDER = 50,
    },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_FIRE_VULNERABLE",
    name = ccb.content.text("Vampiric weakness: vulnerable to fire"),
    points = -1,
    description = ccb.content.text("Fire damages you far more than it should.  You take massive damage from fire and flames, mundane and magical."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_WEAKNESS_FIRE_VULNERABLE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_COLD_BLOODED",
    name = ccb.content.text("Vampiric weakness: cold as a corpse"),
    points = -1,
    description = ccb.content.text("Ambient cold temperature makes you stiff and slow even under winter clothes.  The lower the ambient temperature, the lower your speed."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_WEAKNESS_COLD_BLOODED_0" },
    flags = { "NO_BODY_HEAT" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_NEED_LIVING_BLOOD",
    name = ccb.content.text("Vampiric weakness: living-drinker"),
    points = -1,
    description = ccb.content.text("You now need to drink some fresh, warm blood from a living being once in a while or suffer growing penalties.  You better find someone willing to share their blood, as blood from fresh corpses won't satisfy this need."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_NEED_HUMAN_BLOOD",
    name = ccb.content.text("Vampiric weakness: picky feeding"),
    points = -1,
    description = ccb.content.text("Your ability to process varied types of blood is now hampered.  Blood that isn't regular human blood will only sate your thirst half as much."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_BLOOD_CRAVING",
    name = ccb.content.text("Vampiric weakness: blood cravings"),
    points = -1,
    description = ccb.content.text("Your thirst for blood will occasionally magnify, causing painful cravings.  You can calm these cravings as or before they happen by consuming blood."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_WEAKNESS_NO_FUN",
    name = ccb.content.text("Vampiric weakness: barred from mortal joys"),
    points = -1,
    description = ccb.content.text("Blood is the only thing that can bring a smile to your lips.  Nothing else gives you any lasting joy or pleasure.  It is impossible for you to be truly happy unless you recently consumed blood."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

-- Required for vampire blood to have any consumption benefit.  Regular vampires instinctively feel threatened by you and their renfields try to protect them, so they react accordingly.
-- The traits unlocked by this have no category, as they aren't given by the regular mutation system.
ccb.content.define_mutation {
    id = "VAMPIRE_ANATHEMA",
    name = ccb.content.text("Vampiric Anathema"),
    points = 0,
    description = ccb.content.text("Through the consumption of self-cannibalizing vampire blood, you gained the ability to consume vampire blood to gain vampiric abilities undreamt of by other vampires."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    species_anger = { VAMPIRE = 200, RENFIELD = 200 },
    threshold = true,
    vitamin_intervals = { human_blood_vitamin = 120 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_STORE_MORE_BLOOD",
    name = ccb.content.text("Inner Vault of Blood"),
    points = 5,
    description = ccb.content.text("Your vestigial circulatory system is now better at holding stolen blood.  You can hold two and a half more liters inside you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "EYEGLEAM_UPGRADE",
    name = ccb.content.text("Eternally-Gleaming Eyes"),
    points = 5,
    description = ccb.content.text("Your ability to see in the dark has expanded.  You no longer need to spend blood to maintain your gleaming eyes."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_INSTANT_BLEED",
    name = ccb.content.text("Claim the Crimson Wine"),
    points = 5,
    description = ccb.content.text("You can now attract the blood within a corpse's veins, extracting it all in a second through a small cut.  In addition, you can create temporary blood containers out of some of your stolen blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    flags = { "INSTANT_BLEED" },
    spells_learned = { vampire_summon_blood_container = 1 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_DETECT_VAMPIRES",
    name = ccb.content.text("Apex Vampire's Sight"),
    points = 5,
    description = ccb.content.text("In comparison to you, regular vampires are the same as mortals.  You can now detect nearby vampires, your new prey, even through walls."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_DETECT_VAMPIRES_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BIG_STOMACH",
    name = ccb.content.text("Unlimited Drinking"),
    points = 5,
    description = ccb.content.text("Your digestive system has warped to repurpose some vestigial parts, making you much better at drinking blood.  Drinking reasonable amounts of blood won't ever stretch your stomach, and you drink blood much faster now."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_BIG_STOMACH_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    name = ccb.content.text("See Through Night's Eyes"),
    points = 5,
    description = ccb.content.text("Your supernatural senses have expanded.  You can now see anything close to some nocturnal creatures, even if they lack sight."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    monster_cameras = { mon_bat = 32, xe_mon_bat = 32, mon_vampire_bat = 32, mon_bat_giant = 32 },
}

-- The main draw of BLOOD_FUN is fae blood being a net morale positive.  The main draw of this upgrade is getting stat boosts from the high morale.
ccb.content.define_mutation {
    id = "BLOOD_FUN_UPGRADE",
    name = ccb.content.text("Sanguine Paradise"),
    points = 5,
    description = ccb.content.text("Becoming more vampire than vampires are has affected your new palate, making the consumption of blood feel even better than before.  You now enjoy drinking blood so much that enough of it will bolster your resolve for a while."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_SILENT_MOVE_UPGRADE",
    name = ccb.content.text("Dead Silent Strikes"),
    points = 5,
    description = ccb.content.text("Your lack of movement noise is now encompassing any noise you could do in combat.  All such noises you would've made by attacking in melee are nullified."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_SILENT_MOVE_UPGRADE_0" },
}

-- Behaves as the anathema's threshold, letting the EOC give the stronger traits.  The enabler is a threshold to limit mixing regular mutations and this path.
-- A few mentors knew that this was possible, but they kept the secret to not threaten the plan.
ccb.content.define_mutation {
    id = "THRESH_VAMPIRE_ANATHEMA",
    name = ccb.content.text("Ascended Anathema"),
    points = 0,
    description = ccb.content.text("You drank enough vampire blood to gain access to power the mentors never thought possible.  There is no more limit to how powerful of a vampire you can be."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    mixed_effect = true,
    vitamin_intervals = { human_blood_vitamin = 120 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
    name = ccb.content.text("Inner Sea of Blood"),
    points = 10,
    description = ccb.content.text("Your new power allows you to store even more stolen blood inside your body.  You can hold another five liters inside you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

-- should only work in the dark, but such checks aren't yet.
-- This enchantment removes the effect if the vampire is outside at day.
ccb.content.define_mutation {
    id = "VAMPIRE_INVISIBLE_IN_DARK",
    name = ccb.content.text("Shrouded by the Shadowed Path"),
    points = 10,
    description = ccb.content.text("Darkness is your home, and you can call it to shroud you from others.  When away from the sun, you can become invisible with a constant expense of blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { vampire_invisible_in_dark = 1 },
    enchantments = { "INLINE_ENCH_VAMPIRE_INVISIBLE_IN_DARK_0" },
}

-- should only work in the dark, but such checks aren't yet.
ccb.content.define_mutation {
    id = "VAMPIRE_HEAL_IN_DARK",
    name = ccb.content.text("Stitched by the Shadowed Path"),
    points = 10,
    description = ccb.content.text("Darkness is your new friend, and like a good friend it helps you through hard times.  Passively heal your wounds and reduce your pain while away from the sun."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_FOR_POTENCY",
    name = ccb.content.text("Boiling Crimson Cauldron"),
    points = 10,
    description = ccb.content.text("The powers of vampires come through their sustenance of blood, and you now know how to use this at your advantage.  You can increase your need for blood to boost your vampiric potency until you decide to stop the effect.  If you do not have enough blood, it will have no effect until you drink more blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your power increases as your blood burns away."),
    enchantments = { "INLINE_ENCH_VAMPIRE_BLOOD_FOR_POTENCY_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_BLOOD_FOR_POTENCY_REAL",
    name = ccb.content.text_without_extraction("Boiling Crimson Cauldron Real"),
    points = 10,
    description = ccb.content.text_without_extraction("Increases blood potency and drain while the player-visible version is active and has enough blood.  You should never see this."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    vitamin_intervals = { human_blood_vitamin = 2 },
}

ccb.content.define_mutation {
    id = "VAMPIRE_NO_ILLNESS_UPGRADE",
    name = ccb.content.text("Immortal's Health"),
    points = 10,
    description = ccb.content.text("Being protected against mundane afflictions only is something your flesh has stopped tolerating.  Your condition now protects you from any illness, parasite and poison, no matter how dangerous they are."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_VAMPIRE_NO_ILLNESS_UPGRADE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRE_FORM_UPGRADE",
    name = ccb.content.text("Mastery of Forms"),
    points = 10,
    description = ccb.content.text("You are much more attuned to your other forms, and they are now easier to activate than ever.  The cost to activate them is halved."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
    name = ccb.content.text("Second Final Breath"),
    points = 10,
    description = ccb.content.text("Your instinctive mastery of your mist form has expanded.  You now recover from triggering Last Breath's Mist twice as quickly."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_DRINK_VAMPIRE_BLOOD",
    name = ccb.content.text("Fueled by the Blood-Drinkers' Blood"),
    points = 10,
    description = ccb.content.text("Vampires, mortals, they are all the same for you now.  Drinking vampire blood now gives all the benefits of drinking regular blood, in addition to growing your power."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_GAIN_BLOOD_GIFTS",
    name = ccb.content.text("Knowledge of the Blood"),
    points = 10,
    description = ccb.content.text("Your own blood now reveals its secrets to you.  Every week, you will gain a new gift of the blood.  It will only give you what researching your blood gifts could give you."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE",
    name = ccb.content.text("Maximal Mastery of the Mortal Mind"),
    points = 10,
    description = ccb.content.text("Your mind-control abilities are much simpler to use now, halving their cost."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ANATHEMA_WEAKNESS_SUN_BURN",
    name = ccb.content.text("Anathema's Weakness: Slain by the Sun"),
    points = -10,
    description = ccb.content.text("Vampires burn under the sun, and becoming more of a vampire made you burn far more than any other vampire would.  Being under the sun will quickly ignite your flesh."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ANATHEMA_WEAKNESS_MIND_CHAOS",
    name = ccb.content.text("Anathema's Weakness: Blood-Muddled Mind"),
    points = -10,
    description = ccb.content.text("Your constant consumption of vampire blood has permanently destabilized your mind, and it will only grow worse with each new vampire drained.  Each time you drink vampire blood, you have a growing chance to gain a new mental affliction."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ANATHEMA_WEAKNESS_NEED_VAMPIRE_BLOOD",
    name = ccb.content.text("Anathema's Weakness: Apex's Thirst"),
    points = -10,
    description = ccb.content.text("Drinking all this vampire blood has left your body yearning for more.  Going too long without drinking vampire blood will progressively increase your thirst for blood with each passing day until you starve or drink vampire blood."),
    starting_trait = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "BLOOD_OF_SAINTS",
    name = ccb.content.text("Saint's blood"),
    points = 0,
    description = ccb.content.text("Through a complicated ritual utilizing a saint's relic, you have transubstantiated your own blood with the holy blood of the saints.  It'll prevent you from becoming infected with vampirism while you live, effects postmortem unknown."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    types = { "BLOOD" },
}

ccb.content.define_mutation {
    id = "FUTURESIGHT",
    name = ccb.content.text("Future Sight"),
    points = 0,
    description = ccb.content.text("You aren't where you seem to be."),
    starting_trait = false,
    valid = false,
    flags = { "UNCANNY_DODGE" },
}

ccb.content.define_mutation {
    id = "EATER_SIXTH_SENSE",
    name = ccb.content.text("Eater's Sixth Sense"),
    points = 0,
    description = ccb.content.text("You are no longer limited to the five senses common to most humans in your hunt for the unnatural."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "EATER_SIXTH_SENSE" },
}

ccb.content.define_mutation {
    id = "CALL_DAFFODIL",
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Fae Authority"),
    description = ccb.content.text("Boann bestowed upon you the right to summon a few daffodil warriors once a day."),
    spells_learned = { call_daffodil = 1 },
}

ccb.content.define_mutation {
    id = "IRON_ALLERGY",
    name = ccb.content.text("Iron Intolerance"),
    points = -4,
    description = ccb.content.text("You were born with an allergy to iron and, to a lesser extent, steel.  Wearing or touching anything made of iron or steel will cause you pain and discomfort."),
    starting_trait = true,
}

ccb.content.define_mutation {
    id = "FAE_ENMITY",
    name = ccb.content.text("Fae Enmity"),
    points = -10,
    description = ccb.content.text("The Fair Folk can sense the stolen power within you and their vengeance will be terrible."),
    purifiable = false,
    valid = false,
    species_anger = {
        ARVORE = 100,
        CHANGELING = 100,
        HOMULLUS = 100,
        IERDE = 100,
        SALAMANDER = 100,
        SYLPH = 100,
        UNDINE = 100,
    },
}

ccb.content.define_mutation {
    id = "FALSE_ARVORE_HATRED",
    name = ccb.content.text("False Arvore"),
    points = -4,
    description = ccb.content.text("The arvore can sense the stolen power within you and they will not react well to it."),
    purifiable = false,
    valid = false,
    species_anger = { ARVORE = 100 },
    categories = { "ARVORE_ALCHEMY" },
}

ccb.content.define_mutation {
    id = "FALSE_HOMULLUS_HATRED",
    name = ccb.content.text("False Homullus"),
    points = -4,
    description = ccb.content.text("The homullus can sense the stolen power within you and they will not react well to it."),
    purifiable = false,
    valid = false,
    species_anger = { HOMULLUS = 100 },
}

ccb.content.define_mutation {
    id = "FALSE_SALAMANDER_HATRED",
    name = ccb.content.text("False Salamander"),
    points = -4,
    description = ccb.content.text("The salamanders can sense the stolen power within you and they will not react well to it."),
    purifiable = false,
    valid = false,
    species_anger = { SALAMANDER = 100 },
}

ccb.content.define_mutation {
    id = "BOANN_RETALIATION",
    name = ccb.content.text_without_extraction("Boann's retaliation"),
    points = 0,
    description = ccb.content.text_without_extraction("Intended to be hidden.  Makes Boann teleport the player away, spawns some huntsmen and hounds then cure all her ailments and injuries if she survives being hit by the player."),
    starting_trait = false,
    player_display = false,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BOANN_RETALIATION_0", "INLINE_ENCH_BOANN_RETALIATION_1" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID",
    name = ccb.content.text("Bloodthorne Druid"),
    points = 0,
    description = ccb.content.text("You are a oath-sworn member of the ancient order of Bloodthorne Druids, dedicated to defending humanity against the vampires that lurk in the shadows."),
    purifiable = false,
    valid = false,
    profession = true,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    types = { "HERITAGE" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "XE_FACTION_CAMP_BROWNIE_BLESSING",
    name = ccb.content.text_without_extraction("Brownie's Blessing"),
    points = 1,
    description = ccb.content.text_without_extraction("You are blessed by a brownie.  This should not be visible."),
    purifiable = false,
    valid = false,
    player_display = false,
    chargen_allow_npc = false,
    enchantments = { "INLINE_ENCH_XE_FACTION_CAMP_BROWNIE_BLESSING_0" },
}
