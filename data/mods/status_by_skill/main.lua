local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

-- Keep the effect id used by existing character saves.
local bonus = content.Enchantment { id = "INLINE_ENCH_skill_status_buff_0" }

ccb.runtime.handler("speed_by_dex", function(ctx)
    return (ctx.stats.dexterity - 8) * 2
end)
bonus:value("SPEED", { add_handler = "speed_by_dex", load_skills = {} })

local function add_skill_growth(stat, weights)
    local skill_ids = {}
    for index, weight in ipairs(weights) do
        skill_ids[index] = weight[1]
    end
    local handler = "skill_growth_" .. stat
    ccb.runtime.handler(handler, function(ctx)
        local total = 0
        for _, weight in ipairs(weights) do
            local skill_id, multiplier = weight[1], weight[2]
            total = total + ctx.skills[skill_id] ^ 2 * multiplier
        end
        return math.sqrt(total / 20)
    end)
    bonus:value(stat, { add_handler = handler, load_skills = skill_ids })
end

add_skill_growth("STRENGTH", {
    { "throw", 5 }, { "melee", 5 }, { "bashing", 10 }, { "cutting", 5 },
})
add_skill_growth("DEXTERITY", {
    { "throw", 5 }, { "dodge", 10 }, { "melee", 5 }, { "stabbing", 10 }, { "cutting", 5 },
})
add_skill_growth("INTELLIGENCE", {
    { "computer", 10 }, { "electronics", 10 }, { "chemistry", 10 },
    { "firstaid", 5 }, { "traps", 5 }, { "fabrication", 5 },
})
add_skill_growth("PERCEPTION", {
    { "survival", 10 }, { "archery", 10 }, { "traps", 5 }, { "throw", 5 }, { "gun", 5 },
})

ccb.runtime.handler("focus_by_int", function(ctx)
    return (ctx.stats.intelligence - 8) * 0.1
end)
bonus:value("FOCUS_REGEN", { multiply_handler = "focus_by_int", load_skills = {} })
content.add(bonus)

local effect = content.EffectType { id = "skill_status_buff" }
effect:enchantment(bonus.id)
content.add(effect)

local function apply_skill_bonus()
    local result = services.effects.add(services.characters.avatar(),
        services.types.id("effect", "skill_status_buff"),
        services.time.duration(1, "turn"), { permanent = true })
    if not result.ok then
        error(result.error.message)
    end
end

ccb.runtime.handler("apply_skill_bonus", apply_skill_bonus, 1)
ccb.runtime.on("game:game_start", "apply_skill_bonus")
ccb.runtime.on("game:game_begin", "apply_skill_bonus")
