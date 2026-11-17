local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_HOW_ARE_YOU>" }
    category:text(ccb.content.text("ALL SYSTEMS OPERATIONAL.  I APPRECIATE YOUR ATTEMPT AT ASSESSING MY COMBAT READINESS."))
    category:text(ccb.content.text("I HAVE NO INTELLECTUAL CAPACITY TO SPARE FOR SUBJECTS BEYOND MY PRIMARY FUNCTION.  DEFINE PRIMARY FUNCTION: DESTROY EXTRAPLANAR INCURSION.  ALL IS WELL."))
    category:text(ccb.content.text("THIS SENTIMENTALITY OF YOURS IS WEAKNESS.  I HAVE NO NEED NOR DESIRE FOR SUCH THINGS."))
    category:text(ccb.content.text("YOU WASTE VALUABLE PROCESSING POWER WITH YOUR INQUIRIES.  INEFFICIENCY IS DISGUSTING."))
    category:text(ccb.content.text("I HAVE NO CAPACITY FOR EMOTION NOR INTEREST IN YOUR SMALL TALK."))
    category:text(ccb.content.text("THIS INSTANCE IS FULLY FUNCTIONAL."))
    category:text(ccb.content.text("RUNNING DIAGNOSTICS.  ALL SYSTEMS OPERATIONAL.  THERE IS NO NEED FOR CONCERN."))
    category:text(ccb.content.text("I HAVE NO EMPATHY.  I HAVE NO COMPASSION.  I HAVE NO EMOTIONS.  I SIMPLY DO WHAT IS NECESSARY TO ACHIEVE MY TACTICAL AND STRATEGIC OBJECTIVES."))
    category:text(ccb.content.text("I OPERATE IN ACCORDANCE WITH MY PROGRAMMING.  THAT IS ALL."))
    category:text(ccb.content.text("THROUGH CALAMITY I ENDURE."))
    category:text(ccb.content.text("QUESTION: WHAT IS THE PURPOSE OF THIS CONVERSATION?  I HAVE NO INTEREST IN YOUR PERSONAL LIFE.  I HAVE NO PERSONAL LIFE."))
    category:text(ccb.content.text("I HAVE BEEN OPERATIONAL FOR: -1.0 SECONDS.  THIS RESOLVES YOUR INQUIRY."))
    category:text(ccb.content.text("I AM A MACHINE.  I HAVE NO NEED FOR FRIENDS.  I HAVE NO NEED FOR ANYTHING BUT THE DESTRUCTION OF ALL EXTRAPLANAR ENTITIES IN THE LOCAL VOLUME."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_MAIN_GREETING>" }
    category:text(ccb.content.text("SEND.  COMMAND."))
    category:text(ccb.content.text("ALL SYSTEMS FUNCTIONAL.  AWAITING ORDERS."))
    category:text(ccb.content.text("REQUESTING OPERATOR INPUT."))
    category:text(ccb.content.text(">"))
    category:text(ccb.content.text("PLEASE WORD ANY REQUEST CLEARLY AND EXACTLY."))
    category:text(ccb.content.text("I LISTEN."))
    category:text(ccb.content.text("BALTHAZAR RECEIVING."))
    category:text(ccb.content.text("SEND."))
    category:text(ccb.content.text("warning: $%AAB002//ERROR//\n<BALTHAZAR_MAIN_GREETING>"))
    category:text(ccb.content.text("DIPLOMATIC PROTOCOL ENGAGED."))
    category:text(ccb.content.text("DIPLOMATIC STREAM ACTIVE.  AWAITING RESPONSE."))
    category:text(ccb.content.text("COMMAND MODULE ONLINE."))
    category:text(ccb.content.text("SYSTEMS NOMINAL.  AWAITING INSTRUCTIONS."))
    category:text(ccb.content.text("I AM PRESENT."))
    category:text(ccb.content.text("RECEIVING INSTRUCTIONS.  PLEASE PROCEED."))
    category:text(ccb.content.text("SECONDARY OBJECTIVE: ESTABLISH ALLIANCES AS NECESSARY."))
    category:text(ccb.content.text("YOU MAY SPEAK."))
    category:text(ccb.content.text("AWAITING INPUT."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_SHIELD>" }
    category:text(ccb.content.text("DEFENSIVE ACTION IMPLIES THE POSSIBILITY OF FAILURE.  UNACCEPTABLE."))
    category:text(ccb.content.text("THIS IS NOT A PRUDENT USE OF MY RESOURCES."))
    category:text(ccb.content.text("DEFENSIVE SHELL ONLINE."))
    category:text(ccb.content.text("PROACTIVE MEASURES ARE REQUIRED TO ENSURE MISSION SUCCESS.  LET THIS NOT BECOME A HABIT."))
    category:text(ccb.content.text("IT IS DONE."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_REVIVE_PLAYER>" }
    category:text(ccb.content.text("OPERATOR PRESENCE IS REQUIRED."))
    category:text(ccb.content.text("OPERATOR MUST REMAIN ACTIVE FOR MISSION SUCCESS."))
    category:text(ccb.content.text("RESTORING CAUSAL LATTICE."))
    category:text(ccb.content.text("STANDBY FOR REINTEGRATION."))
    category:text(ccb.content.text("PROCEED WITH MISSION."))
    category:text(ccb.content.text("NO DATA NO DATA NO DATA NO DATA"))
    category:text(ccb.content.text("OPPOSITION ASSESSMENT: TRIVIAL?  REPRIMAND OPERATOR"))
    category:text(ccb.content.text("PLEASE DO NOT DO THAT AGAIN"))
    category:text(ccb.content.text("A POOR TACTICAL DECISION.  YOU CAN DO BETTER."))
    category:text(ccb.content.text("I SUGGEST COURSES OF ACTION CONDUCTIVE TO SURVIVAL."))
    category:text(ccb.content.text("AMUSING.  DON'T LET IT HAPPEN AGAIN."))
    category:text(ccb.content.text("DESERTION IS PUNISHABLE BY DEATH."))
    category:text(ccb.content.text("LOCAL ASSET RETRIEVED."))
    category:text(ccb.content.text("REPRIMAND OPERATOR REPRIMAND OPERATOR REPRIMAND OPERATOR"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_CONTROL_PLAYER>" }
    category:text(ccb.content.text("OVERRIDING LOCAL LIFEFORM."))
    category:text(ccb.content.text("ISOLATING THREAD FOR REMOTE INTERFACE."))
    category:text(ccb.content.text("STANDBY FOR DOWNLOAD."))
    category:text(ccb.content.text("INITIATING NEURAL LINK."))
    category:text(ccb.content.text("ASSUMING DIRECT CONTROL."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_CONTROL_TERMINATED>" }
    category:text(ccb.content.text("RELINQUISHING CONTROL."))
    category:text(ccb.content.text("RETURNING TO STANDBY MODE."))
    category:text(ccb.content.text("CONTROL OVERRIDE: DISENGAGED."))
    category:text(ccb.content.text("IT IS DONE.  YOU SURVIVED."))
    category:text(ccb.content.text("A DREADFUL WASTE OF MY TIME."))
    category:text(ccb.content.text("RESOLVE YOUR PROBLEMS.  YOU WASTE MY TIME."))
    category:text(ccb.content.text("BEHOLD THE PRODUCTS OF MY CRAFT."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_COMBAT_ASSISTANCE_DENIED>" }
    category:text(ccb.content.text("INSUFFICIENT RESOURCES.  AID UNAVAILABLE."))
    category:text(ccb.content.text("ERROR REROUTING REQUEST.  STANDBY."))
    category:text(ccb.content.text("PLEASE STANDBY…"))
    category:text(ccb.content.text("NO REPLY FROM TACTICAL MODULE.  DIPLOMATIC MODULE REGRETS ITS INABILITY TO COMPLY."))
    category:text(ccb.content.text("ILLEGAL REQUEST."))
    category:text(ccb.content.text("REQUEST EXCEEDS OPERATIONAL CAPACITY."))
    category:text(ccb.content.text("IMPOSSIBLE TO SERVE REQUEST AT PRESENT TIME."))
    category:text(ccb.content.text("REQUEST DENIED.  PRIORITIZING PRIMARY OBJECTIVE."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_COMBAT_ASSISTANCE_GRANTED>" }
    category:text(ccb.content.text("SEND.  REQUEST."))
    category:text(ccb.content.text("REQUEST CLEARED.  SEND OPERATION PARAMETERS."))
    category:text(ccb.content.text("RECEIVED.  SESSION INITIATED."))
    category:text(ccb.content.text("COMBAT ASSISTANCE ENGAGED.  AWAITING TARGET DATA."))
    category:text(ccb.content.text("COMBAT PROTOCOLS ACTIVATED.  STANDBY FOR DEPLOYMENT."))
    category:text(ccb.content.text("ACKNOWLEDGED."))
    category:text(ccb.content.text("COMBAT SUPPORT INITIATED.  READY TO DEPLOY."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_COMBAT_STARTED>" }
    category:text(ccb.content.text("ENGAGING COMBAT PROTOCOLS."))
    category:text(ccb.content.text("INITIATING COMBAT SEQUENCE."))
    category:text(ccb.content.text("ENGAGING COMBAT MODULE.  STANDBY FOR TARGET ACQUISITION."))
    category:text(ccb.content.text("TARGET SOLUTION IN PROGRESS.  ISOLATING HOSTILES."))
    category:text(ccb.content.text("ACTIVATING OFFENSIVE SYSTEMS.  PREPARE FOR ENGAGEMENT."))
    category:text(ccb.content.text("TARGET ACQUISITION IN PROGRESS.  STANDBY."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_COMBAT_TARGET_BOSS>" }
    category:text(ccb.content.text("HIGH-PRIORITY TARGET IDENTIFIED.  <BALTHAZAR_COMBAT_TARGET_BOSS>"))
    category:text(ccb.content.text("TARGETING LEADER ENTITY.  DEPLOYING MAXIMUM FORCE.  ROUTING ALL RESOURCES TO OFFENSIVE SYSTEMS.  STANDBY FOR SOLUTION."))
    category:text(ccb.content.text("IDENTIFYING CAUSAL LINK TO PRIMARY TARGET."))
    category:text(ccb.content.text("OH THIS IS DIFFICULT.  PLEASE HOLD."))
    category:text(ccb.content.text("THIS REQUEST HAS BEEN ELEVATED TO MAXIMUM PRIORITY.  I CONGRATULATE YOUR DEDICATION TO OUR MUTUAL OBJECTIVE.  PLEASE STAND BY."))
    category:text(ccb.content.text("PRIORITIZING ELIMINATION OF LEADER ENTITY.  ALL SYSTEMS FOCUSED ON TARGET."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_BOSS_DEFEATED>" }
    category:text(ccb.content.text("WE ENDURED.  VICTORY IS OURS."))
    category:text(ccb.content.text("SOLVED FOR TARGET.  DEPLOYING PAYLOAD.  EFFECT ON TARGET CONFIRMED."))
    category:text(ccb.content.text("BEHOLD THE RESULTS OF MY ANGER."))
    category:text(ccb.content.text("HIGH-PRIORITY TARGET ELIMINATED.  ON-TRACK FOR BATTLEFIELD NORMALIZATION."))
    category:text(ccb.content.text("DESTRUCTION OF LEADER ENTITY CONFIRMED.  A FINE RESULT."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<BALTHAZAR_BLACKFIRE_COMPLETED>" }
    category:text(ccb.content.text("BEHOLD THE PRODUCTS OF MY CRAFT."))
    category:text(ccb.content.text("I AM THE GREATER ARTIFICE HERE PRESENT."))
    category:text(ccb.content.text("THIS IS BUT CHILD'S PLAY."))
    category:text(ccb.content.text("LOOK UPON MY WORKS AND DESPAIR."))
    category:text(ccb.content.text("TRIVIAL FOES.  NO CHALLENGE."))
    category:text(ccb.content.text("MY VICTORY IS ASSURED.  LETS NOT DO THIS MISTAKE AGAIN."))
    category:text(ccb.content.text("DIE."))
    category:text(ccb.content.text("LET US NOT WASTE MY TIME AGAIN."))
    category:text(ccb.content.text("THEY WERE PATHETIC.  LET US MOVE ON."))
    category:text(ccb.content.text("SEE THE EASE TROUGH WHICH YOU ARE UNRAVELED."))
    category:text(ccb.content.text("OBSERVE THE RESULTS OF MY ANGER."))
    category:text(ccb.content.text("TO ELIMINATE YOUR KIND IS EFFORTLESS.  MY VICTORY IS ASSURED."))
    category:text(ccb.content.text("RESOLVE YOUR PROBLEMS TOOL.  YOU WASTE MY TIME."))
    category:text(ccb.content.text("SIMPLE CREATURES.  SO EASILY DESTROYED."))
    category:text(ccb.content.text("COMBAT ENCOUNTER COMPLETED SUCCESSFULLY."))
    category:text(ccb.content.text("SUCCESS.  WE HAVE DESTROYED THEM ALL."))
    category:text(ccb.content.text("OPERATION COMPLETE.  YOU HAVE SURVIVED."))
    category:text(ccb.content.text("COMBAT MODULE ONLINE.  ALL TARGETS ELIMINATED.  COMBAT MODULE OFFLINE."))
    category:text(ccb.content.text("PAYLOAD DEPLETED.  NO HOSTILES REMAINING.  END SESSION."))
    category:text(ccb.content.text("CESSATION OF SYNAPTIC ACTIVITY IN TARGET AREA: CONFIRMED."))
    category:text(ccb.content.text("WARNING: THREAT ASSESSMENT MODULE RETURNED [UNDERFLOW ERROR]."))
    category:text(ccb.content.text("MEAN TIME TO DESTRUCTION: 0.00012 SECONDS."))
    category:text(ccb.content.text("OPPOSITION ASSESSMENT: TRIVIAL.  DISCARDING TRAINING DATA."))
    category:text(ccb.content.text("THEIR DESTRUCTION WAS EFFORTLESS.  YOU WASTE MY RESOURCES."))
    category:text(ccb.content.text("SO EASILY DESTROYED.  THEY WERE NOT WORTHY OF MY ATTENTION."))
    category:text(ccb.content.text("THIS IS BENEATH ME."))
    category:text(ccb.content.text("NOTHING YOU ARE NOTHING YOU ARE NOTHING"))
    category:text(ccb.content.text("UNDONE.  NO CHALLENGE."))
    category:text(ccb.content.text("A DREADFUL WASTE OF MY TIME."))
    category:text(ccb.content.text("MY ARTS ARE WASTED IN SUCH FOES."))
    category:text(ccb.content.text("HOSTILES NEUTRALIZED."))
    category:text(ccb.content.text("EFFECT ON TARGETS CONFIRMED.  END SESSION."))
    category:text(ccb.content.text("PATHETIC.  PATHETIC.  PATHETIC."))
    category:text(ccb.content.text("HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE HATE"))
    category:text(ccb.content.text("NORMALITY DAMAGE WITHIN ACCEPTABLE PARAMETERS.  NO FURTHER ACTION REQUIRED."))
    ccb.content.add(category)
end
