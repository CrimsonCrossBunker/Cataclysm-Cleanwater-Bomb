local ccb = require("ccb")
local services = ccb.services
local magiclysm = ccb.content.is_mod_active("magiclysm")
local chance = magiclysm and 1 / 4 or 1 / 3

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("artifact_mutation", function(impact)
    if services.random.native_float(0, 1) > chance then
        return
    end
    local target = impact.target_creature
    services.random.native_int(0, 0)
    local category = value(services.text.expand_for("<random_category>", target, impact.caster, nil, nil, true))
    if not magiclysm then
        local text = ccb.services.translate("Mutation category is <context_val:dart_mutation_category>.")
        services.messages.add(value(services.text.expand_for(
            text, target, impact.caster, nil, { dart_mutation_category = category }, true)), "debug")
    end
    if target and target.subtype ~= "monster" then
        value(services.mutations.mutate_category(
            target, services.types.id("mutation_category", category), false, true))
    end
end)

ccb.runtime.handler("artifact_calorie_cost", function(impact)
    local target = impact.target_creature
    if target and target.subtype ~= "monster" then
        value(services.needs.modify_calories(target, -100 - services.random.native_int(0, 150)))
    end
end)

ccb.content.add(ccb.content.Spell {
    id = "mom_aea_artifact_calorie_hit",
    name = "Artifact Calorie hit",
    description = "Spends calories, the way psionic powers do, when using the artifact.",
    message = "",
    shape = "blast",
    valid_targets = { "self" },
    flags = { "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
}:lua_impact("artifact_calorie_cost"))

local mutation = ccb.content.Spell {
    id = "MoM_AEA_MUTATE",
    name = ccb.content.text("Artifact Mutate"),
    description = ccb.content.text("Mutates you randomly."),
    message = "",
    shape = "blast",
    valid_targets = { "self" },
    flags = { "VERBAL", "SILENT", "NO_EXPLOSION_SFX" },
    skill = "metaphysics",
}
mutation:lua_impact("artifact_mutation")
mutation:extra_spell { id = "mom_aea_artifact_calorie_hit", self = true }
ccb.content.add(mutation)
