.. _data-files:

**********
Data Files
**********

This chapter discusses the files in which MSG stores its data. These
files adopt the `HDF5 data format <https://www.hdfgroup.org/>`__, a
platform-neutral binary storage format with advanced features such as
transparent decompression.

File Types
==========

MSG files come in five types, distinguished by their differing data
content:

* :ref:`data-schema-files-specint` files store spectroscopic intensity
  data for a single combination of atmospheric parameters.

* :ref:`data-schema-files-photint` files store photometric intensity
  data for a single combination of atmospheric parameters.

* :ref:`data-schema-files-specgrid` files store spectroscopic
  intensity data over a grid of atmospheric parameters.

* :ref:`data-schema-files-photgrid` files store photometric intensity
  data over a grid of atmospheric parameters.

* :ref:`data-schema-files-passband` files store passband response
  functions, used to convert spectroscopic intensities into
  corresponding photometric intensities.

For a detailed description of each file type, refer to the
:ref:`data-schema` chapter.


Obtaining Data
==============

MSG only ships with a limited set of data files, sufficient to enable
the :ref:`walkthroughs <walkthroughs>`. Additional files can be
downloaded separately from the :ref:`grid-files` and
:ref:`passband-files` appendices.


Importing Data
==============

If you would like to import an existing spectroscopic grid into MSG,
then this section describes the process. First, convert the individual
spectra in your grid into corresponding
:ref:`data-schema-files-specint` files. MSG provides a number of tools
to assist with this conversion; see the :ref:`grid-tools` appendix for
further details.

The next step is to create a manifest (named, say,
:file:`manifest.txt`) listing all the :ref:`data-schema-files-specint`
files composing your grid. This is a simple text file with each line
naming one file; for instance::

   specint-0001.h5
   specint-0002.h5
   specint-0003.h5

Then, run the :command:`specint_to_specgrid` tool to create a
:ref:`data-schema-files-specgrid` file:

.. prompt:: bash

   $MSG_DIR/bin/specint_to_specgrid manifest.txt specgrid.h5

The axes and the topology of the grid are automatically determined by
the labels attached to each specint file. 

To build a :ref:`data-schema-files-photgrid` file from the data in a
:ref:`data-schema-files-specgrid` file, run the
:command:`specgrid_to_photgrid` tool:

.. prompt:: bash
	    
   $MSG_DIR/bin/specgrid_to_photgrid specgrid.h5 passband.h5 photgrid.h5

...where :file:`passband.h5` is the name of the
:ref:`data-schema-files-passband` file to use. Note that it's not
always necessary to create a :ref:`data-schema-files-photgrid` file, as MSG
can convolve with passbands on the fly (as discussed in the
:ref:`photometric-colors` section).
