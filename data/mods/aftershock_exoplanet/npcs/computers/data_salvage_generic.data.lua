local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "COMPUTER_GENERIC_SALVAGE_LOCKED",
    line = {
        joined = {
            ccb.content.text("&</color><color_white>─╬─</color><color_pink>    </color><color_white>│</color><color_pink>                                </color><color_white>│</color><color_pink>    </color><color_white>─╬─\n</color>                                                \n<color_red> - RESTRICTED </color><color_white>┐</color><color_red> RESTRICTED - RESTRICTED - RESTRI\n      </color><color_blue>███</color><color_pink> ███∞</color><color_white>│</color><color_pink>                                 \n                             </color><color_white>┐</color><color_pink>                  \n          </color><color_blue>███</color><color_pink> ██     </color><color_blue>███</color><color_pink> </color><color_pink>███∞</color><color_white>│</color><color_pink>              </color><color_pink>███</color><color_pink> \n</color><color_red>ICTED - RE</color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_red>- RESTRICTED - RESTRICTED - R\n</color><color_white>          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>                             \n           </color><color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>  </color><color_white>MERCURIAL</color><color_pink> GENOMICS  </color><color_white>│</color><color_white>      \n<color_pink>             ██</color><color_blue>█████</color><color_pink>∞</color><color_white>│</color><color_white>                          \n          <color_pink>██</color>   <color_blue>██</color><color_pink>∞</color><color_white>│</color><color_white>                             \n        <color_pink>████</color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_white>  </color><color_pink>Colonial Monitor             \n          </color> <color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>  </color><color_blue>SALUS</color><color_white> </color><color_blue>IV</color><color_white>                   \n          </color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>████</color><color_white>∞</color><color_pink>│                            \n<color_pink>         :::::::██</color><color_white>∞</color><color_pink>│                            \n        </color><color_white>└───────::∞</color><color_pink>│             ███ </color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_pink>  Colo\n<color_pink>                ───┘                            \n</color><color_red> RESTRICTED - RESTRICTED - RESTRICTED - RESTRICT\n</color><color_white>                                                \n</color><color_white>─╬─</color><color_white>    </color><color_white>│</color><color_white>                                </color><color_white>│</color><color_white>    </color><color_white>─╬─\n</color><color_white>                                                \n"),
            ccb.content.text("                  AWAITING INPUT"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Attempt system recovery."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_aftershock_exoplanet_3453aafa2375") },
            success = { next_topic = "COMPUTER_GENERIC_SALVAGE_SUCCESS" },
            failure = { next_topic = "COMPUTER_GENERIC_SALVAGE_FAIL" },
        },
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMPUTER_GENERIC_SALVAGE_SUCCESS",
    line = {
        joined = {
            ccb.content.text("&</color><color_white>─╬─</color><color_pink>    </color><color_white>│</color><color_pink>                                </color><color_white>│</color><color_pink>    </color><color_white>─╬─\n</color>                                                \n<color_red> - RESTRICTED </color><color_white>┐</color><color_red> RESTRICTED - RESTRICTED - RESTRI\n      </color><color_blue>███</color><color_pink> ███∞</color><color_white>│</color><color_pink>                                 \n                             </color><color_white>┐</color><color_pink>                  \n          </color><color_blue>███</color><color_pink> ██     </color><color_blue>███</color><color_pink> </color><color_pink>███∞</color><color_white>│</color><color_pink>              </color><color_pink>███</color><color_pink> \n</color><color_red>ICTED - RE</color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_red>- RESTRICTED - RESTRICTED - R\n</color><color_white>          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>                             \n           </color><color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>  </color><color_white>MERCURIAL</color><color_pink> GENOMICS  </color><color_white>│</color><color_white>      \n<color_pink>             ██</color><color_blue>█████</color><color_pink>∞</color><color_white>│</color><color_white>                          \n          <color_pink>██</color>   <color_blue>██</color><color_pink>∞</color><color_white>│</color><color_white>                             \n        <color_pink>████</color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_white>  </color><color_pink>Colonial Monitor             \n          </color> <color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>  </color><color_blue>SALUS</color><color_white> </color><color_blue>IV</color><color_white>                   \n          </color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>████</color><color_white>∞</color><color_pink>│                            \n<color_pink>         :::::::██</color><color_white>∞</color><color_pink>│                            \n        </color><color_white>└───────::∞</color><color_pink>│             ███ </color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_pink>  Colo\n<color_pink>                ───┘                            \n</color><color_red> RESTRICTED - RESTRICTED - RESTRICTED - RESTRICT\n</color><color_white>                                                \n</color><color_white>─╬─</color><color_white>    </color><color_white>│</color><color_white>                                </color><color_white>│</color><color_white>    </color><color_white>─╬─\n</color><color_white>                                                \n"),
            ccb.content.text("   DISC CHK : ███████████████ 100% (COMPLETE)\n\n            Operation Successful."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Extract data from the disc."),
            when = predicates.handler("w16b_p_aftershock_exoplanet_dd3204339ab9"),
            show_always = true,
            show_reason = "Requires powered personal computer with archiving software.",
            trial = { kind = "condition", when = predicates.handler("w16b_p_aftershock_exoplanet_9c96fef38faa") },
            success = { next_topic = "COMPUTER_GENERIC_SALVAGE_COPIED" },
            failure = { next_topic = "COMPUTER_GENERIC_SALVAGE_FAIL" },
        },
        {
            text = ccb.content.text("Shut down the computer."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_a78b9e659073") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMPUTER_GENERIC_SALVAGE_FAIL",
    line = {
        joined = {
            ccb.content.text("&</color><color_white>─╬─</color><color_pink>    </color><color_white>│</color><color_pink>                                </color><color_white>│</color><color_pink>    </color><color_white>─╬─\n</color>                                                \n<color_red> - RESTRICTED </color><color_white>┐</color><color_red> RESTRICTED - RESTRICTED - RESTRI\n      </color><color_blue>███</color><color_pink> ███∞</color><color_white>│</color><color_pink>                                 \n                             </color><color_white>┐</color><color_pink>                  \n          </color><color_blue>███</color><color_pink> ██     </color><color_blue>███</color><color_pink> </color><color_pink>███∞</color><color_white>│</color><color_pink>              </color><color_pink>███</color><color_pink> \n</color><color_red>ICTED - RE</color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_red>- RESTRICTED - RESTRICTED - R\n</color><color_white>          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>                             \n           </color><color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>  </color><color_white>MERCURIAL</color><color_pink> GENOMICS  </color><color_white>│</color><color_white>      \n<color_pink>             ██</color><color_blue>█████</color><color_pink>∞</color><color_white>│</color><color_white>                          \n          <color_pink>██</color>   <color_blue>██</color><color_pink>∞</color><color_white>│</color><color_white>                             \n        <color_pink>████</color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_white>  </color><color_pink>Colonial Monitor             \n          </color> <color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>  </color><color_blue>SALUS</color><color_white> </color><color_blue>IV</color><color_white>                   \n          </color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>████</color><color_white>∞</color><color_pink>│                            \n<color_pink>         :::::::██</color><color_white>∞</color><color_pink>│                            \n        </color><color_white>└───────::∞</color><color_pink>│             ███ </color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_pink>  Colo\n<color_pink>                ───┘                            \n</color><color_red> RESTRICTED - RESTRICTED - RESTRICTED - RESTRICT\n</color><color_white>                                                \n</color><color_white>─╬─</color><color_white>    </color><color_white>│</color><color_white>                                </color><color_white>│</color><color_white>    </color><color_white>─╬─\n</color><color_white>                                                \n"),
            ccb.content.text("<color_red>                     ERROR</color>"),
        },
    },
    replies = {
        {
            text = ccb.content.text("[…]"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_a78b9e659073") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "COMPUTER_GENERIC_SALVAGE_COPIED",
    line = {
        joined = {
            ccb.content.text("&</color><color_white>─╬─</color><color_pink>    </color><color_white>│</color><color_pink>                                </color><color_white>│</color><color_pink>    </color><color_white>─╬─\n</color>                                                \n<color_red> - RESTRICTED </color><color_white>┐</color><color_red> RESTRICTED - RESTRICTED - RESTRI\n      </color><color_blue>███</color><color_pink> ███∞</color><color_white>│</color><color_pink>                                 \n                             </color><color_white>┐</color><color_pink>                  \n          </color><color_blue>███</color><color_pink> ██     </color><color_blue>███</color><color_pink> </color><color_pink>███∞</color><color_white>│</color><color_pink>              </color><color_pink>███</color><color_pink> \n</color><color_red>ICTED - RE</color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_red>- RESTRICTED - RESTRICTED - R\n</color><color_white>          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>                             \n           </color><color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>  </color><color_white>MERCURIAL</color><color_pink> GENOMICS  </color><color_white>│</color><color_white>      \n<color_pink>             ██</color><color_blue>█████</color><color_pink>∞</color><color_white>│</color><color_white>                          \n          <color_pink>██</color>   <color_blue>██</color><color_pink>∞</color><color_white>│</color><color_white>                             \n        <color_pink>████</color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_white>  </color><color_pink>Colonial Monitor             \n          </color> <color_blue>█████</color> <color_pink>∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>███∞</color><color_white>│</color><color_white>  </color><color_blue>SALUS</color><color_white> </color><color_blue>IV</color><color_white>                   \n          </color><color_blue>██</color> <color_pink>█</color> <color_pink>██∞</color><color_white>│</color><color_white>                             \n          </color><color_blue>███</color> <color_pink>████</color><color_white>∞</color><color_pink>│                            \n<color_pink>         :::::::██</color><color_white>∞</color><color_pink>│                            \n        </color><color_white>└───────::∞</color><color_pink>│             ███ </color><color_blue>███</color><color_pink>∞</color><color_white>│</color><color_pink>  Colo\n<color_pink>                ───┘                            \n</color><color_red> RESTRICTED - RESTRICTED - RESTRICTED - RESTRICT\n</color><color_white>                                                \n</color><color_white>─╬─</color><color_white>    </color><color_white>│</color><color_white>                                </color><color_white>│</color><color_white>    </color><color_white>─╬─\n</color><color_white>                                                \n"),
            ccb.content.text("<color_red>**Archive Complete**</color>"),
        },
    },
    on_enter = {
        { actions = { actions.handler("w16b_a_aftershock_exoplanet_2e02c6732904") } },
    },
    replies = {
        {
            text = ccb.content.text("Copy the archived data."),
            false_text = ccb.content.text("This archive contains no new information."),
            text_when = predicates.handler("w16b_p_aftershock_exoplanet_cf103714d71e"),
            next_topic = "COMPUTER_GENERIC_SALVAGE_FAIL",
            actions = { actions.handler("w16b_a_aftershock_exoplanet_596ab37fe21f") },
        },
    },
}
