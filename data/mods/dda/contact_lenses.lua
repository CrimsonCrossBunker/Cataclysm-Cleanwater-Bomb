local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local duration = services.time.duration

local vision_flags = { "HYPEROPIC", "MYOPIC", "MYOPIC_IN_LIGHT" }
local lens_effects = {
    id("effect", "contacts"),
    id("effect", "transition_contacts"),
    id("effect", "transition_contacts_plano"),
}

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has_vision_flag(character, flags)
    for _, flag in ipairs(flags) do
        if value(services.creatures.has_flag_text(character, flag)) then
            return true
        end
    end
    return false
end

local function apply_lenses(required_flags, effect_name, seconds)
    local effect = id("effect", effect_name)
    return function(ctx)
        local character = ctx.character
        if not character then
            return 1
        end

        if #required_flags > 0 and not has_vision_flag(character, required_flags) then
            if has_vision_flag(character, vision_flags) then
                ctx:message(ccb.services.translate("These lenses won't help you with your sight problems."))
            else
                ctx:message(ccb.services.translate("You don't have any sight problems that require lenses."))
            end
            return 1
        end
        if value(services.characters.is_underwater(character)) then
            ctx:message(ccb.services.translate("Can't apply contact lenses underwater."))
            return 1
        end

        local wearing_lenses = false
        for _, old_effect in ipairs(lens_effects) do
            if value(services.effects.has(character, old_effect)) then
                wearing_lenses = true
                break
            end
        end
        if wearing_lenses then
            local actor = value(services.creatures.snapshot(character))
            if actor.kind ~= "avatar" or not services.interaction.confirm(
                ccb.services.translate("You already have lenses applied.  Replace your current lenses?")
            ) then
                ctx:message(ccb.services.translate("You decide not to open the sealed lenses case."))
                return 1
            end
            ctx:message(ccb.services.translate("You remove your old contact lenses and apply a new pair."))
        else
            ctx:message(ccb.services.translate("You apply a new pair of contact lenses."))
        end

        for _, old_effect in ipairs(lens_effects) do
            value(services.effects.remove(character, old_effect))
        end
        local turns = math.floor(services.random.native_float(seconds * 0.94, seconds * 1.06))
        value(services.effects.add(character, effect, duration(turns, "turn")))
        value(services.inventory.consume_by_type(character, id("item", ctx.item_id), 1, 0))
        -- The engine ignores the returned charge count if consumption removed the used item.
        return 1
    end
end

