local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_clear_minded_channeling",
    name = ccb.content.text("Clear-Minded Channeling"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("This \"psychic powers\" stuff is easy, as long as nothing distracts you.  When you are concentrating on 0 powers, or have 0 pain, you have an easier time invoking your powers."),
}

ccb.content.define_mutation {
    id = "perk_concussive_blasts",
    name = ccb.content.text("Concussive Blasts"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your telekinetic attacks really hammer into your target.  Damaging telekinetic powers have a much higher chance to stagger or knock down your targets."),
}

ccb.content.define_mutation {
    id = "perk_efficient_slumber",
    name = ccb.content.text("Efficient Slumber"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Some part of your Metabolic Hyperefficiency is running even when you sleep, or perhaps your wakeful meditations have made the process of sleeping more efficient.  You can stay awake for 20% longer, and sleep is 20% more restorative."),
    enchantments = { "INLINE_ENCH_perk_efficient_slumber_0" },
}

ccb.content.define_mutation {
    id = "perk_grace_under_pain",
    name = ccb.content.text("Grace Under Pain"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Happy.  In Your Lane.  Focused.  Flourishing.  Your Intelligence is only penalized 66% of the normal amount from pain, and 33% of normal if you're using the Biokinetic power Overcome Pain, the Electrokinetic power Pain Suppression, or the Telepathic power Mood Stabilization."),
    enchantments = { "INLINE_ENCH_perk_grace_under_pain_0", "INLINE_ENCH_perk_grace_under_pain_1" },
}

ccb.content.define_mutation {
    id = "perk_in_the_zone",
    name = ccb.content.text("In the Zone"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Once you get going you just keep rolling.  Your next use of a psionic power within five seconds of channeling one has its stamina cost reduced by 25%."),
}

ccb.content.define_mutation {
    id = "perk_mastery_of_form",
    name = ccb.content.text("Mastery of Form"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your control of your own body has given you control of your own genetics, albeit a subconscious one.  You will be less likely to suffer from negative mutations when taking mutagen."),
    enchantments = { "INLINE_ENCH_perk_mastery_of_form_0" },
}

ccb.content.define_mutation {
    id = "perk_wary_sleeper",
    name = ccb.content.text("Wary Sleeper"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your Premonition ability has developed to such a level that you can sense movement around you even when you sleep."),
    active = true,
    enchantments = { "INLINE_ENCH_perk_wary_sleeper_0" },
}

ccb.content.define_mutation {
    id = "perk_mind_cry",
    name = ccb.content.text("Mindcry"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Your telepathic powers can sometimes go out of control when you're hurt.  You have a 1% chance to let out a Psychic Scream if you take damage when you have 10 or more pain."),
}

-- Playstyle perks begin here
ccb.content.define_mutation {
    id = "perk_burning_bright",
    name = ccb.content.text("Burning Bright"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Nether energy easily flows through you, causing your power to rise and fall far faster than normal.  You gain far more Nether Attunement from channeling or maintaining your powers, but you lose your Nether Attunement much faster as well.  You do not lose Nether Attunement at this accelerated rate while maintaining any powers."),
}

ccb.content.define_mutation {
    id = "perk_phoenix_rising",
    name = ccb.content.text("Phoenix Rising"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("Only the phoenix rises and does not descend, but you're going try your hardest.  The stamina cost of your powers is reduced beginning at Nether Attunement level 8, reaching 1/3rd of normal by Nether Attunement level 12."),
}
