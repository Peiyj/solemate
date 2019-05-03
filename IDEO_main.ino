#include <Arduino.h>
#include <SPI.h>
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_UART.h"

#include "BluefruitConfig.h"
#include "ArduinoConfig.h"

#include <SoftwareSerial.h>

#define FACTORYRESET_ENABLE         0
#define MINIMUM_FIRMWARE_VERSION    "0.6.6"
#define MODE_LED_BEHAVIOUR          "MODE"

// set all global variables
const int bufLength = 128; // added one more than what we needed == 2
char command[bufLength];
int sensor_var = SENSORS_ANALOG_TOTAL;
int delay_var = DELAY;
int sample_var = SAMPLE_TIME;
int pos = 0;

// Create the bluefruit object, either software serial...uncomment these lines
SoftwareSerial bluefruitSS = SoftwareSerial(BLUEFRUIT_SWUART_TXD_PIN, BLUEFRUIT_SWUART_RXD_PIN);

Adafruit_BluefruitLE_UART ble(bluefruitSS, BLUEFRUIT_UART_MODE_PIN,
                      BLUEFRUIT_UART_CTS_PIN, BLUEFRUIT_UART_RTS_PIN);

void error(const __FlashStringHelper*err) {
  Serial.println(err);
  while (1);
}

/**************************************************************************/
/*!
    @brief  Sets up the HW an the BLE module (this function is called
            automatically on startup)
*/
/**************************************************************************/

void setup(void){
  Serial.begin(115200);

  /* Initialize the module */
  Serial.print(F("Initializing the Bluefruit LE module: "));
  if ( !ble.begin(VERBOSE_MODE) ){
    error(F("Couldn't find Bluefruit, make sure it's in CoMmanD mode & check wiring?"));
  }

  if (FACTORYRESET_ENABLE){
    /* Perform a factory reset to make sure everything is in a known state */
    Serial.println(F("Performing a factory reset: "));
    if ( ! ble.factoryReset() ){
      error(F("Couldn't factory reset"));
    }
  }

  /* Disable command echo from Bluefruit */
  ble.echo(false);  

  Serial.println("Requesting Bluefruit info:");
  /* Print Bluefruit information */
  ble.info();

  /* Change the device name to make it easier to find */
  Serial.println(F("Setting device name to 'SM Arduino': "));
  if (! ble.sendCommandCheckOK(F( "AT+GAPDEVNAME=SM Arduino" )) ) {
    error(F("Could not set device name?"));
  }

  /* Add or remove service requires a reset */
  Serial.println(F("Performing a SW reset (service changes require a reset): "));
  if (! ble.reset() ) {
    error(F("Couldn't reset??"));
  }
  
  ble.verbose(false);  // debug info is a little annoying after this point!

  Serial.println(F("Waiting for a connection..."));
  /* Wait for connection */
  while (! ble.isConnected()) {
      delay(500);
  }
  Serial.println(F("Connected!..."));
  Serial.println(F("Initializing..."));
  //to let things settle/connect
  delay(3000);
  
  //Need to figure out what this actually does
  ble.sendCommandCheckOK("AT+HWModeLED=" MODE_LED_BEHAVIOUR);
}

/**************************************************************************/
/*!
    @brief  Constantly poll for new command or response data
*/
/**************************************************************************/
void loop(void)
{
  int choice;
  
  // Display Command prompt, 1 = Record, 2 = Change Settings, 3 = AT Command, 4 = debug
  Serial.println("What do you want to do?"
    "\\n[1] Record, [2] Change Settings, [3] Change Stiffness, [4] = debug");
  ble.print("AT+BLEUARTTX=");
  ble.println("\\nWhat do you want to do?\\n"
  "\\n[1] Record, [2] Change Settings, [3] Change Stiffness, [4] = debug\\n");
  
  getUserInput(command, bufLength);
  choice = atoi(command); //convert string to an integer to go through switch cases
  
  switch(choice){
    case 1:
      record();
      break;
    case 2:
      changeSettings();
      break;
    case 3:
      changeStiffness();
      break;
    default:
      Serial.println("No/improper input detected");
      if (DEBUG){
        Serial.print("choice: "); Serial.println(choice);
        Serial.print("command: "); Serial.println(command);
      }
  }
}

