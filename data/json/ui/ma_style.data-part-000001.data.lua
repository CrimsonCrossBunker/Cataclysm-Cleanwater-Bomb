local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates

ccb.content.define_widget {
    id = "ma_buff_indicator_template",
    style = "clause",
    clauses = {
        {
            -- Sōjutsu   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_sojutsu_static"),
            id = "buff_sojutsu_static",
            text = ccb.content.text("Sōjutsu Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_sojutsu_onmove"),
            id = "buff_sojutsu_onmove",
            text = ccb.content.text("Superior Positioning"),
        },
        {
            -- Bōjutsu   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_bojutsu_static"),
            id = "buff_bojutsu_static",
            text = ccb.content.text("Bōjutsu Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_bojutsu_static2"),
            id = "buff_bojutsu_static2",
            text = ccb.content.text("Skilled Striking"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_bojutsu_onmove"),
            id = "buff_bojutsu_onmove",
            text = ccb.content.text("Rolling Staff"),
        },
        {
            -- Muay Thai   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_muay_thai_static"),
            id = "buff_muay_thai_static",
            text = ccb.content.text("Muay Thai Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_muay_thai_ongethit"),
            id = "buff_muay_thai_ongethit",
            text = ccb.content.text("Determination"),
        },
        {
            -- Ninjutsu   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_ninjutsu_static1"),
            id = "buff_sojutsu_static",
            text = ccb.content.text("Ninjutsu Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_ninjutsu_static2"),
            id = "buff_sojutsu_static",
            text = ccb.content.text("Sneak Attack"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_ninjutsu_onattack"),
            id = "buff_ninjutsu_onattack",
            text = ccb.content.text("Loss of Surprise"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_ninjutsu_onmove"),
            id = "buff_ninjutsu_onmove",
            text = ccb.content.text("Momentum Shift"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_ninjutsu_onkill"),
            id = "buff_ninjutsu_onkill",
            text = ccb.content.text("Escape Plan"),
        },
        {
            -- Niten Ichi-Ryu   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_niten_static"),
            id = "buff_niten_static",
            text = ccb.content.text("Niten Ichi-Ryu Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_niten_onmove"),
            id = "buff_niten_onmove",
            text = ccb.content.text("Waning Moon"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_niten_onattack"),
            id = "buff_niten_onattack",
            text = ccb.content.text("Falling Leaf"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_niten_ondodge"),
            id = "buff_niten_ondodge",
            text = ccb.content.text("Moonlight"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_niten_onpause"),
            id = "buff_niten_onpause",
            text = ccb.content.text("Stillness"),
        },
        {
            -- Aikido   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_aikido_static1"),
            id = "buff_aikido_static1",
            text = ccb.content.text("Aikido Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_aikido_static2"),
            id = "buff_aikido_static2",
            text = ccb.content.text("Intermediate Aikido"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_aikido_static3"),
            id = "buff_aikido_static3",
            text = ccb.content.text("Advanced Aikido"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_aikido_onblock"),
            id = "buff_aikido_onblock",
            text = ccb.content.text("Fluid Blocking"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_aikido_ondodge"),
            id = "buff_aikido_ondodge",
            text = ccb.content.text("Fluid Dodging"),
        },
        {
            -- Brawling   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_brawling_block"),
            id = "buff_brawling_block",
            text = ccb.content.text("Enhanced Blocking"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_brawling_onpause"),
            id = "buff_brawling_onpause",
            text = ccb.content.text("Preparation to Hit"),
        },
        {
            -- Barbaran Montante   ----------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_barbaran_static"),
            id = "buff_barbaran_static",
            text = ccb.content.text("Barbaran Represa"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_barbaran_onblock"),
            id = "buff_barbaran_onblock",
            text = ccb.content.text("Reversing Destreza"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_barbaran_onkill"),
            id = "buff_barbaran_onkill",
            text = ccb.content.text("Movimiento Natural"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_barbaran_onmove"),
            id = "buff_barbaran_onmove",
            text = ccb.content.text("Ricasso Step"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_barbaran_onpause"),
            id = "buff_barbaran_onpause",
            text = ccb.content.text("Vulgar Preparation"),
        },
        {
            -- Boxing   ------------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_boxing_static"),
            id = "buff_boxing_static",
            text = ccb.content.text("Boxing Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_boxing_onmove"),
            id = "buff_boxing_onmove",
            text = ccb.content.text("Footwork"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_boxing_ondodge"),
            id = "buff_boxing_ondodge",
            text = ccb.content.text("Counter Chance"),
        },
        {
            -- Zui Quan   --------------- 10 -----------------------
            when = predicate.has_effect("speaker", "mabuff:buff_zuiquan_static"),
            id = "buff_zuiquan_static",
            text = ccb.content.text("Zui Quan Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_zuiquan_onmove"),
            id = "buff_zuiquan_onmove",
            text = ccb.content.text("Drunken Stumble"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_zuiquan_ondodge"),
            id = "buff_zuiquan_ondodge",
            text = ccb.content.text("Drunken Dodging"),
        },
        {
            -- Eskrima   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_eskrima_static"),
            id = "buff_eskrima_static",
            text = ccb.content.text("Eskrima Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_eskrima_oncrit"),
            id = "buff_eskrima_oncrit",
            text = ccb.content.text("Eskrima Combination"),
        },
        {
            -- Fencing   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_fencing_static"),
            id = "buff_fencing_static",
            text = ccb.content.text("Fencing Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_fencing_onblock"),
            id = "buff_fencing_onblock",
            text = ccb.content.text("Parry"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_fencing_onmiss"),
            id = "buff_fencing_onmiss",
            text = ccb.content.text("Remise"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_fencing_onpause"),
            id = "buff_fencing_onpause",
            text = ccb.content.text("Counter Time"),
        },
        {
            -- Fior Di Battaglia   ----------------- 20 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_medievalpole_static"),
            id = "buff_medievalpole_static",
            text = ccb.content.text("Stand Your Ground"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_medievalpole_onmove"),
            id = "buff_medievalpole_onmove",
            text = ccb.content.text("Tactical Retreat"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_medievalpole_onmiss"),
            id = "buff_medievalpole_onmiss",
            text = ccb.content.text("Tactical Feinting"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_medievalpole_onblock"),
            id = "buff_medievalpole_onblock",
            text = ccb.content.text("Defense Break"),
        },
        {
            -- Judo   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_judo_static"),
            id = "buff_judo_static",
            text = ccb.content.text("Judo Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_judo_ondodge"),
            id = "buff_judo_ondodge",
            text = ccb.content.text("Perfect Position"),
        },
        {
            -- Karate   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_karate_static"),
            id = "buff_karate_static",
            text = ccb.content.text("Karate Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_karate_onhit"),
            id = "buff_karate_onhit",
            text = ccb.content.text("Karate Kata"),
        },
        {
            -- Krav Maga   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_krav_maga_static"),
            id = "buff_krav_maga_static",
            text = ccb.content.text("Krav Maga Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_krav_maga_onblock"),
            id = "buff_krav_maga_onblock",
            text = ccb.content.text("Strike Vitals"),
        },
        {
            -- Medieval Swordsmanship   ------------- 20 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_swordsmanship_static"),
            id = "buff_swordsmanship_static",
            text = ccb.content.text("Swordsman's Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_swordsmanship_onblock"),
            id = "buff_swordsmanship_onblock",
            text = ccb.content.text("Mastercut"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_swordsmanship_onhit"),
            id = "buff_swordsmanship_onhit",
            text = ccb.content.text("Conserve Momentum"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_swordsmanship_onpause"),
            id = "buff_swordsmanship_onpause",
            text = ccb.content.text("Half Swording"),
        },
        {
            -- Capoeira   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_capoeira_static"),
            id = "buff_capoeira_static",
            text = ccb.content.text("Capoeira Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_capoeira_onmiss"),
            id = "buff_capoeira_onmiss",
            text = ccb.content.text("Capoeira Tempo"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_capoeira_onmove"),
            id = "buff_capoeira_onmove",
            text = ccb.content.text("Capoeira Momentum"),
        },
        {
            -- Pankration   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_pankration_ondodge"),
            id = "buff_pankration_ondodge",
            text = ccb.content.text("Counter Chance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_pankration_oncrit"),
            id = "buff_pankration_oncrit",
            text = ccb.content.text("Close Combat"),
        },
        {
            -- Silat   -------------------- 20 -------------------
            when = predicate.has_effect("speaker", "mabuff:buff_silat_static"),
            id = "buff_silat_static",
            text = ccb.content.text("Silat Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_silat_ondodge"),
            id = "buff_silat_ondodge",
            text = ccb.content.text("Silat Appraisal"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_silat_onmove"),
            id = "buff_silat_onmove",
            text = ccb.content.text("Silat Ambush"),
        },
        {
            -- Taekwondo   ---------------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_taekwondo_static"),
            id = "buff_taekwondo_static",
            text = ccb.content.text("Taekwondo Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_taekwondo_static2"),
            id = "buff_taekwondo_static2",
            text = ccb.content.text("Unhindered"),
        },
        {
            -- Tai Chi   ---------------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_tai_chi_static"),
            id = "buff_tai_chi_static",
            text = ccb.content.text("Tai Chi Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_tai_chi_onblock"),
            id = "buff_tai_chi_onblock",
            text = ccb.content.text("Repulse the Monkey"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_tai_chi_onpause"),
            id = "buff_tai_chi_onpause",
            text = ccb.content.text("Cross Hands"),
        },
        {
            -- Crane Kung Fu   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_crane_static1"),
            id = "buff_crane_static1",
            text = ccb.content.text("Crane's Precision"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_crane_static2"),
            id = "buff_crane_static2",
            text = ccb.content.text("Crane's Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_crane_static3"),
            id = "buff_crane_static3",
            text = ccb.content.text("Crane's Grace"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_crane_ondodge"),
            id = "buff_crane_ondodge",
            text = ccb.content.text("Crane's Flight"),
        },
        {
            -- Dragon Kung Fu   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_dragon_static"),
            id = "buff_dragon_static",
            text = ccb.content.text("Dragon's Knowledge"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_dragon_onblock"),
            id = "buff_dragon_onblock",
            text = ccb.content.text("Dragon's Vortex"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_dragon_ondodge"),
            id = "buff_dragon_ondodge",
            text = ccb.content.text("Dragon Wing"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_dragon_onpause"),
            id = "buff_dragon_onpause",
            text = ccb.content.text("Dragon Power"),
        },
        {
            -- Leopard Kung Fu   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_leopard_static1"),
            id = "buff_leopard_static1",
            text = ccb.content.text("Leopard's Strategy"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_leopard_static2"),
            id = "buff_leopard_static2",
            text = ccb.content.text("Leopard's Ambush"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_leopard_oncrit"),
            id = "buff_leopard_oncrit",
            text = ccb.content.text("Leopard's Agility"),
        },
        {
            -- Snake Kung Fu   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_snake_static"),
            id = "buff_snake_static",
            text = ccb.content.text("Snake's Sight"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_snake_onhit"),
            id = "buff_snake_onhit",
            text = ccb.content.text("Snake Bite"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_snake_oncrit"),
            id = "buff_snake_oncrit",
            text = ccb.content.text("Snake Fang"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_snake_onpause"),
            id = "buff_snake_onpause",
            text = ccb.content.text("Snake's Coil"),
        },
        {
            -- Tiger Kung Fu   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_tiger_static"),
            id = "buff_tiger_static",
            text = "",
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_tiger_onhit"),
            id = "buff_tiger_onhit",
            text = ccb.content.text("Tiger Fury"),
        },
        {
            -- Wing Chun   -------------- 30 ---------------------
            when = predicate.has_effect("speaker", "mabuff:buff_wingchun_static"),
            id = "buff_wingchun_static",
            text = ccb.content.text("Chi-Sao Sensitivity"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_wingchun_onhit"),
            id = "buff_wingchun_onhit",
            text = ccb.content.text("Chain Punch"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_wingchun_onpause"),
            id = "buff_wingchun_onpause",
            text = ccb.content.text("Biu Ji"),
        },
        {
            -- Bionic Combatives   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_biojutsu_static"),
            id = "buff_biojutsu_static",
            text = ccb.content.text("Biojutsu Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_biojutsu_onblock"),
            id = "buff_biojutsu_onblock",
            text = ccb.content.text("Binary Hardening"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_biojutsu_onkill"),
            id = "buff_biojutsu_onkill",
            text = ccb.content.text("Optimization"),
        },
        {
            -- Centipede Kung Fu   -------------- 30 ----------------
            when = predicate.has_effect("speaker", "mabuff:buff_centipede_onhit"),
            id = "buff_centipede_onhit",
            text = ccb.content.text("Centipede's Frenzy"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_centipede_oncrit"),
            id = "buff_centipede_oncrit",
            text = ccb.content.text("Centipede's Venom"),
        },
        {
            -- Lizard Kung Fu   -------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_lizard_static1"),
            id = "buff_lizard_static1",
            text = ccb.content.text("Lizard's Cunning"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_lizard_static2"),
            id = "buff_lizard_static2",
            text = ccb.content.text("Lizard's Haven"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_lizard_onmove"),
            id = "buff_lizard_onmove",
            text = ccb.content.text("Lizard's Leap"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_lizard_onpause1"),
            id = "buff_lizard_onpause1",
            text = ccb.content.text("Lizard's Perch"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_lizard_onpause2"),
            id = "buff_lizard_onpause2",
            text = ccb.content.text("Lizard's Venom"),
        },
        {
            -- Scorpion Kung Fu   -------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_scorpion_static"),
            id = "buff_scorpion_static",
            text = ccb.content.text("Scorpion's Venom"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_scorpion_onattack"),
            id = "buff_scorpion_onattack",
            text = ccb.content.text("Scorpion's Intimidation"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_scorpion_onmove"),
            id = "buff_scorpion_onmove",
            text = ccb.content.text("Scorpion's Charge"),
        },
        {
            -- Toad Kung Fu   -------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_toad_static"),
            id = "buff_toad_static",
            text = ccb.content.text("Toad's Iron Skin"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_toad_onmove"),
            id = "buff_toad_onmove",
            text = ccb.content.text("Iron Skin Dissipation"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_toad_onpause"),
            id = "buff_toad_onpause",
            text = ccb.content.text("Toad's Meditation"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_toad_ongethit"),
            id = "buff_toad_ongethit",
            text = ccb.content.text("Toad's Venom"),
        },
        {
            -- Viper Kung Fu   -------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_venom_snake_static"),
            id = "buff_venom_snake_static",
            text = ccb.content.text("Viper's Patience"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_venom_snake_oncrit"),
            id = "buff_venom_snake_oncrit",
            text = ccb.content.text("Viper's Venom"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:buff_venom_snake_onhit"),
            id = "buff_venom_snake_onhit",
            text = ccb.content.text("Viper's Rattle"),
        },
        {
            -- Kickboxing   -------------------------------------
            when = predicate.has_effect("speaker", "mabuff:buff_kickboxing_stance_static"),
            id = "buff_kickboxing_stance_static",
            text = ccb.content.text("Kick stance"),
        },
        {
            -- Desert Wind   ------------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_desert_wind_ondodge"),
            id = "buff_desert_wind_ondodge",
            text = ccb.content.text("Zephyr Dance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_desert_wind_onmove"),
            id = "buff_desert_wind_onmove",
            text = ccb.content.text("Wind Stride"),
        },
        {
            -- Diamond Mind   -----------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_diamond_mind_static"),
            id = "buff_diamond_mind_static",
            text = ccb.content.text("Stance of Alacrity"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_diamond_mind_ondodge"),
            id = "buff_diamond_mind_ondodge",
            text = ccb.content.text("Pearl of Black Doubt"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_diamond_mind_ongethit"),
            id = "buff_diamond_mind_ongethit",
            text = ccb.content.text("Mind over Body"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_diamond_mind_onpause"),
            id = "buff_diamond_mind_onpause",
            text = ccb.content.text("Quicksilver Motion"),
        },
        {
            -- Hylian Swordsmanship   ---------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_static1"),
            id = "buff_hylian_static1",
            text = ccb.content.text("Combat Acrobat"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_static2"),
            id = "buff_hylian_static2",
            text = ccb.content.text("Intermediate Combat Acrobat"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_static3"),
            id = "buff_hylian_static3",
            text = ccb.content.text("Master Combat Acrobat"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_spin"),
            id = "buff_hylian_spin",
            text = ccb.content.text("Spinning"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_ondodge"),
            id = "buff_hylian_ondodge",
            text = ccb.content.text("Flurry Rush"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_onmove"),
            id = "buff_hylian_onmove",
            text = ccb.content.text("Dash Attack"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_onpause"),
            id = "buff_hylian_onpause",
            text = ccb.content.text("Charge Up"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_hylian_onpause_2"),
            id = "buff_hylian_onpause_2",
            text = ccb.content.text("Greater Charge Up"),
        },
        {
            -- Panzer Kunst   -----------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_panzer_ondodge"),
            id = "buff_panzer_kunst_ondodge",
            text = ccb.content.text("Einzug Rüstungen"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_panzer_static1"),
            id = "buff_panzer_kunst_static1",
            text = ccb.content.text("Schatten Folgen"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_panzer_static2"),
            id = "buff_panzer_kunst_static2",
            text = ccb.content.text("Seinerweisen"),
        },
        {
            -- Pokken   -----------------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_pokken_oncrit"),
            id = "buff_pokken_oncrit",
            text = ccb.content.text("Sniper"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_pokken_ongethit"),
            id = "buff_pokken_ongethit",
            text = ccb.content.text("Stamina"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_pokken_onkill"),
            id = "buff_pokken_onkill",
            text = ccb.content.text("Moxie"),
        },
        {
            -- Setting Sun   ------------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_setting_sun_onblock"),
            id = "buff_setting_sun_onblock",
            text = ccb.content.text("Fool's Strike"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_setting_sun_ondodge"),
            id = "buff_setting_sun_ondodge",
            text = ccb.content.text("Feigned Opening"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_setting_sun_onpause"),
            id = "buff_setting_sun_onpause",
            text = ccb.content.text("Baffling Defense"),
        },
        {
            -- Shii-Cho   ---------------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_shii_cho_static1"),
            id = "buff_shii_cho_static1",
            text = ccb.content.text("Determination"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_shii_cho_static2"),
            id = "buff_shii_cho_static2",
            text = ccb.content.text("Apprentice Training"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_shii_cho_static3"),
            id = "buff_shii_cho_static3",
            text = ccb.content.text("Knight Training"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_shii_cho_static4"),
            id = "buff_shii_cho_static4",
            text = ccb.content.text("Master Training"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_shii_cho_onblock"),
            id = "buff_shii_cho_onblock",
            text = ccb.content.text("Flowing Water"),
        },
        {
            -- Stone Dragon   -----------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_stone_dragon_static"),
            id = "buff_stone_dragon_static",
            text = ccb.content.text("Stonefoot Stance"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_stone_dragon_oncrit"),
            id = "buff_stone_dragon_oncrit",
            text = ccb.content.text("Iron Bones"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_stone_dragon_onhit"),
            id = "buff_stone_dragon_onhit",
            text = ccb.content.text("Stone Bones"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_stone_dragon_onmove1"),
            id = "buff_stone_dragon_onmove1",
            text = ccb.content.text("Cracked Stone"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_stone_dragon_onmove2"),
            id = "buff_stone_dragon_onmove2",
            text = ccb.content.text("Shattered Stone"),
        },
        {
            -- Tiger Claw   -------------------------------------
            when = predicate.has_effect("speaker", "mabuff:mma_buff_tiger_claw_static"),
            id = "buff_tiger_claw_static",
            text = ccb.content.text("Improved Critical"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_tiger_claw_oncrit"),
            id = "buff_tiger_claw_oncrit",
            text = ccb.content.text("Blood In The Water"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_tiger_claw_ongethit"),
            id = "buff_tiger_claw_ongethit",
            text = ccb.content.text("Cornered Predator"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_tiger_claw_onkill"),
            id = "buff_tiger_claw_onkill",
            text = ccb.content.text("Prey on the Weak"),
        },
        {
            when = predicate.has_effect("speaker", "mabuff:mma_buff_tiger_claw_onmove"),
            id = "buff_tiger_claw_onmove",
            text = ccb.content.text("Pouncing Charge"),
        },
    },
    default_clause = { text = "---" },
}
