local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "abstract_weather_report",
        abstract = true,
        category = "books",
        name = ccb.content.plural_text("abstract weather report", "abstract weather report"),
        symbol = ",",
        color = "white",
        volume_ml = 4,
        mass_milligrams = 1000,
        stackable = true,
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "abstract_mws_weather_data",
        abstract = true,
        copy_from = "abstract_weather_report",
        price_cents = 0,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "abstract_HEW_printout_data",
        abstract = true,
        copy_from = "abstract_weather_report",
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "mws_weather_data_incomplete",
        copy_from = "abstract_mws_weather_data",
        name = ccb.content.plural_text("unspooled thermal paper", "unspooled thermal paper"),
        description = ccb.content.text("A small scrap of thermal paper pulled from a spool."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mws_weather_data",
        copy_from = "abstract_mws_weather_data",
        name = ccb.content.plural_text("weather datasheet", "weather datasheet"),
        description = ccb.content.text("A piece of paper covered in complex weather recordings.  It requires specialized software to interpret."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mws_portal_storm_weather_data",
        copy_from = "abstract_mws_weather_data",
        name = ccb.content.plural_text("strange weather datasheet", "strange weather datasheet"),
        description = ccb.content.text("A piece of paper covered in complex weather recordings.  This one is riddled with visible error messages, but it requires specialized software to interpret."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mws_monster_corpse_weather_data",
        copy_from = "abstract_mws_weather_data",
        name = ccb.content.plural_text("alien \"atmospheric\" datasheet", "alien \"atmospheric\" datasheets"),
        description = ccb.content.text("A piece of paper covered in complex \"weather\" recordings from the inside of a giant, dead creature."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_weather_data",
        copy_from = "abstract_HEW_printout_data",
        name = ccb.content.plural_text("HEW datasheet", "HEW datasheets"),
        description = ccb.content.text("A piece of paper with data on various local conditions, including weather, radiation, and measurements foreign to you.  The document is coded in a series of overlapping numbers and dots that you cannot understand.  It likely requires specialized software to interpret."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data",
        copy_from = "abstract_HEW_printout_data",
        name = ccb.content.plural_text("HEW printout", "HEW printouts"),
        description = ccb.content.text("A short sheet of paper.  The document is coded in a series of complex equations and data that you cannot understand.  \"CONDITIONS NORMAL\" is printed on the bottom."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_portal",
        name = ccb.content.plural_text("HEW stable portal report", "HEW stable portal reports"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with titled \"STABLE PORTAL\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_portal_storm",
        name = ccb.content.plural_text("HEW unstable portal report", "HEW unstable portal reports"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"UNSTABLE PORTAL\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_vitrified",
        name = ccb.content.plural_text("HEW printout CC1044", "HEW printout CC1044s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"CC1044\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_exodii",
        name = ccb.content.plural_text("HEW printout IAE20", "HEW printout IAE20s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"IAE20\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a complex graphic of a waveform labeled \"ANOMALOUS EMF\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_strange_temple",
        name = ccb.content.plural_text("HEW printout WKG1", "HEW printout WKG1s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"WKG1\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a confounding graph labeled \"RESONANCE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_lixa",
        name = ccb.content.plural_text("HEW printout DP72063", "HEW printout DP72063s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"DP72063\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_highlands",
        name = ccb.content.plural_text("HEW printout TCOB1", "HEW printout TCOB1s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"TCOB1\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a wobbly, but mostly horizontal line labeled \"ANOMALOUS EMF\" and a confounding graph labeled \"RESONANCE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_labyrinth",
        name = ccb.content.plural_text("HEW printout DB86", "HEW printout DB86s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"DB86\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a complex graphic of a waveform labeled \"ANOMALOUS EMF\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_physics_lab",
        name = ccb.content.plural_text("HEW printout 22BMBS", "HEW printout 22BMBSs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"22BMBS\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a complex graphic of a waveform labeled \"ANOMALOUS EMF\" and a confounding graph labeled \"RESONANCE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_amigara",
        name = ccb.content.plural_text("HEW printout 01ITO", "HEW printout 01ITOs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"01ITO\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a chaotic, multicolored line graph labeled \"SEISMOGRAM\" and a confounding graph labeled \"RESONANCE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_radiosphere",
        name = ccb.content.plural_text("HEW printout VKTRS", "HEW printout VKTRSs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"VKTRS\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has an extremely complex graphic waveform labeled \"ANOMALOUS EMF\" - it fills much of the datasheet and clearly didn't fit on the page."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_cabin_reverb",
        name = ccb.content.plural_text("HEW printout CITW01", "HEW printout CITW01s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"CITW01\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_cabin_reverb_dimension",
        name = ccb.content.plural_text("HEW printout CITW02", "HEW printout CITW02s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"CITW02\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_barricaded_church",
        name = ccb.content.plural_text("HEW printout ESFX", "HEW printout ESFXs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"ESFX\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_morgantown",
        name = ccb.content.plural_text("HEW printout 01Z90", "HEW printout 01Z90s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report with the mysterious title \"01Z90\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_monster_corpse",
        name = ccb.content.plural_text("HEW printout LKG1", "HEW printout LKG1s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"LKG1\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has an spiky line-chart labeled \"GC-MS\" - the peaks of the lines are labeled with coded dots you cannot interpret."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_string_dimension",
        name = ccb.content.plural_text("HEW printout IHS", "HEW printout IHSs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"IHS\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_spiral_mine",
        name = ccb.content.plural_text("HEW printout UJI98", "HEW printout UJI98s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"UJI98\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has a strange trace of several spiral patterns, labeled \"GPR\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_void_spider_lair",
        name = ccb.content.plural_text("HEW printout NLL8", "HEW printout NLL8s"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"NLL8\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom of the sheet has an spiky line-chart labeled \"GC-MS\" - the peaks of the lines are labeled with coded dots you cannot interpret."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_inner_cabins_open_field",
        name = ccb.content.plural_text("HEW printout CITW-BFα", "HEW printout CITW-BFαs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"CITW-BF\".  Most of the document is coded in a series of complex equations and data that you cannot understand, and there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  However, there are also several relatively mundane weather recordings.  The bottom has a bar graph with several bars, the tallest of which is labeled \"α\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_inner_cabins_warped_cabin",
        name = ccb.content.plural_text("HEW printout CITW-BFβ", "HEW printout CITW-BFβs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"CITW-BF\".  The entire document is a series of obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom has a bar graph with several bars, the tallest of which is labeled \"β\"."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_inner_cabins_home_cabin",
        name = ccb.content.plural_text("HEW printout CITW-BFγ", "HEW printout CITW-BFγs"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"CITW-BF\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  The bottom has a bar graph with several bars, the tallest of which is labeled \"γ\".  Beside it is a topographical map you recognize, centered on the lonely cabin in the field."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "HEW_printout_data_portal_storm_dungeon",
        name = ccb.content.plural_text("HEW printout MROTS-S", "HEW printout MROTS-Ss"),
        copy_from = "abstract_HEW_printout_data",
        description = ccb.content.text("A short paper report labeled with the mysterious title \"MROTS-S\".  Most of the document is coded in a series of complex equations and data that you cannot understand, but there are several obvious error messages starting with \"VALUE OUTSIDE EXPECTED RANGE\".  Printed on the bottom of the page is some sort of topological map, which has been overwritten several times in confusing patterns, making it difficult to decipher."),
    }
    content.add(item)
end
