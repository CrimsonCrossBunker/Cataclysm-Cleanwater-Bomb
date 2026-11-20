local ccb = require("ccb")
local services = ccb.services
local runtime = ccb.runtime
local id = services.types.id
local noble = "UNKNOWING_CHANGELING_NOBLE"
local brownie = "UNKNOWING_CHANGELING_COMMONER_BROWNIE"
local pooka = "UNKNOWING_CHANGELING_COMMONER_POOKA"
local selkie = "UNKNOWING_CHANGELING_COMMONER_SELKIE"
local trow = "UNKNOWING_CHANGELING_COMMONER_TROW"
local heritages = { noble, brownie, pooka, selkie, trow }

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function actor(event)
    return event.actors.speaker or event.actors.character or event.actors.killer or services.characters.avatar()
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function is_changeling(character)
    for _, trait in ipairs(heritages) do
        if has_trait(character, trait) then return true end
    end
    return false
end

local function number(character, key)
    return checked(services.variables.get_number(character, key)).value or 0
end

local function set(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function award(character, milestone, amount)
    local flag = milestone and ("changeling_advancement_" .. milestone)
    if flag and number(character, flag) == 1 then return end
    local key = "changeling_advancement_dreams_counter"
    set(character, key, number(character, key) + (amount or 1))
    if flag then set(character, flag, 1) end
end

local march_lords = {
    mon_march_lord_spring = true, mon_march_lord_summer = true,
    mon_march_lord_autumn = true, mon_march_lord_winter = true,
}
runtime.handler("changeling_hunt_milestones", function(event)
    local character, victim = actor(event), event.data.victim_type
    if march_lords[victim] or victim == "mon_dream_shadowman" then
        if is_changeling(character) then award(character) end
    elseif victim == "mon_triffid_heart" and has_trait(character, pooka) then
        award(character, "pooka_condition_kill_triffid_heart")
    end
end)
runtime.on("game:character_kills_monster", "changeling_hunt_milestones")

runtime.handler("changeling_casting_milestones", function(event)
    local character, difficulty = actor(event), event.data.difficulty
    if not event.data.success or difficulty < 5 then return end
    if is_changeling(character) then award(character, "condition_cast_difficulty_5_or_higher_glamour") end
    if difficulty >= 8 and has_trait(character, noble) then
        award(character, "noble_condition_cast_difficulty_8_or_higher_glamour")
    end
end)
runtime.on("game:spellcasting_finish", "changeling_casting_milestones")

local skills = {
    gramarye = { false, "condition_reach_level_seven_deduction" },
    speech = { noble, "noble_condition_reach_level_seven_social" },
    tailor = { brownie, "brownie_condition_reach_level_seven_food_or_tailoring" },
    cooking = { brownie, "brownie_condition_reach_level_seven_food_or_tailoring" },
    survival = { pooka, "pooka_condition_reach_level_seven_survival" },
    swimming = { selkie, "selkie_condition_reach_level_seven_athletics" },
    fabrication = { trow, "trow_condition_reach_level_seven_fabrication" },
}
runtime.handler("changeling_skill_milestones", function(event)
    local rule = skills[event.data.skill]
    if not rule or event.data.new_level < 7 then return end
    local character = actor(event)
    if (rule[1] and has_trait(character, rule[1])) or (not rule[1] and is_changeling(character)) then
        award(character, rule[2])
    end
end)
runtime.on("game:gains_skill_level", "changeling_skill_milestones")

local waterways = {
    { "river", 1, { "generic_river_bank", "generic_river", "river_center", "river", "river_c_not_ne",
            "river_c_not_nw", "river_c_not_se", "river_c_not_sw" } },
    { "lake", 1, { "lake_shore", "lake_surface" } },
    { "ocean", 2, { "ocean_water_cube", "ocean_surface" } },
}
runtime.handler("changeling_travel_milestones", function(event)
    local character = actor(event)
    if not is_changeling(character) then return end
    local omt = checked(services.creatures.snapshot(character)).position:project_to("omt")
    if services.overmap.matches_location(omt, "boann_sidhe_island") then
        award(character, "condition_found_boanns_island")
    end
    if has_trait(character, selkie) then
        for _, waterway in ipairs(waterways) do
            for _, terrain in ipairs(waterway[3]) do
                if services.overmap.matches_location(omt, terrain) then
                    award(character, "selkie_condition_go_near_" .. waterway[1], waterway[2])
                    break
                end
            end
        end
    end
    if omt.z == -2 and has_trait(character, trow) then
        award(character, "trow_condition_descend_to_negative_z_2")
    end
end)
runtime.on("game:avatar_enters_omt", "changeling_travel_milestones")

runtime.handler("selkie_swimming_milestone", function(event)
    local character = actor(event)
    if not has_trait(character, selkie) or number(character, "changeling_advancement_selkie_condition_swim_in_water") == 1 then
        return
    end
    local position = checked(services.creatures.snapshot(character)).position
    local terrain_has_flag = services.gameplay.environment.terrain_has_flag
    if terrain_has_flag(position, "DEEP_WATER") and not terrain_has_flag(position, "INDOORS") then
        award(character, "selkie_condition_swim_in_water")
    end
end)
runtime.on("game:avatar_moves", "selkie_swimming_milestone")

runtime.handler("trow_mining_milestone", function(event)
    local character = actor(event)
    if event.data.activity == "ACT_MULTIPLE_MINE" and has_trait(character, trow) then
        award(character, "trow_condition_mine")
    end
end)
runtime.on("game:character_starts_activity", "trow_mining_milestone")

runtime.handler("trow_weapon_milestone", function(event)
    local character = actor(event)
    if has_trait(character, trow) and checked(services.inventory.wielded_matches(character, id("material", "moon_tears"))) then
        award(character, "trow_condition_wield_moons_tears_weapon")
    end
end)
runtime.on("game:character_wields_item", "trow_weapon_milestone")

local character_timers = require("character_timers")
local weather = { weather_rain = true, weather_rainstorm = true, weather_thunder = true, weather_lightning = true }

local function raining()
    return weather[services.weather.current().weather.value] == true
end

local function follower_rule(required, milestone, handler)
    return {
        handler = handler,
        eligible = function(character)
            return has_trait(character, noble) and number(character, "changeling_advancement_" .. milestone) ~= 1
        end,
        interval = function() return services.random.native_int(3600, 3600) end,
        act = function(character)
            if services.npcs.count_allies(false) >= required then award(character, milestone) end
        end,
    }
end

local rain_counter = "effect_changeling_advancement_selkie_stand_in_rain_counter"
local rain_milestone = "selkie_condition_stand_in_rain"
local timers = {
    follower_rule(1, "noble_condition_you_have_one_follower", "changeling_first_follower"),
    follower_rule(7, "noble_condition_you_have_seven_followers", "changeling_seven_followers"),
    {
        handler = "selkie_rain_exposure",
        interval = function() return 1 end,
        eligible = function(character)
            return has_trait(character, selkie) and number(character, "changeling_advancement_" .. rain_milestone) ~= 1
                and raining()
        end,
        act = function(character)
            local effect = id("effect", rain_counter)
            local current = services.effects.get(character, effect, id("body_part", "bp_null"))
            if current.ok then
                if current.value.intensity > 900 then award(character, rain_milestone) end
            elseif current.error.code ~= "not_found" then
                checked(current)
            end
            local added = services.effects.add(character, effect, services.time.duration(16, "minute"))
            if not added.ok and added.error.code ~= "rejected" then checked(added) end
        end,
    },
    {
        handler = "brownie_homebody_hour",
        interval = function() return services.random.native_int(3600, 3600) end,
        eligible = function(character) return has_trait(character, "BROWNIE_HOMEBODY") end,
        act = function(character)
            local speed = number(character, "brownie_homebody_speed_bonus")
            if speed > 25 or checked(services.effects.has(character, id("effect", "sleep"),
                id("body_part", "bp_null"), -1)) then return end
            set(character, "brownie_homebody_speed_bonus", speed + 1)
            set(character, "brownie_sense_intruders", number(character, "brownie_sense_intruders") + 1)
            if speed + 1 == 24 and has_trait(character, brownie) then
                award(character, "brownie_condition_spend_twenty_four_hours_indoors")
            end
        end,
    },
}

for _, timer in ipairs(timers) do
    character_timers.register(timer.handler, timer.handler, timer.interval, timer.eligible, timer.act)
end

runtime.handler("record_arvore_wilderness", function(event)
    local character = actor(event)
    local is_pooka = has_trait(character, pooka)
    if not (is_pooka or has_trait(character, "ARVORE") or has_trait(character, "FALSE_ARVORE_HATRED")
        or has_trait(character, "FAE_ENMITY") or has_trait(character, "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT")) then
        return
    end
    local position = checked(services.creatures.snapshot(character)).position:project_to("omt")
    local wild = not services.overmap.matches_location_near(position, "road", 2)
    set(character, "arvore_is_in_wilderness", wild and 1 or 0)
    local tracker = id("effect", "effect_pooka_outdoors_tracker")
    local bp = id("body_part", "bp_null")
    if not wild then
        if checked(services.effects.has(character, tracker, bp, -1)) then
            checked(services.effects.remove(character, tracker))
        end
        return
    end
    if not is_pooka then return end
    local milestone = "pooka_condition_spend_twenty_four_hours_in_the_wilderness"
    if not checked(services.effects.has(character, tracker, bp, -1)) and number(character, "changeling_advancement_" .. milestone) ~= 1 then
        local added = services.effects.add(character, tracker, services.time.duration(61, "minute"))
        if not added.ok and added.error.code ~= "rejected" then checked(added) end
    end
    if checked(services.effects.has(character, tracker, bp, 24)) then award(character, milestone) end
end)
runtime.on("game:avatar_enters_omt", "record_arvore_wilderness")

local homebody_locations = {
    "FACTION_CAMP_ANY", "mansion_e1", "mansion_boarded_e1", "mansion_e2",
    "mansion_+1", "mansion_+1d", "mansion_+1u", "mansion_+1_roof",
    "mansion_+2", "mansion_+2d", "mansion_+2u", "mansion_+2_roof",
    "mansion_+3", "mansion_+3u", "mansion_+3_roof", "mansion_+4",
    "mansion_+4d", "mansion_+4u", "mansion_+4_roof", "mansion_boarded_c1",
    "mansion_c1", "mansion_c1d", "mansion_boarded_c1u", "mansion_c1u",
    "mansion_c1_roof", "mansion_boarded_c2", "mansion_c2", "mansion_c2d",
    "mansion_boarded_c2u", "mansion_c2u", "mansion_c2_roof", "mansion_boarded_c3",
    "mansion_c3", "mansion_c3d", "mansion_boarded_c3u", "mansion_c3u",
    "mansion_c3_roof", "mansion_boarded_c4", "mansion_c4", "mansion_c4d",
    "mansion_boarded_c4u", "mansion_c4u", "mansion_c4_roof", "mansion_c5",
    "mansion_c5d", "mansion_c5u", "mansion_c5_roof", "mansion_e1d",
    "mansion_boarded_e1u", "mansion_e1u", "mansion_e1_roof", "mansion_e2d",
    "mansion_e2u", "mansion_e2_roof", "mansion_t1", "mansion_t1d",
    "mansion_t1u", "mansion_t1_roof", "mansion_boarded_t2", "mansion_boarded_t2_start",
    "mansion_t2", "mansion_boarded_t2d", "mansion_boarded_t2d_start", "mansion_t2d",
    "mansion_boarded_t2u", "mansion_t2u", "mansion_t2_roof", "mansion_boarded_t4",
    "mansion_t4", "mansion_t4d", "mansion_boarded_t4u", "mansion_t4u",
    "mansion_t4_roof", "mansion_t5", "mansion_t5d", "mansion_t5u",
    "mansion_t5_roof", "mansion_t6", "mansion_t6d", "mansion_t6u",
    "mansion_t6_roof", "mansion_t7", "mansion_t7d", "mansion_t7u",
    "mansion_t7_roof",
}

runtime.handler("brownie_leave_home", function(event)
    local character = actor(event)
    local speed = number(character, "brownie_homebody_speed_bonus")
    if speed <= 0 then return end
    local position = checked(services.creatures.snapshot(character)).position
    if not services.gameplay.environment.is_outside(position) then return end
    local omt = position:project_to("omt")
    for _, location in ipairs(homebody_locations) do
        if services.overmap.matches_location(omt, location) then return end
    end
    set(character, "brownie_homebody_speed_bonus", speed - 1)
    set(character, "brownie_sense_intruders", 0)
end)
runtime.on("game:avatar_enters_omt", "brownie_leave_home")

local brownie_recipes = {
    BROWNIE_MAKE_CHEESE_AND_BUTTER = { "cheese_hard_brownie", "butter_brownie" },
    BROWNIE_THRESH_CORN_AND_WHEAT = { "cornmeal_brownie", "flour_brownie" },
}
runtime.handler("learn_brownie_recipes", function(event)
    local recipes = brownie_recipes[event.data.trait]
    if recipes then
        local character = actor(event)
        for _, recipe in ipairs(recipes) do checked(services.recipes.learn(character, id("recipe", recipe))) end
    end
end)
runtime.on("game:gains_mutation", "learn_brownie_recipes")
