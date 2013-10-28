// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-
//---------------------------------------------------------------------------
// Jakob Kuttenkeuler, jakob@kth.se
//---------------------------------------------------------------------------

//  PWM output channels
//   1:  AUV- Port      servo            Mix of PID 1 (Heading) & PID 2 (depth)
//   2:  AUV- Starboard servo            Mix of PID 1 (Heading) & PID 2 (depth)
//   3:  Motor control                   PID 3 - on RPM
//   4:  
//   5:  
//   6:  
//   7:  
//   8:  AUV - Heartbeat
//
//  PWM input channels
//   1:  RC rudder
//   2:  RC throttle
//   3:  RC depth 
//   4:  
//   5:  RC switch (auto/manual)
//   6:  
//   7:  
//   8:  
//   
//   Analogue channels:
//   A0:  RPM
//   A1:  Depth
//   A2:  Wet sensor 1
//   A3:  
//   A4:  Wet sensor 2
//   A5:  
//   A6:  
//   A7:  
//   A8:  
//-------------------------------------------------------------------------------
static float depth_0 = 0.0;
static float accel_length_crash_threshold = 4.0;   // If abs(norm(accel)-9.82) exceeds then kill_mission!!
static float gyro_length_crash_threshold  = 4.0;   // If norm(accel) exceeds then kill_mission!!
//-------------------------------------------------------------------------------

void AUV_RC(){
   pwm_rudder   =  (int)(hal.rcin->read(CH_1));  // From Transmitting RC channel
   pwm_depth    =  (int)(hal.rcin->read(CH_2));  // From Transmitting RC channel
   pwm_motor    =  (int)(hal.rcin->read(CH_3));  // From Transmitting RC channel
  
   pwm_port = 1500 +  ( pwm_rudder + pwm_depth);     //  Mix
   pwm_stbd = 1500 +  ( pwm_rudder - pwm_depth);     //  Mix 
  
   pwm_port = min(max(pwm_port,1010),1990);          // Limit 
   pwm_stbd = min(max(pwm_stbd,1010),1990);          // Limit 

   hal.rcout->write(CH_1,pwm_port);                  // send to port Servo
   hal.rcout->write(CH_2,pwm_stbd);                  // send to stb  Servo
   
   pwm_motor = min(max(pwm_motor,1010),1990);        // Limit
   hal.rcout->write(CH_3, pwm_motor);                // send to motor 
   hal.console->printf_P(PSTR("Ch3 pwm read =%i  \n"),pwm_motor);
}


//-------------------------------------------------------------------------------
void AUV_neutral_ctrl(){
  hal.rcout->write(CH_1,1500);
  hal.rcout->write(CH_2,1500);
  hal.rcout->write(CH_3,1500); 
  hal.rcout->write(CH_4,1500);
  hal.rcout->write(CH_5,1500);
  hal.rcout->write(CH_6,1500);
  hal.rcout->write(CH_7,1500);
  hal.rcout->write(CH_8,1500);
}
//---------------------------------------------------------------------------
void initiate_AUV_mission(){
  // This function is called at mission startup
  depth_0 = 0.0;
  depth_0 = calc_depth();
}
//---------------------------------------------------------------------------
float calc_depth(){
  return (adc1+3.9316*adc1-9.5262) - depth_0;  // Damped & Depending on pressure sensor
}

