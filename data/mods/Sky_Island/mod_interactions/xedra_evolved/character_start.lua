local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")

local lineages = {
    { "IERDE", "mutagen_earthkin" },
    { "UNDINE", "mutagen_waterkin" },
    { "SALAMANDER", "mutagen_flamekin" },
    { "SYLPH", "mutagen_airkin" },
    { "HOMULLUS", "mutagen_dollkin" },
    { "ARVORE", "mutagen_plantkin" },
}

local function add_vitamin(character, key, count)
    local vitamin = services.types.id("vitamin", key)
    local before = state.checked(services.needs.get_vitamin(character, vitamin))
    local total = math.modf(before + count)
    state.checked(services.needs.set_vitamin(character, vitamin, total))
end

ccb.runtime.handler("sky_xedra_character_start", function()
    local character = services.characters.avatar()
    if state.has_trait(character, "LILIN_TRAITS") then
        add_vitamin(character, "lilin_ruach_vitamin", services.random.native_float(550, 850))
    end

    local given_mutagen = false
    for _, lineage in ipairs(lineages) do
        if state.has_trait(character, lineage[1]) then
            if not given_mutagen then
                add_vitamin(character, "mutagen", 550)
                given_mutagen = true
            end
            add_vitamin(character, lineage[2], 550)
        end
    end
end)
ccb.runtime.on("game:game_start", "sky_xedra_character_start")
