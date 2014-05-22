unsigned long i;

void setup()
{
  Serial.begin(9600);
  i = 0;
}

void loop()
{
  char buf[20];
  sprintf(buf, "%lu", i++);
  Serial.println(buf);
}
