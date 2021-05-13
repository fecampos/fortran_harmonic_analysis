      subroutine harmonic_regression(nx,ny,nt,xi,yi,amp,pha,missing_val)

      implicit none

      integer, intent(in) :: nx, ny, nt

      real, intent(in) :: xi(nx,ny,nt), yi(nx,ny,nt), missing_val

      real, intent(out) :: amp(nx,ny,2), pha(nx,ny,2)

      integer :: i

      amp = missing_val

      pha = missing_val

      !$OMP PARALLEL DO
      do i = 1,2
        where(yi(:,:,1).ne.missing_val)
          amp(:,:,i) = 2*sqrt((sum(yi*cos(xi*i),3)/nt)**2 + (sum(-yi*sin(xi*i),3)/nt)**2)
          pha(:,:,i) = atan2(sum(-yi*sin(xi*i),3)/nt,sum(yi*cos(xi*i),3)/nt)
        end where
      end do
      !$OMP END PARALLEL DO

      end subroutine
