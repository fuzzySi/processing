// this spaces out a sequence of a ones & b zeros so they are as evenly spaced as possibly
// this gives a series of euclidian rhythms which are used in world music, though the original research use was in nuclear physios
// http://cgm.cs.mcgill.ca/~godfried/publications/banff.pdf

// this program prints all the variations of 1-16 ones & 1-16 zeros so you can check the function works
// but actually necklace = euclid(a, b); and the euclid function are all you need. 

// this approach calculates where the ones should go, and where they end up not on an integer, they are rounded up 
// this is much quicker than the euclidian algorithm & gives the same results. 
// i couldn't really understand the proper code as below:
// https://github.com/TomWhitwell/Euclidean-sequencer-


int[] necklace = new int[16]; // sequence of numbers to hold list

void setup() {
}

void draw() {   
  noLoop();

  for (int a = 1; a < 16; a ++ ) {
    for (int b = 1; b < 16; b ++) {
      print(" ones = " + a);
      print(" & zeroes = " + b);
      print(" ->  ");
      necklace = euclid(a, b);
      for (int i = 0; i < (a + b); i ++) {
        print(necklace[i]);
      }
      println("");
    }
  }
}

int[] euclid(float ones, float zeroes) {
  int[] bitList = new int[int(ones + zeroes)];
  float gap = (ones + zeroes) / ones; // distance between spaces
  bitList[0] = 1; // starts with 1
  for (int i = 1; i < (ones + zeroes); i ++) {
    bitList[i] = 0; // & clear the rest by filling with 0s
  }
  for (int i = 1; i < ones; i ++) {
    bitList[ceil(gap * i)] = 1; // round up to nearest integer
  }
  return bitList;
}
