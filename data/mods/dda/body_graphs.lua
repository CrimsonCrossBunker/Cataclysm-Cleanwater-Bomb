local content = require("ccb").content

local function register(options, parts, rows, fill_rows)
    local graph = content.BodyGraph(options)
    for _, part in ipairs(parts) do
        graph:part(part[1], part[2])
    end
    if rows then
        for index, row in ipairs(rows) do
            graph:row(row, fill_rows and fill_rows[index])
        end
    end
    content.add(graph)
end

register({ id = "arm_r", parent_body_part = "arm_r", fill_symbol = "#", fill_color = "white" }, {
    { "1", { sub_body_parts = { "arm_shoulder_r" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "arm_upper_r" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "arm_elbow_r" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "arm_lower_r" }, selected_color = "red" } },
}, {
    "                                        ",
    "                                 11111  ",
    "                              11111111  ",
    "                             111111111  ",
    "                             111111111  ",
    "                             211111111  ",
    "                            2222221111  ",
    "                            2222222211  ",
    "    444                    2222222222   ",
    "   444444                 2222222222    ",
    "    444444444            22222222222    ",
    "       444444444444     22222222222     ",
    "         4444444444444422222222222      ",
    "            444444444442222222222       ",
    "              444444443333322222        ",
    "                  444333333322          ",
    "                     3333333            ",
    "                        33              ",
    "                                        ",
    "                                        ",
})

register({ id = "arm_l", parent_body_part = "arm_l", fill_symbol = "#", fill_color = "white", mirror = "arm_r" }, {
    { "1", { sub_body_parts = { "arm_shoulder_l" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "arm_upper_l" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "arm_elbow_l" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "arm_lower_l" }, selected_color = "red" } },
})

register({ id = "foot_r", parent_body_part = "foot_r", fill_symbol = "#", fill_color = "white" }, {
    { "1", { sub_body_parts = { "foot_arch_r" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "foot_toes_r" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "foot_ankle_r" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "foot_heel_r" }, selected_color = "red" } },
    { "5", { sub_body_parts = { "foot_sole_r" }, selected_color = "red" } },
}, {
    "                                        ",
    "                                        ",
    "                                        ",
    " ############                           ",
    " ############                           ",
    " ############                           ",
    "  ###########3                          ",
    "  #######33333                          ",
    "  3333333333333                         ",
    "  33333333333333                        ",
    " 433333333333331111                     ",
    " 444333333333311111111                  ",
    "4444433333331111111111111111            ",
    "44444444444111111111111111111111        ",
    "5554444441111111111111111111111222222222",
    " 555555555555555555555555555555222222222",
    "               55555555555555555555555  ",
    "                                        ",
    "                                        ",
    "                                        ",
})

register({ id = "foot_l", parent_body_part = "foot_l", fill_symbol = "#", fill_color = "white", mirror = "foot_r" }, {
    { "1", { sub_body_parts = { "foot_arch_l" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "foot_toes_l" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "foot_ankle_l" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "foot_heel_l" }, selected_color = "red" } },
    { "5", { sub_body_parts = { "foot_sole_l" }, selected_color = "red" } },
})

register({ id = "full_body", fill_symbol = "#", fill_color = "white" }, {
    { "1", { body_parts = { "head" }, nested_graph = "head", selected_color = "red" } },
    { "2", { body_parts = { "torso" }, nested_graph = "torso", selected_color = "red" } },
    { "3", { body_parts = { "arm_r" }, nested_graph = "arm_r", selected_color = "red" } },
    { "4", { body_parts = { "hand_r" }, nested_graph = "hand_r", selected_color = "red" } },
    { "5", { body_parts = { "arm_l" }, nested_graph = "arm_l", selected_color = "red" } },
    { "6", { body_parts = { "hand_l" }, nested_graph = "hand_l", selected_color = "red" } },
    { "7", { body_parts = { "leg_r" }, nested_graph = "leg_r", selected_color = "red" } },
    { "8", { body_parts = { "foot_r" }, nested_graph = "foot_r", selected_color = "red" } },
    { "9", { body_parts = { "leg_l" }, nested_graph = "leg_l", selected_color = "red" } },
    { "0", { body_parts = { "foot_l" }, nested_graph = "foot_l", selected_color = "red" } },
}, {
    "                  111                   ",
    "                 11111                  ",
    "                  111                   ",
    "                 22222                  ",
    "              32222222225               ",
    "             3322222222255              ",
    "             33 2222222 55              ",
    "             33 2222222 55              ",
    "            33  2222222  55             ",
    "            3  777222999  5             ",
    "           44  7777 9999  66            ",
    "           44  7777 9999  66            ",
    "               7777 9999                ",
    "                77   99                 ",
    "               777   999                ",
    "               777   999                ",
    "                77   99                 ",
    "                77   99                 ",
    "                8     0                 ",
    "               88     00                ",
})

