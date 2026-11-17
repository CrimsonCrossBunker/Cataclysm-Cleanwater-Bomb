local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag { id = "NETHER_IMMUNE" })
content.add(content.JsonFlag { id = "POISON_IMMUNE" })
content.add(content.JsonFlag { id = "PSIONIC_IMMUNE" })

content.upsert_json_flag(content.JsonFlag {
    id = "MAGICAL_MIND_PROTECTION",
    info = ccb.content.text("Your magic protects your mind against assault."),
})

content.add(content.JsonFlag {
    id = "SPELLCASTING_AID",
    info = ccb.content.text("This item makes it easier to cast spells."),
})

-- Used by the NO_CASTING_EVOCATION_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_EVOCATION_SPELLS" })

-- Used by the NO_CASTING_CHANNELING_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_CHANNELING_SPELLS" })

-- Used by the NO_CASTING_CONJURATION_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_SUMMONING_SPELLS" })

-- Used by the NO_CASTING_ENHANCEMENT_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_ENHANCEMENT_SPELLS" })

-- Used by the NO_CASTING_ENERVATION_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_ENERVATION_SPELLS" })

-- Used by the NO_CASTING_CONVEYANCE_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_CONVEYANCE_SPELLS" })

-- Used by the NO_CASTING_RESTORATION_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_RESTORATION_SPELLS" })

-- Used by the NO_CASTING_TRANSFORMATION_SPELLS trait
content.add(content.JsonFlag { id = "NO_CASTING_TRANSFORMATION_SPELLS" })

content.add(content.JsonFlag { id = "MAGIC_FOLLOW" })
