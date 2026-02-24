# run tests for the content
test name channel="dev" tier="premium": (exists name) (has-solver name)
  #!/usr/bin/env bash
  set -euo pipefail

  content=$(just name {{ name }} {{ channel }})

  # Make sure the playground isn't running
  labctl {{ kind }} stop $content

  startArgs="--log-level debug --no-open --no-ssh"

  if [[ "{{ tier }}" == "free" ]]; then
    startArgs="$startArgs --as-free-tier-user"
  fi

  # Start a new playground
  labctl {{ kind }} start $startArgs $content
  trap "[[ \${DEBUG:-} != true ]] && labctl {{ kind }} stop $content" EXIT

  just solve {{ name }} {{ channel }}

  just check-tasks $(just play-id {{ name }} {{ channel }})

# solve the content
@solve name channel="dev": (exists name) (has-solver name)
  just solve-play {{ name }} $(just play-id {{ name }} {{ channel }}) {{ channel }}

# run the solver on a specific play
@solve-play name id channel="dev": (exists name) (has-solver name) (play-exists name id channel)
  {{ name }}/solution/run.sh {{ id }}

[private]
[no-exit-message]
@has-solver name:
  test -f "{{ name }}/solution/run.sh" || (echo "{{ style("error") }}{{ uppercamelcase(kind) }} has no solver: {{ name }}{{ NORMAL }}" >&2 && exit 1)

# resolve the play ID
@play-id name channel="dev":
  labctl playground list -q --filter {{ kind }}=$(just name {{ name }} {{ channel }}) | head -1

[private]
[no-exit-message]
@play-exists name id channel:
  labctl playground list -q --filter {{ kind }}=$(just name {{ name }} {{ channel }}) | grep -q {{ id }} || (echo "{{ style("error") }} Play '{{ id }}' does not exist for {{ kind }}: {{ name }}{{ NORMAL }}" >&2 && exit 1)
