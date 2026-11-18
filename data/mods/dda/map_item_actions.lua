local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local missions = services.missions
local variables = services.variables

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function popup(ctx, text)
    if ctx.character.subtype == "avatar" then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        ctx:message(text)
    end
end

local function assign_mission(character, mission)
    local reserved = value(missions.reserve(id("mission", mission)))
    value(missions.assign(character, reserved.token))
end

local function read_map(handler, spent_item)
    return function(ctx)
        local character = ctx.character
        if not character then
            return 0
        end
        local senses = value(services.characters.snapshot(character, 1)).senses
        if not senses.can_see or (senses.fine_detail_vision_legacy > 4 and
            not value(services.characters.has_flag(character, id("json_flag", "READ_IN_DARKNESS")))) then
            ctx:message(ccb.services.translate("It's too dark to read."))
            return 0
        end
        handler(ctx)
        if spent_item then
            local carried = value(services.inventory.contains(character, ctx.item))
            value(services.items.transform(ctx.item, id("item", spent_item), {
                carrier = carried and character or nil,
                active = false,
            }))
        end
        return 0
    end
end

ccb.runtime.handler("study_evacuation_flyer", read_map(function(ctx)
    local mission = "MISSION_REACH_REFUGEE_CENTER"
    if value(missions.has_active(ctx.character, id("mission", mission))) then
        popup(ctx, ccb.services.translate("You study the flyer.  It shows a similar set of directions to the ones you already have.  You cross-reference them and don't learn anything new."))
    else
        popup(ctx, ccb.services.translate("You study the flyer.  One part of the flyer has a map and address for a nearby refugee center alongside minutia you no longer need trouble yourself with now that society has collapsed, like 'operating hours' and 'acceptable forms of ID'.  You take careful note of the map and address on the flyer and mark down the coordinates."))
        assign_mission(ctx.character, mission)
    end
end))

ccb.runtime.handler("study_xedra_field_notes", read_map(function(ctx)
    local character = ctx.character
    if value(variables.get_string(character, "knows_xedra_field_station_1")).value ~= "yes" then
        popup(ctx, ccb.services.translate("You study the notebook.  The most recent entry has an address underlined several times, with a note: \"S02a deployed for anomaly collection.\"  You mark down the address."))
        assign_mission(character, "MISSION_XEDRA_FIELD_STATION_1")
    elseif value(variables.get_string(character, "knows_xedra_field_station_2")).value ~= "yes" then
        popup(ctx, ccb.services.translate("You study the notebook.  Slipped into the back is a ripped corner of some paper, with only \"CLASSIFIED\" still visible.  Written on the back in pencil is a rural address.  You mark down the address."))
        assign_mission(character, "MISSION_XEDRA_FIELD_STATION_2")
    elseif value(variables.get_string(character, "knows_xedra_field_station_3")).value ~= "yes" then
        popup(ctx, ccb.services.translate("You study the notebook.  Slipped into the back are several receipts for the delivery of supplies and appliances, by boat, to a rural location.  You also find a quote for the installation of a security door - the code, 4321, is written in pencil on the sheet.  You make note of the location."))
        assign_mission(character, "MISSION_XEDRA_FIELD_STATION_3")
    else
        popup(ctx, ccb.services.translate("You study the notebook, but don't find anything interesting or new."))
    end
end, "xedra_field_notes_used"))

ccb.runtime.handler("study_inner_cabins_journal", read_map(function(ctx)
    local mission = "MISSION_INNER_CABINS_GO_TO_DEPTHS"
    if value(missions.has_active(ctx.character, id("mission", mission))) then
        popup(ctx, ccb.services.translate("You study the notebook, but don't find anything interesting or new."))
    else
        popup(ctx, ccb.services.translate("This book is written in a script that you do not recognize or understand.  However, there is a very clear map drawn on the inside of the front cover, with a location circled.  You make note of it."))
        assign_mission(ctx.character, mission)
    end
end, "inner_cabins_depths_note_used"))

