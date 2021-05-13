      module param

      implicit none

      character(len=*),parameter :: file_in=&
      &"/home/fcampos/test/testv4/wind/daily_data/out04.nc"

      character(len=*),parameter :: t_NAME="time"
      character(len=*),parameter :: y_NAME="latitude"
      character(len=*),parameter :: x_NAME="longitude"
      character(len=*),parameter :: temp_NAME="v10"

      integer, parameter :: nx = 280, ny = 321, nt = 9647

      integer i, j, k, ierr

      real, parameter :: pi=3.1415927, missing_val=-32767, sf_thetao=1, af_thetao=0

      real :: T(nt), X(nx), Y(ny), amp_temp(nx,ny,2), pha_temp(nx,ny,2),mean_temp(nx,ny), time(nx,ny,nt)

      real, allocatable :: temp(:,:,:)

      integer :: ncid, ndims, retval, tvarid, xvarid, yvarid, tempvarid

      end module
