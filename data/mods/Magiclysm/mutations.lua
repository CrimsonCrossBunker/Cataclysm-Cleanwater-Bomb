local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function cast_spell_mutation(character, spell_id, energy_amount, prep_moves, success_text, fail_text)
    local stamina = checked(services.needs.get(character)).stamina
    if stamina > energy_amount then
        if prep_moves > 0 then
            checked(services.characters.adjust(character, { moves = -prep_moves }))
        end
        if energy_amount ~= 0 then
            checked(services.needs.set(character, { stamina = stamina - energy_amount }))
        end
        checked(services.characters.cast_spell(character, id("spell", spell_id), {
            targeted = true,
            message = services.translate(success_text),
        }))
    elseif character.subtype == "avatar" then
        services.messages.add(services.translate(fail_text), "bad")
    end
end

ccb.runtime.handler("activate_ravenfolk_leap", function(context)
    cast_spell_mutation(context.character, "spell_ravenfolk_leap", 2500, 100,
        "You launch yourself into a powerful wing-assisted leap.", "You're too tired to leap.")
end)

ccb.runtime.handler("activate_ravenfolk_screech", function(context)
    cast_spell_mutation(context.character, "spell_ravenfolk_screech", 0, 0,
        "You let out a piercing cry!", "You change your mind about screeching.")
end)
