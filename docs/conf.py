from documenteer.conf.guide import *

# Markdown files that aren't pages of the guide. CHANGES.md is included by
# changelog.md, and changes/ holds the news fragments for it.
exclude_patterns.extend(["APDB.md", "CDB.md", "DRP.md", "CHANGES.md", "changes"])

# No empty "Section Navigation" sidebar on top-level pages without
# sub-pages (documenteer already does this for index and changelog).
html_sidebars["categories"] = []
html_sidebars["schemas"] = []