/**************************************************************************/
/*!
    @brief  Checks for user input (via the Serial Monitor)
*/
/**************************************************************************/
void getUserInput(char buff[], uint8_t maxSize){
  memset(buff, 0, maxSize);
  bool inputReceived = false;

  if (DEBUG){
     Serial.println(">> ");
  }

  //bug: doesn't print the first time around if bluetooth isn't fully ready
  ble.print("AT+BLEUARTTX=");
  ble.println(">> ");
  
  do{
    ble.println("AT+BLEUARTRX"); // read from the central unit
    ble.readline(); 
    // Serial.println(ble.buffer);


    if (strcmp(ble.buffer, "OK") != 0){
      inputReceived = true;
      Serial.println("Read from ble");
      snprintf(buff, 4, "%s", ble.buffer); // converts bits to char
    }

    if (Serial.available() != 0){
      inputReceived = true;
      Serial.println("Read from serial");
      Serial.readBytes(buff, maxSize);
    }
    
    delay(100);
  } while(!inputReceived);
}

void waitForUser(void){
  int maxSize = 2;
  char buff [maxSize +1];
  memset(buff, 0, maxSize);
  bool inputReceived = false;
  
  do{
    ble.println("AT+BLEUARTRX");
    ble.readline();
    if (strcmp(ble.buffer, "OK") != 0){
      inputReceived = true;
      Serial.println("Read from ble");
      snprintf(buff, 4, "%s", ble.buffer);
    }

    if (Serial.available() != 0){
      inputReceived = true;
      Serial.println("Read from serial");
      Serial.readBytes(buff, maxSize);
    }
    
    delay(100);
  } while(!inputReceived);
}

void record(void){
  //creates an array for the data to be sent
  int data [SENSORS_ANALOG_TOTAL];

  //wait for user to hit start
  Serial.println("Type something and hit send when ready");
  ble.print("AT+BLEUARTTX=");
  ble.println("\\nType something and hit send when ready\\n");
  waitForUser();

  ble.print("AT+BLEUARTTX=");
  ble.println("\\n");

  double t_max = sample_var*1000 + millis();
  //begin collecting data for a certain amount of time
  while(millis() < t_max){
    //read sensors and add to data array
    ble.print("AT+BLEUARTTX=");
    for (int i = 0; i < sensor_var; i++){
      data[i] = analogRead(i);
      Serial.print(data[i]);
      ble.print(data[i]);

      //parses the data in a format that MATLAB likes
      if (i == (sensor_var - 1)){
        Serial.println(";");
        ble.println(";\\n");
      }else{
        Serial.print(" ");
        ble.print(" ");
      }
    }
    delay(delay_var);
  }
}

void changeSettings(void){
  int choice;
  
  // ask the user what variable they want to change
  Serial.println("What variable do you want to change?"
    "\\n[1] for number of sensors, [2] for delay time, [3] for sample time");
  ble.print("AT+BLEUARTTX=");
  ble.println("\\nWhat variable do you want to change?\\n"
  "\\n[1] for number of sensors, [2] for delay time, [3] for sample time\\n");
  getUserInput(command,bufLength);
  choice = atoi(command);

  switch(choice){
    case 1:
      Serial.println("How many sensors would you like to test?");
      ble.print("AT+BLEUARTTX=");
      ble.println("\\nHow many sensors would you like to test?\\n");
      getUserInput(command, bufLength);
      sensor_var = atoi(command);
      break;
    case 2:
      Serial.println("What do you want the delay time to be? (ms)");
      ble.print("AT+BLEUARTTX=");
      ble.println("\\nWhat do you want the delay time to be? (ms)\\n");
      getUserInput(command, bufLength);
      delay_var = atoi(command);
      break;
    case 3:
      Serial.println("What do you want the sample time to be? (s)");
      ble.print("AT+BLEUARTTX=");
      ble.println("\\nWhat do you want the sample time to be? (s)\\n");
      getUserInput(command, bufLength);
      sample_var = atoi(command);
      break;
    default:
      Serial.println("No/improper input detected");
      if (DEBUG){
        Serial.print("choice: "); Serial.println(choice);
        Serial.print("command: "); Serial.println(command);
      }
  }
  
}

void changeStiffness(void){
 
}
