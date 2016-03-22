// import org.multiply.processing.*;
import processing.serial.*;

// this works as a sine wave LFO but can't go fast as no micros function - so above 1Hz or so speed makes no difference. interesting but useless. 
/*
also a timer, commented out

v0.23 - testing timers. rubbish in processing, no micros(). don't update LFOs in processing - arduino much tighter. use 3 LFOs in arduino, and sequences from processing -> arduino & out
*/


int sineTable[] = { // 256 value lookup table
2048,2061,2073,2086,2098,2111,2123,2136,2148,2161,2174,2186,2199,2211,2224,2236,2249,2261,2274,2286,2299,2311,2324,2336,2349,2361,2373,2386,2398,2411,2423,2435,
2448,2460,2472,2484,2497,2509,2521,2533,2546,2558,2570,2582,2594,2606,2618,2630,2643,2655,2667,2678,2690,2702,2714,2726,2738,2750,2762,2773,2785,2797,2808,2820,
2832,2843,2855,2866,2878,2889,2901,2912,2924,2935,2946,2958,2969,2980,2991,3002,3013,3024,3036,3047,3057,3068,3079,3090,3101,3112,3122,3133,3144,3154,3165,3175,
3186,3196,3207,3217,3227,3238,3248,3258,3268,3278,3288,3298,3308,3318,3328,3337,3347,3357,3367,3376,3386,3395,3405,3414,3423,3433,3442,3451,3460,3469,3478,3487,
3496,3505,3514,3523,3531,3540,3548,3557,3565,3574,3582,3591,3599,3607,3615,3623,3631,3639,3647,3655,3663,3670,3678,3685,3693,3700,3708,3715,3722,3730,3737,3744,
3751,3758,3765,3772,3778,3785,3792,3798,3805,3811,3817,3824,3830,3836,3842,3848,3854,3860,3866,3872,3877,3883,3888,3894,3899,3905,3910,3915,3920,3925,3930,3935,
3940,3945,3950,3954,3959,3963,3968,3972,3976,3980,3985,3989,3993,3997,4000,4004,4008,4011,4015,4018,4022,4025,4028,4032,4035,4038,4041,4043,4046,4049,4052,4054,
4057,4059,4061,4064,4066,4068,4070,4072,4074,4076,4077,4079,4081,4082,4084,4085,4086,4087,4088,4089,4090,4091,4092,4093,4094,4094,4095,4095,4095,4096,4096,4096
};

// LFOs
// private TimedEventGenerator eventTimer; // http://multiply.org/processing/
int lastMillis = 0;



int next = 0;
int result = 0;
int waveQuarter = 0;
int dotSize = 2;
int x = 0;

LFO lfo1;

void setup() {
  size(360,240);
  background(10);
  stroke(153);
  lfo1 = new LFO(0, 0.5, 0, 60); // value, speed, shape, phase (0-255)
  
 // eventTimer = new TimedEventGenerator(this);
 // eventTimer.setIntervalMs(175);
//  eventTimer.setEnabled(true);
  println("starting now");
} // end setup


void draw(){
   float freq = 1000 / (lfo1.speed * 1024); // ms between updates
   int update = 1;
   int duration = int(freq);
   if (duration < 1) {  
     update = int (1 / freq);
   println(update);
   }
  if (millis() > lastMillis + duration) {
       lastMillis = millis();
    x++;
    if (x > 1024) {
      x = 0;
    }
   next += update; 
   if (next > 255) {
     next = 0;
     waveQuarter ++;
     if (waveQuarter > 3) {
       waveQuarter = 0;
     }
   }

     result = lfo1.update(next);
     println(result);
     ellipse(x/4, result/17, dotSize, dotSize);
  }


  
} // end draw



class LFO {
   int value;
   float speed;
   int shape;
   int phase; // used as duty cycle for pulse wave
   int next;
   float freq = 1000 / (speed * 1024); // 1000ms / Hz, 1024 samples per cycle     

   LFO(int v, float s, int sh, int ph) {
     value = v;
     speed = s;
     shape = sh;
     phase = ph;
   }
   int update(int LFO_next){
       int LFO_val = 0;
       switch(shape) {
    case 0: // sine
      if (waveQuarter == 0) {
        LFO_val = (sineTable[LFO_next]);
      } else if (waveQuarter == 1) {
        LFO_val = (sineTable[(255 - LFO_next)]);
      } else if (waveQuarter == 2) {
        LFO_val = (4096 - sineTable[LFO_next]);
      } else if (waveQuarter == 3) {
        LFO_val = (4096 - sineTable[(255 - LFO_next)]);
      }
//        return LFO_val;
      }
      return LFO_val;
    }
}


/*
void onTimerEvent(){
  int millisDiff = millis() - lastMillis;
  lastMillis = millisDiff + lastMillis;  
  println("timer event at " + millis() + "ms (" + millisDiff + ")!");
}
*/