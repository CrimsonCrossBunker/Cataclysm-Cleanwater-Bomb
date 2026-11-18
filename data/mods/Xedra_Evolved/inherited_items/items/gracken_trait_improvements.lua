local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local mutations = services.mutations
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(use, character, text)
    if character.subtype == "avatar" then
        use:message(use:expand_text(text), "neutral")
    end
end

local function consumed(use)
    if not use.character then
        return 1
    end
    if use.item:is_valid() and checked(services.inventory.contains(use.character, use.item)) then
        return 1
    end
    return 0
end

local function graft_limb(mutation_type, mutation_id)
    local mutation = id("mutation", mutation_id)
    local gracken = id("mutation", "GRACKEN")
    return function(use)
        local character = use.character
        if character then
            if not checked(mutations.has(character, mutation)) and checked(mutations.has(character, gracken)) then
                checked(mutations.remove_type(character, mutation_type))
                checked(mutations.replace(character, mutation))
                message(use, character, ccb.services.translate("You exchanged your previous organ successfully."))
            else
                message(use, character, ccb.services.translate("You destroyed the organ trying to merge it into your body."))
            end
        end
        return consumed(use)
    end
end

local function graft_stomach(mutation_id, already_has_diet)
    local mutation = id("mutation", mutation_id)
    local radiotrophic = id("mutation", "RADIOTROPHIC")
    return function(use)
        local character = use.character
        if character then
            if checked(mutations.has(character, mutation)) then
                message(use, character, already_has_diet())
            else
                message(use, character, ccb.services.translate("You exchanged your previous stomach for this."))
                checked(mutations.replace(character, mutation))
                checked(mutations.erase(character, radiotrophic))
            end
        end
        return consumed(use)
    end
end

ccb.runtime.handler("graft_gracken_shade_arms", graft_limb("ARMS", "SHADE_ARMS"))
ccb.runtime.handler("graft_gracken_strong_arms", graft_limb("ARMS", "SHADE_STRONG_ARMS"))
ccb.runtime.handler("graft_gracken_long_arms", graft_limb("ARMS", "SHADE_LONG_ARMS"))
ccb.runtime.handler("graft_gracken_shade_hands", graft_limb("HANDS", "SHADE_HANDS"))
ccb.runtime.handler("graft_gracken_sharp_nails", graft_limb("HANDS", "SHADE_SHARP_NAILS"))
ccb.runtime.handler("graft_gracken_dextrous_hands", graft_limb("HANDS", "SHADE_DEXTROUS_HANDS"))
ccb.runtime.handler("graft_gracken_shade_legs", graft_limb("ARMS", "SHADE_LEGS"))
ccb.runtime.handler("graft_gracken_short_legs", graft_limb("LEGS", "SHADE_SHORT_LEGS"))
ccb.runtime.handler("graft_gracken_long_legs", graft_limb("LEGS", "SHADE_LONG_LEGS"))
ccb.runtime.handler("graft_gracken_herbivorous_stomach", graft_stomach("SHADE_HERBIVORE", function()
    return ccb.services.translate("You are already an herbivore.")
end))
ccb.runtime.handler("graft_gracken_omnivorous_stomach", graft_stomach("SHADE_OMNIVORE", function()
    return ccb.services.translate("You are already an omnivore.")
end))
ccb.runtime.handler("graft_gracken_carnivorous_stomach", graft_stomach("SHADE_CARNIVORE", function()
    return ccb.services.translate("You are already a carnivore.")
end))

do
    -- NO_I18N
    local item = content.Item {
        id = "gracken_improvement_general",
        abstract = true,
        category = "MED",
        name = content.plural_text("abstract gracken improvement", "abstract gracken improvements"),
        mass_milligrams = 1900000,
        volume_ml = 2500,
        symbol = "!",
        color = "light_gray",
        price_postapoc_cents = 1000,
    }
    item:material("flesh", 1)
    item:material("shadowstuff", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_shade_arms",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Shade Arms", "Gracken Shade Arms"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their arms back to a base state."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_shade_arms", ccb.content.text("Replace arms"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_strong_arms",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Strong Arms", "Gracken Strong Arms"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their arms to a stronger form."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_strong_arms", ccb.content.text("Replace arms"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_long_arms",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Long Arms", "Gracken Long Arms"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their arms to a longer form."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_long_arms", ccb.content.text("Replace arms"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_shade_hands",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Shade Hands", "Gracken Shade Hands"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their hands back to a base state."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_shade_hands", ccb.content.text("Replace hands"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_sharp_nails",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Sharp Nails", "Gracken Sharp Nails"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their hands to a sharper form."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_sharp_nails", ccb.content.text("Replace hands"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_dextrous_hands",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Dextrous Hands", "Gracken Dextrous Hands"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their hands to a more agile form."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_dextrous_hands", ccb.content.text("Replace hands"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_herbivorous_stomach",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Herbivorous Stomach", "Gracken Herbivorous Stomach"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their diet to an herbivorous one."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_herbivorous_stomach", ccb.content.text("Activate"), ccb.content.text("You graft this organ onto your body replacing whatever was there before."))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_omnivorous_stomach",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Omnivorous Stomach", "Gracken Omnivorous Stomach"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their diet to an omnivorous one."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_omnivorous_stomach", ccb.content.text("Activate"), ccb.content.text("You graft this organ onto your body replacing whatever was there before."))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_carnivorous_stomach",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Carnivorous Stomach", "Gracken Carnivorous Stomach"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their diet to an carnivorous one."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_carnivorous_stomach", ccb.content.text("Activate"), ccb.content.text("You graft this organ onto your body replacing whatever was there before."))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_shade_legs",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Shade Legs", "Gracken Shade Legs"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their legs back to a base state."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_shade_legs", ccb.content.text("Replace legss"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_short_legs",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Short Legs", "Gracken Short Legs"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their legs to a shorter form."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_short_legs", ccb.content.text("Replace arms"))
    content.add(item)
end

do
    local item = content.Item {
        id = "gracken_long_legs",
        copy_from = "gracken_improvement_general",
        name = ccb.content.plural_text("Gracken Long Legs", "Gracken Long Legs"),
        looks_like = "offal",
        description = ccb.content.text("An organ that allows a mature Gracken to convert their legs to a longer form."),
    }
    item:tool()
    item:clear_use_actions()
    item:on_use("graft_gracken_long_legs", ccb.content.text("Replace legs"))
    content.add(item)
end
