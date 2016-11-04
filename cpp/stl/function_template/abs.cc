using namespace std;
#include <iostream>

/**
 * Template Function
 */
template <class T>
T absolute(T n) {
  return (n<0 ? -n:n);
}

/**
 * Main function
 */

int main() {
  float a = -3.3;  
  float r = 0;
  cout<<"--Function to find absolute"<<endl;
  r = absolute(a);
  cout<<"absolute of " << a << " = " << r;
  return 0;
}