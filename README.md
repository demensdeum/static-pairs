# Static Pairs - Name + Type

## Overview

Static Pairs - Name + Type is a tool designed to create a value name-to-type notation by processing files with source code transpiling based on rules specified in a configuration file. The transpiling process generates consistent and reusable result code, aligning with the DRY (Don't Repeat Yourself) principle by minimizing redundancy. 
Example prototype version is implemented in Python, offering a straightforward and easy-to-understand approach for file processing tasks. The prototype source code example implementation is in Objective-C++, while the preprocessor is in Python. This tool is intended for source code only.

## Features

- **Configuration-Driven**: Reads a configuration file to determine text replacement rules.
- **Flexible Processing**: Processes input files line-by-line, applying replacements as specified.
- **Ease of Use**: The Python script provides a simple interface for defining and applying text replacement rules.

## Installation

### Prerequisites

- **Python**: Ensure you have Python installed on your system.

### Running the Script

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/static-pairs-preprocessor.git
   cd static-pairs-preprocessor
   ```

2. Execute the Python script with the necessary input files:
   ```bash
   python StaticPairsPreprocessor.py
   ```

## Usage

Ensure that the input file and configuration file are correctly specified within the script or passed as arguments.

## Examples

### Creating a .sp Configuration File

The `.sp` configuration file is used to define mappings for the preprocessor. Below is a guide on how to create and structure this file:

1. **Define Mappings**: Each line in the `.sp` file should define a mapping from a placeholder to a specific type or object. The format is as follows:
   ```
   :placeholder -> :(Type *)object
   ```
   For example:
   - `:button -> :(NSButton *)button` maps the placeholder `:button` to an `NSButton` pointer named `button`.
   - `:timeLabel -> :(NSLabel *)timeLabel` maps `:timeLabel` to an `NSLabel` pointer named `timeLabel`.

2. **Supported Types**: You can map placeholders to various types, such as `NSButton`, `NSLabel`, `NSWindow`, `NSTimer`, and other standard types like `std::chrono::steady_clock::time_point` and `bool`.

3. **Usage**: These mappings are used by the preprocessor to replace placeholders in your code with the specified types or objects, facilitating type-safe code generation. This example is specifically for Objective-C or Objective-C++, but the concept can potentially be applied to any language with types to help remove redundancy.

### Real-World Example Before and After Preprocessing

Here's a real-world example to illustrate how the preprocessor can transform code using the `.sp` configuration file:

**Before Preprocessing**
```cpp
#include <iostream>
#include <vector>

void processFiles(std::vector<MyNamespace::File> files) {  
    std::cout << "Processing " << files.size() << " files.\n";
}

int main() {
    std::vector<MyNamespace::File> files;  // Explicit declaration
    processFiles(files);
}
```

**After Preprocessing**
```cpp
StaticPairConfigFile:PairsConfig.sp

#include <iostream>

void processFiles(files) {  // Expands to "std::vector<MyNamespace::File> files"
    std::cout << "Processing " << files.size() << " files.\n";
}

int main() {
    files;  // Expands to "std::vector<MyNamespace::File> files;"
    processFiles(files);
}
```

This example demonstrates how the preprocessor can simplify code by removing redundancy and making type declarations more concise.

### .sp Configuration Rules for C++ Example

To achieve the transformation shown in the real-world example, you can use the following `.sp` configuration rule:

```plaintext
files -> std::vector<MyNamespace::File> files
```

This rule allows the preprocessor to replace the placeholder `files` with `std::vector<MyNamespace::File> files`, simplifying the code by removing explicit type declarations.

### Objective-C++ Timer Application Example

This example demonstrates an Objective-C++ application using the preprocessor for type-safe code generation. The application is a simple timer with a graphical interface.

#### Key Features

- **GUI**: Uses Cocoa for a window with a button and label.
- **Timer**: Implements a start/stop timer with `NSTimer` and `std::chrono`.
- **Preprocessor**: Uses `.mmsp` file for type-safe mappings.

This example shows how the preprocessor streamlines code and enhances type safety in an Objective-C++ context.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, please contact demensdeum@gmail.com.
