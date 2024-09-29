# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
import os
import sys
import re

sys.path.insert(0, os.path.abspath('../../python/src'))
sys.path.insert(0, os.path.abspath('exts'))

import sphinx_rtd_theme


# -- Project information -----------------------------------------------------

project = 'MSG'
author = 'Rich Townsend & The MSG Team'
version = '1.3+dev'
release = version
branch = 'main'
copyright = '2024, Rich Townsend & The MSG Team'


# -- General configuration ---------------------------------------------------

# Numbered figures
numfig = True

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx_rtd_theme',
    'sphinx.ext.mathjax',
    'sphinx.ext.extlinks', 
    'sphinx.ext.intersphinx',
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon',
    'sphinxcontrib.spelling',
    'sphinx-prompt',
    'sphinx_substitution_extensions',
    'nbsphinx',
    'ads_cite',
    'data_schema',
    'sphinxfortran.fortran_domain'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']


# -- Additional configuration ------------------------------------------------

# sphinx_rtd options
html_theme_options = {
    'collapse_navigation': True,
    'sticky_navigation': True,
    'navigation_depth': 4,
    'includehidden': True,
    'titles_only': False,
    'logo_only': True
}

# CSS
html_css_files = [
    'theme_overrides.css'
]

# Set master doc
master_doc = 'index'

# Set logo
html_logo = 'msg-logo.png'

# Set up Extlinks
extlinks = {
    'wiki': ('https://en.wikipedia.org/wiki/%s', None),
    'dict': ('https://en.wiktionary.org/wiki/%s', None),
    'netlib': ('https://www.netlib.org/%s', None),
    'git': ('https://github.com/%s', None),
    'repo': ('https://github.com/rhdtownsend/msg/blob/{:s}/%s'.format(branch), None),
    'grids': ('http://user.astro.wisc.edu/~townsend/resource/download/msg/grids/%s', None),
    'passbands': ('http://user.astro.wisc.edu/~townsend/resource/download/msg/passbands/%s', None),
    'mad-star': ('http://user.astro.wisc.edu/~townsend/static.php?ref=%s', None)
}

# Set site-wide targets

if version.endswith('+dev'):
    dist_dir = 'msg-dev'
    tarball = f'{dist_dir}.tar.gz'
    tarball_url = f'http://user.astro.wisc.edu/~townsend/resource/download/nightly/{tarball}'
else:
    dist_dir = f'msg-{version}'
    tarball = f'{dist_dir}.tar.gz'
    tarball_url = f'https://github.com/rhdtownsend/msg/releases/download/v{version}/{tarball}'

targets = {
    'tarball_url': tarball_url,
    'mesa-sdk': 'http://user.astro.wisc.edu/~townsend/static.php?ref=mesasdk',
    'mad-sdk': 'http://user.astro.wisc.edu/~townsend/static.php?ref=madsdk',
    'grid-files': 'http://user.astro.wisc.edu/~townsend/static.php?ref=msg-grids',
    'passband-files': 'http://user.astro.wisc.edu/~townsend/static.php?ref=msg-passbands',
    'mesa': 'https://docs.mesastar.org/',
    'gyre': 'https://gyre.readthedocs.io/',
    'mist': 'https://waps.cfa.harvard.edu/MIST/'
}

rst_prolog = '\n'.join(['.. _{:s}: {:s}'.format(x, targets[x]) for x in targets])
nbsphinx_prolog = rst_prolog

# Add substitutions for sphinx_substitution_extensions

rep_exts = {"version": version,
            "author": author,
            "dist_dir": dist_dir,
            "tarball": tarball}

for rep_ext_key, rep_ext_val in rep_exts.items():
    rst_prolog += "\n.. |{:s}| replace:: {:s}".format(rep_ext_key, rep_ext_val)

# Add substitutions for en/em dashes

rst_prolog += '''
.. |--| unicode:: U+2013   .. en dash
.. |---| unicode:: U+2014  .. em dash
'''

# Mathjax & Latex macros

macros = {}

with open('macros.def', encoding='utf-8') as f:
    line = f.readline()
    while line:
        key, value = line.rstrip().split('\t')
        macros[key] = value
        line = f.readline()

mathjax_macros = {}
latex_preamble = ''

for key, value in macros.items():
    argnums = re.findall('#(\d)', value)
    if argnums:
        n_args = int(max(argnums))
        mathjax_macros[key] = [value, n_args]
        latex_preamble += f'\\newcommand{{\\{key}}}[{n_args}]{{{value}}}\n'
    else:
        mathjax_macros[key] = value
        latex_preamble += f'\\newcommand{{\\{key}}}{{{value}}}\n'

#mathjax_config = {                  
#    'TeX': { 
#        'Macros': mathjax_macros
#    }
#}
mathjax3_config = {                  
    'tex': { 
        'macros': mathjax_macros
    }
}

latex_elements = {
    'preamble': latex_preamble
}

# Enable email obfuscation
email_automode = True

# Set up intersphinx
intersphinx_mapping = {
    'numpy': ('https://numpy.org/doc/stable', None)
}
intersphinx_disabled_reftypes = ["std:doc"]

# Set up autodoc
autoclass_content = 'class'
autodoc_member_order = 'bysource'
autodoc_mock_imports = ['pycmsg', 'numpy']

# Set up napoleon
napoleon_google_docstring = True
napoleon_include_init_with_doc = True

# Set up nbsphinx
nbsphinx_execute = 'never'
nbsphinx_prolog = rst_prolog

# Spelling
spelling_word_list_filename='spelling_wordlist.txt'

# Pymsg
os.environ['MSG_DIR'] = os.path.abspath('../..')
