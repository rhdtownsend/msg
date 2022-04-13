.. _tensor-product-interpolation:

****************************
Tensor Product Interpolation
****************************

Tensor product interpolation is a generalization of low-dimension
(typically, 2-d or 3-d) multivariate interpolation schemes to an
arbitrary number of dimensions. The literature on this topic is rather
specialized (although see this Wikipedia :wiki:`section
<Multivariate_interpolation#Tensor_product_splines_for_N_dimensions>`);
therefore, this appendix provides a brief introduction. Interpolation
in general is covered by many textbooks, so the focus here is
reviewing how simple schemes can be generalized.

========================
Univariate Interpolation
========================

Suppose we are given a set of values :math:`f(x_{1}), f(x_{2}),
\ldots, f(x_{n})`, representing some function :math:`f(x)` evaluated
at a set of :math:`n` discrete grid points. Then, a piecewise-linear
interpolation scheme approximates :math:`f(x)` in each subinterval
:math:`x_{i} \leq x \leq x_{i+1}` via

.. math::

   \tilde{f}(x) = f_{i} \, \ell_{1} (u) + f_{i+1} \, \ell_{2} (u)

Here :math:`f_{i} \equiv f(x_{i})`, while

.. math::

   u \equiv \frac{x - x_{i}}{x_{i+1} - x_{i}}

is a normalized coordinate that expresses where in the subinterval we
are; :math:`u=0` corresponds to :math:`x=x_{i}`, and :math:`u=1` to
:math:`x=x_{i+1}`. The linear basis functions are defined by

.. math::

   \ell_{1}(u) = 1 - u, \qquad \ell_{2}(u) = u.

This interpolation scheme is :math:`C^{0}` continuous, and reproduces
:math:`f(x)` exactly at the grid points.

If we want a smoother representation of the function, we generally
need more data. Suppose then that we're also provided the derivatives
:math:`\sderiv{f}{x}` at the grid points. Then, a
piecewise-cubic interpolation scheme is

.. math::

   \tilde{f}(x) =
       f_{i} \, c_{1}(u) +
       f_{i+1} \, c_{2}(u) +
       \partial_{x} f_{i} \, c_{3}(u) +
       \partial_{x} f_{i+1} \, c_{4}(u)

where :math:`u` has the same definition as before, :math:`\partial_{x}
f_{i} \equiv (\sderiv{f}{x})_{x=x_{i}}`, and the cubic basis
functions are

.. math::

   c_{1} = 2 u^3 - 3 u^2 + 1 \qquad
   c_{2} = u^3 - u^2 \qquad
   c_{3} = -2 u^3 + 3 u^2 \qquad
   c_{4} = u^3 - 2 u^2 + u

(these can be recognized as the basis functions for :wiki:`cubic Hermite splines <Cubic_Hermite_spline>`). This new definition is
:math:`C^{1}` continuous, and reproduces :math:`f(x)` *and* its first
derivative exactly at the grid points.

=======================      
Bivariate Interpolation
=======================

Bivariate interpolation allows us to approximate a function
:math:`f(x,y)` from its values on a rectilinear (but not necessarily
equally spaced) grid described by the axis values
:math:`x_{1},x_{2},\ldots,x_{n}` and
:math:`y_{1},y_{2},\ldots,y_{m}`. A piecewise-bilinear interpolating scheme
approximates :math:`f(x,y)` in each subinterval :math:`x_{i} \leq x
\leq x_{i+1}`, :math:`y_{j} \leq y \leq y_{j+1}` via

.. math::

   \tilde{f}(x,y) =
       f_{i,j}     \, \ell_{1}(u) \ell_{1}(v) +
       f_{i+1,j}   \, \ell_{2}(u) \ell_{2}(v) +
       f_{i,j+1}   \, \ell_{1}(u) \ell_{1}(v) +
       f_{i+1,j+1} \, \ell_{2}(u) \ell_{2}(v)

Here, :math:`u` has the same definition as before, while

