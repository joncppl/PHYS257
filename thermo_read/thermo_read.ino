#define DEFAULT_BUF_SIZE 25
#define LOOP_TIMER 1000 //Wait 1 seconds

   #define MAX_RESISTOR_TEMP 
#define RESISTOR_TEMP_THRESHOLD 5
#define RESISTOR_TEMP_PIN 0
#define POWER_CONTROL_PIN 0

#define TEMP1_PIN 1
#define TEMP2_PIN 2
#define TEMP3_PIN 3
#define TEMP4_PIN 4
#define TEMP5_PIN 5

/* Symbols for the data being sent over serial */
#define RESISTOR_TEMPERATURE_SYMBOL "resistor_"
#define THERMO_TEMPERATURE_1 "temp1_"
#define THERMO_TEMPERATURE_2 "temp2_"
#define THERMO_TEMPERATURE_3 "temp3_"
#define THERMO_TEMPERATURE_4 "temp4_"
#define THERMO_TEMPERATURE_5 "temp5_"

/* Prototypes */

inline void controlResistor();

void setup()
{
  Serial.begin(9600);
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

/******************************************
 * Need to set max temp as a 10 bit value *
 ******************************************/
inline void controlResistor()
{
  char buf[DEFAULT_BUF_SIZE];
  int res_raw_temp = analogRead(RESISTOR_TEMP_PIN);
  
  if (res_raw_temp > MAX_RESISTOR_TEMP + RESISTOR_TEMP_THRESHOLD)
    digitalWrite(POWER_CONTROL_PIN, HIGH); //TURN OFF
  else if (res_raw_temp < MAX_RESISTOR_TEMP - RESISTOR_TEMP_THRESHOLD)
    digitalWrite(POWER_CONTROL_PIN, LOW); //TURN ON
    
  /* Print the tempertature over serial */
  sprintf(buf, RESISTOR_TEMPERATURE_SYMBOL " %d", res_raw_temp);
  Serial.println(buf);
}