ccb.runtime.handler("study_inner_cabins_map", read_map(function(ctx)
    local mission = "MISSION_INNER_CABINS_GO_TO_DEPTHS_2"
    if value(missions.has_active(ctx.character, id("mission", mission))) then
        popup(ctx, ccb.services.translate("You study the map, but don't find anything interesting or new."))
    else
        popup(ctx, ccb.services.translate("The map shows a stylized cabin, a stairway, and then a path through what appears to be a maze.  It's remarkably well drawn, and you think you can discern where it leads."))
        assign_mission(ctx.character, mission)
    end
end, "inner_cabins_depths_note_2_used"))

local subway_destinations = {
    "MISSION_INNER_CABINS_GO_TO_DEPTHS_3a",
    "MISSION_INNER_CABINS_GO_TO_DEPTHS_3b",
    "MISSION_INNER_CABINS_GO_TO_DEPTHS_3c",
    "MISSION_INNER_CABINS_GO_TO_DEPTHS_3d",
    "MISSION_INNER_CABINS_GO_TO_DEPTHS_3e",
}

ccb.runtime.handler("study_inner_cabins_subway_map", read_map(function(ctx)
    popup(ctx, ccb.services.translate("This was once clearly a subway map, but it has a labyrinthian overlay, and a hand-drawn yellow circle of some destination.  While you do not understand the symbols, you think you can discern direction and distance.  You make a note of the location."))
    local choice = services.random.native_int(0, 4)
    value(variables.set_global("inner_cabins_destination_choice", choice, { include_before = false }))
    assign_mission(ctx.character, subway_destinations[choice + 1])
end, "inner_cabins_depths_note_3_used"))

do
    local item = content.Item {
        id = "flyer_evac",
        name = ccb.content.plural_text("FEMA evacuation flyer", "FEMA evacuation flyers"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("A FEMA-issued flyer as to potential evacuations that'll occur and what to do when it starts.  Activate to look for the address of the nearest Refugee Center."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PRESERVE_SPAWN_LOC")
    item:flag("LOCATION_PRECISE_CLOSEST_CITY")
    item:flag("PAPER_SHAPED")
    item:clear_use_actions()
    item:on_use("study_evacuation_flyer", ccb.content.text("Study the flyer"), ccb.content.text("Activate to look for the address of the nearest Refugee Center"))
    content.add(item)
end

do
    local item = content.Item {
        id = "xedra_field_notes",
        name = ccb.content.plural_text("field notebook", "field notebooks"),
        category = "maps",
        symbol = ",",
        color = "white",
        looks_like = "book_binder",
        description = ccb.content.text("A small notebook with \"X.E.D.R.A\" embossed on the cover.  It's filled with notes scribbled by pencil."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 90000,
        volume_ml = 150,
    }
    item:material("paper", 1)
    item:clear_use_actions()
    item:on_use("study_xedra_field_notes", ccb.content.text("Study the notebook"), ccb.content.text("Activate to highlight interesting locations"))
    content.add(item)
end

do
    local item = content.Item {
        id = "inner_cabins_depths_note",
        name = ccb.content.plural_text("leather notebook", "leather notebooks"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("An absolutely ancient-looking, leather-bound journal.  The pages are gilded at the edges."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 750000,
        volume_ml = 1200,
    }
    item:material("paper", 1)
    item:material("leather", 1)
    item:clear_use_actions()
    item:on_use("study_inner_cabins_journal", ccb.content.text("Study the journal"), ccb.content.text("Study the journal"))
    content.add(item)
end

do
    local item = content.Item {
        id = "inner_cabins_depths_note_2",
        name = ccb.content.plural_text("sketched map", "sketched maps"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("An old scrap of yellow, lined paper.  On it, a very detailed map has been sketched."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    item:clear_use_actions()
    item:on_use("study_inner_cabins_map", ccb.content.text("Study the map"), ccb.content.text("Study the map"))
    content.add(item)
end

do
    local item = content.Item {
        id = "inner_cabins_depths_note_3",
        name = ccb.content.plural_text("strange subway map", "strange subway maps"),
        category = "maps",
        symbol = ",",
        color = "white",
        description = ccb.content.text("A subway map covered in strange symbols and sketches."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    item:clear_use_actions()
    item:on_use("study_inner_cabins_subway_map", ccb.content.text("Study the map"), ccb.content.text("Study the map"))
    content.add(item)
end
