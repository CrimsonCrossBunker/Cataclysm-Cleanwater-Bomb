local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local snippets = services.snippets
local variables = services.variables

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function item_string(item, key)
    return value(variables.get_string(item, key)).value
end

local function set_file_value(item, key, stored)
    value(variables.set(item, key, stored, { include_before = false }))
end

local function message(ctx, text, severity)
    local character = ctx.character
    if character and character.subtype == "avatar" then
        ctx:message(ctx:expand_text(text), severity)
    end
end

local function read_fragment(ctx, category)
    local character = ctx.character
    if not character or character.subtype ~= "avatar" then
        return 0
    end

    local item = ctx.item
    local key = category .. "_snippet_id"
    local selected = item_string(item, key)
    if not selected or selected == "" then
        selected = snippets.native_random_id(category)
        set_file_value(item, key, selected)
        services.lore.remember_snippet(selected)
    end

    local snippet = snippets.get(selected)
    local text = ctx:expand_text(snippets.native_expand(snippet and snippet.text or ""))
    ccb.presentation.notice(text)
    services.activities.offer_interruption("")
    ctx:message(text)
    return 0
end

local function lab_report(category)
    return function(ctx)
        return read_fragment(ctx, category)
    end
end

ccb.runtime.handler("read_biology_report", lab_report("log_mutagen_animal"))
ccb.runtime.handler("read_psychology_report", lab_report("log_psych"))
ccb.runtime.handler("read_security_report", lab_report("log_sec"))

ccb.runtime.handler("inspect_local_files", function(ctx)
    local item = ctx.item
    local contents = item_string(item, "snippet_file")
    if contents ~= "has" and contents ~= "lack" then
        contents = services.random.native_int(0, 1) == 0 and "has" or "lack"
        set_file_value(item, "snippet_file", contents)
        services.native_events.emit("u_var_changed", { "snippet_file", contents })
    end
    if contents == "has" then
        return read_fragment(ctx, "local_files_simple")
    end
    message(ctx, ccb.services.translate("You found nothing interesting."))
    return 0
end)

ccb.runtime.handler("read_map_cache", function(ctx)
    local item = ctx.item
    if item_string(item, "map_cache") == "read" then
        message(ctx, ccb.services.translate("You already noted everything this map cache can offer."))
        return 0
    end

    local spawn = value(variables.get_tripoint(item, "spawn_location")).value
    local coords = services.coords
    local surface = spawn and coords.tripoint_abs_ms(spawn.x, spawn.y, 0) or coords.tripoint_abs_ms(0, 0, 0)
    set_file_value(item, "spawn_location", surface)
    services.overmap.reveal_native(surface:project_to("omt"), services.random.native_int(11, 36))

    -- Updating the marker uses the native RNG, even though "read" is the only value.
    services.random.native_int(0, 0)
    set_file_value(item, "map_cache", "read")
    services.native_events.emit("u_var_changed", { "map_cache", "read" })
    message(ctx, ccb.services.translate("You found some useful data in the map cache and noted it."), "good")
    return 0
end)

