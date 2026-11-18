local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bot_nl_surgicalbot",
        name = ccb.content.plural_text("inactive surgical bonebot", "inactive surgical bonebots"),
        description = ccb.content.text("An inactive surgical bonebot.  Using this item involves placing it on the ground and activating it.  If reprogrammed successfully, the nurse bot will then identify you as a friendly, roam around or follow you, and assist you in surgeries.  That is, if you can figure out how to reprogram this thing in the first place."),
        volume_ml = 62500,
        mass_milligrams = 81500000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_blue",
    }
    item:material("cyber_bone", 1)
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_nl_surgicalbot_assist",
        friendly_message = ccb.content.text("The bonebot slowly rises to its full height, each movement accompanied by the sound of snapping sinew."),
        hostile_message = ccb.content.text("The bonebot slowly rises to its full height, each movement accompanied by the sound of snapping sinew."),
        difficulty = 9,
        moves = 150,
        skills = { "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end
