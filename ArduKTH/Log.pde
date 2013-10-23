// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-
//---------------------------------------------------------------------------
//  Jakob Kuttenkeuler, jakob@kth.se
//---------------------------------------------------------------------------

<<<<<<< HEAD
// the log number of the last log we started
static uint16_t last_log_number;

struct PACKED data_packet {
    LOG_PACKET_HEADER;
    int16_t   packetNumber;
    float     time_since_birth;
    float     target_ctt;
    float     cc;
    float     cog;
    float     sog;
=======
struct PACKED data_packet {
    LOG_PACKET_HEADER;
    float     time_since_birth;
    int16_t   packetNumber;
    float     target_ctt;
    float     cc;
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
    float     roll;
    float     pitch;
    float     lat;
    float     lon;
<<<<<<< HEAD
    float     tdepth;
    float     depth;
    float     PWMstbd;
    float     PWMport;
=======
    float     sog;
    float     cog;
    float     depth;
    float     adc0;
    float     adc1;
    float     adc2;
    float     adc4;
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
};

#define LOG_DATA_MSG 1

static const struct LogStructure log_structure[] PROGMEM = {
    LOG_COMMON_STRUCTURES,
    { LOG_DATA_MSG, sizeof(data_packet),       
<<<<<<< HEAD
      "KTH", "hffffffffffffff",        "NUM,T,tCTT,CC,COG,SOG,Rll,Ptch,Lat,Lon,tdepth,Dpth,PWMs,PWMp" }
};

static void start_new_log(void)
{
    DataFlash.StartNewLog(sizeof(log_structure)/sizeof(log_structure[0]), log_structure);
    last_log_number = DataFlash.find_last_log();
    hal.console->printf_P(PSTR("Started log number %u\n"), 
                          (unsigned)last_log_number);
}

static void erase_logs(void)
{
    hal.console->println("    Erasing... Data flash card (be patient!)");
    DataFlash.EraseAll();
    hal.console->println("done!");
    start_new_log();
=======
      "KTH", "fhfffffffffffff",        "T,PN,tCTT,CC,Rll,Ptch,Lat,Lon,SOG,COG,Dpth,ADC0,ADC1,ADC2,ADC4" }
};


static void erase_logs(void)
{
    hal.console->printf_P(PSTR("    Erasing... Data flash card (be patient!)  "));
    DataFlash.EraseAll();
    hal.console->printf_P(PSTR("done!\n"));
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
}


//-------------------------------------------------------------------------------
static void setup_Flash()
{
    DataFlash.Init();
    // DataFlash initialization    
<<<<<<< HEAD
=======
    DataFlash.StartNewLog(sizeof(log_structure)/sizeof(log_structure[0]), log_structure);
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
    DataFlash.ShowDeviceInfo(hal.console);
    if (DataFlash.NeedErase()) {
        erase_logs();
    }
<<<<<<< HEAD
    start_new_log();
=======
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
}


//-------------------------------------------------------------------------------
static void write_a_row_to_flash()
{
<<<<<<< HEAD
  if ((time_ms-last_log_ms) <= 500)  {
=======
  if ((time_ms-last_log_ms) <= 1000)  {
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
      return;
  }
  last_log_ms = time_ms;
  packets_written = packets_written+1;
  struct data_packet pkt = {
      LOG_PACKET_HEADER_INIT(LOG_DATA_MSG),
<<<<<<< HEAD
      packetNumber      : (int16_t) packets_written,
      time_since_birth  : (float) ((time_ms-birth_ms)/1000.0),
      target_ctt        : (float) target_ctt*180/pi,
      cc                : (float) heading*180/pi,
      cog               : (float) gps.cog*180/pi,
      sog               : (float) gps.sog,
      roll              : (float) roll*180/pi,
      pitch             : (float) pitch*180/pi,
      lat               : (float) current_pos.lat*180/pi,
      lon               : (float) current_pos.lon*180/pi,
      tdepth            : (float) target_depth,
      depth             : (float) depth,
      PWMstbd           : (float) pwm_stbd,
      PWMport           : (float) pwm_port
  };
  
  DataFlash.WriteBlock(&pkt, sizeof(pkt));
  //hal.console->printf_P(PSTR("adc0=%f , adc2=%f , adc4=%f,\n"),pkt.adc0,pkt.adc2,pkt.adc4);
}

//-------------------------------------------------------------------------------
void flash_read_all_packets(uint16_t log_number_to_read)
{
  DataFlash.ListAvailableLogs(hal.console);
  uint16_t num_logs = DataFlash.get_num_logs();
  if (log_number_to_read>num_logs) {return;}

  if (num_logs == 0) {
      hal.console->printf_P(PSTR("No logs available... sorry.\n"));
      DataFlash.StartNewLog(sizeof(log_structure)/sizeof(log_structure[0]), log_structure);
      return;
  }
  uint16_t start_page, end_page;
  DataFlash.get_log_boundaries(log_number_to_read, start_page, end_page);

  hal.console->printf_P(PSTR("\nReading Flash card logn #%u from page %u to %u\n"),
                        (unsigned)log_number_to_read, (unsigned)start_page, (unsigned)end_page);

  DataFlash.LogReadProcess(log_number_to_read, start_page, end_page, 
=======
      time_since_birth  : (float) (time_ms-birth_ms)/1000.0,
      packetNumber      : (int16_t) packets_written,
      target_ctt        : (float) target_ctt,
      cc                : (float) heading,
      roll              : (float) roll,
      pitch             : (float) pitch,
      lat               : (float) current_pos.lat*180/pi,
      lon               : (float) current_pos.lon*180/pi,
      sog               : (float) gps.sog,
      cog               : (float) gps.cog,
      depth             : (float) depth,
      adc0              : (float) adc0,
      adc1              : (float) adc1,
      adc2              : (float) adc2,
      adc4              : (float) adc4
  };
  
  DataFlash.WriteBlock(&pkt, sizeof(pkt));
  hal.console->printf_P(PSTR("adc0=%f , adc1=%f , adc2=%f , adc4=%f,\n"),pkt.adc0,pkt.adc1,pkt.adc2,pkt.adc4);
}

//-------------------------------------------------------------------------------
void flash_read_all_packets()
{
  hal.console->printf_P(PSTR("\nWill now read Flash card \n"));
  DataFlash.ListAvailableLogs(hal.console);

  uint16_t last_log_num = DataFlash.find_last_log();

  DataFlash.LogReadProcess(last_log_num, 1, 0, 
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
                           sizeof(log_structure)/sizeof(log_structure[0]),
                           log_structure, 
                           NULL,
                           hal.console);
<<<<<<< HEAD
                           
  hal.console->printf_P(PSTR("Done reading flash card.\n"));

=======
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
}
//-------------------------------------------------------------------------------




<<<<<<< HEAD

=======
>>>>>>> 10f56fb2420d079b04375c76ae658ba93541998b