do
    local item = content.Item {
        id = "file",
        name = ccb.content.plural_text("file", "files"),
        category = "books",
        description = ccb.content.text("Several documents containing all kinds of information, customer data, and charts, kept together in a manila folder.  Pretty useless now."),
        mass_milligrams = 15000,
        color = "white",
        symbol = ",",
        volume_ml = 50,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("TINDER")
    content.add(item)
end

do
    -- Low-level animal studies, long-form testing logs - naming scheme compound/subject species-test no
    local item = content.Item {
        id = "bio_file",
        name = ccb.content.plural_text("lab report (biology)", "lab reports (biology)"),
        description = ccb.content.text("A manila folder containing top-secret test data.  Most of it is unintelligible without knowing the jargon, and the contents have obviously suffered from the chaos in this place, but there are some intact pages you can make sense of."),
        copy_from = "file",
        looks_like = "file",
    }
    item:conditional_names {
        { kind = "snippet", key = "log_mutagen_animal", value = "test_1", name = ccb.content.plural_text("Report PE012/08-178", "Report PE012/08-178") },
        { kind = "snippet", key = "log_mutagen_animal", value = "test_2", name = ccb.content.plural_text("Report PE027/01-081", "Report PE027/01-081") },
        { kind = "snippet", key = "log_mutagen_animal", value = "test_3", name = ccb.content.plural_text("Report PE031/21-003", "Report PE031/21-003") },
        { kind = "snippet", key = "log_mutagen_animal", value = "test_4", name = ccb.content.plural_text("Report PE065/04-001", "Report PE065/04-001") },
    }
    item:clear_use_actions()
    item:on_use("read_biology_report", ccb.content.text("Activate"), ccb.content.text("Activate to read the file."))
    content.add(item)
end

do
    -- Session logs and similar, naming scheme department code-ID-session number
    local item = content.Item {
        id = "psych_file",
        name = ccb.content.plural_text("lab report (psychology)", "lab reports (psychology)"),
        description = ccb.content.text("A folder full of what appear to be transcripts of confidential psychotherapy sessions.  Most of it is rather trivial, but certain passages catch your eye…"),
        copy_from = "file",
        looks_like = "file",
    }
    item:conditional_names {
        { kind = "snippet", key = "log_psych", value = "dream_1", name = ccb.content.plural_text("Session S-3397-5", "Session S-3397-5") },
        { kind = "snippet", key = "log_psych", value = "dream_2", name = ccb.content.plural_text("Session T-1215-4", "Session T-1215-4") },
        { kind = "snippet", key = "log_psych", value = "dream_3", name = ccb.content.plural_text("Scrawled note", "Scrawled note") },
    }
    item:clear_use_actions()
    item:on_use("read_psychology_report", ccb.content.text("Activate"), ccb.content.text("Activate to read the file."))
    content.add(item)
end

do
    -- Interrogation and surveillance logs, naming scheme facility/incident-material nr
    local item = content.Item {
        id = "security_file",
        name = ccb.content.plural_text("lab report (security)", "lab reports (security)"),
        description = ccb.content.text("A manila folder bearing an atom-and-rifle insignia.  Most of it is concerned with shipping logs and personnel rotations, but there is a single page that feels out of place."),
        copy_from = "file",
        looks_like = "file",
    }
    item:conditional_names {
        { kind = "snippet", key = "log_sec", value = "interview_1", name = ccb.content.plural_text("Personnel Debrief X10/RT338-8", "Personnel Debrief X10/RT338-8") },
        { kind = "snippet", key = "log_sec", value = "interview_2", name = ccb.content.plural_text("Interview Log X33/UE612-1", "Interview Log X33/UE612-1") },
        { kind = "snippet", key = "log_sec", value = "surveillance_1", name = ccb.content.plural_text("Supplementary Material X12/ES081-4", "Supplementary Material X12/ES081-4") },
        { kind = "snippet", key = "log_sec", value = "surveillance_2", name = ccb.content.plural_text("Observation Intercept XA61/RT338-3", "Observation Intercept XA61/RT338-3") },
    }
    item:clear_use_actions()
    item:on_use("read_security_report", ccb.content.text("Activate"), ccb.content.text("Activate to read the file."))
    content.add(item)
end

do
    local item = content.Item {
        id = "efile_lore",
        copy_from = "abstract_efile_exclusive",
        symbol = "o",
        name = ccb.content.plural_text("questionable media file", "questionable media files"),
        description = ccb.content.text("You kept this file on the off-chance that it might be interesting, but you need to take a more thorough look to find out what's inside."),
        electronic_size_kb = 64000,
    }
    item:clear_use_actions()
    item:on_use("inspect_local_files", ccb.content.text("Activate"))
    content.add(item)
end

do
    local item = content.Item {
        id = "efile_map",
        copy_from = "abstract_efile_exclusive",
        symbol = "o",
        name = ccb.content.plural_text("map cache", "map caches"),
        description = ccb.content.text("Information about nearby locations stored from previous use."),
        electronic_size_kb = 32000,
    }
    item:flag("PRESERVE_SPAWN_LOC")
    item:clear_use_actions()
    item:on_use("read_map_cache", ccb.content.text("Activate"))
    content.add(item)
end
