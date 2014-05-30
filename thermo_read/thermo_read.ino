#define DEFAULT_BUF_SIZE 25
#define LOOP_TIMER 1000 //Wait 1 seconds

#define TEMP_CONTROL_DELAY 30 //seconds
#define USE_TEMP_CONTROL 0

#define MAX_RESISTOR_TEMP 100 // CELCIUS
#define RESISTOR_TEMP_THRESHOLD 5
#define RESISTOR_TEMP_PIN 1
#define POWER_CONTROL_PIN 7

#define TEMP1_PIN 0
#define TEMP2_PIN 1
#define TEMP3_PIN 2
#define TEMP4_PIN 3
#define TEMP5_PIN 4

/* Symbols for the data being sent over serial */
#define RESISTOR_TEMPERATURE_SYMBOL "resistor_"
#define THERMO_TEMPERATURE_1 "temp1_"
#define THERMO_TEMPERATURE_2 "temp2_"
#define THERMO_TEMPERATURE_3 "temp3_"
#define THERMO_TEMPERATURE_4 "temp4_"
#define THERMO_TEMPERATURE_5 "temp5_"

short isResistorOn;

/* Prototypes */
inline void controlResistor();

void setup()
{
  Serial.begin(9600);
  pinMode(POWER_CONTROL_PIN, OUTPUT);
  short isResistorOn = false;
}

void loop()
{
    char buf[DEFAULT_BUF_SIZE];
    int read_value;
    
    /* Run the control on the power */    
    controlResistor();
    
  /* Read some temperatures */
  
  /* Temp 1 */
  read_value = analogRead(TEMP1_PIN);  
  
  sprintf(buf, THERMO_TEMPERATURE_1 " %d", read_value);
  Serial.println(buf);

  /* Temp 2 */
  read_value = analogRead(TEMP2_PIN);  
  
  sprintf(buf, THERMO_TEMPERATURE_2 " %d", read_value);
  Serial.println(buf);
  
  /* Temp 3 */
  read_value = analogRead(TEMP3_PIN);  
  
  sprintf(buf, THERMO_TEMPERATURE_3 " %d", read_value);
  Serial.println(buf);
  
  /* Temp 4 */
  read_value = analogRead(TEMP4_PIN);  
  
  sprintf(buf, THERMO_TEMPERATURE_4 " %d", read_value);
  Serial.println(buf);
  
  /* Temp 5 */
  read_value = analogRead(TEMP5_PIN);    
  
  sprintf(buf, THERMO_TEMPERATURE_5 " %d", read_value);
  Serial.println(buf);
  
  /* Wait */
 delay(LOOP_TIMER); 
}

inline void controlResistor()
{
  char buf[DEFAULT_BUF_SIZE];
  int res_raw_temp = analogRead(RESISTOR_TEMP_PIN);
  int temp = res_raw_temp;
  //static int timer = 0;
  
//  if (timer++ < TEMP_CONTROL_DELAY)
//  {
//    #if USE_TEMP_CONTROL
//    return;
//    #endif
//  }
  
  //timer = 0;
  
  //slope is 100C / V
  //#define SLOPE 100
  //get the voltage from the 10bit value
  //double voltage = 5.0 / 1024.0 * res_raw_temp;    
  //Resistor sensor is unamplified.
  //double temp = SLOPE * voltage;     
  
  #undef MAX_RESISTOR_TEMP
  #define MAX_RESISTOR_TEMP 697

  //sprintf(buf, " --- resistor temp %d --- ", (int) temp);
  //Serial.println(buf);  
  //sprintf(buf, "res_vol %d", (int) voltage);
  //Serial.println(buf);  
  if ((int) temp > (MAX_RESISTOR_TEMP + 0))
  {
    digitalWrite(POWER_CONTROL_PIN, LOW); //TURN OFF
    isResistorOn = false;
  }
  else if ((int)temp < (MAX_RESISTOR_TEMP))
  {
    digitalWrite(POWER_CONTROL_PIN, HIGH); //TURN ON
    isResistorOn = true;
  } 
  
  if (isResistorOn ==true)
  {
    Serial.println("power_on");  
  }
  else
  {
    Serial.println("power_off");    
  }
  
  /* Print the tempertature over serial */
  sprintf(buf, RESISTOR_TEMPERATURE_SYMBOL " %d", res_raw_temp);
  Serial.println(buf);
}
