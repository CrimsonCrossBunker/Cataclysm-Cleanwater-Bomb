local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local timers = require("character_timers")
local counter = "paraclesian_passive_mutation_value"
local general = id("vitamin", "mutagen")
local vitamins = {
    { "IERDE", "mutagen_earthkin" }, { "UNDINE", "mutagen_waterkin" },
    { "SALAMANDER", "mutagen_flamekin" }, { "SYLPH", "mutagen_airkin" },
    { "HOMULLUS", "mutagen_dollkin" }, { "ARVORE", "mutagen_plantkin" },
}

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function read_counter(character)
    return checked(services.variables.get_number(character, counter)).value or 0
end

local function store_counter(character, value)
    checked(services.variables.set(character, counter, value, { include_before = false }))
end

local function mutate(character)
    checked(services.needs.set_vitamin(character, general, 550))
    for _, lineage in ipairs(vitamins) do
        if checked(services.mutations.has_id_text(character, lineage[1])) then
            local vitamin = id("vitamin", lineage[2])
            local level = checked(services.needs.get_vitamin(character, vitamin))
            checked(services.needs.set_vitamin(character, vitamin, level + 550))
        end
    end
    checked(services.mutations.mutate(character, 0, true))
    checked(services.needs.set_vitamin(character, general, 0))
    for _, lineage in ipairs(vitamins) do
        checked(services.needs.set_vitamin(character, id("vitamin", lineage[2]), 0))
    end
end

local function advance(character, family, environment)
    local value = read_counter(character)
    if environment(character, family) then
        value = value + 1
        store_counter(character, value)
    elseif value > 0 then
        value = value - 1
        store_counter(character, value)
    end
    if value >= 500 and checked(services.needs.get_vitamin(character, general)) == 0 then
        mutate(character)
        store_counter(character, read_counter(character) - 500)
    end
end

local function interval()
    return services.random.native_int(1800, 5400)
end

return function(profiles, environment)
    for _, profile in ipairs(profiles) do
        local handler = profile.family .. "_passive_mutation"
        timers.register(handler, handler, interval,
            function(character) return checked(services.mutations.has_id_text(character, profile.trait)) end,
            function(character) advance(character, profile.family, environment) end)
    end
end
