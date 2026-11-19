local ccb = require("ccb")

-- LMOE shelter filled with angry NPCs. Has a working generator and light.
-- This particular 2-bed shelter is a more professionally done, all metal bomb shelter with kitchen, secret safe room / gun locker, and workshop.
-- TODO: Full/empty should probably be parameterised in vanilla and then this just change the weights
ccb.content.define_mapgen {
    kind = "overmap",
    id = "lmoe_under_full",
    layout = {
        rows = {
            "########################",
            "########################",
            "##||||||||||||||||||||##",
            "##|{{{{{|UUUUUU|w_№BB|##",
            "##|u____|U___№U|d__BB|##",
            "##|u_№_h|U_UU_U|A,,,_|##",
            "##|u___D|=*==*=|_,,,}|##",
            "##|A____:______+_,,,}|##",
            "##|||||||_1,,1_|S_№hD|##",
            "##|VVVVV=_e,,P_|||||||##",
            "##|__№__*_№,,№___|s_K|##",
            "##|vvvvv=_E,,f___+_№t|##",
            "##|||||||||++|||||||||##",
            "##|c_bbbbA|,,|CSCCKCC|##",
            "##|c______|,,|u№___№C|##",
            "##|c_TT___|,,|u_hLh_F|##",
            "##|c№TTh№_+№№+_______|##",
            "##|c_TT___|__|rrrr__~|##",
            "##|c______|__|||||+|||##",
            "##|c______|__*_№a|_№A|##",
            "##|ccccccc|<<=G_a|HlW|##",
            "##||||||||||||||||||||##",
            "########################",
            "########################",
        },
        palettes = { "bunker", "full_bunker_items" },
        terrain = { ["№"] = "t_thconc_floor_olight" },
        furniture = {
            G = {
                { id = "f_portable_generator", copies = 25 },
                { id = "f_diesel_generator", copies = 5 },
                { id = "f_military_generator", copies = 5 },
                { id = "f_12000_gasoline_generator", copies = 5 },
            },
        },
        fill_terrain = "t_thconc_floor",
        nested_glyphs = {
            h = {
                choices = {
                    { id = "npc_bandit", weight = 25 },
                    { id = "npc_thug", weight = 25 },
                    { id = "null", weight = 50 },
                },
            },
            f = {
                choices = {
                    { id = "npc_bandit", weight = 38 },
                    { id = "npc_thug", weight = 38 },
                    { id = "null", weight = 25 },
                },
            },
        },
    },
}

