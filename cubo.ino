//LED RGB Cube 5x5x5 - Arduino sketch

#define dataPinAndar 10
#define latchPinAndar 9
#define clockPinAndar 8
#define dataPinLED 13
#define latchPinLED 12
#define clockPinLED 11

byte inputdata[50];
long outputdata[10][5];
byte head;
int state = 0;

void convert() {
  for(int i = 0; i < 5; i++) {
    for(int j = 0; j < 10; j++){
      outputdata[j][i] = inputdata[(10 * i) + j];
    }
  }
}

void panelOut() {
  for (int floordata = 0; floordata < 5; floordata++) {
    int floorbit = 1 << floordata;
    digitalWrite(latchPinAndar, LOW);
    shiftOut(dataPinAndar, clockPinAndar, MSBFIRST, floorbit);
    digitalWrite(latchPinAndar, HIGH);
    digitalWrite(latchPinLED, LOW);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[9][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[8][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[7][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[6][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[5][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[4][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[3][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[2][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[1][floordata]);
    shiftOut(dataPinLED, clockPinLED, MSBFIRST, outputdata[0][floordata]);
    digitalWrite(latchPinLED, HIGH);
  }
}

void setup() {
  pinMode(dataPinAndar, OUTPUT);
  pinMode(latchPinAndar, OUTPUT);
  pinMode(clockPinAndar, OUTPUT);
  pinMode(dataPinLED, OUTPUT);
  pinMode(latchPinLED, OUTPUT);
  pinMode(clockPinLED, OUTPUT);
  Serial.begin(9600);
  head = (byte) 0x55;
}

void loop() {  
  if (Serial.available()>0) {
    int input = Serial.read();
    switch (state) {
    case 0:
      if (input==head) {
        state = 1;
      }
      break;
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    case 21:
    case 22:
    case 23:
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 31:
    case 32:
    case 33:
    case 34:
    case 35:
    case 36:
    case 37:
    case 38:
    case 39:
    case 40:
    case 41:
    case 42:
    case 43:
    case 44:
    case 45:
    case 46:
    case 47:
    case 48:
    case 49:
    case 50:
      if((byte) input < 0) {
        inputdata[state-1] = (byte) input + 256;
        state++;
        break;
      }
      else {
        inputdata[state-1] = (byte) input;
        state++;
        break;
      }
    case 51:
      if((byte) input < 0) {
        inputdata[state-1] = (byte) input + 256;
        state = 0;
        convert();
        break;
      }
      else {
        inputdata[state-1] = (byte) input;
        state = 0;
        convert();
        break;
      }
    }
  }
  else {
    panelOut();
  }
}
