local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local proficiencies = services.proficiencies
local id = services.types.id
local duration = services.time.duration

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function is_character(actor)
    return actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character"
end

local function event_character(event)
    return event.actors.speaker or event.actors.character or services.characters.avatar()
end

local function set(actor, key, value)
    checked(variables.set(actor, key, value, { include_before = false }))
end

local function number(actor, key)
    return checked(variables.get_number(actor, key)).value or 0
end

local function cast_adjustment(difficulty, casting_time)
    return difficulty * math.sqrt(casting_time / 100)
end

local evocation = { spell = "evocation", name = "Evocation", proficiency = "evocation", flag = "EVOCATION_SPELL",
    adjustments = { { "damage", 1 } } }
local channeling = { spell = "channeling", name = "Channeling", proficiency = "channel", flag = "CHANNELING_SPELL",
    adjustments = { { "casting_time", -1 }, { "cost", -1 } } }
local transformation = { spell = "transformation", name = "Transformation", proficiency = "transformation", flag = "TRANSFORMATION_SPELL",
    adjustments = { { "casting_time", -1 }, { "duration", 1 } } }
local schools = {
    evocation,
    channeling,
    { spell = "summon", name = "Conjuration", proficiency = "summon", flag = "CONJURATION_SPELL",
        adjustments = { { "duration", 1 }, { "cost", -1 } } },
    { spell = "enhancement", name = "Enhancement", proficiency = "enhancement", flag = "ENHANCEMENT_SPELL",
        adjustments = { { "duration", 1 }, { "casting_time", -1 } }, apprentice_practice = false },
    { spell = "enervation", name = "Enervation", proficiency = "enervation", flag = "ENERVATION_SPELL",
        adjustments = { { "duration", 1 }, { "aoe", 1 } } },
    { spell = "conveyance", name = "Conveyance", proficiency = "conveyance", flag = "CONVEYANCE_SPELL",
        adjustments = { { "cost", -1 }, { "range", 1 } } },
    { spell = "restoration", name = "Restoration", proficiency = "restoration", flag = "RESTORATION_SPELL",
        adjustments = { { "damage", 1 }, { "casting_time", -1 } } },
    transformation,
}

local function progress(actor, proficiency)
    local required = proficiencies.definition(proficiency).time_to_learn.turns
    local practiced = is_character(actor) and checked(proficiencies.get(actor, proficiency)).practiced.turns or 0
    return practiced * 100.0 / required, practiced, required
end

local divisors = { 16, 32, 64 }

local function award_practice(actor, school)
    set(actor, "prof_lowest", 4)
    local level = 3
    for rank, proficiency in ipairs(school.ranks) do
        local percent, practiced, required = progress(actor, proficiency)
        if percent < 100 then
            level = rank - 1
            if rank ~= 2 or school.apprentice_practice ~= false then
                local roll = services.random.native_float(1, 4)
                local adjustment = cast_adjustment(number(actor, "last_spell_cast_difficulty"),
                    number(actor, "last_spell_cast_casting_time"))
                local total = math.modf(required * (percent + roll / divisors[rank] * adjustment) / 100)
                local learned = total - practiced
                if learned > 0 and is_character(actor) then
                    checked(proficiencies.practice(actor, proficiency, duration(learned, "second")))
                end
            end
            break
        end
    end
    set(actor, "prof_level", level)
    set(actor, "prof_lowest", math.min(level, number(actor, "prof_lowest")))
end

local function register_setup(school)
    local prefix = "prof_magic_" .. school.proficiency .. "_"
    school.ranks = { id("proficiency", prefix .. "beginner"), id("proficiency", prefix .. "apprentice"),
        id("proficiency", prefix .. "master") }
    local handler = "spell_practice_" .. school.spell
    ccb.runtime.handler(handler, function(impact)
        award_practice(impact.target_creature, school)
    end)

    ccb.content.add(ccb.content.Spell {
        id = "eoc_" .. school.spell .. "_setup",
        name = "Set Up Proficiency: " .. school.name,
        description = "Sets up proficiency gain.  This is a bug if you have it.",
        message = ccb.content.text("You cast %s!"),
        sound_description = ccb.content.text("an explosion."),
        valid_targets = { "self" },
        spell_class = "NONE",
        flags = { "NO_LEGS" },
        difficulty = 0,
        min_damage = 1,
        max_damage = 1,
        duration_increment = 1,
        shape = "blast",
        energy_source = "NONE",
        base_energy_cost = 0,
        final_energy_cost = 0,
        base_casting_time = 0,
        final_casting_time = 0,
    }:lua_impact(handler))
end

for _, school in ipairs(schools) do register_setup(school) end

local function proficiency_bonus(actor, school)
    local total = 0
    for _, proficiency in ipairs(school.ranks) do
        local percent = progress(actor, proficiency)
        total = total + percent / 1000
    end
    return total
end

ccb.runtime.handler("record_magiclysm_cast", function(event)
    local actor = event_character(event)
    local difficulty = event.data.difficulty
    local casting_time = event.data.cast_time
    set(actor, "last_spell_cast_difficulty", difficulty)
    set(actor, "last_spell_cast_casting_time", casting_time)
    if actor.subtype == "avatar" then
        local format = ccb.services.translate("Your last spell was Difficulty <u_val:last_spell_cast_difficulty> with casting time <u_val:last_spell_cast_casting_time>.  The adjustments value is <context_val:adjustments>.")
        services.messages.add(checked(services.text.expand_for(format, actor, nil, nil,
            { adjustments = cast_adjustment(difficulty, casting_time) })), "debug")
    end
end)
ccb.runtime.on("game:spellcasting_finish", "record_magiclysm_cast")

ccb.runtime.handler("apply_spell_proficiency_bonuses", function(event)
    local actor = event_character(event)
    if not is_character(actor) then return end
    for _, school in ipairs(schools) do
        local bonus = proficiency_bonus(actor, school)
        local filter = { flag_whitelist = school.flag }
        for _, adjustment in ipairs(school.adjustments) do
            checked(services.spells.adjust_casting(actor, adjustment[1], bonus * adjustment[2], filter))
        end
    end
end)
ccb.runtime.on("game:opens_spellbook", "apply_spell_proficiency_bonuses")

return {
    evocation_modifier = function(actor)
        return 1 + proficiency_bonus(actor, evocation)
    end,
    channeling_modifier = function(actor)
        return 1 + proficiency_bonus(actor, channeling)
    end,
    transformation_modifier = function(actor)
        return 1 + proficiency_bonus(actor, transformation)
    end,
}
