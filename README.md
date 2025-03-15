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

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, please contact demensdeum@gmail.com.
