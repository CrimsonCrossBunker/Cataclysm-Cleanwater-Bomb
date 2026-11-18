local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "casing",
        abstract = true,
        category = "spare_parts",
        name = content.plural_text("casing from ammunition cartridge", "casing from ammunition cartridges"),
        stackable = true,
        symbol = "=",
        color = "yellow",
    }
    item:material("brass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "223_casing",
        copy_from = "casing",
        name = ccb.content.plural_text(".223 casing", ".223 casings"),
        description = ccb.content.text("An empty casing from a .223 round."),
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_223_casing",
        copy_from = "casing",
        name = ccb.content.plural_text("primerless .223 casing", "primerless .223 casings"),
        description = ccb.content.text("An empty casing from a .223 round, with its primer removed."),
        mass_milligrams = 5000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "3006_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".30-06 casing", ".30-06 casings"),
        description = ccb.content.text("An empty casing from a .30-06 round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_3006_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .30-06 casing", "primerless .30-06 casings"),
        description = ccb.content.text("An empty casing from a .30-06 round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "3030_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".30-30 Winchester casing", ".30-30 Winchester casings"),
        description = ccb.content.text("An empty casing from a .30-30 Winchester round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_3030_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .30-30 Winchester casing", "primerless .30-30 Winchester casings"),
        description = ccb.content.text("An empty casing from a .30-30 Winchester round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "123ln_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("12.3ln casing", "12.3ln casings"),
        description = ccb.content.text("An empty casing from a 12.3ln round.  It looks deceptively like a .303 British casing, if those were rimless."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_123ln_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless 12.3ln casing", "primerless 12.3ln casings"),
        description = ccb.content.text("An empty casing from a 12.3ln round.  It looks deceptively like a .303 British casing, if those were rimless.  This one has had its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    -- weight reduced due to description.
    local item = content.Item {
        id = "caotel_cell_spent",
        copy_from = "casing",
        looks_like = "caotel_cell",
        mass_milligrams = 20000,
        volume_ml = 190,
        name = ccb.content.plural_text("spent Caotel cell", "spent Caotel cells"),
        description = ccb.content.text("This is a small metallic cube of inscrutable construction.  You think it might feel slightly lighter when compared to the fresh ones."),
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "270win_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".270 Winchester casing", ".270 Winchester casings"),
        description = ccb.content.text("An empty casing from a .270 Winchester round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_270win_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .270 Winchester casing", "primerless .270 Winchester casings"),
        description = ccb.content.text("An empty casing from a .270 Winchester round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "303_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".303 British casing", ".303 British casings"),
        description = ccb.content.text("An empty casing from a .303 British round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_303_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .303 British casing", "primerless .303 British casings"),
        description = ccb.content.text("An empty casing from a .303 British round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "300_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".300 Winchester Magnum casing", ".300 Winchester Magnum casings"),
        description = ccb.content.text("An empty casing from a .300 Winchester Magnum round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_300_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .300 Winchester Magnum casing", "primerless .300 Winchester Magnum casings"),
        description = ccb.content.text("An empty casing from a .300 Winchester Magnum round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "308_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".308 Winchester casing", ".308 Winchester casings"),
        description = ccb.content.text("An empty casing from a .308 Winchester round."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_308_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .308 Winchester casing", "primerless .308 Winchester casings"),
        description = ccb.content.text("An empty casing from a .308 Winchester round, with its primer removed."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "762_51_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("7.62x51mm NATO casing", "7.62x51mm NATO casings"),
        description = ccb.content.text("An empty casing from a 7.62x51mm NATO round."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_762_51_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless 7.62x51mm NATO casing", "primerless 7.62x51mm NATO casings"),
        description = ccb.content.text("An empty casing from a 7.62x51mm NATO round, with its primer removed."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "32_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".32 ACP casing", ".32 ACP casings"),
        description = ccb.content.text("An empty casing from a .32 ACP round."),
        mass_milligrams = 2000,
        volume_ml = 3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_32_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .32 ACP casing", "primerless .32 ACP casings"),
        description = ccb.content.text("An empty casing from a .32 ACP round, with its primer removed."),
        mass_milligrams = 2000,
        volume_ml = 3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "38_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".38 Special casing", ".38 Special casings"),
        description = ccb.content.text("An empty casing from a .38 Special round."),
        mass_milligrams = 3000,
        volume_ml = 4,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_38_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .38 Special casing", "primerless .38 Special casings"),
        description = ccb.content.text("An empty casing from a .38 Special round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 4,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "38super_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".38 Super casing", ".38 Super casings"),
        description = ccb.content.text("An empty casing from a .38 Super round."),
        mass_milligrams = 3000,
        volume_ml = 4,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_38super_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .38 Super casing", "primerless .38 Super casings"),
        description = ccb.content.text("An empty casing from a .38 Super round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 4,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "40_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".40 S&W casing", ".40 S&W casings"),
        description = ccb.content.text("An empty casing from a .40 S&W round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_40_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .40 S&W casing", "primerless .40 S&W casings"),
        description = ccb.content.text("An empty casing from a .40 S&W round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "10mm_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("10mm Auto casing", "10mm Auto casings"),
        description = ccb.content.text("An empty casing from a 10mm Auto round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_10mm_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless 10mm Auto casing", "primerless 10mm Auto casings"),
        description = ccb.content.text("An empty casing from a 10mm Auto round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "40x46mm_m212_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x46mm M212 casing", "40x46mm M212 casings"),
        description = ccb.content.text("A large casing from a spent 40x46mm cartridge, which used to hold a less-lethal projectile."),
        mass_milligrams = 50000,
        volume_ml = 55,
        stackable = true,
        symbol = "=",
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "40x46mm_m118_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x46mm M118 casing", "40x46mm M118 casings"),
        description = ccb.content.text("A large casing from a spent 40x46mm cartridge, which used to hold an HEDP grenade.  Suitable for reloading with buckshot, slug or flechette loads."),
        mass_milligrams = 50000,
        volume_ml = 58,
        stackable = true,
        symbol = "=",
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "40x46mm_m199_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x46mm M199 casing", "40x46mm M199 casings"),
        description = ccb.content.text("A large casing from a spent 40x46mm cartridge, which used to hold a buckshot load.  Suitable for reloading with buckshot, slug or flechette loads."),
        mass_milligrams = 50000,
        volume_ml = 59,
        symbol = "=",
        stackable = true,
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "40x46mm_m195_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x46mm M195 casing", "40x46mm M195 casings"),
        description = ccb.content.text("A large casing from a spent 40x46mm cartridge, which used to hold a tear gas canister."),
        mass_milligrams = 50000,
        volume_ml = 45,
        symbol = "=",
        stackable = true,
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "40x46mm_hornets_nest_22lr_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x46mm .22 LR hornet's nest casing", "40x46mm .22 LR hornet's nest casings"),
        description = ccb.content.text("An empty 40x46mm hornet's nest casing, able to be reloaded with ten .22 LR bullets to fire them simultaneously."),
        mass_milligrams = 50000,
        volume_ml = 59,
        symbol = "=",
        stackable = true,
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "40x46mm_hornets_nest_410_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x46mm .410 hornet's nest casing", "40x46mm .410 hornet's nest casings"),
        description = ccb.content.text("An empty 40x46mm hornet's nest casing, able to be reloaded with four .410 shells to fire them simultaneously."),
        mass_milligrams = 50000,
        volume_ml = 59,
        symbol = "=",
        stackable = true,
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "40x53mm_m169_casing",
        category = "spare_parts",
        name = ccb.content.plural_text("40x53mm M169 casing", "40x53mm M169 casings"),
        description = ccb.content.text("A large casing from a spent 40x53mm cartridge.  Suitable for reloading with buckshot, slug or flechette loads."),
        mass_milligrams = 50000,
        volume_ml = 64,
        symbol = "=",
        stackable = true,
        color = "dark_gray",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "44_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".44 Magnum casing", ".44 Magnum casings"),
        description = ccb.content.text("An empty casing from a .44 Magnum round."),
        mass_milligrams = 4000,
        volume_ml = 6,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_44_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .44 Magnum casing", "primerless .44 Magnum casings"),
        description = ccb.content.text("An empty casing from a .44 Magnum round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 6,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "454_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".454 Casull casing", ".454 Casull casings"),
        description = ccb.content.text("An empty casing from a .454 Casull round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_454_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .454 Casull casing", "primerless .454 Casull casings"),
        description = ccb.content.text("An empty casing from a .454 Casull round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "460sw_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".460 S&W Magnum casing", ".460 S&W Magnum casings"),
        description = ccb.content.text("An empty casing from a .460 S&W Magnum round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_460sw_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .460 S&W Magnum casing", "primerless .460 S&W Magnum casings"),
        description = ccb.content.text("An empty casing from a .460 S&W Magnum round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "45_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".45 ACP casing", ".45 ACP casings"),
        description = ccb.content.text("An empty casing from a .45 ACP round."),
        mass_milligrams = 4000,
        volume_ml = 6,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_45_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .45 ACP casing", "primerless .45 ACP casings"),
        description = ccb.content.text("An empty casing from a .45 ACP round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 6,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "45colt_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".45 Colt casing", ".45 Colt casings"),
        description = ccb.content.text("An empty casing from a .45 Colt round."),
        mass_milligrams = 4000,
        volume_ml = 6,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_45colt_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .45 Colt casing", "primerless .45 Colt casings"),
        description = ccb.content.text("An empty casing from a .45 Colt round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 6,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "4570_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".45-70 casing", ".45-70 casings"),
        description = ccb.content.text("An empty casing from a .45-70 Government round."),
        mass_milligrams = 4000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_4570_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .45-70 casing", "primerless .45-70 casings"),
        description = ccb.content.text("An empty casing from a .45-70 Government round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "50beowulf_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".50 Beowulf casing", ".50 Beowulf casings"),
        description = ccb.content.text("An empty casing from a .50 Beowulf round."),
        mass_milligrams = 4000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_50beowulf_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .50 Beowulf casing", "primerless .50 Beowulf casings"),
        description = ccb.content.text("An empty casing from a .50 Beowulf round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "450_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".450 Bushmaster casing", ".450 Bushmaster casings"),
        description = ccb.content.text("An empty casing from a .450 Bushmaster round."),
        mass_milligrams = 4000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_450_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .450 Bushmaster casing", "primerless .450 Bushmaster casings"),
        description = ccb.content.text("An empty casing from a .450 Bushmaster round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "500_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".500 S&W Magnum casing", ".500 S&W Magnum casings"),
        description = ccb.content.text("An empty casing from a .500 S&W Magnum round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_500_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .500 S&W Magnum casing", "primerless .500 S&W Magnum casings"),
        description = ccb.content.text("An empty casing from a .500 S&W Magnum round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "50_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".50 BMG casing", ".50 BMG casings"),
        description = ccb.content.text("An empty casing from a .50 BMG round."),
        mass_milligrams = 18000,
        volume_ml = 12,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_50_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .50 BMG casing", "primerless .50 BMG casings"),
        description = ccb.content.text("An empty casing from a .50 BMG round, with its primer removed."),
        mass_milligrams = 18000,
        volume_ml = 12,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "338lapua_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".338 Lapua casing", ".338 Lapua casings"),
        description = ccb.content.text("An empty casing from a .338 Lapua round.  These are rare, so you might want to hold onto them."),
        mass_milligrams = 18000,
        volume_ml = 12,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_338lapua_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .338 Lapua casing", "primerless .338 Lapua casings"),
        description = ccb.content.text("An empty casing from a .338 Lapua round.  These are rare, so you might want to hold onto them.  This one has had its primer removed."),
        mass_milligrams = 18000,
        volume_ml = 12,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "77arisaka_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("7.7x58mm Arisaka casing", "7.7x58mm Arisaka casings"),
        description = ccb.content.text("An empty casing from a 7.7x58mm Arisaka round."),
        mass_milligrams = 5000,
        volume_ml = 7,
        longest_side_mm = 58,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_77arisaka_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless 7.7mm Arisaka casing", "primerless 7.7mm Arisaka casings"),
        description = ccb.content.text("An empty casing from a 7.7x58mm Japanese round, with its primer removed."),
        mass_milligrams = 5000,
        volume_ml = 7,
        longest_side_mm = 58,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "545_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("5.45x39mm casing", "5.45x39mm casings"),
        description = ccb.content.text("An empty casing from a 5.45x39mm round."),
        mass_milligrams = 4000,
        volume_ml = 7,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_545_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless 5.45x39mm casing", "primerless 5.45x39mm casings"),
        description = ccb.content.text("An empty casing from a 5.45x39mm round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 7,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "57mm_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("5.7x28mm casing", "5.7x28mm casings"),
        description = ccb.content.text("An empty casing from a 5.7x28mm round."),
        mass_milligrams = 2000,
        volume_ml = 3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_57mm_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless 5.7x28mm casing", "primerless 5.7x28mm casings"),
        description = ccb.content.text("An empty casing from a 5.7x28mm round, with its primer removed."),
        mass_milligrams = 2000,
        volume_ml = 3,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "458wm_casing",
        copy_from = "casing",
        looks_like = "50beowulf_casing",
        name = ccb.content.plural_text(".458 Winchester Magnum casing", ".458 Winchester Magnum casings"),
        description = ccb.content.text("An empty casing from a .458 Winchester Magnum round."),
        mass_milligrams = 13000,
        volume_ml = 8,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_458wm_casing",
        copy_from = "casing",
        looks_like = "50beowulf_casing",
        name = ccb.content.plural_text("primerless .458 Winchester Magnum casing", "primerless .458 Winchester Magnum casings"),
        description = ccb.content.text("An empty casing from a .458 Winchester Magnum round, with its primer removed."),
        mass_milligrams = 13000,
        volume_ml = 8,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "762R_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("7.62x54mmR casing", "7.62x54mmR casings"),
        description = ccb.content.text("An empty casing from a 7.62x54mmR round."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_762R_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless 7.62x54mmR casing", "primerless 7.62x54mmR casings"),
        description = ccb.content.text("An empty casing from a 7.62x54mmR round, with its primer removed."),
        mass_milligrams = 7000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "762_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("7.62x39mm casing", "7.62x39mm casings"),
        description = ccb.content.text("An empty casing from a 7.62x39mm round."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_762_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless 7.62x39mm casing", "primerless 7.62x39mm casings"),
        description = ccb.content.text("An empty casing from a 7.62x39mm round, with its primer removed."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "762_25_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("7.62x25mm Tokarev casing", "7.62x25mm Tokarev casings"),
        description = ccb.content.text("An empty casing from a 7.62x25mm Tokarev round."),
        mass_milligrams = 4000,
        volume_ml = 7,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_762_25_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless 7.62x25mm Tokarev casing", "primerless 7.62x25mm Tokarev casings"),
        description = ccb.content.text("An empty casing from a 7.62x25mm Tokarev round, with its primer removed."),
        mass_milligrams = 4000,
        volume_ml = 7,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "9mm_casing",
        copy_from = "casing",
        name = ccb.content.plural_text("9x19mm casing", "9x19mm casings"),
        description = ccb.content.text("An empty casing from a 9x19mm round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_9mm_casing",
        copy_from = "casing",
        name = ccb.content.plural_text("primerless 9x19mm casing", "primerless 9x19mm casings"),
        description = ccb.content.text("An empty casing from a 9x19mm round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "357sig_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".357 SIG casing", ".357 SIG casings"),
        description = ccb.content.text("An empty casing from a .357 SIG round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_357sig_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .357 SIG casing", "primerless .357 SIG casings"),
        description = ccb.content.text("An empty casing from a .357 SIG round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "357mag_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".357 Magnum casing", ".357 Magnum casings"),
        description = ccb.content.text("An empty casing from a .357 Magnum round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_357mag_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .357 Magnum casing", "primerless .357 Magnum casings"),
        description = ccb.content.text("An empty casing from a .357 Magnum round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "9x18mm_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("9x18mm Makarov casing", "9x18mm Makarov casings"),
        description = ccb.content.text("An empty casing from a 9x18mm Makarov round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_9x18mm_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless 9x18mm Makarov casing", "primerless 9x18mm Makarov casings"),
        description = ccb.content.text("An empty casing from a 9x18mm Makarov round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "380_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".380 ACP casing", ".380 ACP casings"),
        description = ccb.content.text("An empty casing from a .380 ACP round."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_380_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .380 ACP casing", "primerless .380 ACP casings"),
        description = ccb.content.text("An empty casing from a .380 ACP round, with its primer removed."),
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "shot_hull",
        category = "spare_parts",
        name = ccb.content.plural_text("12 gauge hull", "12 gauge hulls"),
        description = ccb.content.text("An empty hull from a 12 gauge shotgun shell."),
        mass_milligrams = 8000,
        volume_ml = 12,
        stackable = true,
        symbol = "=",
        color = "red",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_shot_hull",
        category = "spare_parts",
        name = ccb.content.plural_text("primerless 12 gauge hull", "primerless 12 gauge hulls"),
        description = ccb.content.text("An empty hull from a 12 gauge shotgun shell, with its primer removed."),
        mass_milligrams = 8000,
        volume_ml = 12,
        stackable = true,
        symbol = "=",
        color = "red",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "410shot_hull",
        category = "spare_parts",
        name = ccb.content.plural_text(".410 hull", ".410 hulls"),
        description = ccb.content.text("An empty hull from a .410 shotgun shell."),
        mass_milligrams = 8000,
        volume_ml = 12,
        stackable = true,
        symbol = "=",
        looks_like = "shot_hull",
        color = "red",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_410shot_hull",
        category = "spare_parts",
        name = ccb.content.plural_text("primerless .410 hull", "primerless .410 hulls"),
        description = ccb.content.text("An empty hull from a .410 shotgun shell, with its primer removed."),
        mass_milligrams = 8000,
        volume_ml = 12,
        stackable = true,
        symbol = "=",
        looks_like = "shot_hull",
        color = "red",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "300blk_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".300 AAC Blackout casing", ".300 AAC Blackout casings"),
        description = ccb.content.text("An empty casing from a .300 AAC Blackout round."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_300blk_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .300 AAC Blackout casing", "primerless .300 AAC Blackout casings"),
        description = ccb.content.text("An empty casing from a .300 AAC Blackout round, with its primer removed."),
        mass_milligrams = 6000,
        volume_ml = 9,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "30carbine_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text(".30 Carbine casing", ".30 Carbine casings"),
        description = ccb.content.text("An empty casing from a .30 Carbine round."),
        mass_milligrams = 6000,
        volume_ml = 8,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_30carbine_casing",
        copy_from = "casing",
        looks_like = "223_casing",
        name = ccb.content.plural_text("primerless .30 Carbine casing", "primerless .30 Carbine casings"),
        description = ccb.content.text("An empty casing from a .30 Carbine round, with its primer removed."),
        mass_milligrams = 6000,
        volume_ml = 8,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "273x110casing",
        copy_from = "casing",
        looks_like = "50beowulf_casing",
        name = ccb.content.plural_text("27.3x110 Diyua casing", "27.3x110 Diyua casings"),
        description = ccb.content.text("An empty giant brass shotshell, with illegible alien text on the headstamp.  These are rare, so you might want to hold onto them."),
        mass_milligrams = 19000,
        volume_ml = 13,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "273x44casing",
        copy_from = "casing",
        looks_like = "50beowulf_casing",
        name = ccb.content.plural_text("27.3x44 Diyua casing", "27.3x44 Diyua casings"),
        description = ccb.content.text("An empty giant brass shotshell, with illegible alien text on the headstamp.  These are rare, so you might want to hold onto them."),
        mass_milligrams = 10000,
        volume_ml = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "50ae_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text(".50 AE casing", ".50 AE casings"),
        description = ccb.content.text("An empty casing from a .50 Action Express round."),
        mass_milligrams = 6000,
        volume_ml = 8,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "unprimed_50ae_casing",
        copy_from = "casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("primerless .50 AE casing", "primerless .50 AE casings"),
        description = ccb.content.text("An empty casing from a .50 Action Express round, with its primer removed."),
        mass_milligrams = 6000,
        volume_ml = 8,
    }
    content.add(item)
end
