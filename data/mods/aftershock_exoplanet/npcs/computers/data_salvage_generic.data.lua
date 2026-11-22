local ccb = require("ccb")
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
