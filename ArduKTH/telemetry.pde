// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-

// Here is a shange

//---------------------------------------------------------------------------
// Jakob Kuttenkeuler, jakob@kth.se
//---------------------------------------------------------------------------
char read_one_char_from_serial()
{
    char c = '_';   //'\0';
    uint32_t t0 = hal.scheduler->millis();
    while((hal.scheduler->millis()-t0)<100 && c=='_') {   
      c = (char)hal.console->read();  
    }
    return c;
}
//-------------------------------------------------------------------------------
bool shoul_be_this_char_at_serial(char c1){
  // Returns true if next byte was equal to c1 
  char c2 = read_one_char_from_serial();
  if (c1==c2) {return true;} else {return false;}
}
//-------------------------------------------------------------------------------
double get_a_float_field_from_serial(){  
    double val = NAN;
    char  str[20]; for (int ii=0; ii<20; ii++) { str[ii]=' ';}
    int   Nchar  = 0;
    char  ch     = 'x';
    uint32_t   t0 = hal.scheduler->millis();
    while(((hal.scheduler->millis()-t0)<1000) & (Nchar<20) & (ch!=','))
    {
       if (hal.console->available()){
         ch          = hal.console->read();
         str[Nchar]  = ch; 
         Nchar       += 1;
<<<<<<< HEAD
         //hal.console->printf_P(PSTR("%c"),ch);
       }    
    }
    val = atof(str);// atof
    //hal.console->printf_P(PSTR("Value = %f\n"),val);
=======
         //hal.console->printf_P(PSTR("%c",ch));
       }    
    }
    val = atof(str);// atof
    //hal.console->printf_P(PSTR("Value = %f\n",val));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
    return val;
}
//-------------------------------------------------------------------------------
void empty_serial_buffer(){
    while( hal.console->available() ) { hal.console->read(); }
}
//-------------------------------------------------------------------------------
void parse_PID_1()
{
   // Example  #1,11,22,333,1      (3 fields obviously :-)
   // #1,   99.9  ,21,31,1  
   hal.console->printf_P(PSTR("Parsing PID 1: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
<<<<<<< HEAD
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
=======
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   
   if (kP==NAN || kI==NAN || kD==NAN) {flag =false;} 
   if (!shoul_be_this_char_at_serial('1')){flag =false;} // Identidier check
   
   if (flag){
      pid_1.kP(kP); pid_1.kI(kI); pid_1.kD(kD);  pid_1.imax(500); pid_1.save_gains();
      hal.console->printf_P(PSTR("Ok\n"));
<<<<<<< HEAD
      hal.console->printf_P(PSTR("     PID 1  : P:%10.2f I:%10.2f D:%10.2f     \n"),pid_1.kP() ,pid_1.kI() , pid_1.kD() );
   }
   else{
       hal.console->printf_P(PSTR("Not Ok\n"));
=======
      print_settings();   
   }
   else{
      hal.console->printf_P(PSTR("Not Ok\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   } 
}
//-------------------------------------------------------------------------------
void parse_PID_2()
{
   // Example  #2,0000000011,0000000022,0000000333,2      (3 fields obviously :-)
<<<<<<< HEAD
    hal.console->printf_P(PSTR("Parsing PID 2: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
=======
   hal.console->printf_P(PSTR("Parsing PID 2: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   
   if (kP==NAN || kI==NAN || kD==NAN) {flag =false;} 
   if (!shoul_be_this_char_at_serial('2')){flag =false;} // Identidier check
   
   if (flag){
      pid_2.kP(kP); pid_2.kI(kI); pid_2.kD(kD);  pid_2.imax(500); pid_2.save_gains();
      hal.console->printf_P(PSTR("Ok\n")); 
<<<<<<< HEAD
      hal.console->printf_P(PSTR("     PID 2  : P:%10.2f I:%10.2f D:%10.2f     \n"),pid_2.kP() ,pid_2.kI() , pid_2.kD() );
   }
   else{
       hal.console->printf_P(PSTR("Not Ok\n"));
=======
      print_settings();  
   }
   else{
      hal.console->printf_P(PSTR("Not Ok\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   } 
}
//-------------------------------------------------------------------------------
void parse_PID_3()
{
   // Example  #3, 400, 0 ,  0 ,3      (3 fields obviously :-)
<<<<<<< HEAD
    hal.console->printf_P(PSTR("Parsing PID 3: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
=======
   hal.console->printf_P(PSTR("Parsing PID 3: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   
   if (kP==NAN || kI==NAN || kD==NAN) {flag =false;} 
   if (!shoul_be_this_char_at_serial('3')){flag =false;} // Identidier check
   
   if (flag){
      pid_3.kP(kP); pid_3.kI(kI); pid_3.kD(kD);  pid_3.imax(500); pid_3.save_gains();
      hal.console->printf_P(PSTR("Ok\n")); 
<<<<<<< HEAD
      hal.console->printf_P(PSTR("     PID 3  : P:%10.2f I:%10.2f D:%10.2f     \n"),pid_3.kP() ,pid_3.kI() , pid_3.kD() );
   }
   else{
       hal.console->printf_P(PSTR("Not Ok\n"));
=======
      print_settings();  
   }
   else{
      hal.console->printf_P(PSTR("Not Ok\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   } 
}
//-------------------------------------------------------------------------------
void parse_PID_4()
{
   // Example  #4, 400, 0 ,  0 ,3      (3 fields obviously :-)
   hal.console->printf_P(PSTR("Parsing PID 4: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
<<<<<<< HEAD
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
=======
   float kP = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kI = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
   float kD = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   
   if (kP==NAN || kI==NAN || kD==NAN) {flag =false;} 
   if (!shoul_be_this_char_at_serial('4')){flag =false;} // Identidier check
   
   if (flag){
      pid_4.kP(kP); pid_4.kI(kI); pid_4.kD(kD);  pid_4.imax(500); pid_4.save_gains();
      hal.console->printf_P(PSTR("Ok\n")); 
<<<<<<< HEAD
      hal.console->printf_P(PSTR("     PID 4  : P:%10.2f I:%10.2f D:%10.2f     \n"),pid_4.kP() ,pid_4.kI() , pid_4.kD() );
   }
   else{
       hal.console->printf_P(PSTR("Not Ok\n"));
=======
      print_settings();  
   }
   else{
      hal.console->printf_P(PSTR("Not Ok\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   } 
}

//-------------------------------------------------------------------------------
<<<<<<< HEAD
void parse_deviation_mission()
{
   // Format :  #d,pwm,d
   // Example:  #d,1600,d
   hal.console->printf_P(PSTR("Parsing Deviation mission: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
   int rpm_pwm = (int)get_a_float_field_from_serial(); 
   if (rpm_pwm<1000 || rpm_pwm>2000){flag=false;} 
   if (!shoul_be_this_char_at_serial('d')){flag =false;}
   if (flag==false){hal.console->printf_P(PSTR("   ... Sorry, parsing failed. \n")); return;}
  
   kill_mission();
   //hal.console->printf_P(PSTR("You wanna do Deviation, lets try :-)\n"));
   //start_Deviation_mission();
   mission_start_pos = current_pos;
   hal.console->printf_P(PSTR("\nStarting Deviation mission (at position %.5f,  %.5f)  \n"),ToDeg(mission_start_pos.lon), ToDeg(mission_start_pos.lat));
   arm_RC();
   target_rpm        = rpm_pwm;
=======
void do_deviation_mission()
{
   kill_mission();
   //hal.console->printf_P(PSTR("You wanna do Deviation, lets try :-)\n"));
  //start_Deviation_mission();
   mission_start_pos = current_pos;
   hal.console->printf_P(PSTR("\nStarting Deviation mission (at position %.5f,  %.5f)  \n"),ToDeg(mission_start_pos.lon), ToDeg(mission_start_pos.lat));
   arm_RC();
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   mission_start_ms  = time_ms; 
   mission_ms        = 0;
   current_leg_nr    = 0;
   ctrl_mode         = 'd';
<<<<<<< HEAD

   hal.console->printf_P(PSTR("Flirting with motor control..."));
   hal.rcout->write(CH_3,1500); // To make Motor-control happy
   hal.scheduler->delay(2000);  // Wait for Motor-control
=======
  
   hal.console->printf_P(PSTR("Flirting with motor control..."));
   hal.rcout->write(CH_3,1500); // To make Motor-control happy
   hal.scheduler->delay(2000); // Wait for Motor-control
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   hal.console->printf_P(PSTR(" done. \n"));   

}
//-------------------------------------------------------------------------------
void parse_k_Xtrack()
{
   // Example  #6,k_value,6   
   hal.console->printf_P(PSTR("Parsing Xtrak: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
<<<<<<< HEAD
   float k = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n"),f);
=======
   float k = (float)get_a_float_field_from_serial();  //hal.console->printf_P(PSTR("Float %.5f\n",f));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   
   if (k==NAN) {flag =false;} 
   if (!shoul_be_this_char_at_serial('6')){flag =false;} // Identidier check
   
   if (flag){
      k_xtrack = min(max(k,0.0),1.0);
      hal.console->printf_P(PSTR("Ok\n")); 
      print_settings();  
   }
   else{
<<<<<<< HEAD
       hal.console->printf_P(PSTR("Not Ok\n"));
=======
      hal.console->printf_P(PSTR("Not Ok\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   } 
}

//-------------------------------------------------------------------------------
void parse_CC_mission(){
  // Example   #C,  Nlegs  ,  duration,    course,     depth,       rpm,  duration,    course,     depth,       rpm,C
  //           #C,   2     ,    20    ,     123.4,       1  ,       1600,       20,       180,         2,       200,C
  // Kvadrat:  #C,4,    10, 0,0,0,  10,90,0,0,  10,180,0,0,    10,270,0,0,C
  kill_mission();
<<<<<<< HEAD
  hal.console->print("Parsing CC mission: ");
=======
  hal.console->printf_P(PSTR("Parsing CC mission: \n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  bool flag = true; // The flag saying "ok" or "not ok"
  if (!shoul_be_this_char_at_serial(',')){flag =false;}
  Nlegs_cc = (int)get_a_float_field_from_serial();  // Number of legs
  for (int ileg=0; ileg<Nlegs_cc ; ileg++){ 
     CC_mission[ileg].duration = (float)get_a_float_field_from_serial();
     CC_mission[ileg].course   = (float)ToRad((float)get_a_float_field_from_serial());
     CC_mission[ileg].depth    = (float)get_a_float_field_from_serial();
     CC_mission[ileg].rpm      = (float)get_a_float_field_from_serial();
     if (CC_mission[ileg].duration==NAN || CC_mission[ileg].course==NAN || CC_mission[ileg].depth==NAN  || CC_mission[ileg].rpm==NAN ) {flag =false;} 
   }
   if (!shoul_be_this_char_at_serial('C')){flag =false;} // Identifier check

   if (flag==true){
      //mission = prospect_mission;
      //for (int ii=0; ii<Nlegs; ii++) {mission[ii] = mission[ii]; }
<<<<<<< HEAD
       hal.console->printf_P(PSTR("Nlegs = %i\n"),Nlegs_cc);
      hal.console->print("Ok\n");   
      print_CC_mission();
   }
   else{
      hal.console->print("FAIL => I will therefor setup default mission.\n");
=======
      hal.console->printf_P(PSTR("Nlegs = %i \n"),Nlegs_cc);
      hal.console->printf_P(PSTR("Ok\n"));   
      print_CC_mission();
   }
   else{
      hal.console->printf_P(PSTR("FAIL => I will therefor setup default mission.\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
      setup_default_CC_mission();
   } 
}
//-------------------------------------------------------------------------------
<<<<<<< HEAD
static void parse_GPS_mission(){
=======
void parse_GPS_mission(){
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  //          #G,Nlegs,  lon,lat,depth,wp_radius,rpm,     lon,lat,depth,wp_radiusrpm,G
  // Example  #G,3, 18.07205,59.34837,0,20,1600, 18.26582,59.31257,0,20,1700, 18.07205,59.34837,0,20,1500,G
  //
  kill_mission();
<<<<<<< HEAD
  hal.console->print("Parsing GPS-mission: ");
=======
  hal.console->printf_P(PSTR("Parsing GPS-mission: \n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  bool flag = true; // The flag saying "ok" or "not ok"
  if (!shoul_be_this_char_at_serial(',')){flag =false;}
  Nlegs_GPS = (int)get_a_float_field_from_serial();  // Number of legs
  
  for (int ileg=0; ileg<Nlegs_GPS ; ileg++){ 
     GPS_mission[ileg].lon            = (float)ToRad((float)get_a_float_field_from_serial());
     GPS_mission[ileg].lat            = (float)ToRad((float)get_a_float_field_from_serial());
     GPS_mission[ileg].depth          = (float)get_a_float_field_from_serial();
     GPS_mission[ileg].wp_radius      = (float)get_a_float_field_from_serial();
     GPS_mission[ileg].rpm            = (float)get_a_float_field_from_serial();
   }
   if (!shoul_be_this_char_at_serial('G')){flag =false;} // Identifier check
 
   if (flag==true){
    //mission = prospect_mission;
    //for (int ii=0; ii<Nlegs; ii++) {mission[ii] = mission[ii]; }
<<<<<<< HEAD
       hal.console->printf_P(PSTR("Nlegs = %i\n"),Nlegs_GPS);
    hal.console->print("Ok\n");   
    print_GPS_mission();
   }
   else{
    hal.console->print("FAIL => I will therefor setup default mission.\n");
=======
    hal.console->printf_P(PSTR("Nlegs = %i\n"),Nlegs_GPS);
    hal.console->printf_P(PSTR("Ok\n"));   
    print_GPS_mission();
   }
   else{
    hal.console->printf_P(PSTR("FAIL => I will therefor setup default mission.\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
    setup_default_GPS_mission();
   }
}
//-------------------------------------------------------------------------------
<<<<<<< HEAD
static void parse_read_logs()  {
  uint16_t log_number=99999;
   if (!shoul_be_this_char_at_serial(',')){return;}
   log_number = (uint16_t) get_a_float_field_from_serial();
   if (log_number>0) {flash_read_all_packets(log_number);}
}
//-------------------------------------------------------------------------------
static void parse_crash_limits() {
   hal.console->printf_P(PSTR("Parsing Crash limits: "));
   bool flag =true; // The flag sayin "ok" or "not ok"
   if (!shoul_be_this_char_at_serial(',')){flag =false;}
   float a_prospect = (float)get_a_float_field_from_serial();
   float g_prospect  = (float)get_a_float_field_from_serial();
   if (!shoul_be_this_char_at_serial('X')){flag =false;}
   if (flag){
      accel_length_crash_threshold = a_prospect;
      gyro_length_crash_threshold  = g_prospect;
      hal.console->printf_P(PSTR(" ok :-) \n"));
   }
   else {
        hal.console->printf_P(PSTR(" sorry, I did not understand that :-( \n"));
   }
   hal.console->printf_P(PSTR("  accel_length_crash_threshold = %.2f \n"),accel_length_crash_threshold);
   hal.console->printf_P(PSTR("  gyro_length_crash_threshold  = %.2f \n"), gyro_length_crash_threshold);
 }
//-------------------------------------------------------------------------------

static void print_main_menu(){
    hal.console->println_P(PSTR("-----------------------------------------------------------------------------------------"));
    hal.console->println_P(PSTR("Craft:    #S Solar    #A AUV       #P Plane    #K Kite"));
    hal.console->println_P(PSTR("PID:      #x,kP,kI,kD,x        (PID controller no x) "));
    hal.console->println_P(PSTR("Mission:  #C Upload Compass mission,  Format  #C,Nlegs,  duration,cc,depth,rpm,          duration,cc,depth,rpm,C "));
    hal.console->println_P(PSTR("          #G Upload GPS mission,      Format  #G,Nlegs,  lon,lat,depth,wp_radius,rpm,    lon,lat,depth,wp_radiusrpm,G"));
    hal.console->println_P(PSTR("Run mode: #c Start  compass mission           #g Start GPS mission     #q Kill mission"));
    hal.console->println_P(PSTR("Log:      #s Send entire log  ex.  #s,4 "));
    hal.console->println_P(PSTR("          #E Erase all logs in Flash memory."));
    hal.console->println_P(PSTR("          #t Continuosly send"));
    hal.console->println_P(PSTR("          #a Print all status  "));
    hal.console->println_P(PSTR("          #d Start Deviation Mission"));
    hal.console->println_P(PSTR("          #X,acc,gyro,X  Set Crash limits on norm(accel) & norm(gyro) "));
    hal.console->println_P(PSTR("          #k X-track error compensation,  Example  #6,k_value,6 "));
  
    hal.console->println_P(PSTR("-----------------------------------------------------------------------------------------"));
=======
void print_main_menu()
{
  hal.console->printf_P(PSTR("-----------------------------------------------------------------------------------------\n"));
  hal.console->printf_P(PSTR("Craft:    #S Solar    #A AUV       #P Plane    #K Kite \n"));
  hal.console->printf_P(PSTR("PID:      #x,kP,kI,kD,x        (PID controller no x) \n"));
  hal.console->printf_P(PSTR("Mission:  #C Upload Compass mission,  Format  #C,Nlegs,  duration,cc,depth,rpm,          duration,cc,depth,rpm,C \n"));
  hal.console->printf_P(PSTR("          #G Upload GPS mission,      Format  #G,Nlegs,  lon,lat,depth,wp_radius,rpm,    lon,lat,depth,wp_radiusrpm,G\n"));
  hal.console->printf_P(PSTR("Run mode: #c Start  compass mission           #g Start GPS mission     #q Kill mission\n"));
  hal.console->printf_P(PSTR("Log:      #s Send entire log\n"));
  hal.console->printf_P(PSTR("          #t Continuosly send\n"));
  hal.console->printf_P(PSTR("          #a Print all status \n "));
  hal.console->printf_P(PSTR("          #d Start Deviation Mission\n"));
  hal.console->printf_P(PSTR("          #E Erase logs\n"));
  hal.console->printf_P(PSTR("          #k X-track error compensation,  Example  #6,k_value,6 \n"));
  
  hal.console->printf_P(PSTR("-----------------------------------------------------------------------------------------\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
}
//-------------------------------------------------------------------------------
void parse_incoming_telemetry()  {
   char Id = read_one_char_from_serial();
   switch ( Id ) {
     case '1': parse_PID_1();                break;
     case '2': parse_PID_2();                break;
     case '3': parse_PID_3();                break;
     case '4': parse_PID_4();                break;
     case 'a': print_settings();             break;
     case 'x': parse_k_Xtrack();             break;
     case 'S': kill_mission();Solar_craft_setup();          break;
<<<<<<< HEAD
     case 'E': kill_mission();erase_logs();                 break;
=======
     case 'E': erase_logs();                                break;
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
     case 'A': kill_mission();AUV_craft_setup();            break;
     case 'P': kill_mission();Plane_craft_setup();          break;
     case 'K': kill_mission();Kite_craft_setup();           break;
     case 'c': kill_mission();start_CC_mission();           break;
     case 'g': kill_mission();start_GPS_mission();          break;
     case 'C': kill_mission();parse_CC_mission();           break;
     case 'G': kill_mission();parse_GPS_mission();          break;
<<<<<<< HEAD
     case 'd': kill_mission();parse_deviation_mission();       break;
     case 'r': kill_mission(); ctrl_mode='r';  hal.console->printf_P(PSTR("\nRC dude\n"));break;
     case 't': continously_send=true; break;
     case 'q': kill_mission();break;
     case 'X': parse_crash_limits();break;
     case 's': kill_mission();continously_send=false;parse_read_logs();break;
=======
     case 'd': kill_mission();do_deviation_mission();       break;
     case 'r': kill_mission(); ctrl_mode='r';  hal.console->printf_P(PSTR("\nRC dude\n"));break;
     case 't': continously_send=true; break;
     case 'q': kill_mission();break;
     case 's': kill_mission();continously_send=false;flash_read_all_packets();break;
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
     default :  ;                     break;
   } 
   
}
//-------------------------------------------------------------------------------
void view_debug_data()
{
<<<<<<< HEAD
    hal.console->printf_P(PSTR("lat=%0.5f, lon=%0.5f, Alt=%.2fm sog=%.2fm/s cog=%.1f SAT=%d time=%lu status=%i\n"),
                          ToDeg(gps.lat),ToDeg(gps.lon),gps.alt,gps.sog,ToDeg(gps.cog), gps.nsats,  
                          (unsigned long)gps.time,  gps.status);
=======
  hal.console->printf_P(PSTR("lat=%0.5f, lon=%0.5f, Alt=%.2fm sog=%.2fm/s cog=%.1f SAT=%d time=%lu status=%i\n"),
              ToDeg(gps.lat),ToDeg(gps.lon),gps.alt,gps.sog,ToDeg(gps.cog), gps.nsats,  gps.time,  gps.status);
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  hal.console->printf_P(PSTR("cc=%4.1fdeg    roll=%0.1fdeg   pitch= %0.1fdeg \n"),ToDeg(heading),ToDeg(roll),ToDeg(pitch));
  hal.console->printf_P(PSTR("Acc=%4.2f,%4.2f,%4.2f (norm:%4.2f)  Gyro: %4.3f,%4.3f,%4.3f\n"),accel.x, accel.y, accel.z, accel.length(), gyro.x, gyro.y, gyro.z);
}
//-------------------------------------------------------------------------------
void print_settings(){
   hal.console->printf_P(PSTR("\n-----------------------------------------------------------------------------------------\n"));
   hal.console->printf_P(PSTR("<< Info dump >>\n"));
<<<<<<< HEAD
   hal.console->printf_P(PSTR("Memory free:  %u   (out of 8000 bytes)\n"),(unsigned) memcheck_available_memory());
   
   hal.console->printf_P(PSTR("     Craft type    = '%c'\n"),craft_type);
   hal.console->printf_P(PSTR("     Control mode  = '%c'\n"),ctrl_mode);
   hal.console->printf_P(PSTR("\n"));          
=======
   hal.console->printf_P(PSTR("Memory free:  %u bytes out of 8000 bytes installed.)\n"),(unsigned) memcheck_available_memory());
   
   hal.console->printf_P(PSTR("     Craft type    = '%c'\n"),craft_type);
   hal.console->printf_P(PSTR("     Control mode  = '%c'\n"),ctrl_mode);
   hal.console->printf("\n");          
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   hal.console->printf_P(PSTR("                   kP          kI         kD      \n"));
   hal.console->printf_P(PSTR("     PID 1  : %10.2f %10.2f %10.2f     \n"),pid_1.kP() ,pid_1.kI() , pid_1.kD() );
   hal.console->printf_P(PSTR("     PID 2  : %10.2f %10.2f %10.2f     \n"),pid_2.kP() ,pid_2.kI() , pid_2.kD() );
   hal.console->printf_P(PSTR("     PID 3  : %10.2f %10.2f %10.2f     \n"),pid_3.kP() ,pid_3.kI() , pid_3.kD() );
   hal.console->printf_P(PSTR("     PID 4  : %10.2f %10.2f %10.2f     \n"),pid_4.kP() ,pid_4.kI() , pid_4.kD() );
   hal.console->printf_P(PSTR("     After mixing pwm_port=%i  pwm_stbd=%i\n\n"), pwm_port , pwm_stbd);
   hal.console->printf_P(PSTR("\n     GPS:   lon=%0.5f, lat=%0.5f, Altitude=%.2fm sog=%.2fm/s cog=%.1f SAT=%d time=%lu status=%i\n"),
<<<<<<< HEAD
                         ToDeg(gps.lon),ToDeg(gps.lat),gps.alt,gps.sog,ToDeg(gps.cog), gps.nsats,  
                         (unsigned long)gps.time,  gps.status);
=======
              ToDeg(gps.lon),ToDeg(gps.lat),gps.alt,gps.sog,ToDeg(gps.cog), gps.nsats,  gps.time,  gps.status);
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   hal.console->printf_P(PSTR("     Current position lon=%0.5f, lat=%0.5f  (Could be GPS or dead reconing) \n"),ToDeg(current_pos.lon),ToDeg(current_pos.lat));          
   hal.console->printf_P(PSTR("     IMU: cc =%4.1fdeg    roll=%0.1fdeg   pitch= %0.1fdeg  "),ToDeg(heading),ToDeg(roll),ToDeg(pitch));
   hal.console->printf_P(PSTR("  Acc=%4.2f,%4.2f,%4.2f (norm:%4.2f)  Gyro: %4.3f,%4.3f,%4.3f\n"),accel.x, accel.y, accel.z, accel.length(), gyro.x, gyro.y, gyro.z);
   print_CC_mission();
   print_GPS_mission(); 
<<<<<<< HEAD
   hal.console->printf_P(PSTR("\n     Analogue channels:  adc0: %f, adc1: %f, adc2: %f, adc4: %f, vcc: %f\r\n"),adc0, adc1, adc2, adc4, vcc);  
   hal.console->printf_P(PSTR("       AUV accel_length_crash_threshold = %.2f \n"), accel_length_crash_threshold);
   hal.console->printf_P(PSTR("       AUV gyro_length_crash_threshold  = %.2f \n"), gyro_length_crash_threshold);   
=======
   hal.console->printf_P(PSTR("\n     Analogue channels:  adc0: %f, adc1: %f, adc2: %f, adc4: %f, vcc: %f\r\n"),adc0, adc1, adc2, adc4, vcc);            
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
   hal.console->printf_P(PSTR("-----------------------------------------------------------------------------------------\n"));
}
//-------------------------------------------------------------------------------
void kill_mission(){
  if (  ctrl_mode != 'i') {
<<<<<<< HEAD
      hal.console->printf_P(PSTR("Killing mission\n"));
=======
    hal.console->printf_P(PSTR("Killing mission\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
    disarm_RC();
    mission_start_ms = 0;
    current_leg_nr   = 0;
    if (craft_type=='A') {  AUV_neutral_ctrl();  }
    if (craft_type=='S') {  Solar_neutral_ctrl();}
    if (craft_type=='P') {  Plane_neutral_ctrl();}
    if (craft_type=='K') {  Kite_neutral_ctrl(); }
<<<<<<< HEAD
    print_main_menu();
    ctrl_mode         = 'i';
  }
  continously_send  = false;
=======
    ctrl_mode         = 'i';
  }
  continously_send  = false;
  print_main_menu();
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  wait_ms(500); // Let everybody calm down :-)
}
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------

