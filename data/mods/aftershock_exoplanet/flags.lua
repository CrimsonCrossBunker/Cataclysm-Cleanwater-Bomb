local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "OLD_TSKBEM_CARD",
    info = ccb.content.text("This item is an access card for ancient industrial locations."),
})

content.add(content.JsonFlag {
    id = "OLD_ENFORCER_CARD",
    info = ccb.content.text("This item is an access card for ancient police locations."),
})

content.add(content.JsonFlag {
    id = "OLD_MERCURIAL_CARD",
    info = ccb.content.text("This item is an access card for ancient Mercurial locations."),
})

content.add(content.JsonFlag { id = "HEAVY_TOOL" })

content.upsert_json_flag(content.JsonFlag {
    id = "TEEPSHIELD",
    info = ccb.content.text("You are immune to telepathy."),
})

-- Immune to telekinetic damage
content.upsert_json_flag(content.JsonFlag { id = "TELEKIN_SHIELD" })

content.add(content.JsonFlag {
    id = "SHIELD_GENERATOR",
    info = ccb.content.text("This item is capable of projecting a Riemann protective shield."),
})

content.add(content.JsonFlag { id = "ACTIVE_CRYOSUIT" })

-- This tool is being used to perform hacking operations.
content.add(content.JsonFlag { id = "ACTIVE_HACK_TOOL" })

-- This Hacking tool does not consume energy.
content.add(content.JsonFlag { id = "HACK_NO_CHARGE" })
