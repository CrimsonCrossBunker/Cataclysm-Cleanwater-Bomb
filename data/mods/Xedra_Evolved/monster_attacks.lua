local ccb = require("ccb")
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
