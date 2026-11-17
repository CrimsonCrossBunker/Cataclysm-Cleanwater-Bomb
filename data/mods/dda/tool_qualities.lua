local ccb = require("ccb")
local content = ccb.content

do
    local quality = content.ToolQuality { id = "CUT", name = ccb.content.text("cutting", "tool_quality") }
    quality:usage(1, "salvage")
    quality:usage(1, "inscribe")
    content.add(quality)
end
content.add(content.ToolQuality { id = "GRASS_CUT", name = ccb.content.text("grass cutting") })
do
    local quality = content.ToolQuality { id = "CUT_FINE", name = ccb.content.text("fine cutting") }
    quality:usage(1, "salvage")
    quality:usage(1, "inscribe")
    content.add(quality)
end
content.add(content.ToolQuality { id = "GLARE", name = ccb.content.text("glare protection") })
content.add(content.ToolQuality { id = "SHEAR", name = ccb.content.text("shearing") })
content.add(content.ToolQuality { id = "CHURN", name = ccb.content.text("churn") })
content.add(content.ToolQuality { id = "LEATHER_AWL", name = ccb.content.text("awl") })
content.add(content.ToolQuality { id = "SEW_CURVED", name = ccb.content.text("curved needle") })
content.add(content.ToolQuality { id = "ANESTHESIA", name = ccb.content.text("anesthesia") })
do
    local quality = content.ToolQuality { id = "FISHING_ROD", name = ccb.content.text("fishing", "tool_quality") }
    quality:usage(1, "FISH_ROD")
    content.add(quality)
end
do
    local quality = content.ToolQuality { id = "FISH_TRAP", name = ccb.content.text("fish trapping") }
    quality:usage(1, "FISH_TRAP")
    content.add(quality)
end
content.add(content.ToolQuality { id = "TREE_TAP", name = ccb.content.text("tree tapping") })
content.add(content.ToolQuality { id = "SMOOTH", name = ccb.content.text("smoothing") })
content.add(content.ToolQuality { id = "WELD", name = ccb.content.text("welding", "tool_quality") })
content.add(content.ToolQuality { id = "HACK", name = ccb.content.text("hacking", "tool_quality") })
content.add(content.ToolQuality { id = "HAMMER", name = ccb.content.text("hammering") })
content.add(content.ToolQuality { id = "HAMMER_FINE", name = ccb.content.text("fine hammering") })
content.add(content.ToolQuality { id = "HAMMER_SOFT", name = ccb.content.text("soft hammering") })
do
    local quality = content.ToolQuality { id = "SAW_W", name = ccb.content.text("wood sawing") }
    quality:usage(2, "LUMBER")
    quality:usage(2, "saw_stock")
    content.add(quality)
end
do
    local quality = content.ToolQuality { id = "SAW_M", name = ccb.content.text("metal sawing") }
    quality:usage(2, "HACKSAW")
    quality:usage(2, "saw_barrel")
    content.add(quality)
end
content.add(content.ToolQuality { id = "SAW_M_FINE", name = ccb.content.text("fine metal sawing") })
content.add(content.ToolQuality { id = "COOK", name = ccb.content.text("food cooking") })
content.add(content.ToolQuality { id = "HOTPLATE", name = ccb.content.text("hotplate") })
content.add(content.ToolQuality { id = "BOIL", name = ccb.content.text("boiling") })
content.add(content.ToolQuality { id = "CONTAIN", name = ccb.content.text("containing") })
content.add(content.ToolQuality { id = "CHEM", name = ccb.content.text("chemical making") })
content.add(content.ToolQuality { id = "SIEVE", name = ccb.content.text("sieving") })
content.add(content.ToolQuality { id = "WINNOW", name = ccb.content.text("winnowing") })
content.add(content.ToolQuality { id = "STRAIN", name = ccb.content.text("straining") })
content.add(content.ToolQuality { id = "SMOKE_PIPE", name = ccb.content.text("smoking") })
content.add(content.ToolQuality { id = "DISTILL", name = ccb.content.text("distilling") })
do
    local quality = content.ToolQuality { id = "AXE", name = ccb.content.text("tree cutting") }
    quality:usage(1, "CHOP_TREE")
    quality:usage(1, "CHOP_LOGS")
    quality:usage(2, "LUMBER")
    content.add(quality)