-- LMOE shelter filled with angry NPCs. Has a working generator and light.
-- This is a commercially built 4-bed LMOE shelter based on IRL plans.
-- There are extensive secret rooms which might contain a lot of treasure in the non-looted version.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "lmoe_under_full",
    layout = {
        rows = {
            "##|||||#################",
            "##|,@<|||||||###########",
            "##|Y,<|w,BBd|###########",
            "||||+||},BB,|###########",
            "|A,@,E|,,@,,|###########",
            "|f,,,,|+|||||||||||#####",
            "|f,,,e|,,,@b|lllll|#####",
            "|f,,,,|,,h,,|u_№_U|#####",
            "|Dh,,P|,hLh,|u_u_U|#####",
            "|,,,,,|,hLh,|u_u_U|#####",
            "|,,@,,+,,h,,|u_u_U|#####",
            "|,|||||~,,,u|u_u_U|#####",
            "|,+,@B|K@,,u:__№_U|#####",
            "|@|d,B|COC,u|u_v_U|#####",
            "|,||||||||+||u_v_U|#####",
            "|,+,@B|t,@,K|u_№_U|#####",
            "|}|d,B|WAv,s|AV_VU|#####",
            "|;|||||||||:|||+||||||||",
            "|_{|l__aa|{№|l__RRRR=_G|",
            "|_{|l__aa||+|l_№____*№_|",
            "|№{|l____ll_|l_____c=_a|",
            "|_{|l___№___+__!___c=_a|",
            "|__+________|```cccc=_A|",
            "||||||||||||||||||||||||",
        },
        palettes = { "bunker", "full_bunker_items" },
        terrain = {
            ["№"] = "t_thconc_floor_olight",
            ["@"] = "t_red_carpet_olight",
            A = "t_carpet_red",
            b = "t_carpet_red",
            B = "t_carpet_red",
            C = "t_carpet_red",
            d = "t_carpet_red",
            D = "t_carpet_red",
            e = "t_carpet_red",
            E = "t_carpet_red",
            F = "t_carpet_red",
            f = "t_carpet_red",
            h = "t_carpet_red",
            L = "t_carpet_red",
            P = "t_carpet_red",
            T = "t_carpet_red",
            v = "t_carpet_red",
            w = "t_carpet_red",
            W = "t_carpet_red",
            Y = "t_carpet_red",
            ["&"] = "t_carpet_red",
            ["}"] = "t_carpet_red",
        },
        furniture = {
            ["`"] = "f_table",
            ["!"] = "f_chair",
            G = {
                { id = "f_portable_generator", copies = 25 },
                { id = "f_diesel_generator", copies = 5 },
                { id = "f_military_generator", copies = 5 },
                { id = "f_12000_gasoline_generator", copies = 5 },
            },
        },
        fill_terrain = "t_thconc_floor",
        nested_glyphs = {
            h = {
                choices = {
                    { id = "npc_bandit", weight = 25 },
                    { id = "npc_thug", weight = 25 },
                    { id = "null", weight = 50 },
                },
            },
            ["!"] = {
                choices = {
                    { id = "npc_bandit", weight = 25 },
                    { id = "npc_thug", weight = 25 },
                    { id = "null", weight = 50 },
                },
            },
            f = {
                choices = {
                    { id = "npc_bandit", weight = 38 },
                    { id = "npc_thug", weight = 38 },
                    { id = "null", weight = 25 },
                },
            },
        },
    },
}

-- LMOE shelter filled with angry NPCs. Has a working generator and light.
-- This particular 4-bed shelter is definitely homemade, mostly carved out of bare rock, and seems to be incomplete.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "lmoe_under_full",
    layout = {
        rows = {
            "########################",
            "########################",
            "##<<..=...^#############",
            "##...№*....^############",
            "##....=....^############",
            "##===###Y...^###########",
            "##G.R###-+|||####||||||#",
            "##a.l###A.|UUVVvv|{{{{|#",
            "##=*=###..|U...№.:..№.|#",
            "##c№.ll-.№|Uuuu.u||||||#",
            "##c....+..|||||+||Dh..d#",
            "##c.h..-r.+......+..№BB#",
            "##c.TTT-r.-r..h№.------#",
            "#######--+-r.hLh.+..№BB#",
            "#######-F.Sr..h..-Dh..d#",
            "#######-C№......-------#",
            "#######-CCKC.uu.+...hD-#",
            "#######-----.--+-}..№.-#",
            "#########W.~.-s№-}.BBS-#",
            "#########H.№.-&.-w.BBr-#",
            "#########l..A-Kt-------#",
            "#########--------#######",
            "########################",
            "########################",
        },
        palettes = { "bunker", "full_bunker_items" },
        terrain = { ["№"] = "t_rock_floor_olight" },
        furniture = {
            G = {
                { id = "f_portable_generator", copies = 25 },
                { id = "f_diesel_generator", copies = 5 },
                { id = "f_military_generator", copies = 5 },
                { id = "f_12000_gasoline_generator", copies = 5 },
            },
        },
        fill_terrain = "t_rock_floor",
        nested_glyphs = {
            h = {
                choices = {
                    { id = "npc_bandit", weight = 25 },
                    { id = "npc_thug", weight = 25 },
                    { id = "null", weight = 50 },
                },
            },
        },
    },
}
