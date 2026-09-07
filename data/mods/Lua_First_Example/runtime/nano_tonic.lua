local ccb = require("ccb")
local tonic = {}
local state = ccb.state.character
local effect_name = "lua_first_nano_recovery"
local function value(result)
    assert(result.ok, "Nano-tonic native operation failed")
    return result.value
end

function tonic.use(context)
    local now = ccb.services.time.snapshot().turn
    if state.get("tonic_ready_at", 0) > now then
        context:message("The nano-tonic is still cooling down.")
        return 0
    end
    local consumed = ccb.services.inventory.consume(context.character,
        ccb.services.types.id("item", "lua_first_cleanwater_cell"), 1)
    if not consumed.ok then
        context:message("The nano-tonic needs a purification capacitor cell.")
        return 0
    end
    state.set("tonic_ready_at", now + 60)
    state.set("tonic_active", true)
    value(ccb.services.effects.add(context.character,
        ccb.services.types.id("effect", effect_name), ccb.services.time.duration(31, "turn")))
    context:message("The nano-tonic starts three recovery pulses. One capacitor cell consumed.")
    return 0
end

function tonic.gained_effect(event)
    if event.data.effect ~= effect_name or not state.get("tonic_active", false) then
        return
    end
    local actor = event.actors.character
    if actor == nil or state.get("tonic_task", 0) ~= 0 then
        return
    end
    state.set("tonic_events", state.get("tonic_events", 0) + 1)
    state.set("tonic_task", ccb.tasks.after(10, "lua_first_task_tonic_tick",
        { remaining = 3 }, 1, "character", actor))
end

function tonic.tick(task)
    if state.get("tonic_task", 0) ~= task.id then
        return
    end
    state.set("tonic_task", 0)
    if task.actor == nil then
        state.set("tonic_active", false)
        return
    end
    value(ccb.services.needs.modify(task.actor, { stamina = 100 }))
    state.set("lua_first_tonic_ticks", state.get("lua_first_tonic_ticks", 0) + 1)
    if task.payload.remaining > 1 then
        state.set("tonic_task", ccb.tasks.after(10, "lua_first_task_tonic_tick",
            { remaining = task.payload.remaining - 1 }, 1, "character", task.actor))
    else
        value(ccb.services.effects.remove(task.actor, ccb.services.types.id("effect", effect_name)))
        state.set("tonic_active", false)
    end
end

return tonic
