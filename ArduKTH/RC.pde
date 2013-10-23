// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-
//---------------------------------------------------------------------------
// Jakob Kuttenkeuler, jakob@kth.se
//---------------------------------------------------------------------------

void arm_RC() {
<<<<<<< HEAD
 //hal.console->printf_P(PSTR("  Arming RC-channels.\n"));
=======
 //hal.console->printf("  Arming RC-channels.\n");
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
 hal.rcout->enable_ch(CH_1); 
 hal.rcout->enable_ch(CH_2); 
 hal.rcout->enable_ch(CH_3);
 hal.rcout->enable_ch(CH_4);
 hal.rcout->enable_ch(CH_5);
 hal.rcout->enable_ch(CH_6); 
 hal.rcout->enable_ch(CH_7);
 hal.rcout->enable_ch(CH_8);
}
//---------------------------------------------------------------------------
void disarm_RC() {
<<<<<<< HEAD
 //hal.console->printf_P(PSTR("  Disarming RC-channels. \n"));
=======
 //hal.console->printf("  Disarming RC-channels. \n");
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
 hal.rcout->disable_ch(CH_1); 
 hal.rcout->disable_ch(CH_2); 
 hal.rcout->disable_ch(CH_3);
 hal.rcout->disable_ch(CH_4);
 hal.rcout->disable_ch(CH_5);
 hal.rcout->disable_ch(CH_6); 
 hal.rcout->disable_ch(CH_7);
 hal.rcout->disable_ch(CH_8);
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

