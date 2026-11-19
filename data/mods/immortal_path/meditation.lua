local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local realm_spell_id = "realm_qi_refining"
local realm_spell = id("spell", realm_spell_id)
local qi_vit = id("vitamin", "qi")
local qi_fatigue_vit = id("vitamin", "qi_fatigue")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function exp_for_level(level)
    return 86 * level * (level + 1)
end

local function fatigue_mult(fatigue)
    return math.max(0, 1 - fatigue / 80)
end

local function qi_max(character)
    return checked(services.characters.enchantment_value(character, "qi_max", 100))
end

local function polarization(character, phase)
    return checked(services.characters.enchantment_value(character, "polarization_" .. phase, 1))
end

local function set_var(character, key, value)
    checked(services.variables.set(character, key, value, { include_before = false }))
end

local function emit_msg(character, raw, severity)
    local expanded = checked(services.text.expand_for(services.translate(raw), character))
    services.messages.add(expanded, severity)
end

local function settle_meditation(character, raw_hinder)
    if not character or not character:is_valid() or character.subtype == "monster" then return end

    local layer_before = math.max(0, checked(services.spells.effective_level(character, realm_spell_id)))
    local fatigue_before = checked(services.needs.get_vitamin(character, qi_fatigue_vit))
    local hinder = (raw_hinder > 0) and math.min(raw_hinder, 4) or 1
    local exp_gain = math.floor(33 * fatigue_mult(fatigue_before) / hinder + 0.5)

    local snap = services.spells.get(character, realm_spell)
    if not snap.ok then
        if snap.error.code ~= "not_known" then error(snap.error.message) end
        checked(services.spells.set_level(character, realm_spell, 0))
        checked(services.spells.set_experience(character, realm_spell, exp_gain))
    else
        local cur_exp = math.max(0, snap.value.experience or 0)
        checked(services.spells.set_experience(character, realm_spell, cur_exp + exp_gain))
    end

    checked(services.needs.set_vitamin(character, qi_fatigue_vit, math.modf(fatigue_before + 22)))

    local layer_after = math.max(0, checked(services.spells.effective_level(character, realm_spell_id)))
    local exp_after = math.max(0, checked(services.spells.get(character, realm_spell)).experience or 0)
    local exp_into_layer = exp_after - exp_for_level(layer_after)
    local layer_need = exp_for_level(layer_after + 1) - exp_for_level(layer_after)

    local cap = qi_max(character)
    local cur_qi = checked(services.needs.get_vitamin(character, qi_vit))
    local full_before = (cur_qi >= cap) and 1 or 0
    checked(services.needs.set_vitamin(character, qi_vit, math.modf(math.min(cur_qi + 60, cap))))

    set_var(character, "qi_layer_before", layer_before)
    set_var(character, "qi_fatigue_before", fatigue_before)
    set_var(character, "qi_pol_hinder", hinder)
    set_var(character, "qi_exp_gain", exp_gain)
    set_var(character, "qi_refining_layer", layer_after)
    set_var(character, "qi_exp_into_layer", exp_into_layer)
    set_var(character, "qi_layer_need", layer_need)
    set_var(character, "qi_full_before", full_before)

    if character.subtype ~= "avatar" then return end

    if fatigue_before >= 60 then
        emit_msg(character,
            "心神已疲，强行吐纳事倍功半（修为 +<u_val:qi_exp_gain>，炼气 <u_val:qi_refining_layer> 层 <u_val:qi_exp_into_layer>/<u_val:qi_layer_need>）。",
            "bad")
    elseif layer_before >= 10 then
        emit_msg(character,
            "炼气将满，每层所需修为剧增，纯吐纳精进缓慢（修为 +<u_val:qi_exp_gain>，炼气 <u_val:qi_refining_layer> 层 <u_val:qi_exp_into_layer>/<u_val:qi_layer_need>）。",
            "mixed")
    else
        emit_msg(character,
            "你吐纳一周天（修为 +<u_val:qi_exp_gain>，炼气 <u_val:qi_refining_layer> 层 <u_val:qi_exp_into_layer>/<u_val:qi_layer_need>），灵气温养经脉。",
            "good")
    end

    if full_before > 0 then
        emit_msg(character, "丹田灵气已满，盈则溢，吐纳暂无益于蓄气。", "neutral")
    end
    if hinder > 1.01 then
        emit_msg(character, "相克之力扰乱真气运转，本系修为难以凝练，进境大减。", "bad")
    end
    if layer_after > layer_before then
        emit_msg(character, "修为精进！炼气已至 <u_val:qi_refining_layer> 层。", "good")
    end