-- Only used to display coverage of armor in item info
register({ id = "full_body_iteminfo", fill_symbol = "#", fill_color = "dark_gray" }, {
    { "1", { sub_body_parts = { "eyes_right", "eyes_left" }, selected_color = "dark_gray" } },
    { "2", { sub_body_parts = { "mouth_lips", "mouth_chin" }, selected_color = "dark_gray" } },
    { "3", { sub_body_parts = { "mouth_nose" }, selected_color = "dark_gray" } },
    { "4", { sub_body_parts = { "mouth_cheeks" }, selected_color = "dark_gray" } },
    { "5", { sub_body_parts = { "head_forehead" }, selected_color = "dark_gray" } },
    { "6", { sub_body_parts = { "head_crown" }, selected_color = "dark_gray" } },
    { "7", { sub_body_parts = { "head_throat" }, selected_color = "dark_gray" } },
    { "8", { sub_body_parts = { "head_ear_r", "head_ear_l" }, selected_color = "dark_gray" } },
    { "9", { sub_body_parts = { "head_nape" }, selected_color = "dark_gray" } },
    { "0", { sub_body_parts = { "torso_neck" }, selected_color = "dark_gray" } },
    { "a", { sub_body_parts = { "torso_upper" }, selected_color = "dark_gray" } },
    { "b", { sub_body_parts = { "torso_lower" }, selected_color = "dark_gray" } },
    { "c", { sub_body_parts = { "torso_waist", "torso_lower" }, selected_color = "dark_gray" } },
    { "d", { sub_body_parts = { "arm_shoulder_r", "arm_shoulder_l" }, selected_color = "dark_gray" } },
    { "e", { sub_body_parts = { "arm_upper_r", "arm_upper_l" }, selected_color = "dark_gray" } },
    { "f", { sub_body_parts = { "arm_elbow_r", "arm_elbow_l" }, selected_color = "dark_gray" } },
    { "g", { sub_body_parts = { "arm_lower_r", "arm_lower_l" }, selected_color = "dark_gray" } },
    { "h", { sub_body_parts = { "hand_wrist_r", "hand_wrist_l" }, selected_color = "dark_gray" } },
    { "i", { sub_body_parts = { "hand_palm_r", "hand_palm_l" }, selected_color = "dark_gray" } },
    { "j", { sub_body_parts = { "hand_back_r", "hand_back_l" }, selected_color = "dark_gray" } },
    { "k", { sub_body_parts = { "hand_fingers_r", "hand_fingers_l" }, selected_color = "dark_gray" } },
    { "l", { sub_body_parts = { "leg_hip_r", "leg_hip_l" }, selected_color = "dark_gray" } },
    { "m", { sub_body_parts = { "leg_upper_r", "leg_upper_l" }, selected_color = "dark_gray" } },
    { "n", { sub_body_parts = { "leg_knee_r", "leg_knee_l" }, selected_color = "dark_gray" } },
    { "o", { sub_body_parts = { "leg_lower_r", "leg_lower_l" }, selected_color = "dark_gray" } },
    { "p", { sub_body_parts = { "foot_ankle_r", "foot_ankle_l" }, selected_color = "dark_gray" } },
    { "q", { sub_body_parts = { "foot_arch_r", "foot_arch_l" }, selected_color = "dark_gray" } },
    { "r", { sub_body_parts = { "foot_toes_r", "foot_toes_l" }, selected_color = "dark_gray" } },
    { "s", { sub_body_parts = { "foot_heel_r", "foot_heel_l" }, selected_color = "dark_gray" } },
}, {
    "                66                      ",
    "               655           lllll      ",
    "               813           lllll      ",
    "               842          mmmmmm      ",
    "                97          mmmmmm      ",
    "              a000          mmmmm       ",
    "           ddaaaaa          mmmmm       ",
    "          dddaaaaa         mmmmm        ",
    "          eeeaaaaa         nnnmm        ",
    "         eeeeaaaaa         nnnn         ",
    "         eee aaaaa         nnnoo        ",
    "        eee   bbbb          oooo        ",
    "        fff   bbbb          ooo         ",
    "       ggg    bbbb          ooo         ",
    "       ggg   ccccc          oo          ",
    "       gg   llllll          pp          ",
    "       h    llllll         qqs          ",
    "      ji    llllll        qqqs          ",
    "      jik   mmmmmm       rrrr           ",
    "      kk    mmmmm                       ",
})