//---------------------------------------------------------------------------
void AUV_craft_setup(){
  hal.console->printf_P(PSTR("===========================\n"));
  hal.console->printf_P(PSTR("Setting up AUV-type craft\n"));
  hal.console->printf_P(PSTR("===========================\n"));
  craft_type='A';
  
    pid_1.kP(70);  pid_1.kI(2.0);   pid_1.kD(0.0);    pid_1.imax(1000.0);   pid_1.save_gains();
    pid_2.kP(60);   pid_2.kI(3.0);   pid_2.kD(0.0);    pid_2.imax(1000.0);   pid_2.save_gains();
    pid_3.kP(100);   pid_3.kI(0.0);   pid_3.kD(0.0);    pid_3.imax(1000.0);   pid_3.save_gains();
    pid_4.kP(500);   pid_4.kI(0.0);   pid_4.kD(0.0);    pid_4.imax(1000.0);   pid_4.save_gains();
    AUV_neutral_ctrl();
    sog_threshold = 999;      // [m/s] speed when to switch from Heading=Compass to Heading=SOG 
    k_xtrack      = 0.0;      // 0:steer directly to wp, 1:steer to closest point on rhumb-line
    
    hal.console->printf_P(PSTR("  Flirting with motor control... wait..."));
    hal.rcout->write(CH_3,1500); // To make Motor-control happy
    hal.scheduler->delay(3000);  // Wait for Motor-control
    hal.console->printf_P(PSTR("  done. \n"));
}
//-------------------------------------------------------------------------------
void crash_test(){
  //hal.console->printf_P(PSTR("  Accel-length. %.2f   Gyro-length. %.2f\n"),accel.length(),gyro.length());
  if (abs(accel.length()-9.81)>accel_length_crash_threshold) {
     kill_mission(); 
     hal.console->printf_P(PSTR("  Accelerometers detected crash at norm(accel)=%0.1f !!!!!!!!!!!!!!!! \n"),accel.length());
   }
   if (gyro.length()>gyro_length_crash_threshold) {
     kill_mission(); 
     hal.console->printf_P(PSTR("  Gyros detected crash at norm(gyro)=%0.1f !!!!!!!!!!!!!!!\n"),sqrt(gyro.y*gyro.y+gyro.z*gyro.z));
   }
   if (depth>10) {
     kill_mission();
     hal.console->printf_P(PSTR("  Depth > 10m!!!\n"));
 }
}
//-------------------------------------------------------------------------------
void write_AUV_telementry_data(){
  if ((time_ms-last_data_sent_ms)>200)  {
     last_data_sent_ms = time_ms; 
     write_a_row_to_flash();
     hal.console->printf_P(PSTR("#AUV, %.1f, Leg=%i, ctt=%.1f, dtt=%.0fm    heading=%.1f, roll=%.1f,  pitch=%.2f,  Acc=[%.1f,%.1f,%.1f],   sog=%.1f,  cog=%.1f,   %i,%i,%i\n"),
                            (float)mission_ms/1000,current_leg_nr,
                            ToDeg(target_ctt), target_dtt*1852,      // Mission
                            ToDeg(heading),ToDeg(roll),ToDeg(pitch), // Attitudes
                            accel.x, accel.y, accel.z,               // Accelerations
                            gps.sog,ToDeg(gps.cog),                  // GPS
                            pwm_rpm,pwm_port,pwm_stbd);  // Control
  }
}
//-------------------------------------------------------------------------------
void AUV_Control_Laws(){
  if ((time_ms-last_ctrl_ms)>20)  {
        last_ctrl_ms = time_ms;
        crash_test();
        // Check Wet sensor
        if (adc2<0.1 || adc4<0.1){  
          kill_mission();
          hal.console->printf_P(PSTR("WET SENSOR KILLED MISSION!!!  \n"));
        } 
        
        
        // Motor RPM control
        //err_rpm  = target_rpm - rpm;         // Control error to feedback
        pwm_rpm = target_rpm;
        pwm_rpm = min(max(pwm_rpm,1010),1800);   // 
        hal.rcout->write(CH_3,pwm_rpm);            // send to motor 
        //hal.console->printf_P(PSTR("err_rpm=%f  pwm_rpm  %i \n"),err_rpm,pwm_rpm);
        
        // Rudder & Depth control
        depth      = calc_depth();  
        err_depth  = target_depth - depth;               // Control error to feedback
        err_cc     = unwrap_pi(heading-target_ctt);      // Control error to feedback
        pwm_cc     = pid_1.get_pid(err_cc);              // Local help variable
        pwm_depth  = pid_2.get_pid(err_depth);           // Local help variable
        pwm_port   = 1500 + ( pwm_cc + pwm_depth);       //  Mix
        pwm_stbd   = 1500 + ( pwm_cc - pwm_depth);       //  Mix 
       
          // Limit deflection to enable turns under water and to save servos from locking.
          int pwm_port_temp = 0;
          if (pwm_port>( pwm_stbd+780))  {pwm_port_temp = pwm_port; pwm_port = pwm_port - ( pwm_port-( pwm_stbd+ 780))/2; pwm_stbd = pwm_stbd + (-pwm_stbd+( pwm_port_temp- 780))/2; }       
          if (pwm_port>(-pwm_stbd+3400)) {pwm_port_temp = pwm_port; pwm_port = pwm_port - ( pwm_port-(-pwm_stbd+3400))/2; pwm_stbd = pwm_stbd - ( pwm_stbd-(-pwm_port_temp+3400))/2; }
          if (pwm_port<( pwm_stbd-600))  {pwm_port_temp = pwm_port; pwm_port = pwm_port + (-pwm_port+( pwm_stbd- 600))/2; pwm_stbd = pwm_stbd - ( pwm_stbd-( pwm_port_temp+ 600))/2; }
          if (pwm_port<(-pwm_stbd+2600)) {pwm_port_temp = pwm_port; pwm_port = pwm_port + (-pwm_port+(-pwm_stbd+2600))/2; pwm_stbd = pwm_stbd + (-pwm_stbd+(-pwm_port_temp+2600))/2; }      
               
        hal.rcout->write(CH_1,pwm_port);                 // send to port Servo
        hal.rcout->write(CH_2,pwm_stbd);                 // send to stb  Servo
        //hal.console->printf_P(PSTR("errCC=%.4f   err Depth=%.4f   pwm_cc=%i  pwm_port=%i  pwm_stbd=%i\n"),err_cc,err_depth,pwm_cc,pwm_port, pwm_stbd);
        //al.console->printf_P(PSTR("port=%i   stb=%i \n"),pwm_port,pwm_stbd);
      }
}
//-------------------------------------------------------------------------------
void AUV(){
  // This subroutine is called with high frequency 
  // regardless of mission on/off
  if (hal.rcin->read(CH_5)>1900) {RC_feedthrough=true;} else {RC_feedthrough=false;};
  
  if (RC_feedthrough)  { AUV_RC();  }          // Radio control the bugger
  else 
  if (ctrl_mode != 'i')  { AUV_Control_Laws(); write_AUV_telementry_data(); }
}
//-------------------------------------------------------------------------------