end

local phase_handlers = {
    {
        name = "immortal_path_meditate_neutral",
        hinder = function() return 1 end,
    },
    {
        name = "immortal_path_meditate_evergreen",
        hinder = function(c) return polarization(c, "metal") * polarization(c, "earth") end,
    },
    {
        name = "immortal_path_meditate_blazing_sun",
        hinder = function(c) return polarization(c, "water") * polarization(c, "metal") end,
    },
    {
        name = "immortal_path_meditate_deep_earth",
        hinder = function(c) return polarization(c, "wood") * polarization(c, "water") end,
    },
    {
        name = "immortal_path_meditate_true_metal",
        hinder = function(c) return polarization(c, "fire") * polarization(c, "wood") end,
    },
    {
        name = "immortal_path_meditate_cold_pool",
        hinder = function(c) return polarization(c, "earth") * polarization(c, "fire") end,
    },
}

for _, phase in ipairs(phase_handlers) do
    ccb.runtime.handler(phase.name, function(impact)
        local caster = impact.caster
        if not caster or not caster:is_valid() or caster.subtype == "monster" then return end
        settle_meditation(caster, phase.hinder(caster))
    end)
end

local meditation_spells = {
    {
        id = "immortal_path_meditate",
        name = "吐纳打坐",
        description = "盘膝静坐，吐纳天地灵气，温养经脉。耗费时间，补充灵气，并累积炼气境修为。",
        handler = "immortal_path_meditate_neutral",
    },
    {
        id = "immortal_path_meditate_evergreen",
        name = "养荣导引",
        description = "葳蕤经的吐纳法门。引木行生气入体，经脉如春木抽枝，温养之余更添生机。打坐推进炼气修为，兼能滋养气血。",
        handler = "immortal_path_meditate_evergreen",
    },
    {
        id = "immortal_path_meditate_blazing_sun",
        name = "炼焰息",
        description = "炎阳真传的吐纳法门。纳火行炎气入丹田，烈烈如日，灼炼经脉。修炼之余，体魄渐染炎上之力。",
        handler = "immortal_path_meditate_blazing_sun",
    },
    {
        id = "immortal_path_meditate_deep_earth",
        name = "镇岳吐纳",
        description = "磐石篇的吐纳法门。沉气入地，纳土行厚重之元，稳如山岳。修炼使体魄坚凝，不易撼动。",
        handler = "immortal_path_meditate_deep_earth",
    },
    {
        id = "immortal_path_meditate_true_metal",
        name = "淬锋诀",
        description = "素锋录的吐纳法门。引金行锐气入体，淬炼筋骨如百炼精钢。修炼之余，出手愈发锋锐。",
        handler = "immortal_path_meditate_true_metal",
    },
    {
        id = "immortal_path_meditate_cold_pool",
        name = "纳川息",
        description = "玄渊心法的吐纳法门。心静如止水，纳水行至阴之气，丹田如渊纳百川。修炼使灵气蓄养更深更广。",
        handler = "immortal_path_meditate_cold_pool",
    },
    {
        id = "immortal_path_meditate_blood_fiend",
        name = "摄血息",
        description = "血煞炼尸功的吐纳法门。摄死气血煞入体，炼尸为养，催修为暴进——然反噬经脉、有损根本。此乃邪道捷径，慎之。",
        handler = "immortal_path_meditate_neutral",
    },
}

for _, def in ipairs(meditation_spells) do
    ccb.content.add(ccb.content.Spell {
        id = def.id,
        name = ccb.content.text(def.name),
        description = ccb.content.text(def.description),
        valid_targets = { "self" },
        shape = "blast",
        energy_source = "NONE",
        spell_class = "NONE",
        flags = { "NO_FAIL", "SILENT", "CONCENTRATE" },
        base_casting_time = 96000,
        base_energy_cost = 0,
        difficulty = 0,
        max_level = 0,
        min_damage = 0,
        max_damage = 0,
        min_range = 0,
        max_range = 0,
    }:lua_impact(def.handler))
end
