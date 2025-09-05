


``` cpp
#include <cstdlib>
#include <iomanip>
#include <iostream>

int main(int argc, char *argv[]){
	std::cout << "argc == " << argc << '\n';
	
	for (int ndx{}; ndx != argc; ++ndx)
		std::cout << "argv["<< ndx << "] == " << std::quoted(argv[ndx]) << '\n';
	std::cout << "argv[" << argc << "] == " 
		<< static_cast<void*>(argv[agrc]) << '\n';
	
	/* ... */
	
	return argc == 3 ? EXIT_SUCCESS : EXIT FAILURE; // optional return value 
}

```

