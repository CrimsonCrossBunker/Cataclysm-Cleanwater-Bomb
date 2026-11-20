local ccb = require("ccb")
local services = ccb.services
local runtime = ccb.runtime
local id = services.types.id
local near_settlement = require("paraclesian_settlements")

local notices = {
    fell_tree = function() return services.translate("You feel a stabbing pain as the tree falls.  One of your own, murdered by your hand.") end,
    light_fire = function() return services.translate("Your heart races as you spark the fire.  A fire, outdoors, in the view of the trees and the grasses.  Visions of charred wood, of blackened trunks and broken branches, fill your mind.") end,
    arvore_wake = function() return services.translate("You awaken with a groggy head, blinking bleary eyes.  Sleeping near the remnants of civilization away from the bounty of nature, your sleep was not as restful as it should have been.") end,
    ierde_wake = function() return services.translate("You awaken in pain, your muscles stiff, your body groaning in protest.  Away from the depths of the living earth, your sleep was not as restful as it should have been.") end,
    earth_tools = function() return services.translate("You feel a stabbing pain as your tools dig into the living earth.  Tools made of material torn from the earth by humans.  You should not be using them.") end,
    slain_human = function() return services.translate("You feel a stab of pain as the human collapses in a puddle of their own blood.  A human, slain by your hand, in defiance of your nature.") end,
    loneliness = function() return services.translate("You awaken with a start as a terrible feeling of crushing loneliness grips you.  You were meant to live in close contact with humans, not wake up to an empty home.") end,
    wet = function() return services.translate("Accursed water!  The touch of it burns you like acid, reminding you of your nature.  Your flames must not be dowsed.") end,
    still_air = function() return services.translate("You gasp as you awaken, the still air barely moving into your lungs.  You long for the blowing winds.") end,
    underground = function() return services.translate("The walls seem like they're closing in on you.  You were born to fly free, to dance on the winds, not to cower underground like a worm.  You have to get out to the open sky.") end,
    land = function() return services.translate("You gasp as you awaken, thin air barely filling your lungs as you struggle to breath.  You long for the soothing embrace of the waters.") end,
}

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function actor(event)
    return event.actors.speaker or event.actors.character or event.actors.killer or services.characters.avatar()
end

