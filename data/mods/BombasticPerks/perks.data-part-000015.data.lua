local ccb = require("ccb")

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
