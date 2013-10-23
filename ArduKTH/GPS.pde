// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-
//---------------------------------------------------------------------------
//  Jakob Kuttenkeuler, jakob@kth.se
//---------------------------------------------------------------------------

void print_GPS()
{
    hal.console->printf_P(PSTR("lat=%.5f, lon=%.5f, Alt=%.1fm sog=%.1fm/s cog=%.1f SAT=%d time=%lu status=%i\n"),
<<<<<<< HEAD
                          ToDeg(gps.lat),ToDeg(gps.lon),gps.alt,gps.sog,ToDeg(gps.cog), gps.nsats,  
                          (unsigned long)gps.time,  gps.status);
=======
              ToDeg(gps.lat),ToDeg(gps.lon),gps.alt,gps.sog,ToDeg(gps.cog), gps.nsats,  gps.time,  gps.status);
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
}
//uint8_t fix = gpsA->status();

//-------------------------------------------------------------------------------
void init_GPS()
{
<<<<<<< HEAD
    hal.console->printf_P(PSTR("  Init GPS:  "));
   hal.uartB->begin(38400);
   g_gps->init(hal.uartB, GPS::GPS_ENGINE_AIRBORNE_2G);
   wait_ms(200);         // Why do I have this here?
   hal.console->println_P(PSTR("  Done :-)"));
=======
   hal.console->printf_P(PSTR("  Init GPS:  \n"));
   hal.uartB->begin(38400);
   g_gps->init(hal.uartB, GPS::GPS_ENGINE_AIRBORNE_2G);
   wait_ms(200);         // Why do I have this here?
   hal.console->printf_P(PSTR("  Done :-)\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  }

//-------------------------------------------------------------------------------
void update_GPS()
{
    if (time_ms-last_GPS_fix>500){g_gps->update();}
    
    if (g_gps->new_data) {
        if (g_gps->fix) {
          gps.lat         = ToRad((float)(g_gps->latitude)/10000000);               // [rad]
          gps.lon         = ToRad((float)(g_gps->longitude)/10000000);              // [rad]
          gps.alt         = (float)g_gps->altitude_cm / 100.0;                      // [m]
          gps.cog         = unwrap_2pi(ToRad((float)g_gps->ground_course_cd/100.0)); // [rad]
          gps.sog         = (float)g_gps->ground_speed_cm / 100.0;                  // [m/s]
          gps.time        = (uint32_t)g_gps->time;                                  // [???]
          gps.nsats       = (int)g_gps->num_sats;                                   // [-]
          gps.status      = (char)g_gps->status();
          last_GPS_fix    = time_ms;
          current_pos.lon = gps.lon;
          current_pos.lat = gps.lat;
          current_pos.alt = gps.alt;
          //print_GPS();
        } else {
<<<<<<< HEAD
            //hal.console->println_P(PSTR("No fix"));
=======
            //hal.console->println("No fix");
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
            // If fix very old, do death reconing
            //print_GPS();
        }
        g_gps->new_data = false;
    }
    else{
<<<<<<< HEAD
      //hal.console->println_P(PSTR("No GPS new data"));
=======
      //hal.console->println("No GPS new data");
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
    }
}
//-------------------------------------------------------------------------------








