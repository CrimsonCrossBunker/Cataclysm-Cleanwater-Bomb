local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function attunement(character)
    return checked(services.needs.get_vitamin(character, id("vitamin", "vitamin_psionic_drain")))
end

local function set_attunement(character, amount)
    local native_amount = math.modf(amount)
    checked(services.needs.set_vitamin(character, id("vitamin", "vitamin_psionic_drain"), native_amount))
end

local function add_attunement(character, amount)
    set_attunement(character, attunement(character) + amount)
end

local function spend_focus(character)
    local focus = checked(services.needs.get(character)).focus
    local amount = focus >= 75 and 50 or focus >= 50 and 25
        or focus >= 34 and 10 or focus >= 30 and 5
    if amount then
        checked(services.needs.set(character, { focus = focus - amount }))
    end
end

return {
    attunement = attunement,
    set_attunement = set_attunement,
    add_attunement = add_attunement,
    spend_focus = spend_focus,
}
