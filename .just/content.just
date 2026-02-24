export IXIMIUZ_CONTENT_ROOT := env('IXIMIUZ_CONTENT_ROOT', parent_directory(justfile_directory()))

# create new content
new kind name:
  #!/usr/bin/env bash
  set -euo pipefail

  path={{ kind }}s/{{ name }}

  test ! -d $path || (echo "{{ style("error") }}{{ uppercamelcase(kind) }} already exists: {{ name }}{{ NORMAL }}" >&2 && exit 1)

  mkdir -p $path/

  # TODO: implement channel based content creation in labx

# generate the final manifest and files
generate name channel="dev": (exists name)
  #!/usr/bin/env bash
  set -euo pipefail

  cd {{ name }}

  if [[ -f justfile ]]; then
    just
  fi

  labx generate --template-dir {{ IXIMIUZ_CONTENT_ROOT }}/_templates --data-dir {{ IXIMIUZ_CONTENT_ROOT }}/_data --channel {{ channel }} --clear

# push files and container images
push name channel="dev": (exists name) (push-image name channel) (push-content name channel)

# push files from the local directory to the platform
push-content name channel="dev": (exists name) (generate name channel)
  labctl content push --dir {{ name }}/dist/ --force {{ kind }} $(just name {{ name }} {{ channel }})

# shorthand for "push name dev"
dev name: (push name "dev")

# shorthand for "push-content name dev"
dev-content name: (push-content name "dev")

# shorthand for "push name live"
release name: (push name "live")

# watch the local directory for changes and push them automatically
watch name channel="dev":
  watchexec just push {{ name }} {{ channel }}

# push a container image
push-image name channel="dev":
  #!/usr/bin/env bash
  set -euo pipefail

  if just ../.bake/ exists {{ name }}; then
    CHANNEL={{ channel }} just ../.bake/ push {{ name }}
  fi

# check content for broken links
check-links name:
  lychee '{{ name }}/*.md' '{{ name }}/**/*.md'

[private]
[no-exit-message]
@exists name:
  test -d "{{ name }}" || (echo "{{ style("error") }}{{ uppercamelcase(kind) }} not found: {{ name }}{{ NORMAL }}" >&2 && exit 1)

[private]
[no-exit-message]
@name name channel: (exists name)
  yq -r '.channels.{{ channel }}.name' {{ name }}/manifest.yaml

[private]
[no-exit-message]
@check-tasks id:
  labctl playground tasks {{ id }} --wait --fail-fast --timeout 120s
