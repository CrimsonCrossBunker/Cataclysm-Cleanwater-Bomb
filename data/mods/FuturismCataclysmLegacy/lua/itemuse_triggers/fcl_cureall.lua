local ccb = require("ccb")

local vitamin_rules = {
    { id = "calcium", minimum = 0, delta = 0 },
    { id = "iron", minimum = 0, delta = 0 },
    { id = "vitC", minimum = 0, delta = 0 },
    { id = "redcells", minimum = -5000, delta = 1000 },
    { id = "blood", minimum = -2500, delta = 1000 },
}

local function apply(event)
    if event.data.effect ~= "fcl_cureall" then
        return
    end
    local character = event.actors.character
    if character == nil then
        return
    end
    for _, rule in ipairs(vitamin_rules) do
        local vitamin = ccb.services.types.id("vitamin", rule.id)
        local current = ccb.services.vitamins.get(character, vitamin)
        if current.ok then
            local amount = math.max(rule.minimum, current.value.amount + rule.delta)
            ccb.services.vitamins.set(character, vitamin, amount)
        end
    end
end

ccb.runtime.handler("fcl_cureall_apply", apply, 1)
ccb.runtime.on("game:character_gains_effect", "fcl_cureall_apply")
