local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "WISE_SORCERY_AID",
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This item <good>reduces the cost of your enchantments</good> when wielded."),
})

-- Has a bad taste or texture that can't be covered up through cooking.
content.add(content.JsonFlag {
    id = "XEDRAWOOD_INSECT_BAD_TASTE",
    craft_inherit = true,
    taste_modifier = -8,
    -- TRANSLATORS: Leave the tags in angle brackets unchanged.
    info = ccb.content.text("This food is <bad>unappetizing</bad> in a way that <bad>can't be covered up by most cooking</bad>."),
})
