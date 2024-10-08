.. f:type:: axis_t

   The axis_t type represents a grid axis.


   .. f:subroutine:: get_n(n)

      Get the number of points making up the axis.

      :p integer rank [out]: Number of points.

			     
   .. f:subroutine:: get_x_min(x_min)

      Get the minimum value of the axis.

      :p real(RD) x_min [out]: Minimum value.

			     
   .. f:subroutine:: get_x_max(x_max)

      Get the maximum value of the axis.

      :p real(RD) x_max [out]: Maximum value.


   .. f:subroutine:: get_label(label)

      Get the axis label.

      :p character(:), allocatable label [out]: Label.


   .. f:subroutine:: fetch(i, x, stat)

      Fetch an axis value.

      :p integer i [in]: Index of value (from 1 to `n`).
      :p real(RD) x [out]: Axis value.
      :o integer stat [out]: Status code.

   
   .. f:subroutine:: locate(x, i)

      Locate where along the axis a value falls.

      :p real(RD) x [out]: Value to locate.
      :p integer i [out]: Location index.


