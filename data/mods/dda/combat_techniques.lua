local ccb = require("ccb")

local profiles = {
    {
        id = "boxing_double_jab", name = ccb.content.text("Double Jab"),
        description = ccb.content.text("A light lead-hand combination trades overall impact for speed and accuracy. The combination resolves as a single attack."),
        styles = { "style_boxing", "style_kickboxing" }, vector = "vector_punch",
        damage = "bash", scale = 0.65, speed = 0.85, accuracy = 1, level = 2,
    },
    {
        id = "boxing_cross", name = ccb.content.text("Rear-Hand Cross"),
        description = ccb.content.text("Commit the rear shoulder and hip to a straight punch, with a longer recovery."),
        styles = { "style_boxing", "style_kickboxing", "style_pankration" }, vector = "vector_punch",
        damage = "bash", scale = 1.3, speed = 1.2, accuracy = 0, level = 2,
    },
    {
        id = "boxing_body_hook", name = ccb.content.text("Short Body Hook"),
        description = ccb.content.text("A compact hook favors human-shaped opponents within arm's reach."),
        styles = { "style_boxing", "style_kickboxing" }, vector = "vector_punch",
        damage = "bash", scale = 1.2, speed = 1.05, accuracy = 1, level = 3, policy = "human",
    },
    {
        id = "karate_reverse_punch", name = ccb.content.text("Reverse Punch"),
        description = ccb.content.text("A planted reverse punch concentrates impact at the cost of recovery time."),
        styles = { "style_karate" }, vector = "vector_punch",
        damage = "bash", scale = 1.35, speed = 1.25, accuracy = 1, level = 3,
    },
    {
        id = "karate_palm_heel", name = ccb.content.text("Palm-Heel Strike"),
        description = ccb.content.text("A controlled open-hand strike sacrifices some force for reliable contact."),
        styles = { "style_karate", "style_krav_maga", "style_tai_chi", "style_brawling" }, vector = "vector_palm",
        damage = "bash", scale = 0.9, speed = 0.85, accuracy = 2, level = 1,
    },
    {
        id = "muay_short_elbow", name = ccb.content.text("Short Elbow"),
        description = ccb.content.text("A compact elbow delivers a quick close-range impact without a long windup."),
        styles = { "style_muay_thai", "style_krav_maga", "style_silat" }, vector = "vector_elbow",
        damage = "bash", scale = 1.15, speed = 0.9, accuracy = 0, level = 2,
    },
    {
        id = "muay_clinch_knee", name = ccb.content.text("Clinch Knee"),
        description = ccb.content.text("Drive a knee into a human-shaped opponent while maintaining your own established grip."),
        styles = { "style_muay_thai", "style_pankration", "style_krav_maga" }, vector = "vector_knee",
        damage = "bash", scale = 1.5, speed = 1.15, accuracy = 2, level = 3, policy = "grip",
    },
    {
        id = "muay_push_kick", name = ccb.content.text("Push Kick"),
        description = ccb.content.text("Extend the sole to make space against an upright opponent no larger than yourself."),
        styles = { "style_muay_thai", "style_kickboxing", "style_kicks" }, vector = "vector_foot_sole",
        damage = "bash", scale = 0.85, speed = 1.15, accuracy = 1, level = 2, policy = "push", knockback = 1,
    },
    {
        id = "taekwondo_side_kick", name = ccb.content.text("Driving Side Kick"),
        description = ccb.content.text("Turn the hip and drive the heel through a powerful but slower side kick."),
        styles = { "style_taekwondo", "style_karate", "style_kicks" }, vector = "vector_foot_heel",
        damage = "bash", scale = 1.5, speed = 1.45, accuracy = -1, level = 3,
    },
    {
        id = "capoeira_turning_kick", name = ccb.content.text("Turning Heel Kick"),
        description = ccb.content.text("A committed turning kick trades accuracy and recovery for impact. Requires an upright stance."),
        styles = { "style_capoeira", "style_taekwondo" }, vector = "vector_foot_heel",
        damage = "bash", scale = 1.7, speed = 1.6, accuracy = -2, level = 4,
    },
    {
        id = "wingchun_chain", name = ccb.content.text("Straight-Punch Chain"),
        description = ccb.content.text("A compact straight-punch combination trades overall power for speed and accuracy. The combination resolves as a single attack."),
        styles = { "style_wingchun" }, vector = "vector_punch",
        damage = "bash", scale = 0.5, speed = 0.8, accuracy = 1, level = 3,
    },
    {
        id = "brawling_hammerfist", name = ccb.content.text("Descending Hammerfist"),
        description = ccb.content.text("A simple descending fist is forceful but easier to anticipate."),
        styles = { "style_brawling", "style_krav_maga", "style_pankration" }, vector = "vector_punch",
        damage = "bash", scale = 1.25, speed = 1.2, accuracy = -1, level = 1,
    },
    {
        id = "aikido_wrist_turn", name = ccb.content.text("Wrist-Turn Disarm"),
        description = ccb.content.text("Turn a human-shaped opponent's weapon hand. Requires your own grip and an armed opponent; not a general-purpose monster lock."),
        styles = { "style_aikido", "style_judo", "style_krav_maga" }, vector = "vector_palm",
        damage = "bash", scale = 0.5, speed = 1.4, accuracy = 1, level = 4, policy = "disarm", disarms = true,
    },
    {
        id = "tiger_raking_blow", name = ccb.content.text("Raking Palm Blow"),
        description = ccb.content.text("A heavy raking open-hand blow favors impact rather than speed."),
        styles = { "style_tiger", "style_dragon" }, vector = "vector_palm",
        damage = "bash", scale = 1.25, speed = 1.15, accuracy = 0, level = 3,
    },
    {
        id = "snake_precise_palm", name = ccb.content.text("Precise Palm Thrust"),
        description = ccb.content.text("A light, precisely placed palm thrust minimizes recovery."),
        styles = { "style_snake", "style_crane", "style_leopard" }, vector = "vector_palm",
        damage = "bash", scale = 0.8, speed = 0.8, accuracy = 2, level = 3,
    },
    {
        id = "boxing_opening_cross", name = ccb.content.text("Opening Cross"),
        description = ccb.content.text("Automatically capitalize on a critical opening with a committed rear-hand punch. Cannot be selected manually."),
        styles = { "style_boxing", "style_kickboxing" }, vector = "vector_punch",
        damage = "bash", scale = 1.45, speed = 1.1, accuracy = 1, level = 4, critical = true,
    },
    {
        id = "staff_long_thrust", name = ccb.content.text("Staff Thrust"),
        description = ccb.content.text("Drive a staff end forward in an accurate, restrained thrust, including at weapon reach."),
        styles = { "style_bojutsu", "style_brawling" }, categories = { "QUARTERSTAVES" },
        damage = "bash", scale = 0.9, speed = 0.85, accuracy = 2, level = 2, reach = true,
    },
    {
        id = "staff_butt_strike", name = ccb.content.text("Staff Butt Strike"),
        description = ccb.content.text("Use the near end of a staff for a short, quick blow instead of a full swing."),
        styles = { "style_bojutsu", "style_brawling" }, categories = { "QUARTERSTAVES" },
        damage = "bash", scale = 0.75, speed = 0.65, accuracy = 1, level = 2,
    },
    {
        id = "spear_set_thrust", name = ccb.content.text("Set Spear Thrust"),
        description = ccb.content.text("Commit to a straight spear thrust with deliberate recovery, including at weapon reach."),
        styles = { "style_sojutsu", "style_medievalpole", "style_brawling" }, categories = { "SPEARS", "POLEARMS" },
        damage = "stab", scale = 1.3, speed = 1.25, accuracy = 1, level = 2, reach = true,
    },
    {
        id = "sword_draw_cut", name = ccb.content.text("Drawing Cut"),
        description = ccb.content.text("Keep the edge engaged through a controlled drawing cut; slower than a light slash."),
        styles = { "style_swordsmanship", "style_niten", "style_ninjutsu", "style_brawling" },
        categories = { "MEDIUM_SWORDS", "LONG_SWORDS", "SHORT_SWORDS", "GREAT_SWORDS" },
        damage = "cut", scale = 1.25, speed = 1.2, accuracy = 0, level = 3,
    },
    {
        id = "sword_measured_thrust", name = ccb.content.text("Measured Sword Thrust"),
        description = ccb.content.text("An accurate point-first attack sacrifices broad cutting impact for placement."),
        styles = { "style_fencing", "style_swordsmanship", "style_brawling" },
        categories = { "FENCING_WEAPONRY", "LONG_THRUSTING_SWORDS", "LONG_SWORDS" },
        damage = "stab", scale = 1.15, secondary = "cut", secondary_scale = 0.6,
        speed = 1.05, accuracy = 2, level = 2,
    },
    {
        id = "knife_short_thrust", name = ccb.content.text("Short Knife Thrust"),
        description = ccb.content.text("A compact thrust retains speed and placement at the expense of impact."),
        styles = { "style_eskrima", "style_silat", "style_krav_maga", "style_ninjutsu", "style_brawling" },
        categories = { "KNIVES", "SHIVS" }, damage = "stab", scale = 0.85, speed = 0.7, accuracy = 1, level = 2,
    },
    {
        id = "baton_diagonal", name = ccb.content.text("Diagonal Baton Strike"),
        description = ccb.content.text("A compact diagonal baton blow balances speed and impact."),
        styles = { "style_eskrima", "style_brawling" }, categories = { "BATONS" },
        damage = "bash", scale = 1.1, speed = 0.9, accuracy = 1, level = 1,
    },
    {
        id = "mace_committed_blow", name = ccb.content.text("Committed Mace Blow"),
        description = ccb.content.text("Commit the weight of a mace or hammer to a hard blow with a long recovery."),
        styles = { "style_barbaran", "style_brawling" }, categories = { "MACES", "GREAT_HAMMERS" },
        damage = "bash", scale = 1.5, speed = 1.6, accuracy = -1, level = 3,
    },
    {
        id = "axe_hewing_cut", name = ccb.content.text("Hewing Cut"),
        description = ccb.content.text("A committed axe cut increases edge impact but leaves a slower recovery."),
        styles = { "style_barbaran", "style_brawling" }, categories = { "HAND_AXES", "GREAT_AXES" },
        damage = "cut", scale = 1.4, speed = 1.5, accuracy = -1, level = 3,
    },
    {
        id = "polearm_hook", name = ccb.content.text("Low Polearm Hook"),
        description = ccb.content.text("Hook an upright human-shaped opponent's footing. Requires a hooking weapon and a target no larger than yourself."),
        styles = { "style_medievalpole", "style_brawling" }, categories = { "HOOKING_WEAPONRY" },
        damage = "bash", scale = 0.6, speed = 1.4, accuracy = -1, level = 4, policy = "trip", down = 1,
    },
}

