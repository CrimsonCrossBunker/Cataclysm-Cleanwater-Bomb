local ccb = require("ccb")

-- Above ground
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lmoe" },
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        fill_terrain = "t_region_groundcover",
    },
}

-- This particular 2-bed shelter is a more professionally done, all metal bomb shelter with kitchen, secret safe room / gun locker, and workshop.
-- This terrain is the destination for the prepper_1 quest.  The front door is locked and can be unlocked by completing the quest.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lmoe_under_empty_prepperquest" },
    layout = {
        rows = {
            "########################",
            "########################",
            "##||||||||||||||||||||##",
            "##|{{{{{|UUUUUU|w__BB|##",
            "##|u____|U____U|d__BB|##",
            "##|u___h|U_UU_U|A,,,_|##",
            "##|u___D|=*==*=|_,,,}|##",
            "##|A____:______+_,,,}|##",
            "##|||||||_1,,1_|S__h2|##",
            "##|VVVVV=_e,,P_|||||||##",
            "##|_____*__,,____|s_K|##",
            "##|vvvvv=_E,,f___+__t|##",
            "##|||||||||++|||||||||##",
            "##|c_bbbbA|,,|CSCCKCC|##",
            "##|c______|,,|u_____C|##",
            "##|c_TT___|,,|u_hLh_F|##",
            "##|c_TTh__+__+______é|##",
            "##|c_TT___|__|rrrr__~|##",
            "##|c______|__|||||+|||##",
            "##|c______|__*__a|__A|##",
            "##|ccccccc|<<=G_a|HlW|##",
            "##||||||||||||||||||||##",
            "########################",
            "########################",
        },
        palettes = { "bunker", "empty_prepperquest_bunker_items" },
        fill_terrain = "t_metal_floor",
        nested = {
            { id = "lmoe_exit_prepperquest_n", x = 9, y = 17, z = 1 },
            { id = "lmoe_prepperquest_sign", x = 10, y = 16, z = 1 },
        },
    },
}
