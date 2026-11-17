local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "DUST_STORM_NIGHT_MESSAGES_1" }
    category:text(ccb.content.text("A gust of wind hits you from above."))
    category:text(ccb.content.text("You notice small patches of dust blown away by the wind."))
    category:text(ccb.content.text("The stars are slowly being consumed by ominous-looking clouds."))
    category:text(ccb.content.text("The Sun is slowly being consumed by ominous-looking clouds."))
    category:text(ccb.content.text("You have a feeling you should take shelter immediately."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "DUST_STORM_DAY_MESSAGES_1" }
    category:text(ccb.content.text("A gust of wind hits you from above."))
    category:text(ccb.content.text("You notice small patches of dust blown away by the wind."))
    category:text(ccb.content.text("The Sun is slowly being consumed by ominous-looking clouds."))
    category:text(ccb.content.text("You have a feeling you should take shelter immediately."))
    ccb.content.add(category)
end
