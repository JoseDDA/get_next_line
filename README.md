# Get Next Line

A Function to Read a Line from a File Descriptor

- [Get Next Line](#get-next-line)
  - [1. Description](#1-description)
  - [2. Usage](#2-usage)
  - [3. Functions Overview:](#3-functions-overview)
    - [a. Static variable `static char	*left_string`](#a-static-variable-static-charleft_string)
    - [b. Error Handling](#b-error-handling)
    - [c. Memory Management](#c-memory-management)
  - [4. Limitations](#4-limitations)
  - [5. Bonus](#5-bonus)
  - [6. Useful Defintions](#6-useful-defintions)

## 1. Description

The goal of this project is to implement a function that reads and returns a line read from a [file descriptor](#6-useful-defintions) `fd`, handling different file types and sizes efficiently.

The functions reads characters either up to a user-defined [BUFFER_SIZE](#6-useful-defintions)`BUFFER_SIZE`, until a newline character `('\n')` is encountered, or until the end of the file `'\0'` is reacherd. It ensures that leftover data between function calls is properly managed through the use of [static variables](#a-static-variable-static-charleft_string).

This project demonstrates efficient memory management, error handling, and a modular approach to code design.

## 2. Usage

To use `get_next_line` function in your project, follow these steps:

1. **Include All Files**: Ensure you have the `get_next_line.c`, `get_next_line_utils.c`, `get_next_line.h` files included in your project.
2. **Compile**: Compile your program with the appropriate files. Make sure to define `BUFFER_SIZE` with a specific value; otherwise, the default value will be used.
3. **Call the function**: Create a [main](main.c) program, open file and pass its file descriptor to `get_next_line()`.
   - The functions reads one line at a time from the file descriptor
   - It returns `NULL` when the end of the line is reached
   - If an error occurs it `return -1`.
4. **Memory management**: each line returned by `get_next_line` should be freed after it's used to avoid memory leaks.

## 3. Functions Overview:

In addition to `get_next_line` this project consist of several helper functions that handle different task. Below is a brief description of each:

- `char *get_next_line(int fd)`:

  - The main function of the project. It reads a line from the file descriptor `fd` and returns it. The functions manages previously read data using a static variable `left_string`, ensuring it can resume from where it left off. If the end of the file is reached, or an error occurs, it returns `NULL`.

- `char *ft_read_to_buffer(int fd, char *left_string)`:

  - This function reads the data from the file descriptor `fd` into buffer of size `BUFFER_SIZE`. The read content is then appended to `left_string`. The function continues reading until it encounters a newline character `'\n'` or reaches the end of the file.
  - It returns `left_string` containing the read content. If an error occurs or memory allocation fails, it returns `NULL`
  - **Key responsibilities**: Reading from file descriptor, appending to `left_string`, managing buffer memory.

* `void *ft_free(char * left_string, char *buffer)`:
  - This function joins the `buffer` content with `left_string`, freeing any temporary memory along the way. It's essential for managing memory efficiently and ensuring that previously read data is not lost.
  - At the start, `left_string` has to be filled with an empty string in order to concatenate it with `buffer`.
  - **Key responsibilities**: concatenating `left_string` and `buffer`, managing memory freeing.
* `char *ft_extract_line(char *left_string)`:
  - Extracts the next line from `left_string`, up to and including the newline character `'\n'`, or up to the end of the string if no newline is found. This extracted line is returned to the caller
  - The function allocates memory for the new_string and must be freed by the caller after use in the main program.
  - **Key responsibilites**: Extracting a single line from left_string, handling memory allocation for the returned string.
* `char *ft_update_string(char *left_string)`:
  - After extracting a line, this function updates `left_string` by removing the extracted portion and retaining any remaining data that may still need to be processed in future calls. If no remaining characters exist, it returns `NULL`.
  - To effectively allocate the memory the length of `left_string` is needed.
  - **Key responsibilities**: Updating `left_string` after a line has been extracted.

### a. Static variable `static char	*left_string`

It is a variable declared as static wihtin the `get_next_line ()`, which means it retains its value between successive calls to the function. This allows the function to remember previously read data even after it has returned, facilitating the continuation of reading from the file descriptor in subsequent calls.

When `get_next_line(fd)` is called:

- If a line has already been partially read from the file, `left_string` contains this leftover data. The function can then append new data from the file to this existing string rather that starting from scratch.
- After each line is extradted, `left_string` is updated to remove the extracted portion allowing any remaining data to be retained for the next call. This way, the function efficiently handles reading lines from a file without losing track of where it left off.

### b. Error Handling

The functions performs checks to ensure valid input. If an invalid file descriptor is provided `(fd < 0)` or if `BUFFER_SIZE` is set non-positive value, it returns `NULL`. It additionally checks if any error occurs during reading `(read(fd, 0 , 0) < 0 )`. In such cases, the static variable is freed to prevent memory leaks and set to `NULL`.

### c. Memory Management

Memory allocation in this project is handled using malloc. It allocates the exact memory needed for each string. The `ft_free `function plays a crucial role in efficiently managing memory by joining the contents of the buffer with left_string and ensuring that previously allocated memory is properly freed. Careful attention is paid to ensure that all allocated memory is freed when no longer needed.

## 4. Limitations

- **BUFFER SIZE**: this determines how much data is read from the file descriptor in each call. A larger size may increase efficiency when reading large files. A extremely high `BUFFER_SIZE` could also lead to return `NULL` because the `read()` function may no be able to handle it.

- **Edge cases**: if the file contains very long line or large numbers of lines, memory allocation may fail.

## 5. Bonus

This function had a bonus assigment, which can be found in [get_next_line_bonus.c](./gnl_bonus/get_next_line_bonus.c).

Almost every previously discussed function on [Functions Overview](#3-functions-overview) remains exactly the same, except `get_next_line(int fd)`.

The structure from the function remains consistent; however, instead of using an `static char	*left_string`, it'll use a static array `static char	*left_string[OPEN_MAX]`.

- **Array of Pointers**: Each element in the `left_string` array corresponds to a file descriptor and can hold the remaining data for that specific file. This allows the function to handle multiple file descriptos simultaneously, with each `fd` having its own string.
- **Static Variable Properties**: Due to its properties, it retains the value between calls to `get_next_line`. Any line read from the file descriptor, any data that remains after extracting a line is preserved for future calls.
- **Row Assignment**: For each file descriptor (up to `OPEN_MAX`), the corresponding entry in the `left_string` array acts like a row where te pointer to the read string is stored. This way, each file descriptor can manage its own state indepently.

## 6. Useful Defintions

1. **File Descriptor** `fd`

   It's an non-negative integers that act as handles for these files or resources. It's an unique identifier.

   It serves as an index into a table maintained by the operating system, which tracks all open files, input or output and their operations.

2. **BUFFER SIZE** `BUFFER_SIZE`

   `BUFFER_SIZE` is a preprocessor macro that defines the size of the buffer used for reading data from a file descriptor. It determines how many bytes are read from the file at one time.

   The macro is defined in [get_next_line.h](./get_next_line.h) using a conditional directive. If `BUFFER_SIZE` isn't defined by user, it defaults to a specific value.

3. **Read()**

   Syntax: `int	read(int fd, void *buf, size_t nbyte)`

   The `read()` function attempts to read up to `nbyte` bytes of data from the object referenced by the descriptor `fd` into the buffer pointed to by `buf`. It starts reading from the current of `fd`, and the pointer is incremented by the number of bytes actually read.

4. **Open()**

   Syntax: `int	open(const char *path, int flags, ...)`

   The `open()` function attempts to open a file specified by `path`. The `flags` specify the type of access to the file. Relevant flags include:

   - **O_RDONLY**: Open the file in read-only mode.
   - **O_WRONLY**: Open the file in write-only mode.
   - **O_RDWR**: Open the file for both reading and writing.
   - **O_CREAT**: Create the file if it doesn't exist.
   - **O_EXCL**: Prevent file creation if it already exists.

   The functions retrun a file descriptor `fd`, a non-negative integer that serves as index in the process's table of open file descriptor. If an error occurs, `open()` return -1 to indicate failure.
