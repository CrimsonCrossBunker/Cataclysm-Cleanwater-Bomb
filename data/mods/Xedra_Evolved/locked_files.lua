local ccb = require("ccb")
local services = ccb.services
local snippets = services.snippets
local variables = services.variables

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("read_xedra_locked_folders", function(use)
    local character = use.character
    if not character then
        return 0
    end

    local unlocked = value(services.skills.level(character, "computer")) >= 2
        and services.random.native_int(1, 10) + value(services.skills.level(character, "deduction")) > 12
    if character.subtype ~= "avatar" then
        return 0
    end
    if not unlocked then
        use:message(ccb.services.translate("You found nothing interesting."))
        return 0
    end

    local item = use.item
    local key = "local_files_xedra_snippet_id"
    local selected = value(variables.get_string(item, key)).value
    if not selected or selected == "" then
        selected = snippets.native_random_id("local_files_xedra")
        value(variables.set(item, key, selected, { include_before = false }))
        services.lore.remember_snippet(selected)
    end

    local snippet = snippets.get(selected)
    local text = use:expand_text(snippets.native_expand(snippet and snippet.text or ""))
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
    use:message(text)
    return 0
end)
