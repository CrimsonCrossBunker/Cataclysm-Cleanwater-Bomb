local content = require("ccb").content

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for Armalite Rifles (though other stanag compliants could work too)
    local group = content.ItemGroup { id = "field_ar15", kind = "collection" }
    group:entry {
        distribution = {
            { item = "stanag30", charges = { 30, 30 }, probability = 50 },
            { item = "stanag30", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "stanag30", charges = { 30, 30 }, probability = 30 },
            { item = "stanag30", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "stanag30", charges = { 30, 30 }, probability = 30 },
            { item = "stanag30", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for HK417 rifles
    local group = content.ItemGroup { id = "field_hk417", kind = "collection" }
    group:entry {
        distribution = {
            { item = "hk417mag_20rd", charges = { 20, 20 }, probability = 50 },
            { item = "hk417mag_20rd", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "hk417mag_20rd", charges = { 20, 20 }, probability = 30 },
            { item = "hk417mag_20rd", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "hk417mag_20rd", charges = { 20, 20 }, probability = 30 },
            { item = "hk417mag_20rd", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for XEDRA
    local group = content.ItemGroup { id = "field_xedra_rifle", kind = "collection" }
    group:entry {
        distribution = {
            { item = "xedra40", charges = { 40, 40 }, probability = 50 },
            { item = "xedra40", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "xedra40", charges = { 40, 40 }, probability = 30 },
            { item = "xedra40", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "xedra40", charges = { 40, 40 }, probability = 30 },
            { item = "xedra40", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for XEDRA Officer boss drops
    local group = content.ItemGroup { id = "field_xedra_officer", kind = "collection" }
    group:entry {
        distribution = {
            { item = "8x40_10_mag", charges = { 10, 10 }, probability = 50 },
            { item = "8x40_10_mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "8x40_10_mag", charges = { 10, 10 }, probability = 30 },
            { item = "8x40_10_mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "8x40_10_mag", charges = { 10, 10 }, probability = 30 },
            { item = "8x40_10_mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for XEDRA
    local group = content.ItemGroup { id = "field_xedra_shotgun", kind = "collection" }
    group:entry {
        distribution = {
            { item = "xedra10", charges = { 10, 10 }, probability = 50 },
            { item = "xedra10", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "xedra10", charges = { 10, 10 }, probability = 30 },
            { item = "xedra10", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "xedra10", charges = { 10, 10 }, probability = 30 },
            { item = "xedra10", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for any shotgun since its just shells
    local group = content.ItemGroup { id = "field_shotgun", kind = "collection" }
    group:entry { item = "shot_00", charges = { 1, 6 }, probability = 80 }
    group:entry { item = "shot_beanbag", charges = { 1, 4 }, probability = 30 }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for any sniper in 3006 since its just shells
    local group = content.ItemGroup { id = "field_3006", kind = "collection" }
    group:entry { item = "3006", charges = { 1, 6 } }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for any sniper in 308 since its just shells
    local group = content.ItemGroup { id = "field_308", kind = "collection" }
    group:entry { item = "308", charges = { 1, 6 } }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for any sniper in 300 win mag since its just shells
    local group = content.ItemGroup { id = "field_300", kind = "collection" }
    group:entry { item = "300_winmag", charges = { 1, 6 } }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for any sniper in 338 lapua since its just shells
    local group = content.ItemGroup { id = "field_338", kind = "collection" }
    group:entry { item = "338lapua_hpbt", charges = { 1, 6 } }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for any sniper in 3006 since its just shells
    local group = content.ItemGroup { id = "field_50bmg", kind = "collection" }
    group:entry { item = "50match", charges = { 1, 6 } }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the 57
    local group = content.ItemGroup { id = "field_fn57", kind = "collection" }
    group:entry {
        distribution = {
            { item = "fn57mag", charges = { 20, 20 }, probability = 50 },
            { item = "fn57mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "fn57mag", charges = { 20, 20 }, probability = 30 },
            { item = "fn57mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "fn57mag", charges = { 20, 20 }, probability = 30 },
            { item = "fn57mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the P90
    local group = content.ItemGroup { id = "field_p90", kind = "collection" }
    group:entry {
        distribution = {
            { item = "fnp90mag", charges = { 50, 50 }, probability = 50 },
            { item = "fnp90mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "fnp90mag", charges = { 50, 50 }, probability = 30 },
            { item = "fnp90mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "fnp90mag", charges = { 50, 50 }, probability = 30 },
            { item = "fnp90mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the glock 19
    local group = content.ItemGroup { id = "field_glock_19", kind = "collection" }
    group:entry {
        distribution = {
            { item = "glockmag", charges = { 15, 15 }, probability = 50 },
            { item = "glockmag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "glockmag", charges = { 15, 15 }, probability = 30 },
            { item = "glockmag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "glockmag", charges = { 15, 15 }, probability = 30 },
            { item = "glockmag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the glock 17
    local group = content.ItemGroup { id = "field_glock_17", kind = "collection" }
    group:entry {
        distribution = {
            { item = "glock17_17", charges = { 17, 17 }, probability = 50 },
            { item = "glock17_17", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "glock17_17", charges = { 17, 17 }, probability = 30 },
            { item = "glock17_17", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "glock17_17", charges = { 17, 17 }, probability = 30 },
            { item = "glock17_17", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the glock 34
    local group = content.ItemGroup { id = "field_glock_34", kind = "collection" }
    group:entry {
        distribution = {
            { item = "glock17_17", charges = { 17, 17 }, probability = 50 },
            { item = "glock17_17", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "glock17_17", charges = { 17, 17 }, probability = 30 },
            { item = "glock17_17", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "glock17_17", charges = { 17, 17 }, probability = 30 },
            { item = "glock17_17", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the m9
    local group = content.ItemGroup { id = "field_m9", kind = "collection" }
    group:entry {
        distribution = {
            { item = "m9mag", charges = { 15, 15 }, probability = 50 },
            { item = "m9mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "m9mag", charges = { 15, 15 }, probability = 30 },
            { item = "m9mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "m9mag", charges = { 15, 15 }, probability = 30 },
            { item = "m9mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the usp 9mm
    local group = content.ItemGroup { id = "field_usp_9mm", kind = "collection" }
    group:entry {
        distribution = {
            { item = "usp9mag", charges = { 15, 15 }, probability = 50 },
            { item = "usp9mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "usp9mag", charges = { 15, 15 }, probability = 30 },
            { item = "usp9mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "usp9mag", charges = { 15, 15 }, probability = 30 },
            { item = "usp9mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the sig sp2022 9mm
    local group = content.ItemGroup { id = "field_sp2022_9mm", kind = "collection" }
    group:entry {
        distribution = {
            { item = "sp2022mag_15rd_9mm", charges = { 15, 15 }, probability = 50 },
            { item = "sp2022mag_15rd_9mm", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "sp2022mag_15rd_9mm", charges = { 15, 15 }, probability = 30 },
            { item = "sp2022mag_15rd_9mm", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "sp2022mag_15rd_9mm", charges = { 15, 15 }, probability = 30 },
            { item = "sp2022mag_15rd_9mm", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the px4 9mm
    local group = content.ItemGroup { id = "field_px4_9mm", kind = "collection" }
    group:entry {
        distribution = {
            { item = "px4mag", charges = { 17, 17 }, probability = 50 },
            { item = "px4mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "px4mag", charges = { 17, 17 }, probability = 30 },
            { item = "px4mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "px4mag", charges = { 17, 17 }, probability = 30 },
            { item = "px4mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the MP5
    local group = content.ItemGroup { id = "field_mp5", kind = "collection" }
    group:entry {
        distribution = {
            { item = "mp5mag", charges = { 30, 30 }, probability = 50 },
            { item = "mp5mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "mp5mag", charges = { 30, 30 }, probability = 30 },
            { item = "mp5mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "mp5mag", charges = { 30, 30 }, probability = 30 },
            { item = "mp5mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the UZI/Colt SMG
    local group = content.ItemGroup { id = "field_uzi", kind = "collection" }
    group:entry {
        distribution = {
            { item = "uzimag", charges = { 32, 32 }, probability = 50 },
            { item = "uzimag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "uzimag", charges = { 32, 32 }, probability = 30 },
            { item = "uzimag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "uzimag", charges = { 32, 32 }, probability = 30 },
            { item = "uzimag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the APC9
    local group = content.ItemGroup { id = "field_apc9", kind = "collection" }
    group:entry {
        distribution = {
            { item = "btmp9mag_9x19mm_30", charges = { 30, 30 }, probability = 50 },
            { item = "btmp9mag_9x19mm_30", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "btmp9mag_9x19mm_30", charges = { 30, 30 }, probability = 30 },
            { item = "btmp9mag_9x19mm_30", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "btmp9mag_9x19mm_30", charges = { 30, 30 }, probability = 30 },
            { item = "btmp9mag_9x19mm_30", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the UMP in 9mm
    local group = content.ItemGroup { id = "field_ump9", kind = "collection" }
    group:entry {
        distribution = {
            { item = "ump9mag", charges = { 30, 30 }, probability = 50 },
            { item = "ump9mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "ump9mag", charges = { 30, 30 }, probability = 30 },
            { item = "ump9mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "ump9mag", charges = { 30, 30 }, probability = 30 },
            { item = "ump9mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the P226 .357 SIG
    local group = content.ItemGroup { id = "field_p226_357sig", kind = "collection" }
    group:entry {
        distribution = {
            { item = "p226mag_12rd_357sig", charges = { 12, 12 }, probability = 50 },
            { item = "p226mag_12rd_357sig", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "p226mag_12rd_357sig", charges = { 12, 12 }, probability = 30 },
            { item = "p226mag_12rd_357sig", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "p226mag_12rd_357sig", charges = { 12, 12 }, probability = 30 },
            { item = "p226mag_12rd_357sig", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the P320 .357 SIG
    local group = content.ItemGroup { id = "field_p320_357sig", kind = "collection" }
    group:entry {
        distribution = {
            { item = "p320mag_13rd_357sig", charges = { 13, 13 }, probability = 50 },
            { item = "p320mag_13rd_357sig", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "p320mag_13rd_357sig", charges = { 13, 13 }, probability = 30 },
            { item = "p320mag_13rd_357sig", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "p320mag_13rd_357sig", charges = { 13, 13 }, probability = 30 },
            { item = "p320mag_13rd_357sig", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the px4 40
    local group = content.ItemGroup { id = "field_px4_40", kind = "collection" }
    group:entry {
        distribution = {
            { item = "px4_40mag", charges = { 14, 14 }, probability = 50 },
            { item = "px4_40mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "px4_40mag", charges = { 14, 14 }, probability = 30 },
            { item = "px4_40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "px4_40mag", charges = { 14, 14 }, probability = 30 },
            { item = "px4_40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the glock 22
    local group = content.ItemGroup { id = "field_sig_40", kind = "collection" }
    group:entry {
        distribution = {
            { item = "sig40mag", charges = { 12, 12 }, probability = 50 },
            { item = "sig40mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "sig40mag", charges = { 12, 12 }, probability = 30 },
            { item = "sig40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "sig40mag", charges = { 12, 12 }, probability = 30 },
            { item = "sig40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the UMP in .40 S&W
    local group = content.ItemGroup { id = "field_ump40", kind = "collection" }
    group:entry {
        distribution = {
            { item = "ump40mag", charges = { 30, 30 }, probability = 50 },
            { item = "ump40mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "ump40mag", charges = { 30, 30 }, probability = 30 },
            { item = "ump40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "ump40mag", charges = { 30, 30 }, probability = 30 },
            { item = "ump40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the glock 21
    local group = content.ItemGroup { id = "field_glock_21", kind = "collection" }
    group:entry {
        distribution = {
            { item = "glock_21mag", charges = { 13, 13 }, probability = 50 },
            { item = "glock_21mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "glock_21mag", charges = { 13, 13 }, probability = 30 },
            { item = "glock_21mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "glock_21mag", charges = { 13, 13 }, probability = 30 },
            { item = "glock_21mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the glock 22
    local group = content.ItemGroup { id = "field_usp_45", kind = "collection" }
    group:entry {
        distribution = {
            { item = "usp45mag", charges = { 12, 12 }, probability = 50 },
            { item = "usp45mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "usp45mag", charges = { 12, 12 }, probability = 30 },
            { item = "usp45mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "usp45mag", charges = { 12, 12 }, probability = 30 },
            { item = "usp45mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- this is a distribution for ammo and magazines an active combatant would have immediately on hand.  Most should be expended.
    -- usually takes the form of 100% chance for first mag, 70% for second, 50% for third with reducing chances of them being mostly expended.
    -- this group is for the UMP in .45 ACP
    local group = content.ItemGroup { id = "field_ump45", kind = "collection" }
    group:entry {
        distribution = {
            { item = "ump45mag", charges = { 25, 25 }, probability = 50 },
            { item = "ump45mag", charges = { 0, 5 }, probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "ump45mag", charges = { 25, 25 }, probability = 30 },
            { item = "ump45mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 70,
    }
    group:entry {
        distribution = {
            { item = "ump45mag", charges = { 25, 25 }, probability = 30 },
            { item = "ump40mag", charges = { 0, 5 }, probability = 70 },
        },
        probability = 50,
    }
    content.add(group)
end
