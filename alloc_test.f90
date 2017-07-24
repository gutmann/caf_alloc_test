program caf_allocation_test

    implicit none

    type data_set
        real, allocatable :: coarray1(:,:,:)[:]
        real, allocatable :: coarray2(:,:,:)[:]
        real, allocatable :: coarray3(:,:,:)[:]
        real, allocatable :: coarray4(:,:,:)[:]
        real, allocatable :: coarray5(:,:,:)[:]
        real, allocatable :: coarray6(:,:,:)[:]
        real, allocatable :: coarray7(:,:,:)[:]
        real, allocatable :: coarray8(:,:,:)[:]
        real, allocatable :: coarray9(:,:,:)[:]
    end type

    type(data_set) :: ds1, ds2, ds3, ds4, ds5, ds6, ds7, ds8, ds9

    integer :: nx, ny, nz
    real :: t1,t2

    if (this_image()==1) print*, num_images()

    nx=100
    ny=1000
    nz=30

    call cpu_time(t1)
    call alloc_dataset(ds1,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds2,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds3,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds4,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds5,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds6,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds7,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds8,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

    call cpu_time(t1)
    call alloc_dataset(ds9,nx,ny,nz)
    call cpu_time(t2)
    if (this_image()==1) print*, t2-t1

contains

    subroutine alloc_dataset(ds,nx,ny,nz)
        implicit none
        type(data_set), intent(inout) :: ds
        integer, intent(in) :: nx,ny,nz

        allocate(ds%coarray1(nx,ny,nz)[*])
        allocate(ds%coarray2(nx,ny,nz)[*])
        allocate(ds%coarray3(nx,ny,nz)[*])
        allocate(ds%coarray4(nx,ny,nz)[*])
        allocate(ds%coarray5(nx,ny,nz)[*])
        allocate(ds%coarray6(nx,ny,nz)[*])
        allocate(ds%coarray7(nx,ny,nz)[*])
        allocate(ds%coarray8(nx,ny,nz)[*])
        allocate(ds%coarray9(nx,ny,nz)[*])

    end subroutine alloc_dataset


end program caf_allocation_test
