local content = require("ccb").content

do
    local group = content.ItemGroup { id = "cop_torso-navy", kind = "distribution" }
    group:item("dress_shirt", 100, "blue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-navy", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-navy", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-navy", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-navy", kind = "distribution" }
    group:item("dress_shirt", 100, "blue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-navy", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-navy", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-navy", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-navy", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-tan", kind = "distribution" }
    group:item("postman_shirt", 100, "sheriff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-tan", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_green")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-tan", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-tan", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-tan", kind = "distribution" }
    group:item("postman_shirt", 100, "sheriff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-tan", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_green")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-tan", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-tan", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-tan", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-southern", kind = "distribution" }
    group:item("postman_shirt", 100, "sheriff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-southern", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-southern", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-southern", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-southern", kind = "distribution" }
    group:item("postman_shirt", 100, "sheriff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-southern", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-southern", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-southern", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-southern", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-texas", kind = "distribution" }
    group:item("postman_shirt", 100, "sheriff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-texas", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_coyote")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-texas", kind = "distribution" }
    group:item("boots_western")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-texas", kind = "distribution" }
    group:item("cowboy_hat", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-texas", kind = "distribution" }
    group:item("postman_shirt", 100, "sheriff")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-texas", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_coyote")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-texas", kind = "distribution" }
    group:item("boots_western")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-texas", kind = "distribution" }
    group:item("cowboy_hat")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-texas", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-cold", kind = "distribution" }
    group:item("dress_shirt", 100, "gray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-cold", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-cold", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-cold", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-cold", kind = "distribution" }
    group:item("dress_shirt", 100, "gray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-cold", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-cold", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-cold", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-cold", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-patrol", kind = "distribution" }
    group:item("dress_shirt", 100, "black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-patrol", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-patrol", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-patrol", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-patrol", kind = "distribution" }
    group:item("dress_shirt", 100, "black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-patrol", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-patrol", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-patrol", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-patrol", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-ontario", kind = "distribution" }
    group:item("dress_shirt", 100, "blue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-ontario", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-ontario", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-ontario", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-ontario", kind = "distribution" }
    group:item("dress_shirt", 100, "blue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-ontario", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-ontario", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-ontario", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-ontario", kind = "collection" }
    group:item("boots_combat")
    group:item("hat_ball")
    group:item("dress_shirt", 100, "white")
    group:item("pants_tactical", 100, "tactical_pants_black")
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-quebec", kind = "distribution" }
    group:item("dress_shirt", 100, "gray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-quebec", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_green")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-quebec", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-quebec", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-quebec", kind = "distribution" }
    group:item("dress_shirt", 100, "gray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-quebec", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_green")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-quebec", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-quebec", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-quebec", kind = "collection" }
    group:item("boots")
    group:item("hat_ball")
    group:item("dress_shirt", 100, "white")
    group:item("pants_tactical", 100, "tactical_pants_black")
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-pacific_ca", kind = "distribution" }
    group:item("dress_shirt", 100, "black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-pacific_ca", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-pacific_ca", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-pacific_ca", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-pacific_ca", kind = "distribution" }
    group:item("dress_shirt", 100, "black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-pacific_ca", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-pacific_ca", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-pacific_ca", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-pacific_ca", kind = "collection" }
    group:item("boots_combat")
    group:item("hat_ball")
    group:item("dress_shirt", 100, "white")
    group:item("pants_tactical", 100, "tactical_pants_black")
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-rcmp", kind = "distribution" }
    group:item("dress_shirt", 100, "gray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-rcmp", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-rcmp", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-rcmp", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-rcmp", kind = "distribution" }
    group:item("dress_shirt", 100, "gray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-rcmp", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-rcmp", kind = "distribution" }
    group:item("boots")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-rcmp", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-rcmp", kind = "collection" }
    group:item("boots")
    group:item("hat_ball")
    group:item("dress_shirt", 100, "white")
    group:item("pants_tactical", 100, "tactical_pants_black")
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-central_mx", kind = "distribution" }
    group:item("dress_shirt", 100, "blue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-central_mx", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-central_mx", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-central_mx", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-central_mx", kind = "distribution" }
    group:item("dress_shirt", 100, "blue")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-central_mx", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-central_mx", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-central_mx", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-central_mx", kind = "collection" }
    group:item("boots_combat")
    group:item("hat_ball")
    group:item("dress_shirt", 100, "white")
    group:item("pants_tactical", 100, "tactical_pants_black")
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_torso-patrol_mx", kind = "distribution" }
    group:item("dress_shirt", 100, "black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_pants-patrol_mx", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_grey")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_shoes-patrol_mx", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cop_helmet-patrol_mx", kind = "distribution" }
    group:item("hat_ball", 85)
    group:item("helmet_riot", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shirt-patrol_mx", kind = "distribution" }
    group:item("dress_shirt", 100, "black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_pants-patrol_mx", kind = "distribution" }
    group:item("pants_tactical", 100, "tactical_pants_grey")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_shoes-patrol_mx", kind = "distribution" }
    group:item("boots_combat")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_CITY_COP_hat-patrol_mx", kind = "distribution" }
    group:item("hat_ball")
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer-patrol_mx", kind = "collection" }
    group:item("boots_combat")
    group:item("hat_ball")
    group:item("dress_shirt", 100, "white")
    group:item("pants_tactical", 100, "tactical_pants_black")
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
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
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_swat_death_drops-ca",
        kind = "collection",
        with_ammo = 40,
        with_magazine = 100,
    }
    group:entry { group = "swat_zombie_gear", damage = { 0, 2 } }
    group:entry { group = "swat_gloves", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "swat_helmet", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "pants_tactical", damage = { 0, 4 }, variant = "tactical_pants_black" }
    group:entry { group = "swat_shoes", damage = { 0, 4 } }
    group:entry { group = "swat_torso-ca", damage = { 0, 4 } }
    group:group("swat_weapons", 25)
    group:group("cop_holster", 70)
    group:entry { group = "underwear", damage = { 0, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 10)
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_torso-ca", kind = "collection" }
    group:entry {
        distribution = {
            { item = "armor_riot", probability = 30 },
            { item = "armor_riot_torso", probability = 15 },
            { group = "swat_ballistic_vest", probability = 80 },
        },
        probability = 65,
    }
    group:entry { item = "dress_shirt", damage = { 0, 4 }, variant = "black" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_marine_death_drops-ca",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            {
                group = "military_standard_assault_rifles",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 75,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap_simple" },
                },
                probability = 10,
            },
            {
                group = "military_standard_shotguns",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 5,
            },
        },
        probability = 15,
    }
    group:group("gear_soldier_sidearm", 10)
    group:entry { group = "loaded_webbing_belt", damage = { 0, 4 }, probability = 60 }
    group:entry { item = "pants_tactical", damage = { 0, 4 }, variant = "tactical_pants_black" }
    group:entry { item = "boots_combat", damage = { 0, 4 } }
    group:entry {
        item = "sheath",
        contents = {
            { item = "knife_combat_marine" },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 25,
    }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, 100 }, damage = { 1, 4 }, probability = 25 },
            {
                item = "mask_gas",
                charges = { 0, 100 },
                damage = { 1, 4 },
                contents = {
                    { group = "gasmask_inserts_in_use" },
                },
                probability = 25,
            },
            { group = "gasmask_bag_full", damage = { 1, 4 }, probability = 25 },
            { group = "gasmask_bag_used", damage = { 1, 4 }, probability = 60 },
        },
        probability = 5,
    }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:entry { group = "military_standard_grenades", count = { 1, 3 }, probability = 20 }
    group:group("military_patrol_food")
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:entry { item = "elbow_pads", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "knee_pads", damage = { 0, 4 }, probability = 85 }
    group:entry { item = "helmet_army", damage = { 0, 4 } }
    group:entry { item = "gloves_tactical", damage = { 0, 4 }, probability = 60 }
    group:entry { group = "military_ballistic_vest", damage = { 0, 4 } }
    group:entry { group = "molle_backpacks_and_accessories", damage = { 0, 4 }, probability = 85 }
    group:entry { group = "clothing_tactical_leg", damage = { 0, 4 }, probability = 15 }
    group:item("dog_tag", 40)
    group:entry { item = "combat_shirt", damage = { 0, 4 } }
    group:item("nomex_socks")
    group:group("underwear")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_swat_death_drops-mx",
        kind = "collection",
        with_ammo = 40,
        with_magazine = 100,
    }
    group:entry { group = "swat_zombie_gear", damage = { 0, 2 } }
    group:entry { group = "swat_gloves", damage = { 0, 4 }, probability = 30 }
    group:entry { group = "swat_helmet", damage = { 0, 4 }, probability = 20 }
    group:entry { item = "pants_tactical", damage = { 0, 4 }, variant = "tactical_pants_grey" }
    group:entry { group = "swat_shoes", damage = { 0, 4 } }
    group:entry { group = "swat_torso-mx", damage = { 0, 4 } }
    group:group("swat_weapons", 25)
    group:group("cop_holster", 70)
    group:entry { group = "underwear", damage = { 0, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 10)
    group:entry { group = "wallets", damage = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "swat_torso-mx", kind = "collection" }
    group:entry {
        distribution = {
            { item = "armor_riot", probability = 30 },
            { item = "armor_riot_torso", probability = 15 },
            { group = "swat_ballistic_vest", probability = 80 },
        },
        probability = 65,
    }
    group:entry { item = "dress_shirt", damage = { 0, 4 }, variant = "black" }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "mon_zombie_marine_death_drops-mx",
        kind = "collection",
        with_ammo = 60,
        with_magazine = 100,
    }
    group:entry {
        distribution = {
            {
                group = "military_standard_assault_rifles",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 75,
            },
            {
                group = "military_standard_lmgs",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap_simple" },
                },
                probability = 10,
            },
            {
                group = "military_standard_shotguns",
                damage = { 0, 4 },
                dirt = { 0, 6000 },
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 5,
            },
        },
        probability = 15,
    }
    group:group("gear_soldier_sidearm", 10)
    group:entry { group = "loaded_webbing_belt", damage = { 0, 4 }, probability = 60 }
    group:entry { item = "pants_tactical", damage = { 0, 4 }, variant = "tactical_pants_grey" }
    group:entry { item = "boots_combat", damage = { 0, 4 } }
    group:entry {
        item = "sheath",
        contents = {
            { item = "knife_combat_marine" },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "infantry_officer_gear" },
            { group = "infantry_medical_gear" },
        },
        probability = 25,
    }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 25 }
    group:entry { item = "two_way_radio", charges = { 0, 300 }, probability = 25 }
    group:group("wallets_military", 5)
    group:entry { group = "clothing_glasses", damage = { 0, 4 }, probability = 5 }
    group:entry {
        distribution = {
            { item = "mask_gas", charges = { 0, 100 }, damage = { 1, 4 }, probability = 25 },
            {
                item = "mask_gas",
                charges = { 0, 100 },
                damage = { 1, 4 },
                contents = {
                    { group = "gasmask_inserts_in_use" },
                },
                probability = 25,
            },
            { group = "gasmask_bag_full", damage = { 1, 4 }, probability = 25 },
            { group = "gasmask_bag_used", damage = { 1, 4 }, probability = 60 },
        },
        probability = 5,
    }
    group:entry { item = "wristwatch", damage = { 0, 4 }, probability = 33 }
    group:entry { group = "military_standard_grenades", count = { 1, 3 }, probability = 20 }
    group:group("military_patrol_food")
    group:group("pocket_cigar", 5)
    group:group("misc_smoking_legal", 10)
    group:entry { item = "elbow_pads", damage = { 0, 4 }, probability = 10 }
    group:entry { item = "knee_pads", damage = { 0, 4 }, probability = 85 }
    group:entry { item = "helmet_army", damage = { 0, 4 } }
    group:entry { item = "gloves_tactical", damage = { 0, 4 }, probability = 60 }
    group:entry { group = "military_ballistic_vest", damage = { 0, 4 } }
    group:entry { group = "molle_backpacks_and_accessories", damage = { 0, 4 }, probability = 85 }
    group:entry { group = "clothing_tactical_leg", damage = { 0, 4 }, probability = 15 }
    group:item("dog_tag", 40)
    group:entry { item = "combat_shirt", damage = { 0, 4 } }
    group:item("nomex_socks")
    group:group("underwear")
    content.add(group)
end
