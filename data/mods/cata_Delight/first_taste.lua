local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local id = services.types.id

local first_taste_trait = id("mutation", "DELIGHT_FIRST_TASTE")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

ccb.runtime.handler("delight_first_taste_on_eat", function(event)
    local actor = event.actors.character or services.characters.avatar()
    if not actor:is_valid() or not checked(services.mutations.has(actor, first_taste_trait)) then
        return
    end

    local now_days = services.time.now().turn / 86400
    local last_day = checked(variables.get_number(actor, "delight_first_taste_day")).value
    if now_days == last_day then return end

    local itype = event.data.itype
    local fun = 0
    if type(itype) == "string" and itype ~= "" then
        local item_id = id("item", itype)
        if item_id:is_valid() then
            fun = services.items.food_fun(item_id)
        end
    end

    checked(variables.set(actor, "delight_first_taste_fun", fun, { include_before = false }))
    checked(variables.set(actor, "delight_first_taste_day", now_days, { include_before = false }))
    if actor.subtype == "avatar" then
        local text = checked(services.text.expand_for(
            services.translate("You tasted your first meal of the day, and its deliciousness was <u_val:delight_first_taste_fun>."),
            actor, nil, nil, nil, true))
        services.messages.add(text, "good")
    end
end)
ccb.runtime.on("game:character_eats_item", "delight_first_taste_on_eat")