local function available(profile, context)
    if not context.can_attack or context.mounted or context.prone or context.in_shell then return false end
    if context.stamina < (profile.scale >= 1.4 and 350 or 150) then return false end
    if context.crouching and (profile.vector == "vector_foot_heel" or profile.vector == "vector_foot_sole") then
        return false
    end
    local target = context.target
    if not target then return true end
    if not target.alive then return false end
    if profile.policy == "human" then return target.bodytype == "human" end
    if profile.policy == "grip" or profile.policy == "disarm" then
        return target.bodytype == "human" and target.own_grip and target.adjacent and
            (profile.policy ~= "disarm" or target.armed)
    end
    if profile.policy == "push" or profile.policy == "trip" then
        return not target.flying and not target.downed and target.size_difference <= 0 and
            (profile.policy ~= "trip" or target.bodytype == "human")
    end
    return true
end

for _, profile in ipairs(profiles) do
    local id = "tec_lua_" .. profile.id
    local handler = id .. "_available"
    ccb.runtime.handler(handler, function(context) return available(profile, context) end, 1)
    local armed = profile.categories ~= nil
    local technique = ccb.content.Technique {
        id = id, name = profile.name, description = profile.description,
        avatar_message = ccb.content.text("You strike %s"),
        npc_message = ccb.content.text("<npcname> strikes %s"),
        manual_activation = not profile.critical, crit_tec = profile.critical or false,
        cooldown_turns = profile.critical and 0 or 3,
        unarmed_allowed = not armed, strictly_unarmed = not armed, melee_allowed = armed,
        disarms = profile.disarms or false, knockback_dist = profile.knockback or 0,
        down_dur = profile.down or 0, reach_ok = profile.reach or false,
        active_when = handler,
    }
    technique:attack_vector(profile.vector or "vector_null")
        :requires_skill(armed and "melee" or "unarmed", profile.level)
        :damage_multiplier(profile.damage, profile.scale)
        :move_cost_multiplier(profile.speed):accuracy_bonus(profile.accuracy)
    if profile.secondary then technique:damage_multiplier(profile.secondary, profile.secondary_scale) end
    for _, style in ipairs(profile.styles) do technique:style(style) end
    for _, category in ipairs(profile.categories or {}) do technique:weapon_category(category) end
    ccb.content.add(technique)
end

