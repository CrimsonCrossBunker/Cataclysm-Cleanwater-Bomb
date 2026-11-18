local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bot_sniperbot",
        name = ccb.content.plural_text("inactive sniper bot", "inactive sniper bots"),
        description = ccb.content.text("A compressed sniper sentry.  Ludicrous, physical law violating compression allows you to fit them into a small metal cylinder, but the weight compression is not as effective."),
        mass_milligrams = 5000000,
        volume_ml = 500,
        symbol = ";",
        color = "red",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_sniperbot",
        difficulty = 0,
        moves = 100,
        skills = { "deduction", "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("INVENTOR_CRAFTED")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_shotgunbot",
        name = ccb.content.plural_text("inactive shotgun bot", "inactive shotgun bots"),
        description = ccb.content.text("A compressed shotgun sentry.  Ludicrous, physical law violating compression allows you to fit them into a small metal cylinder, but the weight compression is not as effective."),
        mass_milligrams = 5000000,
        volume_ml = 500,
        symbol = ";",
        color = "red",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_shotgunbot",
        difficulty = 0,
        moves = 100,
        skills = { "deduction", "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("INVENTOR_CRAFTED")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_meleebot",
        name = ccb.content.plural_text("inactive melee bot", "inactive melee bots"),
        description = ccb.content.text("A compressed melee sentry.  Ludicrous, physical law violating compression allows you to fit them into a small metal cylinder, but the weight compression is not as effective."),
        mass_milligrams = 5000000,
        volume_ml = 500,
        symbol = ";",
        color = "red",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_meleebot",
        difficulty = 0,
        moves = 100,
        skills = { "deduction", "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("INVENTOR_CRAFTED")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bot_bitebot",
        name = ccb.content.plural_text("inactive bitebot", "inactive bitebots"),
        description = ccb.content.text("A compressed biting sentry.  Ludicrous, physical law violating compression allows you to fit them into a small metal cylinder, but the weight compression is not as effective."),
        mass_milligrams = 5000000,
        volume_ml = 500,
        symbol = ";",
        color = "red",
    }
    item:clear_use_actions()
    item:deploy_monster {
        monster = "mon_bitebot",
        difficulty = 0,
        moves = 100,
        skills = { "deduction", "electronics", "computer" },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("INVENTOR_CRAFTED")
    item:tool()
    content.add(item)
end
