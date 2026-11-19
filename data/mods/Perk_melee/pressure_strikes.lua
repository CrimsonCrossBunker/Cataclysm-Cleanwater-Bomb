local ccb = require("ccb")
local services = ccb.services
local tasks = ccb.tasks
local variables = services.variables
local id = services.types.id
local insight = require("insight")

local pure_damage = id("damage_type", "pure")
local torso = id("body_part", "torso")
local deal_damage_handler = "perk_pressure_strikes_deal_damage"

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(owner, key)
    return checked(variables.get_number(owner, key)).value or 0
end

local function set_number(owner, key, value)
    checked(variables.set(owner, key, value, { include_before = false }))
end

ccb.runtime.handler("perk_pressure_strikes_monster", function(event)
    local victim = event.actors.speaker
    local attacker = event.actors.interlocutor
    if not victim or not attacker or not victim:is_valid() or not attacker:is_valid() then return end
    if not checked(services.creatures.has_flag_text(attacker, "MELEE_PERK_PRESSURE_STRIKES"))
        or checked(services.creatures.snapshot(attacker)).has_weapon then
        return
    end

    set_number(victim, "pressure_redeal_damage", number(victim, "pressure_redeal_damage") + (event.data.damage or 0))
    if number(victim, "pressure_redeal_queued") ~= 1 then
        set_number(victim, "pressure_redeal_queued", 1)
        set_number(victim, "timer_pressure_redeal", services.time.now().turn)
    end
end)
ccb.runtime.on("game:monster_takes_damage", "perk_pressure_strikes_monster")

ccb.runtime.handler(deal_damage_handler, function(payload)
    local actor = payload.character
    local targets = {}
    local offset = 0
    while true do
        local page = services.creatures.nearby(actor, {
            kind = "monster",
            attitude = "any",
            visible_only = false,
            include_hallucinations = true,
            radius = 1000,
            limit = 256,
            offset = offset,
        })
        if page.ok == false then error(page.error.message) end
        for _, entry in ipairs(page.items) do
            targets[#targets + 1] = entry.handle
        end
        if not page.has_more or page.returned == 0 then break end
        offset = offset + page.returned
    end

    local now = services.time.now().turn
    for _, monster in ipairs(targets) do
        if monster:is_valid() and number(monster, "pressure_redeal_queued") == 1 then
            local timer = checked(variables.get_number(monster, "timer_pressure_redeal")).value
            if timer ~= nil and (now - timer) > 3 then
                set_number(monster, "pressure_redeal_queued", 0)
                local amount = number(monster, "pressure_redeal_damage")
                local damaged = services.creatures.damage(monster, pure_damage, amount, {
                    body_part = torso,
                    source = monster,
                })
                if not damaged.ok and damaged.error.code ~= "dead" and damaged.error.code ~= "destroyed" then
                    error(damaged.error.message)
                end
                if monster:is_valid() then
                    set_number(monster, "timer_pressure_redeal", now + 60 * 3600)
                    set_number(monster, "pressure_redeal_damage", 0)
                end
            end
        end
    end
end, 1)

ccb.runtime.handler("perk_style_hit", function(style)
    insight.spend(style.character)
    tasks.after_character_turn(style.character, 4, deal_damage_handler)
    tasks.after_character_turn(style.character, 6, deal_damage_handler)
end)
