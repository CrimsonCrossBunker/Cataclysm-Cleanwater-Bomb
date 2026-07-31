local vitamin_rules = {
    { id = "calcium", minimum = 0, delta = 0 },
    { id = "iron", minimum = 0, delta = 0 },
    { id = "vitC", minimum = 0, delta = 0 },
    { id = "redcells", minimum = -5000, delta = 1000 },
    { id = "blood", minimum = -2500, delta = 1000 },
}

game.native_events.on("character_gains_effect", function(event)
    if event.data.effect ~= "fcl_cureall" then
        return
    end

    local character_result = game.characters.by_id(event.data.character)
    if not character_result.ok then
        return
    end

    local character = character_result.value
    for _, rule in ipairs(vitamin_rules) do
        local vitamin = game.types.id("vitamin", rule.id)
        local current = game.vitamins.get(character, vitamin)
        if current.ok then
            local amount = math.max(
                rule.minimum,
                current.value.amount + rule.delta
            )
            game.vitamins.set(character, vitamin, amount)
        end
    end
end)
