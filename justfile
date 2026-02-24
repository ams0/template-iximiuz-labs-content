export IXIMIUZ_CONTENT_ROOT := justfile_directory()

[private]
default:
  @just --list

mod bake '.bake/'

# challenge actions
# mod challenge 'challenges/'
challenge *ARGS:
  @just challenges/ {{ ARGS }}

# course actions
# mod course 'courses/'
course *ARGS:
  @just courses/ {{ ARGS }}

# playground actions
# mod playground 'playgrounds/'

# playground actions
playground *ARGS:
  @just playgrounds/ {{ ARGS }}

# tutorial actions
# mod tutorial 'tutorials/'
tutorial *ARGS:
  @just tutorials/ {{ ARGS }}

# remove .DS_Store files
cleands:
  rm -rf **/.DS_Store

# trigger running test workflow on GitHub Actions
trigger-test channel="live":
  gh workflow run test-content.yaml -f channel={{ channel }}

[private]
@generate-data: generate-vars

[private]
@generate-vars:
  mkdir -p _data

  just .bake/ vars-json | jq 'map({key: .name, value: .value}) | from_entries' > _data/bake.json
