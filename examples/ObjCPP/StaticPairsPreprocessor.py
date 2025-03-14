def preprocessFile(input_file_path, export_file_path):
    with open(input_file_path, 'r') as file:
        first_line = file.readline().strip().split('StaticPairConfigFile:')[1]
        with open(first_line, 'r') as target_file:
            lines = target_file.readlines()
    
    # Process each line into a tuple of two values
    tuples = [tuple(line.strip().split('->')) for line in lines if '->' in line]
    
    # Open the export file for writing
    with open(export_file_path, 'w') as export_file:
        # Read the input file line by line
        with open(input_file_path, 'r') as input_file:
            next(input_file)
            for line in input_file:
                # Apply the replacements based on the tuples
                for old_text, new_text in tuples:
                    line = line.replace(old_text.strip(), new_text.strip())
                # Write the modified line to the export file
                export_file.write(line)

# Example usage
preprocessFile('TimerApp.mmsp', 'TimerApp.mm')