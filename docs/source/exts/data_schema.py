from docutils.parsers.rst import nodes
from sphinx import addnodes

## Extension for formatting and referencing data schema entries

def setup(app):

    app.add_object_type('file-schema', 'f-schema', 'single: %s', objname='file type', ref_nodeclass=nodes.emphasis)
    app.add_object_type('group-schema', 'g-schema', 'single: %s', objname='group type', ref_nodeclass=nodes.emphasis)

    return {
        'version': '0.1',
    }

