// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-
//---------------------------------------------------------------------------
// Jakob Kuttenkeuler, jakob@kth.se
//---------------------------------------------------------------------------

void init_analog(){
<<<<<<< HEAD
  hal.console->print("  Analog: ");
=======
  hal.console->printf_P(PSTR("  Analog:  "));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
  Ch0 = hal.analogin->channel(0);
  Ch1 = hal.analogin->channel(1);
  Ch2 = hal.analogin->channel(2);
  Ch3 = hal.analogin->channel(3);
  Ch4 = hal.analogin->channel(4);
  Vcc = hal.analogin->channel(ANALOG_INPUT_BOARD_VCC);
<<<<<<< HEAD
  hal.console->println_P(PSTR(" ok. "));
=======
  hal.console->printf_P(PSTR(" ok. \n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
}
//-------------------------------------------------------------------------------

void read_analogue_channels(){
   if (abs(time_ms-last_adc_update)>20){
      last_adc_update = time_ms;
<<<<<<< HEAD
      adc0 =  Ch0->voltage_average();
      adc1 =  Ch1->voltage_average();
      adc2 =  Ch2->voltage_average();
      adc3 =  Ch3->voltage_average();
      adc4 =  Ch4->voltage_average();
      vcc  =  Vcc->voltage_average();
      //hal.console->printf_P(PSTR("Analogue channels:  adc0=%.2f, adc1=%.2f,   adc2=%.2f, vcc: %f\r\n"),adc0,adc1, adc1, vcc);
    }
}
//-------------------------------------------------------------------------------
void update_power_consumption(){
   if (abs(time_ms-last_power_update)>100){
     last_power_update = time_ms;
     battery_mon.read();
      hal.console->printf_P(PSTR("\nVoltage: %.2f \tCurrent: %.2f \tTotCurr:%.2f"),
			    battery_mon.voltage(),
			    battery_mon.current_amps(),
                            battery_mon.current_total_mah());
   }
}
//-------------------------------------------------------------------------------
=======
       adc0 =  (float)Ch0->read_average()/1024.*5.;  // [Volt]
       adc1 =  (float)Ch1->read_average()/1024.*5.;  // [Volt]
       adc2 =  (float)Ch2->read_average()/1024.*5.;  // [Volt]
       adc3 =  (float)Ch3->read_average()/1024.*5.;  // [Volt]
       adc4 =  (float)Ch4->read_average()/1024.*5.;  // [Volt]
       vcc  =  (float)Vcc->read_average()/1000.;     // [Volt]
      //hal.console->printf_P(PSTR("Analogue channels:  adc0=%.2f, adc1=%.2f,   adc2=%.2f, vcc: %f\r\n"),adc0,adc1, adc1, vcc);
    }
}//-------------------------------------------------------------------------------


>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b







