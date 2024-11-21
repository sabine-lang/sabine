SRC_DIR = ./src
BUILD_DIR = ./build

OBJECTS =
INCLUDES = -I./include

# .PHONY all
all: ${OBJECTS}
	gcc $(SRC_DIR)/main.c ${INCLUDES} ${OBJECTS} -g -o $(BUILD_DIR)/sabine

# .PHONY clean
clean:
	rm $(BUILD_DIR)/sabine
	rm -rf ${OBJECTS}

# .PHONY format
format:
	# I used absolute path because silly me aliased find to ripgrep
	/usr/bin/find . -iname '*.h' -o -iname '*.c' -exec clang-format -style=file -i {} \;
