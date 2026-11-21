local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function register_scenario_startup(start_handler, due_handler, callback)
    ccb.runtime.handler(due_handler, callback)
    ccb.runtime.handler(start_handler, function(payload)
        ccb.tasks.after_character_turn(payload.character, 0, due_handler)
    end)
end

local function bind_scenario(scenario_id, start_handler)
    content.replace(content.Scenario {
        id = scenario_id,
        inherits = scenario_id,
        on_start = start_handler,
    })
end

register_scenario_startup("scenario_once_bitten_start", "scenario_once_bitten_due", function(payload)
    local applied = services.effects.add(payload.character, id("effect", "vampire_virus"),
        services.time.duration(1, "turn"), { permanent = true, intensity = 1 })
    if not applied.ok and applied.error.code ~= "rejected" then
        error(applied.error.message)
    end
end)

register_scenario_startup("scenario_lilin_starting_ruach_start", "scenario_lilin_starting_ruach_due", function(payload)
    checked(services.needs.modify_vitamin(payload.character, id("vitamin", "lilin_ruach_vitamin"),
        services.random.native_int(550, 850)))
end)

local paraclesian_mutagens = {
    { "IERDE", "mutagen_earthkin" },
    { "UNDINE", "mutagen_waterkin" },
    { "SALAMANDER", "mutagen_flamekin" },
    { "SYLPH", "mutagen_airkin" },
    { "HOMULLUS", "mutagen_dollkin" },
    { "ARVORE", "mutagen_plantkin" },
}

register_scenario_startup("scenario_paraclesian_birth_start", "scenario_paraclesian_birth_due", function(payload)
    local actor = payload.character
    checked(services.needs.modify_vitamin(actor, id("vitamin", "mutagen"), 550))
    for _, entry in ipairs(paraclesian_mutagens) do
        if checked(services.mutations.has_id_text(actor, entry[1])) then
            checked(services.needs.modify_vitamin(actor, id("vitamin", entry[2]), 550))
        end
    end
end)

local werewolf_variables = {
    { "werewolf_xp_threshold", 100 },
    { "werewolf_xp_threshold_updater", 250 },
    { "werewolf_give_xp_value", 1 },
    { "werewolf_give_xp_updater_value", 1 },
}

register_scenario_startup("scenario_werewolf_variables_start", "scenario_werewolf_variables_due", function(payload)
    local actor = payload.character
    for _, entry in ipairs(werewolf_variables) do
        checked(services.variables.set(actor, entry[1], entry[2], { include_before = false }))
    end
end)

register_scenario_startup("scenario_xe_permanent_ominous_fog_start", "scenario_xe_permanent_ominous_fog_due", function()
    checked(services.variables.set_global("xe_weather_ominous_fog_scenario", 1, { include_before = false }))
end)

register_scenario_startup("scenario_xe_revenant_scenario_start", "scenario_xe_revenant_scenario_due", function(payload)
    local actor = payload.character
    local handles = {}
    local continuation = nil
    repeat
        local page = checked(services.items.page(
            { kind = "character", character = actor, slot = "worn" },
            { page_size = 256, recursive = false },
            continuation))
        for _, entry in ipairs(page.items) do
            handles[#handles + 1] = entry.handle
        end
        continuation = page.continuation
    until not continuation

    local filthy = id("json_flag", "FILTHY")
    for _, handle in ipairs(handles) do
        checked(services.items.set_flag(handle, filthy, true))
    end
end)

bind_scenario("paraclesian_birth", "scenario_paraclesian_birth_start")
bind_scenario("werewolf_native_born", "scenario_werewolf_variables_start")
bind_scenario("once_bitten", "scenario_once_bitten_start")
bind_scenario("xe_lilin_scenario", "scenario_lilin_starting_ruach_start")
bind_scenario("xe_ominous_for_permanent", "scenario_xe_permanent_ominous_fog_start")
bind_scenario("xe_revenant_scenario", "scenario_xe_revenant_scenario_start")

if content.is_mod_active("innawood") then
    bind_scenario("paraclesian_birth_naked_afraid", "scenario_paraclesian_birth_start")
    bind_scenario("xe_lilin_scenario_naked_afraid", "scenario_lilin_starting_ruach_start")
    bind_scenario("once_bitten_naked_and_afraid", "scenario_once_bitten_start")
end