local function has(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function gain(character, trait)
    checked(services.mutations.replace(character, id("mutation", trait)))
end

local function has_effect(character, effect)
    return checked(services.effects.has(character, effect, nil, -1))
end

local function add_effect(character, effect, duration, options)
    local added = services.effects.add(character, effect, duration, options)
    if not added.ok and added.error.code ~= "rejected" then checked(added) end
end

local function mature(character, lineage, gift)
    return has(character, "THRESH_" .. lineage) or has(character, gift)
        or checked(services.mutations.category_count(character, id("mutation_category", lineage), "ALL", true)) >= 15
end

local function break_ban(character)
    checked(services.morale.add(character, id("morale", "morale_broke_fae_ban"), -20, -80, {
        duration = services.time.duration(24, "hour"), decay_start = services.time.duration(12, "hour"),
    }))
    local broken = id("effect", "effect_broke_fae_ban")
    local intensity = checked(services.effects.exact_intensity(character, broken)) or -1
    local turns = services.random.native_int(0, 259200) + 86400
    add_effect(character, broken, services.time.duration_from_turns(turns), { intensity = intensity + 1 })
end

local function message(character, notice)
    if character.subtype == "avatar" then services.messages.add(notices[notice](), "bad") end
end

local pain_task = "paraclesian_ban_pain"
runtime.handler(pain_task, function(task)
    checked(services.needs.modify_raw_pain(task.character, services.random.native_int(0, 35) + 8))
end)

local function painful_violation(character)
    break_ban(character)
    ccb.tasks.after_character_turn(character, 1, pain_task)
end

runtime.handler("arvore_felling_ban", function(event)
    local character = actor(event)
    if has(character, "THRESH_ARVORE") or has(character, "ARVORE_NURTURING_THE_GREEN") then
        painful_violation(character)
        message(character, "fell_tree")
    end
end)
runtime.on("game:cuts_tree", "arvore_felling_ban")

local earth_tools = { ACT_MULTIPLE_MINE = true, ACT_PICKAXE = true, ACT_CHURN = true }
runtime.handler("paraclesian_tool_bans", function(event)
    local character, activity = actor(event), event.data.activity
    if activity == "ACT_START_FIRE" and has(character, "ARVORE") and checked(services.creatures.snapshot(character)).outside
        and (checked(services.spells.effective_level(character, "arvore_damage_zombies_heal_living")) >= 0
            or checked(services.spells.effective_level(character, "arvore_overgrowth_spell")) >= 0) then
        painful_violation(character)
        message(character, "light_fire")
    elseif earth_tools[activity] and has(character, "THRESH_IERDE") and has(character, "IERDE_RESHAPE_THE_EARTH") then
        painful_violation(character)
        message(character, "earth_tools")
    end
end)
runtime.on("game:character_starts_activity", "paraclesian_tool_bans")

local food_traits = { "PICKYEATER", "ANTIJUNK" }
local gifts = {
    ARVORE_SUN_NUTRIENTS = { "ARVORE", { "ANTIJUNK" } },
    ARVORE_BLOOD = { "ARVORE", { "ANTIJUNK" } },
    IERDE_DETECT_NEARBY_MONSTERS_EARTH = { "IERDE", { "ANTIJUNK" } },
    IERDE_SINK_INTO_EARTH = { "IERDE", { "ANTIJUNK" } },
    IERDE_CARDIO2 = { "IERDE", { "HEAVYSLEEPER2" } },
    IERDE_SLOW_BLEEDING = { "IERDE", { "HEAVYSLEEPER2" } },
    HOMULLUS_EAT_DEMIHUMANS = { "HOMULLUS", food_traits },
    SALAMANDER_COOKING_HEAT = { "SALAMANDER", { "PYROMANIA" } },
    SALAMANDER_HEAT_EYES2 = { "SALAMANDER", { "PYROMANIA" } },
    air_sprite = { "SYLPH", { "ANTIJUNK" } },
    BREATHE_WO_AIR = { "SYLPH", { "ANTIJUNK" } },
    SYLPH_INT_BONUS_1 = { "SYLPH", { "MOODSWINGS" } },
    SLYPH_RESIST_COLD2 = { "SYLPH", { "MOODSWINGS" } },
    FOUL_WATER = { "UNDINE", { "ANTIJUNK" } },
    SUMMON_RAIN = { "UNDINE", { "ANTIJUNK" } },
    SALTWATER_TO_FRESHWATER = { "UNDINE", { "LIGHTWEIGHT" } },
    UNDINE_SLEEP_WATER = { "UNDINE", { "LIGHTWEIGHT" } },
}
runtime.handler("paraclesian_ban_traits", function(event)
    local rule = gifts[event.data.trait]
    if not rule then return end
    local character = actor(event)
    if has(character, rule[1]) then
        for _, trait in ipairs(rule[2]) do gain(character, trait) end
    end
end)
runtime.on("game:gains_mutation", "paraclesian_ban_traits")

local underground_terrain = {
    t_rock_floor_no_roof = true, t_rock = true, t_rock_floor = true, t_rock_smooth = true,
    t_rock_wall_half = true, t_dirt_underground = true, t_mud_underground = true,
    t_moss_underground = true, t_clay_underground = true, t_claymound_underground = true,
    t_sand_underground = true,
}

local function unrested(character, notice)
    painful_violation(character)
    local sleepiness = checked(services.needs.get(character)).sleepiness
    checked(services.needs.set(character, { sleepiness = sleepiness + 150 }))
    message(character, notice)
end

local function keep_food_traits(character)
    if (has(character, "HOMULLUS_EAT_DEMIHUMANS") or has(character, "THRESH_HOMULLUS"))
        and (not has(character, "PICKYEATER") or not has(character, "ANTIJUNK")) then
        for _, trait in ipairs(food_traits) do gain(character, trait) end
    end
end

local sky_island = ccb.content.is_mod_active("skyisland")
runtime.handler("paraclesian_sleep_bans", function(event)
    local character = actor(event)
    if sky_island then
        keep_food_traits(character)
        return
    end
    local location = checked(services.creatures.snapshot(character))
    if (has(character, "THRESH_ARVORE") or has(character, "ARVORE_MOSS"))
        and (near_settlement(location.position:project_to("omt")) or services.overmap.is_in_city(location.position)) then
        unrested(character, "arvore_wake")
    end
    if mature(character, "IERDE", "IERDE_SINK_INTO_EARTH") then
        local tile = checked(services.map.tile(location.position))
        if location.outside or not underground_terrain[checked(services.map.snapshot(tile)).terrain.value] then
            unrested(character, "ierde_wake")
        end
    end
    if (has(character, "THRESH_HOMULLUS")
        or (has(character, "HOMULLUS_BACKSTAGE") and has(character, "HOMULLUS_REGEN_STAMINA")))
        and checked(services.characters.count_nearby(location.position, character, { radius = 45, attitude = "any" })) == 0 then
        break_ban(character)
        message(character, "loneliness")
    end
    keep_food_traits(character)
    if (has(character, "THRESH_SYLPH") or has(character, "SYLPH_DEX_BONUS_2")) and not location.outside then
        break_ban(character)
        message(character, "still_air")
    end
    if has(character, "THRESH_UNDINE") and has(character, "UNDINE_SLEEP_WATER")
        and not checked(services.characters.is_underwater(character)) then
        break_ban(character)
        message(character, "land")
    end
end)
runtime.on("game:character_wakes_up", "paraclesian_sleep_bans")

local function human_monster(event)
    local victim = event.participants.interlocutor
    if not victim then return false end
    local human, zombie = false, false
    for _, species in ipairs(victim.species) do
        if species == "FERAL" then return true end
        if species == "ZOMBIE" then zombie = true end
        if species == "HUMAN" then human = true end
    end
    return not zombie and (human or services.monsters.type_has_flag(id("monster", event.data.victim_type),
        id("monster_flag", "HUMAN")))
end

local function homullus_kill(character)
    painful_violation(character)
    message(character, "slain_human")
end
runtime.handler("homullus_kill_character_ban", function(event)
    local character = actor(event)
    if mature(character, "HOMULLUS", "HOMULLUS_BACKSTAGE") then homullus_kill(character) end
end)
runtime.on("game:character_kills_character", "homullus_kill_character_ban")
runtime.handler("homullus_kill_monster_ban", function(event)
    local character = actor(event)
    if mature(character, "HOMULLUS", "HOMULLUS_BACKSTAGE") and human_monster(event) then homullus_kill(character) end
end)
runtime.on("game:character_kills_monster", "homullus_kill_monster_ban")

local wet_limiter = id("effect", "effect_salamander_wet_rate_limiter")
runtime.handler("salamander_wet_ban", function(event)
    if event.data.effect ~= "wet" or (event.data.bodypart ~= "head" and event.data.bodypart ~= "foot_l") then return end
    local character = actor(event)
    if (has(character, "THRESH_SALAMANDER") or has(character, "SALAMANDER_SKIN_2")) and not has_effect(character, wet_limiter) then
        painful_violation(character)
        add_effect(character, wet_limiter, services.time.duration_from_turns(60))
        message(character, "wet")
    end
end)
runtime.on("game:character_gains_effect", "salamander_wet_ban")

local confinement = id("effect", "effect_sylph_underground_timer")
local confinement_task = "sylph_underground_ban"
runtime.handler("track_sylph_confinement", function(event)
    local character = actor(event)
    if not has(character, "THRESH_SYLPH") then return end
    local location = checked(services.creatures.snapshot(character))
    if location.position.z < 0 and has(character, "SYLPH_FLY_AT_WILL") and not has_effect(character, confinement) then
        add_effect(character, confinement, services.time.duration(61, "minute"))
        ccb.tasks.after_character_turn(character, services.random.native_int(3600, 3600), confinement_task)
    elseif location.position.z >= 0 and has_effect(character, confinement) and location.outside then
        checked(services.effects.remove(character, confinement))
    end
end)
runtime.on("game:avatar_moves", "track_sylph_confinement")

runtime.handler(confinement_task, function(task)
    local character = task.character
    if has(character, "THRESH_SYLPH") and has_effect(character, confinement) then
        break_ban(character)
        message(character, "underground")
    end
end)
