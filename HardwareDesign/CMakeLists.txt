cmake_minimum_required(VERSION 3.24.0)
project("Hans2_Hardware")

include(hardware_targets)

# Adding all subdirectories
add_subdirectory(cmake_example)
add_subdirectory(Audiosystem)
add_subdirectory(Controller)
add_subdirectory(Graphicsystem)
add_subdirectory(Timer)
add_subdirectory(Counter)
add_subdirectory(Processor)
add_subdirectory(Prototypes)
add_subdirectory(Storage)
