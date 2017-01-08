// this is an alternative Euclidean algorithm for allocating k beats evenly into n steps  
// written for processing to show output, euclid function works in arduino
// it calculates the average gap between beats, rounds that up, and moves that far along a step of 0s, changing that step to a 1 (a beat)
// for background, search for The Euclidean Algorithm Generates Traditional Musical Rhythms by Godfried Toussaint

int beats = 0; // starting number of beats
int steps = 18; // number of steps
int necklace[]; // holds output

void setup() {
  size(200, 200);
  necklace = new int[steps];
}

void draw() {
  beats ++;
  if (beats <= steps) {   
    euclid(beats, steps);
    printResults();
  }
}

void euclid(float k, float n) { // spread _k_ beats over total of _n_ steps
  float gap = n / k; //  must be a float
  necklace[0] = 1; // start with 1
  for (int i = 1; i < n; i ++) {
    necklace[i] = 0; // & clear the rest by filling with 0s
  }
  for (int i = 1; i < k; i ++) {
    necklace[int(ceil(gap * i))] = 1; // move (value of _gap_) steps along (rounded to next integer) and make this step a 1
  }
}

void printResults() { 
  print(beats);
  print(" of ");
  print(steps);
   print(" : ");
  for (int i = 0; i < steps; i ++) {
    print(necklace[i]);
  }
  println();
}

