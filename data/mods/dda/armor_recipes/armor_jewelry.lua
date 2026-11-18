local content = require("ccb").content

local NO_EXERCISE = 1

-- By all rights, you shouldn’t be able to disassemble the craft and still get a functional bullet casing out
-- of it, considering that you’re literally punching holes in, through, and within it, but otherwise the
-- conditional names don’t work because the used components don’t get saved if reversable isn't set to true.
-- If you wanted the brass to end up nice and shiny, you’d have to buff it with a cloth. You don’t get nice
-- and shiny in this expedient craft; you’re doing the equivalent of drilling out a casing, threading it on a
-- piece of string, and calling it a necklace.
content.add(content.Recipe {
    id = "simple_pistol_cartridge_necklace",
    result = "simple_pistol_cartridge_necklace",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "multitool", count = 1 },
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 }
        })
    :quality("DRILL", 1, 1)
    :requirement("cordage_short", 3)
    :requirement("pistol_casings", 1)
)

-- By all rights, you shouldn’t be able to disassemble the craft and still get a functional bullet casing out
-- of it, considering that you’re literally punching holes in, through, and within it, but otherwise the
-- conditional names don’t work because the used components don’t get saved if reversable isn't set to true.
-- If you wanted the brass to end up nice and shiny, you’d have to buff it with a cloth. You don’t get nice
-- and shiny in this expedient craft; you’re doing the equivalent of drilling out a casing, threading it on a
-- piece of string, and calling it a necklace.
content.add(content.Recipe {
    id = "simple_rifle_cartridge_necklace",
    result = "simple_rifle_cartridge_necklace",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "multitool", count = 1 },
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 }
        })
    :quality("DRILL", 1, 1)
    :requirement("cordage_short", 3)
    :requirement("rifle_casings", 1)
)

-- By all rights, you shouldn’t be able to disassemble the craft and still get a functional bullet casing out
-- of it, considering that you’re literally punching holes in, through, and within it, but otherwise the
-- conditional names don’t work because the used components don’t get saved if reversable isn't set to true.
-- If you wanted the brass to end up nice and shiny, you’d have to buff it with a cloth. You don’t get nice
-- and shiny in this expedient craft; you’re doing the equivalent of drilling out a casing, threading it on a
-- piece of string, and calling it a necklace.
content.add(content.Recipe {
    id = "simple_ordnance_cartridge_necklace",
    result = "simple_ordnance_cartridge_necklace",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "multitool", count = 1 },
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 }
        })
    :quality("DRILL", 1, 1)
    :requirement("cordage_short", 3)
    :requirement("heavy_weapon_casings", 1)
)

-- By all rights, you shouldn’t be able to disassemble the craft and still get a functional bullet casing out
-- of it, considering that you’re literally punching holes in, through, and within it, but otherwise the
-- conditional names don’t work because the used components don’t get saved if reversable isn't set to true.
-- Water and cotton are present as tools to represent you needing or wanting to polish the casing before
-- stringing it.
-- Metal sawing for removing the base, rim, and primer, and filing for smoothing down the resulting edges.
content.add(content.Recipe {
    id = "fancy_pistol_cartridge_necklace",
    result = "fancy_pistol_cartridge_necklace",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "multitool", count = 1 },
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 }
        })
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :tool_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component("any_wire", 1, true)
    :quality("DRILL", 1, 1)
    :quality("FILE", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("plain_necklaces", 1)
    :requirement("gemstones", 1)
    :requirement("pistol_casings", 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_gem_setting")
)

-- By all rights, you shouldn’t be able to disassemble the craft and still get a functional bullet casing out
-- of it, considering that you’re literally punching holes in, through, and within it, but otherwise the
-- conditional names don’t work because the used components don’t get saved if reversable isn't set to true.
-- Water and cotton are present as tools to represent you needing or wanting to polish the casing before
-- stringing it.
-- Metal sawing for removing the base, rim, and primer, and filing for smoothing down the resulting edges.
content.add(content.Recipe {
    id = "fancy_rifle_cartridge_necklace",
    result = "fancy_rifle_cartridge_necklace",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "multitool", count = 1 },
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 }
        })
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :tool_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component("any_wire", 1, true)
    :quality("DRILL", 1, 1)
    :quality("FILE", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("plain_necklaces", 1)
    :requirement("gemstones", 1)
    :requirement("rifle_casings", 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_gem_setting")
)

-- By all rights, you shouldn’t be able to disassemble the craft and still get a functional bullet casing out
-- of it, considering that you’re literally punching holes in, through, and within it, but otherwise the
-- conditional names don’t work because the used components don’t get saved if reversable isn't set to true.
-- Water and cotton are present as tools to represent you needing or wanting to polish the casing before
-- stringing it.
-- Metal sawing for removing the base, rim, and primer, and filing for smoothing down the resulting edges.
content.add(content.Recipe {
    id = "fancy_ordinance_cartridge_necklace",
    result = "fancy_ordinance_cartridge_necklace",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "multitool", count = 1 },
            { id = "pliers", count = 1 },
            { id = "big_pliers", count = 1 },
            { id = "pliers_locking", count = 1 }
        })
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :tool_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component("any_wire", 1, true)
    :quality("DRILL", 1, 1)
    :quality("FILE", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("plain_necklaces", 1)
    :requirement("gemstones", 1)
    :requirement("heavy_weapon_casings", 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_gem_setting")
)

-- Pliers to cut and manipulate the wire.
-- The filing quality is only there to blunt the 'impossibly-sharp' monster teeth, probably not needed for
-- other teeth.
content.add(content.Recipe {
    id = "necklace_teeth_necklace_teeth_monster",
    result = "necklace_teeth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    variant = "necklace_teeth_monster",
}
    :tool("pliers", 1)
    :component("any_wire", 1, true)
    :component("nm_teeth", 1)
    :quality("FILE", 1, 1)
    :requirement("cordage_short", 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_gem_setting")
)
