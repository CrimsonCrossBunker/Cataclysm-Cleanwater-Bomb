local ccb = require("ccb")
local content = ccb.content

do
    -- 最基础的入门功法：教人引气入体、吐纳打坐。用 learn_spell use_action 授予 immortal_path_meditate spell，是玩家踏上修炼的唯一入口（开局不再默认会打坐）。残卷=不完整传承，故只授予入门吐纳。译名查 GLOSSARY：功法=cultivation technique、吐纳=qi breathing、残卷=scroll。/ The most basic entry method: teaches drawing qi into the body and meditation. Grants the meditate spell via learn_spell — the player's only way onto the cultivation path (no one starts able to meditate). A 'scroll' = partial transmission, so it only grants the entry breathing art.
    -- A tattered scroll of cultivation art, recording the entry method of drawing qi into the body and nourishing it through breathing. Study it to sit in meditation and gather the qi of heaven and earth.
    -- Qi-Breathing Method (scroll)
    -- copies of the Qi-Breathing Method (scroll)
    local book = content.Item {
        id = "immortal_path_manual_breathing",
        category = "manuals",
        name = ccb.content.plural_text("吐纳引气诀（残卷）", "吐纳引气诀（残卷）"),
        description = ccb.content.text("一卷残破的修炼功法，记载着引气入体、吐纳温养的入门法门。研读之后，便可盘膝打坐、纳天地灵气入体。"),
        mass_milligrams = 120000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 500,
        looks_like = "cookbook",
        symbol = "?",
        color = "yellow",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 木行练气期功法（完整传承，非残卷）。learn_spell 授予养荣导引；学会后由 EOC_immortal_path_bind_art_traits 授予载体特性「草木同春」。练气期上限功法,无更高法术/秘术。/ Wood-phase Qi-Refining technique (complete, not a scroll). Grants the breathing art; the carrier trait follows.
    -- A complete Wood-phase cultivation manual, its cover wound with green vine, its pages carrying a faint green freshness. Its breathing method draws the living qi of Wood into the body, keeping the meridians evergreen. A Qi-Refining technique.
    -- Sutra of Verdant Flourishing
    -- copies of the Sutra of Verdant Flourishing
    local book = content.Item {
        id = "immortal_path_manual_evergreen",
        category = "manuals",
        name = ccb.content.plural_text("葳蕤经", "葳蕤经"),
        description = ccb.content.text("一部完整的木行修炼功法，封皮以青藤缠绕，纸页似有草木清气。所载养荣导引引木行生气入体，使经脉常青、生机不绝。乃练气期之法。"),
        mass_milligrams = 340000,
        volume_ml = 500,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "green",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate_evergreen" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 火行练气期功法。learn_spell 授予炼焰息；学会后授载体特性「阳炎附骨」。/ Fire-phase Qi-Refining technique.
    -- A Fire-phase manual, its pages scorched amber and warm to the touch. Its breathing method takes the blazing qi of Fire into the dantian, lending the body yang force and harder melee. A Qi-Refining technique.
    -- Blazing Sun Transmission
    -- copies of the Blazing Sun Transmission
    local book = content.Item {
        id = "immortal_path_manual_blazing_sun",
        category = "manuals",
        name = ccb.content.plural_text("炎阳真传", "炎阳真传"),
        description = ccb.content.text("一部火行修炼功法，纸页泛着焦黄，触手微温。所载炼焰息纳火行炎气入丹田，体魄染炎上之力，近战更具威势。乃练气期之法。"),
        mass_milligrams = 340000,
        volume_ml = 500,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate_blazing_sun" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 土行练气期功法。learn_spell 授予镇岳吐纳；学会后授载体特性「不动如山」。/ Earth-phase Qi-Refining technique.
    -- An Earth-phase manual, its cover heavy as a stone slab, weighty in the hand. Its breathing method sinks the breath into the ground, making the body solid as a mountain. A Qi-Refining technique.
    -- The Bedrock Chapter
    -- copies of the Bedrock Chapter
    local book = content.Item {
        id = "immortal_path_manual_deep_earth",
        category = "manuals",
        name = ccb.content.plural_text("磐石篇", "磐石篇"),
        description = ccb.content.text("一部土行修炼功法，封皮厚重如石板，入手沉甸。所载镇岳吐纳沉气入地，体魄坚凝如山岳，御伤难撼。乃练气期之法。"),
        mass_milligrams = 340000,
        volume_ml = 500,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        looks_like = "cookbook",
        symbol = "?",
        color = "brown",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate_deep_earth" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 金行练气期功法。learn_spell 授予淬锋诀；学会后授载体特性「百炼成锋」。/ Metal-phase Qi-Refining technique.
    -- A Metal-phase manual, its pages thin metal leaves with a cold sheen. Its forging method tempers sinew and bone with the sharp qi of Metal. A Qi-Refining technique.
    -- Record of the Bared Edge
    -- copies of the Record of the Bared Edge
    local book = content.Item {
        id = "immortal_path_manual_true_metal",
        category = "manuals",
        name = ccb.content.plural_text("素锋录", "素锋录"),
        description = ccb.content.text("一部金行修炼功法，以薄金片为页，寒光内蕴。所载淬锋诀引金行锐气淬炼筋骨，出手锋锐精准。乃练气期之法。"),
        mass_milligrams = 600000,
        volume_ml = 500,
        price_cents = 25000,
        price_postapoc_cents = 1200,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate_true_metal" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 水行练气期功法。learn_spell 授予纳川息；学会后授载体特性「渊渟」（额外灵气上限）。/ Water-phase Qi-Refining technique.
    -- A Water-phase manual, its pages cool and moist. Its breathing method stills the mind like standing water; the dantian holds qi like an abyss. A Qi-Refining technique.
    -- Abyssal Heart Method
    -- copies of the Abyssal Heart Method
    local book = content.Item {
        id = "immortal_path_manual_cold_pool",
        category = "manuals",
        name = ccb.content.plural_text("玄渊心法", "玄渊心法"),
        description = ccb.content.text("一部水行修炼功法，纸页清润如得水汽。所载纳川息心静如止水，丹田如渊纳百川，灵气蓄养更深。乃练气期之法。"),
        mass_milligrams = 340000,
        volume_ml = 500,
        price_cents = 22000,
        price_postapoc_cents = 1100,
        looks_like = "cookbook",
        symbol = "?",
        color = "blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate_cold_pool" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 魔功练气期功法（残篇）。learn_spell 授予摄血息；学会后授载体特性「血煞侵髓」（凶威+反噬代价占位）。邪典，来源阴暗、稀有。/ Demonic Qi-Refining technique (fragment). Grants the demonic breathing art; carrier trait carries menace + a placeholder backlash cost.
    -- A grimoire bound in dark-red leather, its script seemingly written in blood, exuding a faint reek. Its demonic breathing method feeds on death-qi to surge cultivation, but gnaws the meridians and erodes the foundation. A demonic art; cultivate with care.
    -- Blood-Fiend Corpse Refining (fragment)
    -- copies of the Blood-Fiend Corpse Refining (fragment)
    local book = content.Item {
        id = "immortal_path_manual_blood_fiend",
        category = "manuals",
        name = ccb.content.plural_text("血煞炼尸功（残篇）", "血煞炼尸功（残篇）"),
        description = ccb.content.text("一卷以暗红皮革装订的邪典，字迹似以血书成，翻动时隐有腥气。所载摄血息摄死气血煞养身，催修为暴进，却反噬经脉、有损根本。邪道之法，慎修。"),
        mass_milligrams = 500000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 2000,
        looks_like = "cookbook",
        symbol = "?",
        color = "pink",
    }
    book:material("leather", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_meditate_blood_fiend" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 火行入门攻击法术残卷。learn_spell 授予火弹术 immortal_path_fireball——本 mod 第一个主动攻击法术。**定位为「法术」（无门槛）**：凡引气入体者皆可学,故比五行整套功法传承常见、价格更低,不再像神通那样稀缺。残卷=单一法门,只授一术。译名查 GLOSSARY：法术=art、残卷=scroll。/ Entry Fire-phase attack spell (scroll). Grants Fireball — a no-prerequisite art, so it is more common and cheaper than the full elemental technique transmissions.
    -- A scorch-marked scroll recording the method of gathering Fire-phase qi into a hurled bolt. Anyone who can draw qi into the body may study it and spend qi conjuring fireballs that scorch their foes.
    -- Fireball (scroll)
    -- copies of Fireball (scroll)
    local book = content.Item {
        id = "immortal_path_manual_fireball",
        category = "manuals",
        name = ccb.content.plural_text("火弹术（残卷）", "火弹术（残卷）"),
        description = ccb.content.text("一卷焦痕斑驳的法术残卷，记载着凝聚火行灵气、催作火弹掷敌的法门。但凡能引气入体，研读之后便能以灵气催发火弹，灼伤来犯之敌。"),
        mass_milligrams = 150000,
        volume_ml = 250,
        price_cents = 8000,
        price_postapoc_cents = 500,
        looks_like = "cookbook",
        symbol = "?",
        color = "red",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_fireball" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- 水行入门攻击法术残卷。learn_spell 授予寒泉迸 immortal_path_water_burst——「法术·无门槛」第二范例,与火弹术同口径（凡引气入体者皆可学,故较常见、价低）。残卷=单一法门,只授一术。译名查 GLOSSARY：法术=art、残卷=scroll。/ Entry Water-phase attack spell (scroll). Grants Cold-Spring Burst — a no-prerequisite art, same footing as Fireball: more common and cheaper than the full elemental transmissions.
    -- A water-stained scroll, its ink faintly rippled, recording the method of gathering the utmost-yin qi of Water into a bursting jet. Anyone who can draw qi into the body may study it and spend qi loosing cold springs that lance their foes.
    -- Cold-Spring Burst (scroll)
    -- copies of Cold-Spring Burst (scroll)
    local book = content.Item {
        id = "immortal_path_manual_water_burst",
        category = "manuals",
        name = ccb.content.plural_text("寒泉迸（残卷）", "寒泉迸（残卷）"),
        description = ccb.content.text("一卷水渍晕染、字迹微皱的法术残卷，记载着凝聚水行至阴之气、催作寒泉迸敌的法门。但凡能引气入体，研读之后便能以灵气催发寒泉，激射来犯之敌。"),
        mass_milligrams = 150000,
        volume_ml = 250,
        price_cents = 8000,
        price_postapoc_cents = 500,
        looks_like = "cookbook",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:clear_use_actions()
    book:teach_spells({ "immortal_path_water_burst" })
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
