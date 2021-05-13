     subroutine write_harmonic_output(nx,ny,X,Y,missing_val,amp,pha,mean_var)

      use netcdf

      implicit none

      character(len=*), parameter :: file_out="harmonic_output.nc"

      integer, intent(in) :: nx, ny

      real, intent(in) :: missing_val

      real, intent(in) :: X(nx), Y(ny)

      real :: NN(2)

      real, intent(in) :: amp(nx,ny,2), pha(nx,ny,2), mean_var(nx,ny)

      integer, parameter :: NDIMS2=2, NDIMS3=3

      character(len=*), parameter :: n_NAME="harmonic"
      character(len=*), parameter :: x_NAME="longitude"
      character(len=*), parameter :: y_NAME="latitude"

      integer :: n_dimid, y_dimid, x_dimid, n_varid, y_varid, x_varid

      character(len=*), parameter :: amp_NAME="amp_xi"
      character(len=*), parameter :: pha_NAME="pha_xi"
      character(len=*), parameter :: m_NAME="mean_xi"

      integer :: amp_varid, pha_varid, m_varid, dimids2(NDIMS2), dimids3(NDIMS3)

      character(len=*), parameter :: UNITS="units"
      character(len=*), parameter :: n_UNITS="1st and 2nd harmonic"
      character(len=*), parameter :: x_UNITS="degrees_east"
      character(len=*), parameter :: y_UNITS="degrees_north"
      character(len=*), parameter :: amp_UNITS="var"
      character(len=*), parameter :: pha_UNITS="rad"
      character(len=*), parameter :: m_UNITS="var"
      
      character(len=*), parameter :: LNAME="long_name"
      character(len=*), parameter :: n_LNAME="1st and 2nd harmonic"
      character(len=*), parameter :: x_LNAME="Longitude"
      character(len=*), parameter :: y_LNAME="Latitude"
      character(len=*), parameter :: amp_LNAME="Variable"
      character(len=*), parameter :: pha_LNAME="Angle"
      character(len=*), parameter :: m_LNAME="Variable"

      integer :: retval, ncid, rhvarid

      NN = (/1,2/)

      retval = nf90_create(file_out,ior(nf90_noclobber,nf90_64bit_offset), ncid)

      retval = nf90_def_dim(ncid, n_NAME, 2, n_dimid)
      retval = nf90_def_dim(ncid, y_NAME, NY, y_dimid)
      retval = nf90_def_dim(ncid, x_NAME, NX, x_dimid)

      retval = nf90_def_var(ncid, n_NAME, NF90_REAL, n_dimid, n_varid)
      retval = nf90_def_var(ncid, y_NAME, NF90_REAL, y_dimid, y_varid)
      retval = nf90_def_var(ncid, x_NAME, NF90_REAL, x_dimid, x_varid)

      retval = nf90_put_att(ncid, n_varid, UNITS, n_UNITS)
      retval = nf90_put_att(ncid, y_varid, UNITS, y_UNITS)
      retval = nf90_put_att(ncid, x_varid, UNITS, x_UNITS)

      retval = nf90_put_att(ncid, n_varid, LNAME, n_LNAME)
      retval = nf90_put_att(ncid, y_varid, LNAME, y_LNAME)
      retval = nf90_put_att(ncid, x_varid, LNAME, x_LNAME)

      retval = nf90_put_att(ncid, rhvarid,"title",&
                &'code written by fecg: fecampos1302@gmail.com')

      dimids2(1) = x_dimid
      dimids2(2) = y_dimid

      dimids3(1) = x_dimid
      dimids3(2) = y_dimid
      dimids3(3) = n_dimid
      
      retval = nf90_def_var(ncid, m_NAME, NF90_REAL, dimids2, m_varid)
      retval = nf90_def_var(ncid, amp_NAME, NF90_REAL, dimids3, amp_varid)
      retval = nf90_def_var(ncid, pha_NAME, NF90_REAL, dimids3, pha_varid)

      retval = nf90_put_att(ncid, m_varid, UNITS, m_UNITS)
      retval = nf90_put_att(ncid, pha_varid, UNITS, pha_UNITS)
      retval = nf90_put_att(ncid, amp_varid, UNITS, amp_UNITS)

      retval = nf90_put_att(ncid, m_varid, LNAME, m_LNAME)
      retval = nf90_put_att(ncid, pha_varid, LNAME, pha_LNAME)
      retval = nf90_put_att(ncid, amp_varid, LNAME, amp_LNAME)

      retval = nf90_put_att(ncid,m_varid,'missing_value',missing_val)
      retval = nf90_put_att(ncid,pha_varid,'missing_value',missing_val)
      retval = nf90_put_att(ncid,amp_varid,'missing_value',missing_val)

      retval = nf90_enddef(ncid)

      retval = nf90_put_var(ncid, n_varid, NN)
      retval = nf90_put_var(ncid, y_varid, Y)
      retval = nf90_put_var(ncid, x_varid, X)

      retval = nf90_put_var(ncid, m_varid, mean_var)
      retval = nf90_put_var(ncid, pha_varid, pha)
      retval = nf90_put_var(ncid, amp_varid, amp)

      retval = nf90_close(ncid)

      return

      end subroutine
