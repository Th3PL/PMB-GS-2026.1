#include <Servo.h>

Servo braco;
Servo garra;

const int ledStatus = 7;

int posBraco = 30;
int posGarra = 90;

void setup()
{
  Serial.begin(9600);

  braco.attach(9);
  garra.attach(10);

  pinMode(ledStatus, OUTPUT);

  braco.write(posBraco);
  garra.write(posGarra);

  Serial.println("=== BRACO ROBOTICO ===");
  Serial.println("U = UP");
  Serial.println("D = DOWN");
  Serial.println("O = OPEN");
  Serial.println("C = CLOSE");
}

void loop()
{
  if (Serial.available())
  {
    char comando = toupper(Serial.read());

    switch(comando)
    {
      case 'U':
        posBraco = 120;
        braco.write(posBraco);

        digitalWrite(ledStatus, HIGH);

        Serial.println("Braco levantado");
        break;

      case 'D':
        posBraco = 30;
        braco.write(posBraco);

        digitalWrite(ledStatus, LOW);

        Serial.println("Braco abaixado");
        break;

      case 'O':
        posGarra = 90;
        garra.write(posGarra);

        Serial.println("Garra aberta");
        break;

      case 'C':
        posGarra = 0;
        garra.write(posGarra);

        Serial.println("Garra fechada");
        break;

      default:
        Serial.println("Comando invalido");
        break;
    }
  }
}