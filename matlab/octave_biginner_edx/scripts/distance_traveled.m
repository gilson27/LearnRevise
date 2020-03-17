%The script computes distance travelled by the car given it's time and velocity
vel = input("Enter the velocity of the car");
t = input("Time taken by the car");
dist = vel * t;
disp(['distance covered by the car is ' num2str(dist)]);