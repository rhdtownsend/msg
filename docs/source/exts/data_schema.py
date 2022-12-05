from docutils.parsers.rst import nodes
from sphinx import addnodes

## Role functions for formatting and referencing data schema entries

def schema_type(role, rawtext, text, linenon, inliner, options={}, content=[]):

    node = nodes.emphasis(rawtext, text)

    return [node], []

def schema_ref(role, rawtext, text, linenon, inliner, options={}, content=[]):

    if role == 'fileref':
        refname = f'data-schema-files-{text}'
    elif role == 'groupref':
        refname = f'data-schema-groups-{text}'

    # This doesn't quite work as expected; when sphinx resolves the
    # reference, it strips out the formatting

    node = addnodes.pending_xref(rawtext, nodes.emphasis('', text), reftype='ref', refexplicit=False, reftarget=refname, refdomain='std')

    return [node], []

def setup(app):

    # Set up roles

    app.add_role('filetype', schema_type)
    app.add_role('grouptype', schema_type)
    app.add_role('fileref', schema_ref)
    app.add_role('groupref', schema_ref)

    return {
        'version': '0.1',
    }

