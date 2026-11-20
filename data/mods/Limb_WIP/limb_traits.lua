local ccb = require("ccb")
local services = ccb.services
local mutations = services.mutations

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function trait(name)
    return services.types.id("mutation", name)
end

local function limb(side, part, replacements)
    local prosthetics = {}
    for _, replacement in ipairs(replacements) do
        prosthetics[#prosthetics + 1] = trait(side .. "_" .. replacement)
    end
    local name = side .. "_" .. part
    return {
        missing = trait("NO_" .. name),
        present = trait("HAS_" .. name),
        marker = "traits_limbs_missing_" .. name:lower(),
        prosthetics = prosthetics,
    }
end

local arm_prosthetics = { "PROSTHETIC_ARM", "NEUROPROSTHETIC_ARM", "COSMETIC_PROSTHETIC_ARM" }
local leg_prosthetics = { "PROSTHETIC_LEG", "PEG_LEG" }
local arms = { limb("LEFT", "ARM", arm_prosthetics), limb("RIGHT", "ARM", arm_prosthetics) }
local legs = { limb("LEFT", "LEG", leg_prosthetics), limb("RIGHT", "LEG", leg_prosthetics) }

local function has_any(character, traits)
    for _, mutation in ipairs(traits) do
        if checked(mutations.has(character, mutation)) then return true end
    end
    return false
end

local function initialize(event, limbs)
    local character = event.actors.speaker or services.characters.avatar()
    for _, part in ipairs(limbs) do
        if not checked(mutations.has(character, part.missing)) and not has_any(character, part.prosthetics) then
            checked(mutations.replace(character, part.present))
        end
    end
end

ccb.runtime.handler("initialize_arm_traits", function(event) initialize(event, arms) end)
ccb.runtime.on("game:game_begin", "initialize_arm_traits")
ccb.runtime.handler("initialize_leg_traits", function(event) initialize(event, legs) end)
ccb.runtime.on("game:game_start", "initialize_leg_traits")

local arm_mutations = {
    trait("INSECT_ARMS"), trait("INSECT_ARMS_OK"), trait("ARACHNID_ARMS"), trait("ARACHNID_ARMS_OK"),
    trait("AMORPHOUS"), trait("ARM_TENTACLES"), trait("ARM_TENTACLES_4"), trait("ARM_TENTACLES_8"),
}
local leg_mutations = {
    trait("CRAB_LEGS"), trait("GASTROPOD_FOOT"), trait("AMORPHOUS"), trait("ROOTS1"), trait("LEG_TENTACLES"),
}

local function restore(character, limbs, triggers)
    if not has_any(character, triggers) then return end
    for _, part in ipairs(limbs) do checked(mutations.erase(character, part.missing)) end
    for _, part in ipairs(limbs) do checked(mutations.replace(character, part.present)) end
    for _, part in ipairs(limbs) do
        checked(services.variables.remove(character, part.marker, { include_before = false }))
    end
end

ccb.runtime.handler("restore_mutated_limbs", function(event)
    local character = event.actors.speaker or event.actors.character or services.characters.avatar()
    restore(character, arms, arm_mutations)
    restore(character, legs, leg_mutations)
end)
ccb.runtime.on("game:gains_mutation", "restore_mutated_limbs")
ccb.runtime.on("game:evolves_mutation", "restore_mutated_limbs")
