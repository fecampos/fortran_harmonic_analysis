      program main_harmonic_analysis

      use netcdf

      use param

      implicit none

      do i = 1,nt
        time(:,:,i) = (i-1)*2*pi/365.25
      end do

      allocate(temp(nx,ny,nt))

      retval = nf90_open(file_in, NF90_NOWRITE, ncid)
      retval = nf90_inq_varid(ncid, t_NAME, tvarid)
      retval = nf90_inq_varid(ncid, x_NAME, xvarid)
      retval = nf90_inq_varid(ncid, y_NAME, yvarid)
      retval = nf90_get_var(ncid, tvarid, T)
      retval = nf90_get_var(ncid, xvarid, X)
      retval = nf90_get_var(ncid, yvarid, Y)
      retval = nf90_inq_varid(ncid, temp_NAME, tempvarid)
      retval = nf90_get_var(ncid, tempvarid, temp)
      retval = nf90_close(ncid)

      where(temp.ne.missing_val)
        temp = temp*sf_thetao+af_thetao
      elsewhere
        temp = missing_val
      end where

      mean_temp = sum(temp,3)/nt

      where(temp(:,:,1).eq.missing_val)
        mean_temp = missing_val
      end where

      call harmonic_regression(nx,ny,nt,time,temp,amp_temp,pha_temp,missing_val)  
      
      deallocate(temp)

      call write_harmonic_output(nx,ny,X,Y,missing_val,amp_temp,pha_temp,mean_temp)

      end program

      
