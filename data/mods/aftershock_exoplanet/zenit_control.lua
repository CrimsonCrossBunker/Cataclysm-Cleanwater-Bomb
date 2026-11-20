local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local defensive = id("effect", "afs_ai_defensive")

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function write(actor, key, value)
    checked(services.variables.set(actor, key, value, { include_before = false }))
end

local function number(actor, key)
    return checked(services.variables.get_number(actor, key)).value
end

local function cooling_down(actor, key, duration)
    local last = number(actor, key)
    return last == nil or services.turn() - last <= duration
end

local function announce(actor, text)
    if checked(services.creatures.player_can_see(actor)) then
        services.messages.add(text, "neutral")
    end
end

local function is_defensive(actor)
    return checked(services.effects.exact_intensity(actor, defensive)) ~= nil
end

local function lower_armor(actor)
    if is_defensive(actor) then
        checked(services.effects.remove(actor, defensive))
        announce(actor, ccb.services.translate("The Zenit raises its body."))
    end
end

local function defend(actor, target)
    -- The original targeting rule checks the target's stance before protecting the Zenit.
    if not is_defensive(target) then
        checked(services.effects.add(actor, defensive, services.time.duration(10, "minute")))
        announce(actor, ccb.services.translate("The Zenit crouches forward, hiding most of its body behind its upper armor plate."))
    end
end

local function cast(actor, key, delay, spell, position, text)
    if not cooling_down(actor, key, delay) then
        lower_armor(actor)
        write(actor, key, services.turn())
        checked(services.monsters.cast_spell(actor, id("spell", spell), { target = position }))
        announce(actor, text)
    end
end

local function smoke(actor, position)
    cast(actor, "timer_zenit_smoke", 40, "quadraphract_smoke_mortar", position,
        ccb.services.translate("Several bomblets are expelled from the Zenit's munitions bay"))
end

local function release_mines(actor, position)
    if not cooling_down(actor, "timer_zenit_shock_mines", 300) then
        lower_armor(actor)
        write(actor, "timer_zenit_shock_mines", services.turn())
        checked(services.spawns.population(id("monster", "mon_shock_mine"), position,
            { count = 30, min_radius = 5, max_radius = 13 }))
        announce(actor, ccb.services.translate("Several mines are expelled from the Zenit's munitions bay"))
    end
end

ccb.runtime.handler("zenit_control", function(hit)
    local actor, target = hit.attacker, hit.target
    if number(actor, "setup") ~= 1 then
        write(actor, "setup", 1)
        write(actor, "timer_zenit_shock_mines", 0)
        write(actor, "timer_zenit_shock_att", 0)
        write(actor, "timer_zenit_smoke", 0)
    end
    local me = checked(services.creatures.snapshot(actor))
    local other = checked(services.creatures.snapshot(target))
    local distance = me.position:game_distance(other.position)
    if distance >= 25 then
        smoke(actor, other.position)
        defend(actor, target)
    elseif distance >= 12 then
        defend(actor, target)
    elseif distance >= 6 then
        cast(actor, "timer_zenit_shock_att", 12, "spell_electric_chain_2", other.position,
            ccb.services.translate("The Zenit emits an explosion of arcing electricity."))
    else
        release_mines(actor, me.position)
        smoke(actor, me.position)
    end
end)
