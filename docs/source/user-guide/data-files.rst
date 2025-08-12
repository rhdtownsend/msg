.. _data-files:

**********
Data Files
**********

This chapter discusses the files used by MSG to store data on
disk. These files adopt the `HDF5 data format
<https://www.hdfgroup.org/>`__, a platform-neutral binary storage
format with advanced features such as transparent decompression.

File Types
==========

There are five types of MSG data files, distinguished by their
differing content:

* :f-schema:`specint` files store spectroscopic intensity
  data for a single combination of photospheric parameters.

* :f-schema:`photint` files store photometric intensity
  data for a single combination of photospheric parameters.

* :f-schema:`specgrid` files store spectroscopic
  intensity data over a grid of photospheric parameters.

* :f-schema:`photgrid` files store photometric intensity
  data over a grid of photospheric parameters.

* :f-schema:`passband` files store passband response
  functions, used to convert spectroscopic intensities into
  corresponding photometric intensities.

For a detailed description of each file type, refer to the
:ref:`data-schema` chapter.

.. _data-files-obtaining:

Obtaining Data
==============

MSG ships with a limited set of data files in the
:file:`$MSG_DIR/data` subdirectory, sufficient to enable the
:ref:`walkthroughs <walkthroughs>`:

* :file:`grids/sg-demo.h5` is a :f-schema:`specgrid`
  file based on a solar-metallicity `Kurucz
  <http://kurucz.harvard.edu/grids>`__ atmosphere grid (ap00k2odfnew),
  with intensity spectra synthesized using SYNSPEC :ads_citep:`hubeny:2017`.
* :file:`passbands/pb-Generic-Johnson.*-Vega.h5` are
  :f-schema:`passband` files for the U, B and V filters of the Johnson
  photometric system.
  
Additional files can be downloaded separately from the `grid files
<grid-files_>`__ and `passband files <passband-files_>`__ web pages.

.. _data-files-importing:

Importing Data
==============

To import an existing grid of spectra into the MSG ecosystem, first
convert the individual spectra into corresponding :f-schema:`specint`
files. MSG provides a number of tools to assist with this conversion;
see the :ref:`grid-tools` appendix for further details.

The next step is to create a manifest (named, say,
:file:`manifest.txt`) listing all the :f-schema:`specint` files
composing the grid. This is a simple text file with each line naming
one file; for instance::

   specint-0001.h5
   specint-0002.h5
   specint-0003.h5

Then, run the :program:`specint_to_specgrid` tool to create a
:f-schema:`specgrid` file:

.. code-block:: console

   $ $MSG_DIR/bin/specint_to_specgrid manifest.txt specgrid.h5

To build a :f-schema:`photgrid` file from the data in a
:f-schema:`specgrid` file, run the :program:`specgrid_to_photgrid`
tool:

.. code-block:: console
	    
   $ $MSG_DIR/bin/specgrid_to_photgrid specgrid.h5 passband.h5 photgrid.h5

...where :file:`passband.h5` is the name of the :f-schema:`passband`
file to use.

.. _data-files-photgrid:

.. note::

   It's not always necessary to create :f-schema:`photgrid` files,
   because MSG supports loading a :f-schema:`specgrid` file and then
   convolving with a passband on-the-fly. This approach is used in the
   examples presented in the :ref:`walkthroughs` chapter. It has the
   advantage of convenience, but a disadvantage in the form of a
   performance penalty, as discussed in the :ref:`performance` chapter.
