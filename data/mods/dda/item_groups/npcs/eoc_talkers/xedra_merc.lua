local content = require("ccb").content

do
    -- equipment dropped by the XEDRA officer boss
    local group = content.ItemGroup { id = "xedra_officer_set", kind = "collection" }
    group:group("clothing_soldier_shirt")
    group:entry {
        distribution = {
            { item = "socks", probability = 95 },
            { item = "socks_wool", probability = 5 },
        },
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    group:group("clothing_tactical_leg")
    group:group("clothing_watch")
    group:item("phase_immersion_suit")
    group:item("phase_immersion_helmet")
    group:item("phase_immersion_cca")
    group:item("military_papr_blower_off")
    group:item("id_science_security_black")
    group:entry { item = "survivor_machete_qt", variant = "xedra_machete", container = "scabbard" }
    group:entry {
        collection = {
            { item = "rm103a_pistol", charges = { 6, 6 }, container = "holster" },
            { group = "field_xedra_officer" },
        },
    }
    content.add(group)
end
