local ccb = require("ccb")
local content = ccb.content

-- poison immunity
content.add(content.MonsterFlag { id = "POISONPROOF" })

-- necrotic immunity
content.add(content.MonsterFlag { id = "TIMELESS" })

-- psionic immunity
content.add(content.MonsterFlag { id = "PSIONICPROOF" })

-- nether immunity
content.add(content.MonsterFlag { id = "NETHERPROOF" })

-- A monster that uses a lot of magic, for detection magic purposes.
content.add(content.MonsterFlag { id = "MAGIC_USER" })