-- Only used for displaying as a widget in the sidebar.  Not to be included with other bodygraphs.
-- Note: The code assumes the graph is at most 15x13 (WxH)
register({ id = "full_body_widget", fill_symbol = "#", fill_color = "white" }, {
    { "e", { body_parts = { "eyes" }, selected_color = "white" } },
    { "m", { body_parts = { "mouth" }, selected_color = "white" } },
    { "1", { body_parts = { "head" }, selected_color = "white" } },
    { "2", { body_parts = { "torso" }, selected_color = "white" } },
    { "3", { body_parts = { "arm_r" }, selected_color = "white" } },
    { "4", { body_parts = { "hand_r" }, selected_color = "white" } },
    { "5", { body_parts = { "arm_l" }, selected_color = "white" } },
    { "6", { body_parts = { "hand_l" }, selected_color = "white" } },
    { "7", { body_parts = { "leg_r" }, selected_color = "white" } },
    { "8", { body_parts = { "foot_r" }, selected_color = "white" } },
    { "9", { body_parts = { "leg_l" }, selected_color = "white" } },
    { "0", { body_parts = { "foot_l" }, selected_color = "white" } },
}, {
    "     1e1                                ",
    "     1m1                                ",
    "    22222                               ",
    "  322222225                             ",
    "  332222255                             ",
    " 33 22222 55                            ",
    " 3  22222  5                            ",
    "4  7772999  6                           ",
    "   777 999                              ",
    "   777 999                              ",
    "    77 99                               ",
    "    77 99                               ",
    "     8 0                                ",
    "                                        ",
    "                                        ",
    "                                        ",
    "                                        ",
    "                                        ",
    "                                        ",
    "                                        ",
})

-- Only used for displaying as a widget in the sidebar.  Not to be included with other bodygraphs.
-- Note: The code assumes the graph is at most 15x13 (WxH)
register({ id = "compact_full_body_widget", fill_symbol = "#", fill_color = "white" }, {
    { "e", { body_parts = { "eyes" }, selected_color = "white" } },
    { "m", { body_parts = { "mouth" }, selected_color = "white" } },
    { "1", { body_parts = { "head" }, selected_color = "white" } },
    { "2", { body_parts = { "torso" }, selected_color = "white" } },
    { "3", { body_parts = { "arm_r" }, selected_color = "white" } },
    { "4", { body_parts = { "hand_r" }, selected_color = "white" } },
    { "5", { body_parts = { "arm_l" }, selected_color = "white" } },
    { "6", { body_parts = { "hand_l" }, selected_color = "white" } },
    { "7", { body_parts = { "leg_r" }, selected_color = "white" } },
    { "8", { body_parts = { "foot_r" }, selected_color = "white" } },
    { "9", { body_parts = { "leg_l" }, selected_color = "white" } },
    { "0", { body_parts = { "foot_l" }, selected_color = "white" } },
}, {
    "   1e1                                  ",
    "   1m1                                  ",
    "  32225                                 ",
    " 3 222 5                                ",
    "4  729  6                               ",
    "   7 9                                  ",
    "  88 00                                 ",
})

