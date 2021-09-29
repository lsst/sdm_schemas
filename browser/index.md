---
layout: schema_index
title: Science Data Model Schemas
---
This schema browser provides a view on a curated subset of the Rubin Observatory's database schemas for
user-facing data products (the Science Data Model, or SDM).  These pages are rendered directly from the latest
revisions of schema definition YAML files maintained in the [sdm_schemas](https://github.com/lsst/sdm_schemas)
github repository.

Schemas available here for browsing include:

<ul>
    {%- assign schemas = site.pages | where: 'dir','/browser/' | sort: 'sort-index' %}
    {%- for schema in schemas %}
    {%- if schema.name != 'index.md' %}
    <li><a href="{{ schema.url | relative_url }}">{{ schema.title }}</a> {{ schema.content }}</li>
    {%- endif %}
    {%- endfor %}
</ul>