ccb.runtime.handler("use_myopia_contacts_weekly", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT" }, "contacts", 604800))

do
    -- 6 * 4 * 0.9 cm, someone need to confirm
    local item = content.Item {
        id = "myopia_contacts_weekly",
        category = "drugs",
        name = ccb.content.plural_text("myopia contact lenses (weekly)", "myopia contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two extended-wear soft contact lenses, buffered in saline solution.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>nearsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        mass_milligrams = 2600,
        volume_ml = 22,
        price_cents = 72,
        price_postapoc_cents = 25,
        symbol = "[",
        color = "cyan",
        stackable = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("IRREPLACEABLE_CONSUMABLE")
    item:clear_use_actions()
    item:on_use("use_myopia_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_myopia_transition_contacts_weekly", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT" }, "transition_contacts", 604800))

do
    local item = content.Item {
        id = "myopia_transition_contacts_weekly",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("myopia transition contact lenses (weekly)", "myopia transition contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two extended-wear soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments.  They sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>nearsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        price_cents = 600,
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_myopia_transition_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_myopia_contacts_daily", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT" }, "contacts", 57600))

do
    local item = content.Item {
        id = "myopia_contacts_daily",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("myopia contact lenses (daily)", "myopia contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two daily-use soft contact lenses, buffered in saline solution.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>nearsightedness</color>, and should be discarded after <color_light_blue>16 hours</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_myopia_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_myopia_transition_contacts_daily", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT" }, "transition_contacts", 57600))

do
    local item = content.Item {
        id = "myopia_transition_contacts_daily",
        copy_from = "myopia_transition_contacts_weekly",
        looks_like = "myopia_transition_contacts_weekly",
        name = ccb.content.plural_text("myopia transition contact lenses (daily)", "myopia transition contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two transition daily-use soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>nearsightedness</color>, and should be discarded after <color_light_blue>16 hours</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_myopia_transition_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_hyperopia_contacts_weekly", apply_lenses({ "HYPEROPIC" }, "contacts", 604800))

do
    local item = content.Item {
        id = "hyperopia_contacts_weekly",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("hyperopia contact lenses (weekly)", "hyperopia contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two extended-wear soft contact lenses, buffered in saline solution.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>farsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_hyperopia_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_hyperopia_transition_contacts_weekly", apply_lenses({ "HYPEROPIC" }, "transition_contacts", 604800))

do
    local item = content.Item {
        id = "hyperopia_transition_contacts_weekly",
        copy_from = "myopia_transition_contacts_weekly",
        looks_like = "myopia_transition_contacts_weekly",
        name = ccb.content.plural_text("hyperopia transition contact lenses (weekly)", "hyperopia transition contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two transition extended-wear soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments.  The lenses are designed to help anyone with <color_light_blue>farsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_hyperopia_transition_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_hyperopia_contacts_daily", apply_lenses({ "HYPEROPIC" }, "contacts", 57600))

do
    local item = content.Item {
        id = "hyperopia_contacts_daily",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("hyperopia contact lenses (daily)", "hyperopia contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two extended-wear soft contact lenses, buffered in saline solution.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>farsightedness</color>, and should be discarded after <color_light_blue>16 hours</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_hyperopia_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_hyperopia_transition_contacts_daily", apply_lenses({ "HYPEROPIC" }, "transition_contacts", 57600))

do
    local item = content.Item {
        id = "hyperopia_transition_contacts_daily",
        copy_from = "myopia_transition_contacts_weekly",
        looks_like = "myopia_transition_contacts_weekly",
        name = ccb.content.plural_text("hyperopia transition contact lenses (daily)", "hyperopia transition contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two transition extended-wear soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments.  The lenses are designed to help anyone with <color_light_blue>farsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_hyperopia_transition_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_bifocal_contacts_weekly", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT", "HYPEROPIC" }, "contacts", 604800))

do
    local item = content.Item {
        id = "bifocal_contacts_weekly",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("bifocal contact lenses (weekly)", "bifocal contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two extended-wear soft contact lenses, buffered in saline solution.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>both nearsightedness and farsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_bifocal_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness or farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_bifocal_transition_contacts_weekly", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT", "HYPEROPIC" }, "transition_contacts", 604800))

do
    local item = content.Item {
        id = "bifocal_transition_contacts_weekly",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("bifocal transition contact lenses (weekly)", "bifocal transition contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two transition extended-wear soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>both nearsightedness and farsightedness</color>, and should be discarded after <color_light_blue>a week</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_bifocal_transition_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness or farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_bifocal_contacts_daily", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT", "HYPEROPIC" }, "contacts", 57600))

do
    local item = content.Item {
        id = "bifocal_contacts_daily",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("bifocal contact lenses (daily)", "bifocal contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two daily-use soft contact lenses, buffered in saline solution.  They are a great replacement for wearing glasses and sit comfortably on the surface of the eye.  The lenses are designed to help anyone with <color_light_blue>both nearsightedness and farsightedness</color>, and should be discarded after <color_light_blue>16 hours</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_bifocal_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness or farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_bifocal_transition_contacts_daily", apply_lenses({ "MYOPIC", "MYOPIC_IN_LIGHT", "HYPEROPIC" }, "transition_contacts", 57600))

do
    local item = content.Item {
        id = "bifocal_transition_contacts_daily",
        copy_from = "myopia_transition_contacts_weekly",
        looks_like = "myopia_transition_contacts_weekly",
        name = ccb.content.plural_text("bifocal transition contact lenses (daily)", "bifocal transition contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two transition daily-use soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments.  The lenses are designed to help anyone with <color_light_blue>both nearsightedness and farsightedness</color>, and should be discarded after <color_light_blue>16 hours</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_bifocal_transition_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your nearsightedness or farsightedness."))
    content.add(item)
end

ccb.runtime.handler("use_plano_transition_contacts_weekly", apply_lenses({}, "transition_contacts_plano", 604800))

do
    local item = content.Item {
        id = "plano_transition_contacts_weekly",
        copy_from = "myopia_contacts_weekly",
        looks_like = "myopia_contacts_weekly",
        name = ccb.content.plural_text("plano transition contact lenses (weekly)", "plano transition contact lenses (weekly)"),
        description = ccb.content.text("Small plastic case with two transition extended-wear soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments, but it doesn't help with any sight issues.  Essentially a pair of temporary sunglasses, this lenses should be discarded after <color_light_blue>a week</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_plano_transition_contacts_weekly", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate your the bright light discomfort."))
    content.add(item)
end

ccb.runtime.handler("use_plano_transition_contacts_daily", apply_lenses({}, "transition_contacts_plano", 57600))

do
    local item = content.Item {
        id = "plano_transition_contacts_daily",
        copy_from = "myopia_transition_contacts_weekly",
        looks_like = "myopia_transition_contacts_weekly",
        name = ccb.content.plural_text("plano transition contact lenses (daily)", "plano transition contact lenses (daily)"),
        description = ccb.content.text("Small plastic case with two transition daily-use soft contact lenses, buffered in saline solution.  This high-tech pair darkens in response to light, making it easier to see in bright environments, but it doesn't help with any sight issues.  Essentially a pair of temporary sunglasses, this lenses should be discarded after <color_light_blue>16 hours</color> of use."),
        symbol = "[",
        color = "cyan",
    }
    item:clear_use_actions()
    item:on_use("use_plano_transition_contacts_daily", ccb.content.text("Apply contact lenses"), ccb.content.text("You can use this to mitigate the bright light discomfort."))
    content.add(item)
end