-- Only used for displaying as a widget in the sidebar.  Not to be included with other bodygraphs.
-- Note: The code assumes the graph is at most 15x13 (WxH)
local tiny_parts = {
    { "e", { body_parts = { "eyes" }, selected_color = "white" } },
    { "m", { body_parts = { "mouth" }, selected_color = "white" } },
    { "1", { body_parts = { "head" }, selected_color = "white" } },
    { "2", { body_parts = { "torso" }, selected_color = "white" } },
    { "3", { body_parts = { "arm_r" }, selected_color = "white" } },
    { "4", { body_parts = { "hand_r" }, selected_color = "white" } },
    { "5", { body_parts = { "arm_l" }, selected_color = "white" } },
    { "6", { body_parts = { "hand_l" }, selected_color = "white" } },
    { "7", { body_parts = { "leg_r" }, selected_color = "white" } },
    { "8", { body_parts = { "foot_r" }, selected_color = "white" } },
    { "9", { body_parts = { "leg_l" }, selected_color = "white" } },
    { "0", { body_parts = { "foot_l" }, selected_color = "white" } },
}

local function register_tiny(id, rows, fill_rows)
    register({ id = id, fill_symbol = " ", fill_color = "white", label_fill = "∀" }, tiny_parts, rows, fill_rows)
end

register_tiny("tiny_full_body_widget", {
    "1eme1                                   ",
    "43256                                   ",
    "87 90                                   ",
}, {
    "(⁰⎼⁰)                                   ",
    "₀/∀\\₀                                   ",
    "_╱ ╲_                                   ",
})

-- Only used for displaying as a widget in the sidebar.  Not to be included with other bodygraphs.
-- Note: The code assumes the graph is at most 15x13 (WxH)
register_tiny("tiny_full_body_side_widget", {
    " 1em                                    ",
    "43256                                   ",
    "87 90                                   ",
}, {
    " (⁰◀                                    ",
    "₀/∀\\₀                                   ",
    "_╱ ╲_                                   ",
})

register({ id = "hand_r", parent_body_part = "hand_r", fill_symbol = "#", fill_color = "white" }, {
    { "1", { sub_body_parts = { "hand_wrist_r" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "hand_palm_r" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "hand_back_r" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "hand_fingers_r" }, selected_color = "red" } },
}, {
    "            44      44                  ",
    "            444     44                  ",
    "      44     44     44                  ",
    "       44    444    44                  ",
    "        44    44    44                  ",
    "         44   444   44                  ",
    "444       44   44   444                 ",
    "  444      444222222222                 ",
    "    4444   4222222222222            444 ",
    "      4444222222222222222         444444",
    "         422222222222222222     4444    ",
    "          222222222222222222224444      ",
    "           2222222222222222222244       ",
    "            2222222222222222222         ",
    "            222222222222222222          ",
    "             222222222222222            ",
    "              111111111111              ",
    "             111111111111               ",
    "             111111111111               ",
    "            111111111111                ",
})

register({ id = "hand_l", parent_body_part = "hand_l", fill_symbol = "#", fill_color = "white", mirror = "hand_r" }, {
    { "1", { sub_body_parts = { "hand_wrist_l" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "hand_palm_l" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "hand_back_l" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "hand_fingers_l" }, selected_color = "red" } },
})

