local content = require("ccb").content

local function warped_recipe(options)
    options.category = "CC_WARP"
    options.skill = "survival"
    options.activity_level = 1.0
    options.reversible = false
    if options.autolearn == nil then options.autolearn = false end
    if options.flags == nil then options.flags = { "BLIND_EASY" } end
    return content.Recipe(options)
end

return warped_recipe
