local ccb = require("ccb")

local profiles = {
    {
        id = "tec_rapid_window_break", name = ccb.content.text("Rapid Window Break"),
        description = ccb.content.text("Drive a controlled heel kick through ordinary window glass. Reinforced glass may resist. Requires a clear adjacent window; never targets its occupants."),
        kind = "window", vector = "vector_foot_heel", skill = "unarmed", level = 1,
        cooldown = 3, styles = { "style_brawling", "style_kicks", "style_karate", "style_taekwondo", "style_krav_maga" },
    },
    {
        id = "tec_weapon_breach", name = ccb.content.text("Committed Breaching Blow"),
        description = ccb.content.text("Use a substantial blunt weapon to strike adjacent bashable terrain or furniture. Normal material resistance still applies; vehicles and occupied tiles are excluded."),
        kind = "breach", vector = "vector_null", skill = "bashing", level = 2,
        cooldown = 5, styles = { "style_brawling", "style_barbaran", "style_medievalpole", "style_bojutsu" },
        categories = { "MACES", "GREAT_HAMMERS", "GREAT_AXES", "HAND_AXES", "QUARTERSTAVES", "BATONS", "POLEARMS" },
    },
    {
        id = "tec_shadow_combination", name = ccb.content.text("Shadow Combination"),
        description = ccb.content.text("Rehearse a short combination into clear adjacent space. Uses time and stamina without damaging terrain or granting combat experience."),
        kind = "shadow", vector = "vector_punch", skill = "unarmed", level = 0,
        cooldown = 2, styles = { "style_brawling", "style_boxing", "style_karate", "style_kickboxing", "style_muay_thai", "style_wingchun" },
    },
}

for _, profile in ipairs(profiles) do
    local handler = profile.id .. "_plan"
    local condition = profile.id .. "_available"
    ccb.runtime.handler(condition, function(context)
        return context.can_attack and not context.mounted and not context.prone and not context.in_shell and
            (profile.kind ~= "window" or not context.crouching)
    end, 1)
    ccb.runtime.handler(handler, function(context)
        local power, moves, stamina = 0, 85, 70
        if profile.kind == "window" then
            if not context.window or not context.bashable then return { allowed = false } end
            power = math.floor(context.strength * 1.8 + context.unarmed_skill * 2)
            moves, stamina = math.max(50, 85 - math.floor(context.unarmed_skill * 3)), 110
        elseif profile.kind == "breach" then
            if not context.armed or context.weapon_bash < 8 or not context.bashable then
                return { allowed = false }
            end
            power = math.floor(context.strength + context.weapon_bash * 1.2 + context.melee_skill)
            moves, stamina = 150, 220
        elseif not context.passable then
            return { allowed = false }
        end
        return { allowed = true, stamina_cost = stamina, move_cost = moves, bash_power = power }
    end, 1)
    local technique = ccb.content.Technique {
        id = profile.id, name = profile.name, description = profile.description,
        manual_activation = true, cooldown_turns = profile.cooldown,
        unarmed_allowed = profile.kind ~= "breach", melee_allowed = profile.kind ~= "shadow",
        strictly_unarmed = profile.kind == "shadow", position_plan = handler, active_when = condition,
    }
    technique:attack_vector(profile.vector):requires_skill(profile.skill, profile.level)
    for _, style in ipairs(profile.styles) do technique:style(style) end
    for _, category in ipairs(profile.categories or {}) do technique:weapon_category(category) end
    ccb.content.add(technique)
end