register({ id = "head", parent_body_part = "head", fill_symbol = "#", fill_color = "white" }, {
    { "1", { sub_body_parts = { "eyes_right" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "eyes_left" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "mouth_lips" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "mouth_nose" }, selected_color = "red" } },
    { "5", { sub_body_parts = { "mouth_cheeks" }, selected_color = "red" } },
    { "6", { sub_body_parts = { "head_forehead" }, selected_color = "red" } },
    { "7", { sub_body_parts = { "head_crown" }, selected_color = "red" } },
    { "8", { sub_body_parts = { "head_throat" }, selected_color = "red" } },
    { "9", { sub_body_parts = { "head_ear_r" }, selected_color = "red" } },
    { "0", { sub_body_parts = { "head_ear_l" }, selected_color = "red" } },
    { "a", { sub_body_parts = { "mouth_chin" }, selected_color = "red" } },
    { "b", { sub_body_parts = { "head_nape" }, selected_color = "red" } },
}, {
    "             7777777777777              ",
    "          7777777777777777777           ",
    "         777777777777777777777          ",
    "        66666666666666666666666         ",
    "        66666666666666666666666         ",
    "        66666666666666666666666         ",
    "      9 99666666666666666666600 0       ",
    "      999991111114444422222200000       ",
    "      999911111114444422222220000       ",
    "      999955555555444555555550000       ",
    "       9955555555544455555555500        ",
    "        95555555544444555555550         ",
    "         555555533333335555555          ",
    "          5555533333333355555           ",
    "           aaaaaaa333aaaaaaa            ",
    "            aaaaaaaaaaaaaaa             ",
    "            b aaaaaaaaaaa b             ",
    "         bb88888 aaaaa 88888bb          ",
    "       bbb88888888   88888888bbb        ",
    "           b888888888888888b            ",
})

register({ id = "leg_r", parent_body_part = "leg_r", fill_symbol = "#", fill_color = "white" }, {
    { "1", { sub_body_parts = { "leg_hip_r" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "leg_upper_r" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "leg_knee_r" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "leg_lower_r" }, selected_color = "red" } },
}, {
    "        111111                          ",
    "       11111111222                      ",
    "       111111222222222                  ",
    "       111222222222222222               ",
    "        22222222222222222222            ",
    "          2222222222222222223333        ",
    "               22222222222223333        ",
    "                      2222223333        ",
    "                         444433         ",
    "                        4444444         ",
    "                        4444444         ",
    "                        4444444         ",
    "                        444444          ",
    "                         44444          ",
    "                         4444           ",
    "                         4444           ",
    "                          444           ",
    "                          444           ",
    "                          ####          ",
    "                          ######        ",
})

register({ id = "leg_l", parent_body_part = "leg_l", fill_symbol = "#", fill_color = "white", mirror = "leg_r" }, {
    { "1", { sub_body_parts = { "leg_hip_l" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "leg_upper_l" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "leg_knee_l" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "leg_lower_l" }, selected_color = "red" } },
})

register({ id = "torso", parent_body_part = "torso", fill_symbol = "#", fill_color = "white" }, {
    { "1", { sub_body_parts = { "torso_upper" }, selected_color = "red" } },
    { "2", { sub_body_parts = { "torso_neck" }, selected_color = "red" } },
    { "3", { sub_body_parts = { "torso_lower" }, selected_color = "red" } },
    { "4", { sub_body_parts = { "torso_hanging_front" }, selected_color = "red" } },
    { "5", { sub_body_parts = { "torso_hanging_back" }, selected_color = "red" } },
    { "6", { sub_body_parts = { "torso_waist" }, selected_color = "red" } },
}, {
    "                                        ",
    "          2###2               ####2     ",
    "         #2###2#               222##    ",
    "    ##1111#222#1111##       2 21##1111  ",
    "  ###111111111111111###   22 11####111 5",
    " ####111111111111111####  4 111####111 5",
    "     111111111111111      4 1111111111 5",
    "      1111111111111       4 1111111111 5",
    "      1111111111111       44 11111111 55",
    "      1111111111111       44 11111111 55",
    "      1133333333311       44 11111111 55",
    "      3333333333333       44 33333333 55",
    "      3333333333333       44 33333333 55",
    "     666666666666666         66666666   ",
    "     333333333333333         ##33333##  ",
    "    ######33333######       ##########  ",
    "    #################       ##########  ",
    "    ######## ########       #########   ",
    "    #######   #######        #######    ",
    "                                        ",
})
