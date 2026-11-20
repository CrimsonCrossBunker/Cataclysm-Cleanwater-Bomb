local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local env = services.gameplay.environment

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function actor(event)
    return event.actors.speaker or event.actors.character or services.characters.avatar()
end

local function has(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function flag(character, key)
    return checked(services.variables.get_number(character, key)).value == 1
end

local function easier(character, school)
    local count = checked(services.mutations.category_count(character, id("mutation_category", school), "ALL", true))
    checked(services.spells.adjust_casting(character, "difficulty", count / -2, { school = id("mutation", school) }))
end

local function penalize(character, school)
    local spell_class = id("mutation", school)
    local current = checked(services.spells.school_level_adjustment(character, spell_class))
    checked(services.spells.set_school_level_adjustment(character, spell_class, current - 4))
end

local wooden = {
    t_barkfloor = true, t_floor = true, t_wood_stairs_down = true, t_wood_stairs_up = true,
    t_door_o = true, t_dirt_underground = true, t_dirtfloor_thatchroof = true,
}
local unsuitable_earth = {
    t_vitrified_sand = true, t_pit_corpsed = true, t_fungus = true, t_glassed_sand = true,
    t_rubber_mulch = true, t_swater_surf = true, t_woodchips = true,
}
local water = {
    t_water_dp = true, t_water_sh = true, t_swater_dp = true, t_swater_dp_underground = true,
    t_water_dp_underground = true, t_water_pool = true, t_water_pool_outdoors = true,
    t_water_hot = true, t_water_murky = true, t_water_sh_underground = true, t_swater_sh_underground = true,
    t_swater_sh = true, t_water_pool_shallow = true, t_water_pool_shallow_outdoors = true,
    t_water_moving_dp = true, t_water_moving_dp_underground = true, t_water_sh_murky_underground = true,
}
local waterways = {
    "generic_river_bank", "generic_river", "river_center", "river", "river_c_not_ne", "river_c_not_nw",
    "river_c_not_se", "river_c_not_sw", "lake_shore", "lake_surface",
}
local hot_fields = { "fd_hot_air1", "fd_hot_air2", "fd_hot_air3", "fd_hot_air4", "fd_fire" }
local lit_items = { "torch_lit", "candle_lit", "oil_lamp_on", "oil_lamp_clay_on", "cigar_lit", "cig_lit" }

local function fahrenheit_in_kelvin(value)
    local offset = string.unpack("f", string.pack("f", 459.67))
    local divisor = string.unpack("f", string.pack("f", 1.8))
    return (value + offset) / divisor
end

local hot = fahrenheit_in_kelvin(80)
local freezing = fahrenheit_in_kelvin(32)

local function terrain(position)
    return checked(services.map.snapshot(checked(services.map.tile(position)))).terrain.value
end

local function waterway(omt, adjacent)
    for _, source in ipairs(waterways) do
        if adjacent then
            if services.overmap.matches_location_near(omt, source, 1) then return true end
        elseif services.overmap.matches_location(omt, source) then
            return true
        end
    end
    return false
end

local function salamander_modifiers(character, position)
    local temperature = services.weather.current().precise.temperature.value
    local fire = false
    for _, field in ipairs(hot_fields) do
        if env.field_exists(position, field, false) then fire = true break end
    end
    if fire or temperature >= hot then easier(character, "SALAMANDER") end
    if not fire and temperature <= freezing then
        for _, item in ipairs(lit_items) do
            if checked(services.inventory.has_type(character, id("item", item))) then return end
        end
        penalize(character, "SALAMANDER")
    end
end

ccb.runtime.handler("paraclesian_environmental_magic", function(event)
    local character = actor(event)
    local location = checked(services.creatures.snapshot(character))
    local position = location.position
    local omt = position:project_to("omt")
    local tile = terrain(position)
    if has(character, "ARVORE") then
        if location.outside and (env.terrain_has_flag(position, "SHRUB") or env.terrain_has_flag(position, "DIGGABLE")
            or env.terrain_has_flag(position, "YOUNG") or tile == "t_barkfloor" or tile == "t_barkfloor_noroof")
            and flag(character, "arvore_is_in_wilderness") then
            easier(character, "ARVORE")
        end
        if (not location.outside and (env.terrain_has_flag(position, "FLAT") or env.terrain_has_flag(position, "ROAD"))
            and not wooden[tile]) or (wooden[tile] and services.overmap.matches_location_near(omt, "road", 1)) then
            penalize(character, "ARVORE")
        end
    end
    if flag(character, "homullus_is_in_civilization") then
        easier(character, "HOMULLUS")
    elseif has(character, "HOMULLUS") and not services.overmap.matches_location_near(omt, "road", 1) then
        penalize(character, "HOMULLUS")
    end
    if has(character, "IERDE") then
        if (omt.z <= -1 or env.terrain_has_flag(position, "DIGGABLE") or tile == "t_rock_floor"
            or tile == "t_railroad_rubble" or tile == "t_dirt_underground") and not unsuitable_earth[tile] then
            easier(character, "IERDE")
        end
        if omt.z >= 1 then penalize(character, "IERDE") end
    end
    if has(character, "SALAMANDER") then salamander_modifiers(character, position) end
    if has(character, "SYLPH") then
        if location.outside and (omt.z >= 1 or services.weather.current().precise.wind_speed_mph >= 15) then
            easier(character, "SYLPH")
        end
        if omt.z <= -1 and not location.outside then penalize(character, "SYLPH") end
    end
    if has(character, "UNDINE") then
        if checked(services.characters.is_underwater(character)) or water[tile] or waterway(omt, true) then
            easier(character, "UNDINE")
        end
        local last_wet = checked(services.variables.get_number(character, "timer_undine_last_in_water")).value
        if last_wet and services.time.now().turn - last_wet >= 21600 then penalize(character, "UNDINE") end
    end
end)
ccb.runtime.on("game:opens_spellbook", "paraclesian_environmental_magic")

ccb.runtime.handler("record_undine_water_contact", function(event)
    local character = actor(event)
    if not has(character, "UNDINE") then return end
    local position = checked(services.creatures.snapshot(character)).position
    if water[terrain(position)] or waterway(position:project_to("omt"), false) then
        checked(services.variables.set(character, "timer_undine_last_in_water", services.time.now().turn, { include_before = false }))
    end
end)
ccb.runtime.on("game:avatar_moves", "record_undine_water_contact")
