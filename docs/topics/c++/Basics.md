---
comments: true
--- 
# C++ Basics
C++ is used for: 
- High-performance applications
- video games
- device drivers
- web browser
- servers
- operating systems

One of the fastest and most efficient languages.

To master c++ you have to learn: 
- c++ languages
- c++ standard library - prewritten c++ code that provides functionality like Datastructures

# IDE'S
On windows: visual studio code
On Mac: XCode

A project in C++ has a `main.cpp` file is the main file of the project.

The `main` function in the file is the entry point to the program.
It is a function that returns an integer to tell the operating system if the program terminated succesfully(0) or not.

```cpp
#include <iosstream>//Input output stream functionalities - printing on the screen or getting user input
int main() {
    //std short for standard library
    std::cout << "Hallo Wolrd";// cout for character out
    return 0;// if we return any other value than 0 that means our programm hat an error.
}
```
## Compiling and Running Programm
To run the code, it needs to get compiled to from c++ to machine code that can be run by the computers operating system.
If we compile it on windows we get an executable that only runs on windows. If we run it on a mac we have to recompile it on the mac to make it executable MacOS.

## Variables
To declare and initialize a variable in c++
`int file_size = 100;`
`double sales = 9.99`

In c++ variables doesn't get automatically intialised to 0 when you don't assign a value.

## Constants
We declare constants for values that we don't want to change during our program