end
do
    local quality = content.ToolQuality { id = "DIG", name = ccb.content.text("digging") }
    quality:usage(1, "MAKEMOUND")
    quality:usage(1, "DIG")
    quality:usage(1, "FILL_PIT")
    quality:usage(1, "DIG_CHANNEL")
    quality:usage(2, "CLEAR_RUBBLE")
    content.add(quality)
end
content.add(content.ToolQuality { id = "WRENCH", name = ccb.content.text("bolt turning") })
content.add(content.ToolQuality { id = "WRENCH_FINE", name = ccb.content.text("fine bolt turning") })
do
    local quality = content.ToolQuality { id = "SCREW", name = ccb.content.text("screw driving") }
    quality:usage(1, "REMOVE_ALL_MODS")
    content.add(quality)
end
content.add(content.ToolQuality { id = "SCREW_FINE", name = ccb.content.text("fine screw driving") })
content.add(content.ToolQuality { id = "BUTCHER", name = ccb.content.text("butchering", "tool_quality") })
content.add(content.ToolQuality { id = "DRILL", name = ccb.content.text("drilling", "tool_quality") })
content.add(content.ToolQuality { id = "DRILL_ROCK", name = ccb.content.text("rock drilling") })
content.add(content.ToolQuality { id = "PRY", name = ccb.content.text("prying") })
content.add(content.ToolQuality { id = "PRYING_NAIL", name = ccb.content.text("nail prying") })
content.add(content.ToolQuality { id = "PUNCH", name = ccb.content.text("punch") })
content.add(content.ToolQuality { id = "WRITE", name = ccb.content.text("pencil") })
content.add(content.ToolQuality { id = "LIFT", name = ccb.content.text("lifting") })
content.add(content.ToolQuality { id = "JACK", name = ccb.content.text("jacking") })
content.add(content.ToolQuality { id = "SELF_JACK", name = ccb.content.text("self jacking") })
do
    local quality = content.ToolQuality { id = "HOSE", name = ccb.content.text("siphoning") }
    quality:usage(1, "SIPHON")
    content.add(quality)
end
content.add(content.ToolQuality { id = "CHISEL", name = ccb.content.text("chiseling") })
content.add(content.ToolQuality { id = "CHISEL_WOOD", name = ccb.content.text("wood chiseling") })
content.add(content.ToolQuality { id = "SEW", name = ccb.content.text("sewing") })
content.add(content.ToolQuality { id = "KNIT", name = ccb.content.text("knitting", "tool_quality") })
content.add(content.ToolQuality { id = "PULL", name = ccb.content.text("bullet pulling") })
content.add(content.ToolQuality { id = "ANVIL", name = ccb.content.text("anvil", "tool_quality") })
-- A category meant to include various ways of identifying that the chemical you have is the chemical you want.
-- analysis 1 is very basic stuff, eg. melting point determination or spectrophotometry.
-- analysis 2 and 3 imply increasing degrees of precision.
content.add(content.ToolQuality { id = "ANALYSIS", name = ccb.content.text("analysis") })
-- Meant to represent a wide range of chemical functions to increase the concentration of a substance without changing state or solvent.
-- Good examples might be rotary evaporation or centrifugation
content.add(content.ToolQuality { id = "CONCENTRATE", name = ccb.content.text("concentration") })
-- This is to represent separating things that aren't separated by distillation or chromatography.
-- Good example: a separation funnel which separates hydrophilic/phobic chemicals.
content.add(content.ToolQuality { id = "SEPARATE", name = ccb.content.text("separation") })
-- Fine distillation is about precisely separating specific components.
-- This is in contrast to high level normal distillation which is more about high output.
content.add(content.ToolQuality { id = "FINE_DISTILL", name = ccb.content.text("fine distillation") })
-- Think of this as 'fine separating'. Chromatography represents a number of precise separation techniques
-- useful in both analysis and purification.
content.add(content.ToolQuality { id = "CHROMATOGRAPHY", name = ccb.content.text("chromatography") })
-- Tools specifically for turning wood into musical instruments.  Used for a complete tool kit of objects required for this process.
content.add(content.ToolQuality { id = "LUTHIER", name = ccb.content.text("luthier") })
content.add(content.ToolQuality { id = "SNOW_MAKING", name = ccb.content.text("snow making") })
content.add(content.ToolQuality { id = "GRIND", name = ccb.content.text("grinding") })
content.add(content.ToolQuality { id = "FINE_GRIND", name = ccb.content.text("fine grinding") })
content.add(content.ToolQuality { id = "REAM", name = ccb.content.text("reaming") })
content.add(content.ToolQuality { id = "FILE", name = ccb.content.text("filing") })
content.add(content.ToolQuality { id = "VISE", name = ccb.content.text("clamping") })
content.add(content.ToolQuality { id = "PRESSURIZATION", name = ccb.content.text("pressurizing") })
do
    local quality = content.ToolQuality { id = "LOCKPICK", name = ccb.content.text("lockpicking", "tool_quality") }
    quality:usage(1, "PICK_LOCK")
    content.add(quality)
