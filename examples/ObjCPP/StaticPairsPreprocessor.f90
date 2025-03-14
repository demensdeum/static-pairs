program preprocess_file
    implicit none
    character(len=256) :: input_file_path, export_file_path, line, first_line, old_text, new_text
    character(len=256), dimension(:), allocatable :: tuples
    integer :: i, num_tuples, ios
    logical :: found

    ! Define file paths
    input_file_path = 'TimerApp.mmsp'
    export_file_path = 'TimerApp.mm'

    ! Open the input file and read the first line to get the configuration file
    open(unit=10, file=trim(input_file_path), status='old', action='read', iostat=ios)
    if (ios /= 0) stop 'Error opening input file'
    read(10, '(A)', iostat=ios) first_line
    if (ios /= 0) stop 'Error reading first line'
    close(10)

    ! Extract the configuration file name
    call extract_config_file(first_line, first_line)

    ! Read the tuples from the configuration file
    call read_tuples(trim(first_line), tuples, num_tuples)

    ! Open the input file again and the export file for writing
    open(unit=10, file=trim(input_file_path), status='old', action='read', iostat=ios)
    if (ios /= 0) stop 'Error opening input file'
    open(unit=20, file=trim(export_file_path), status='replace', action='write', iostat=ios)
    if (ios /= 0) stop 'Error opening export file'

    ! Skip the first line
    read(10, '(A)', iostat=ios)
    if (ios /= 0) stop 'Error skipping first line'

    ! Process each line, apply replacements, and write to the export file
    do
        read(10, '(A)', iostat=ios) line
        if (ios /= 0) exit
        do i = 1, num_tuples
            call parse_tuple(tuples(i), old_text, new_text)
            call replace_text(line, old_text, new_text, found)
        end do
        write(20, '(A)') trim(line)
    end do

    close(10)
    close(20)

contains

    subroutine extract_config_file(line, config_file)
        character(len=*), intent(in) :: line
        character(len=*), intent(out) :: config_file
        integer :: pos

        pos = index(line, 'StaticPairConfigFile:')
        if (pos > 0) then
            config_file = trim(adjustl(line(pos+len('StaticPairConfigFile:'):)))
        else
            config_file = ''
        end if
    end subroutine extract_config_file

    subroutine read_tuples(filename, tuples, num_tuples)
        character(len=*), intent(in) :: filename
        character(len=256), dimension(:), allocatable, intent(out) :: tuples
        integer, intent(out) :: num_tuples
        character(len=256) :: line
        integer :: ios, unit

        unit = 30
        open(unit=unit, file=trim(filename), status='old', action='read', iostat=ios)
        if (ios /= 0) stop 'Error opening configuration file'

        num_tuples = 0
        do
            read(unit, '(A)', iostat=ios) line
            if (ios /= 0) exit
            if (index(line, '->') > 0) then
                num_tuples = num_tuples + 1
                if (.not.allocated(tuples)) then
                    allocate(tuples(num_tuples))
                else
                    call move_alloc(tuples, tuples, source=[tuples, line])
                end if
            end if
        end do
        close(unit)
    end subroutine read_tuples

    subroutine parse_tuple(tuple, old_text, new_text)
        character(len=*), intent(in) :: tuple
        character(len=*), intent(out) :: old_text, new_text
        integer :: pos

        pos = index(tuple, '->')
        if (pos > 0) then
            old_text = trim(adjustl(tuple(1:pos-1)))
            new_text = trim(adjustl(tuple(pos+2:)))
        else
            old_text = ''
            new_text = ''
        end if
    end subroutine parse_tuple

    subroutine replace_text(line, old_text, new_text, found)
        character(len=*), intent(inout) :: line
        character(len=*), intent(in) :: old_text, new_text
        logical, intent(out) :: found
        integer :: pos

        found = .false.
        pos = index(line, old_text)
        if (pos > 0) then
            line = adjustl(line(1:pos-1) // new_text // line(pos+len(old_text):))
            found = .true.
        end if
    end subroutine replace_text

end program preprocess_file
