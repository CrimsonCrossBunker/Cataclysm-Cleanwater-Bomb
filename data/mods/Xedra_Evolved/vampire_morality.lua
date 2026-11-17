local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function message(character, text, type)
    if character.subtype == "avatar" then
        services.messages.add(text, type)
    end
end

local function number(character, key)
    return value(services.variables.get_number(character, key)).value or 0
end

local function set_number(character, key, amount)
    value(services.variables.set(character, key, amount, { include_before = false }))
end

local shed_morality = "shed_morality"

local function remove_drowned_morals(character)
    if not has_trait(character, "VAMPIRE4") then
        return
    end
    local count = number(character, shed_morality)
    if has_trait(character, "VEGAN") then
        value(services.mutations.erase(character, id("mutation", "VEGAN")))
        if count > 0 then
            message(character, ccb.services.translate("A wave of crimson drowns your empathy for lesser beings."), "mixed")
        end
    end
    if has_trait(character, "SPIRITUAL") then
        value(services.mutations.erase(character, id("mutation", "SPIRITUAL")))
        if count > 0 then
            message(character, ccb.services.translate("There are no wonders and nothing beyond sight, only the thirst and how you will sate it."), "mixed")
        end
    end
    if has_trait(character, "PACIFIST") then
        value(services.mutations.erase(character, id("mutation", "PACIFIST")))
        if count > 0 then
            message(character, ccb.services.translate("Your disdain for violence melts as you drink your fill."), "mixed")
        end
    end
    if not has_trait(character, "PSYCHOPATH") then
        value(services.mutations.replace(character, id("mutation", "PSYCHOPATH")))
        if count > 0 then
            message(character, ccb.services.translate("The blood in your mouth makes you realise that anything that isn't blood isn't worth caring about."), "mixed")
        end
    end
    set_number(character, shed_morality, count + 1)
end

return remove_drowned_morals