.. math::

   v \equiv \frac{y - y_{j}}{y_{j+1} - y_{j}},

and :math:`f_{i,j} \equiv f(x_{i},y_{j})`. We can also write the
scheme in the more-compact form

.. math::

   \tilde{f}(x,y) = \sum_{p,q=1}^{2} \mathcal{L}^{p,q} \, \ell_{p}(u) \ell_{q}(v),

where the coefficients :math:`\mathcal{L}^{p,q}` can be expressed as the matrix

.. math::

   \mathcal{L}^{p,q} \equiv
   \begin{bmatrix}
   f_{i,j} & f_{i,j+1} \\
   f_{i+1,j} & f_{i+1,j+1}
   \end{bmatrix}.
   
A corresponding piecewise-bicubic interpolating scheme can be written
in the form

.. math::

   \tilde{f}(x,y) = \sum_{p,q=1}^{4} \mathcal{C}^{p,q} \, c_{p}(u) c_{q}(v),

where the coefficients :math:`\mathcal{C}^{h}` can be expressed as the matrix

.. math::

   \mathcal{C}^{p,q} \equiv
   \begin{bmatrix}
     f_{i,j} & f_{i,j+1} & \partial_{y} f_{i,j} & \partial_{y} f_{i,j+1} \\
     f_{i+1,j} & f_{i+1,j+1} & \partial_{y} f_{i+1,j} & \partial_{y} f_{i+1,j+1} \\
     \partial_{x} f_{i,j} & \partial_{x} f_{i,j+1} & \partial_{xy} f_{i,j} & \partial_{xy} f_{i,j+1} \\
     \partial_{x} f_{i+1,j} & \partial_{x} f_{i+1,j+1} & \partial_{xy} f_{i+1,j} & \partial_{xy} f_{i+1,j+1}
   \end{bmatrix}.
     
Constructing this matrix requires 16 values: the function at the four
corners of the subinterval, the first derivatives with respect to
:math:`x` and with respect to :math:`y` at the corners, and the cross
derivatives :math:`\partial_{xy} f` at the corners.

==========================
Multivariate Interpolation
==========================

Let's now generalize the compact expressions above for
piecewise-bilinear and bicubic interpolation, to piecewise
interpolation in :math:`N` dimensions. For linear interpolation, we
have

.. math::

   \tilde{f}(x_{1},x_{2},\ldots,x_{N}) =
   \sum_{p_{1},p_{2},\ldots,p_{N}=1}^{2}
   \mathcal{L}^{p_{1},p_{2},\ldots,p_{N}}
   \prod_{k=1}^{N}
   \ell_{p_{k}}(u_{k})

Likewise, for cubic interpolation, we have

.. math::

   \tilde{f}(x_{1},x_{2},\ldots,x_{N}) =
   \sum_{p_{1},p_{2},\ldots,p_{N}=1}^{4}
   \mathcal{C}^{p_{1},p_{2},\ldots,p_{N}}
   \prod_{k=1}^{N}
   c_{p_{k}}(u_{k}).

The coefficients :math:`\mathcal{L}^{p_{1},p_{2},\ldots,p_{N}}` and
:math:`\mathcal{C}^{p_{1},p_{2},\ldots,p_{N}}` cannot easily be expressed in
closed form, but they are relatively easy to construct
algorithmically.

The summations in expressions above can be regarded as the contraction
(over all indices) of a pair of rank-:math:`N` tensors. In the cubic
case, the components of the first tensor correspond to the
coefficients :math:`\mathcal{C}^{p_{1},p_{2},\ldots,p_{N}}`, while the second
tensor is formed by taking :math:`N` outer products between the
vectors

.. math::

   \mathbf{c}_{k}(u_{k}) =
   \begin{bmatrix}
   c_{1}(u_{k}) \\
   c_{2}(u_{k}) \\
   c_{3}(u_{k}) \\
   c_{4}(u_{k})
   \end{bmatrix}
   \quad
   (k = 1,\ldots,N)

Hence, this kind of multivariate interpolation is also known as tensor
product interpolation.
