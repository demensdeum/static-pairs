def preprocessFile(input_file_path, export_file_path):
    with open(input_file_path, 'r') as file:
        first_line = file.readline().strip().split('StaticPairConfigFile:')[1]
        
        # Read the contents of the file specified in the first line
        with open(first_line, 'r') as target_file:
            lines = target_file.readlines()
    
    # Process each line into a tuple of two values
    tuples = [tuple(line.strip().split('->')) for line in lines if '->' in line]
    
    # Export the tuples to the specified file
    with open(export_file_path, 'w') as export_file:
        for t in tuples:
            export_file.write(f"{t[0]} -> {t[1]}\n")

preprocessFile('TimerApp.mmsp', 'TimerApp.mm')