end
content.add(content.ToolQuality { id = "EXTRACT", name = ccb.content.text("extraction") })
content.add(content.ToolQuality { id = "FILTER", name = ccb.content.text("filtration") })
-- Conceptually similar to lifting, except items with suspending do not move.
content.add(content.ToolQuality { id = "SUSPENDING", name = ccb.content.text("suspending") })
content.add(content.ToolQuality { id = "ROPE", name = ccb.content.text("rope") })
-- A flat surface, like a table or a mat. 1 would be the size of a cutting board.
content.add(content.ToolQuality { id = "SURFACE", name = ccb.content.text("clean surface") })
-- A tool that is capable of manipulating the lug nuts of a vehicle's wheels or smaller to replace or fasten them.
content.add(content.ToolQuality { id = "WHEEL_FAST", name = ccb.content.text("wheel fastening") })
-- A tool that is capable of charging something with electricity.
content.add(content.ToolQuality { id = "JUMPSTART", name = ccb.content.text("jump starting") })
-- A tool that shares a large number of qualities with cutting tools, with the added benefit of being suitable for cutting fabric to patterned shapes for tailoring.
do
    local quality = content.ToolQuality { id = "FABRIC_CUT", name = ccb.content.text("fabric cutting") }
    quality:usage(1, "salvage")
    quality:usage(1, "inscribe")
    content.add(quality)
end
-- A category for items that allow the even applicaton of heat to a contained object.
-- oven 1 represents makeshift ovens.
-- oven 2 represents purpose built ovens with basic temperature reglation, including dutch ovens and similar.
-- oven 3 represents professional ovens with fine-grained temperature regulation, suitable for the most demanding culinary application.
content.add(content.ToolQuality { id = "OVEN", name = ccb.content.text("oven cooking") })
-- A catchall for firearms so they can be used in practice recipes.
content.add(content.ToolQuality { id = "GUN", name = ccb.content.text("firearm practice") })
-- A catchall for firearms so they can be used in practice recipes.
content.add(content.ToolQuality { id = "RIFLE", name = ccb.content.text("rifle practice") })
-- A catchall for firearms so they can be used in practice recipes.
content.add(content.ToolQuality { id = "SHOTGUN", name = ccb.content.text("shotgun practice") })
-- A catchall for firearms so they can be used in practice recipes.
content.add(content.ToolQuality { id = "SMG", name = ccb.content.text("submachine gun practice") })
-- A catchall for firearms so they can be used in practice recipes.
content.add(content.ToolQuality { id = "PISTOL", name = ccb.content.text("pistol practice") })
content.add(content.ToolQuality { id = "CUT_GLASS", name = ccb.content.text("glass cutting") })
content.add(content.ToolQuality { id = "MOP", name = ccb.content.text("mopping", "tool_quality") })
content.add(content.ToolQuality { id = "BLOW_HOT_AIR", name = ccb.content.text("hot air blowing") })
content.add(content.ToolQuality { id = "THREAD_CUT", name = ccb.content.text("thread cutting") })
content.add(content.ToolQuality { id = "THREAD_TAP", name = ccb.content.text("thread tapping") })
-- If item can be used to ignite matches.
content.add(content.ToolQuality { id = "STRIKING_SURFACE", name = ccb.content.text("striking surface") })
-- An item that can be used to temper metal with. Levels corresponds to size of metal that can be reasonably tempered
content.add(content.ToolQuality { id = "TEMPER", name = ccb.content.text("tempering", "tool_quality") })
