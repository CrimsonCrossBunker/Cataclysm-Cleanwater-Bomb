local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "IRONSWORN",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This gear <good>completely protects</good> you from <info>cold iron damage</info>."),
})

content.add(content.JsonFlag {
    id = "INVENTOR_CRAFTED",
    info = ccb.content.text("This thing was crafted by a mad inventor.  It is very unstable and will rapidly degrade without an inventor's presence."),
})

content.add(content.JsonFlag {
    id = "WOODEN_WEAPON",
    info = ccb.content.text("This weapon is primarily or mostly made of wood."),
})

content.add(content.JsonFlag {
    id = "ARVORE_POLLEN_IMMUNE",
    info = ccb.content.text("This character cannot be affected by Arvore pollens."),
})

content.add(content.JsonFlag {
    id = "SKINCHANGED",
    info = ccb.content.text("This gear will transform you into animal form, and may have some side effects."),
})

content.add(content.JsonFlag {
    id = "HEDGE_ENCHANTED",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item has a <good>charm</good> on it."),
})

content.add(content.JsonFlag {
    id = "BLESSED_WEAPON",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This weapon does <good>extra damage</good> against creatures of the <info>Nether</info>."),
})

content.add(content.JsonFlag {
    id = "EVIL_EYE_IMMUNE",
    info = ccb.content.text("You are immune to the evil eye."),
})

content.add(content.JsonFlag {
    id = "WARDING_SYMBOL",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("Wearing this is <good>comforting</good>."),
})

content.add(content.JsonFlag {
    id = "STABILIZED_TIMELINE",
    info = ccb.content.text("You are immune to adverse affects on your timeline."),
})

content.add(content.JsonFlag { id = "NO_FEY_MAGIC" })
content.add(content.JsonFlag { id = "NO_HEDGE_MAGICK" })
content.add(content.JsonFlag { id = "NO_WEREWOLF_POWERS" })
content.add(content.JsonFlag { id = "NO_VAMPIRE_BLOOD_POWERS" })
content.add(content.JsonFlag { id = "NO_THORNWITCHERY" })

-- Your mind is protected from attack due to magic.  The same as the Magiclysm flag for compatibility
content.upsert_json_flag(content.JsonFlag { id = "MAGICAL_MIND_PROTECTION" })

-- Immune to shadow damage
content.add(content.JsonFlag { id = "SHADOW_CHAR_IMMUNE" })

-- Immune to withering damage
content.add(content.JsonFlag { id = "WITHERING_IMMUNE" })
