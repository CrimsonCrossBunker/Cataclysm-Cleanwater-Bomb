local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local metamagic_off = {
    perk_metamagic_quicken = function() return ccb.services.translate("You deactivate your quicken metamagic") end,
    perk_metamagic_extended = function() return ccb.services.translate("You deactivate your extended metamagic") end,
    perk_metamagic_widen = function() return ccb.services.translate("You deactivate your widen metamagic") end,
    perk_metamagic_reach = function() return ccb.services.translate("You deactivate your reach metamagic") end,
    perk_metamagic_silent = function() return ccb.services.translate("You deactivate your silent metamagic") end,
    perk_metamagic_still = function() return ccb.services.translate("You deactivate your still metamagic") end,
    perk_metamagic_careful = function() return ccb.services.translate("You deactivate your careful metamagic") end,
    perk_metamagic_efficient = function() return ccb.services.translate("You deactivate your efficient metamagic") end,
    perk_metamagic_intuitive = function() return ccb.services.translate("You deactivate your intuitive metamagic") end,
}

local function set_metamagic_disabled(context, disabled)
    local mutation = context.mutation.value
    local setting = disabled and "yes" or "no"
    local key = mutation .. "_deactivated"
    -- The original variable action drew from a one-element list before writing.
    services.random.native_int(0, 0)
    value(services.variables.set(context.character, key, setting, { include_before = false }))
    services.native_events.emit("u_var_changed", { key, setting })
end

ccb.runtime.handler("metamagic_enable", function(context)
    set_metamagic_disabled(context, false)
end)

ccb.runtime.handler("metamagic_disable", function(context)
    if context.character.subtype == "avatar" then
        services.messages.add(metamagic_off[context.mutation.value]())
    end
    set_metamagic_disabled(context, true)
end)

ccb.runtime.handler("toggle_sight_beyond_sight", function(context)
    local character = context.character
    local trait = id("mutation", "perk_sight_beyond_sight_active")
    if value(services.mutations.has(character, trait)) then
        value(services.mutations.erase(character, trait))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You open your eyes."))
        end
    else
        value(services.mutations.replace(character, trait))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You close your eyes and feel the air."), "good")
        end
    end
end)

ccb.runtime.handler("frankenstein_insight", function(context)
    local character = context.character
    local recipe = id("recipe", "meat_hunk")
    if value(services.recipes.knows(services.characters.avatar(), recipe)) then
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You have already mastered the art of bringing back the undead!"))
        end
        return
    end
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("With a flash of insight you now understand how to bring the dead back to life!"))
    end
    value(services.recipes.learn(character, recipe))
end)
