local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

ccb.runtime.handler("inject_warping_poison", function(hit)
    local target = hit.target
    if hit.total_damage <= 0 or not target or target.subtype == "monster" or not target:is_valid() then
        return
    end
    -- The original dialogue rule drew a string index before expanding the weighted snippet.
    services.random.native_int(0, 0)
    local category = services.text.expand_for("<random_category>", hit.attacker, target, nil, nil, true)
    if not category.ok then
        error(category.error.message)
    end
    local mutation = services.mutations.mutate_category(
        target, services.types.id("mutation_category", category.value), false, true)
    if not mutation.ok then
        error(mutation.error.message)
    end
end)

local bite = content.MonsterAttack { id = "inject_warping_poison", cooldown = 25 }
bite:melee {
    move_cost = 150,
    minimum_hit_size = 4,
    damage = { { type = "stab", amount = 15, armor_penetration = 8, armor_multiplier = 0.5 } },
    avatar_hit = ccb.content.text("%1$s bites and injects poison into your %2$s!"),
    npc_hit = ccb.content.text("%1$s bites and injects poison into <npcname>!"),
    avatar_miss = ccb.content.text("%1$s tries to bite your %2$s, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to bite <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s tries to bite your %2$s, but fails to penetrate your armor."),
    npc_no_damage = ccb.content.text("%1$s tries to bite <npcname>, but fails to penetrate their armor."),
}
bite:on_hit("inject_warping_poison")
content.add(bite)
