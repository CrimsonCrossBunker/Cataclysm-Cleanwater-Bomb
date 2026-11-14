local ccb = require("ccb")

local profiles = {
    {
        id = "tec_grapple_hold", name = ccb.content.text("Grappling Grip"), action = "hold",
        style = "style_brawling",
        skill = 2, power = 100, stamina = 180, cooldown = 3,
        description = ccb.content.text("Establish two-handed control of an adjacent opponent without striking.  Strength and Unarmed Combat determine the maximum weight you can control; heavier and larger opponents shorten the hold and increase its action and stamina costs.  A target more than one size category larger cannot be held.  Only one opponent can be held at a time.  The opponent is restrained briefly, not made harmless."),
    },
    {
        id = "tec_grapple_drag", name = ccb.content.text("Grapple and Drag"), action = "drag",
        style = "style_brawling",
        skill = 2, power = 120, stamina = 120, cooldown = 1,
        description = ccb.content.text("Keep your own established grip and step one tile directly away from the opponent, pulling them into your previous position.  This does not refresh the hold.  Your retreat must be clear and supported; you cannot pull a ridden, harnessed or tied creature.  Heavier opponents cost more time and stamina."),
    },
    {
        id = "tec_brawl_grapple_throw", name = ccb.content.text("Body-Lock Trip"), action = "throw",
        style = "style_brawling",
        skill = 2, power = 90, stamina = 300, cooldown = 6, impact = 0.8,
        description = ccb.content.text("From your own two-handed grip, crowd the opponent's balance and trip them into the clear tile behind you.  This rough brawling finish needs more effort and offers less leverage than a trained hip throw.  Heavy opponents are harder to move.  Releases your grip."),
    },
    {
        id = "tec_judo_hip_throw", name = ccb.content.text("O-goshi Hip Throw"), action = "throw",
        skill = 3, power = 125, stamina = 280, cooldown = 5,
        description = ccb.content.text("From your own grip, break the opponent's balance and load them across your hip, throwing them into the clear tile behind you.  Judo's leverage handles more weight than a simple arm projection.  Heavy or larger opponents suffer less impact and spend less time down.  Releases your grip."),
    },
    {
        id = "tec_aikido_projection", name = ccb.content.text("Aikido Projection"), action = "throw",
        skill = 3, power = 100, stamina = 180, cooldown = 4, impact = 0.25,
        description = ccb.content.text("Guide an opponent you already control off balance and down into the clear tile behind you.  Aikido emphasizes redirection and disengagement rather than injury: this projection inflicts little impact damage.  Weight and size still limit leverage; it cannot topple arbitrarily heavy monsters.  Releases your grip."),
    },
    {
        id = "tec_pankration_slam", name = ccb.content.text("Pankration Body Slam"), action = "throw",
        skill = 4, power = 115, stamina = 350, cooldown = 6, impact = 1.5,
        description = ccb.content.text("Use your established wrestling grip to lift and slam the opponent into the clear tile behind you.  This forceful finish does more impact damage but costs more stamina and takes longer to recover than a defensive projection.  Weight and size reduce its effectiveness.  Releases your grip."),
    },
    {
        id = "tec_taichi_unbalance", name = ccb.content.text("Push-Hands Unbalancing"), action = "throw",
        skill = 3, power = 95, stamina = 160, cooldown = 4, impact = 0.4,
        description = ccb.content.text("Maintain contact with an opponent in your own grip, redirect their center of balance and guide them down behind you.  This controlled push-hands finish favors balance disruption over impact damage.  It is less effective against heavy opponents and requires clear space behind you.  Releases your grip."),
    },
    {
        id = "tec_krav_grapple_takedown", name = ccb.content.text("Controlled Takedown"), action = "throw",
        skill = 3, power = 110, stamina = 240, cooldown = 5,
        description = ccb.content.text("Finish your established clinch with a direct takedown into the clear tile behind you, creating an opportunity to escape.  This practical self-defense finish balances impact, stamina use and recovery.  Larger and heavier opponents are harder to put down.  Releases your grip."),
    },
}

local function plan(profile, context)
    local capacity = math.max(1, (context.strength * 10 + context.unarmed_skill * 5) * context.power / 100)
    local load = context.target_weight_kg / capacity
    if context.size_difference > 1 or load > 1 then
        return { allowed = false }
    end
    local size_penalty = math.max(0, context.size_difference)
    local duration
    if profile.action == "hold" then
        duration = math.max(2, math.floor(6 - 3 * load) - size_penalty)
    else
        duration = math.max(1, math.floor(4 - 2 * load) - size_penalty)
    end
    local damage = 0
    if profile.action == "throw" then
        damage = math.max(1, (context.strength + context.unarmed_skill) * context.power / 100
            * (1 - load * 0.5) * (profile.impact or 1) / (1 + 0.5 * size_penalty))
    end
    return {
        allowed = true,
        stamina_cost = context.base_stamina + math.floor(context.base_stamina * load),
        move_cost = math.floor(100 + 100 * load + size_penalty * 25),
        duration_turns = duration,
        damage = damage,
    }
end

local function available(profile, context)
    if context.phase == "menu" then
        return true
    end
    if not context.can_attack or context.mounted or context.weapon_id ~= "" then
        return false
    end
    if profile.action == "drag" and not context.can_move then
        return false
    end
    if context.phase ~= "target" then
        return true
    end
    local target = context.target
    if not target or not target.alive or not target.adjacent then
        return false
    end
    if profile.action == "hold" then
        return not target.gripped or target.own_grip
    end
    return target.own_grip
end

for _, profile in ipairs(profiles) do
    local handler = profile.id .. "_plan"
    local condition = profile.id .. "_available"
    ccb.runtime.handler(handler, function(context)
        return plan(profile, context)
    end, 1)
    ccb.runtime.handler(condition, function(context)
        return available(profile, context)
    end, 1)
    local technique = ccb.content.Technique {
        id = profile.id,
        name = profile.name,
        description = profile.description,
        manual_activation = true,
        unarmed_allowed = true,
        strictly_unarmed = true,
        grapple_action = profile.action,
        grapple_power = profile.power,
        grapple_stamina = profile.stamina,
        grapple_cooldown_turns = profile.cooldown,
        grapple_plan = handler,
        active_when = condition,
    }
    technique:attack_vector("vector_punch")
    technique:requires_skill("unarmed", profile.skill)
    if profile.style then
        technique:style(profile.style)
    end
    ccb.content.add(technique)
end
