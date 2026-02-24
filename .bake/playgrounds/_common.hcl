function "playground_path" {
  params = [path]
  result = "${root_path}/playgrounds/${path}"
}

function "playground_tag" {
  params = [name]
  result = "${REPOSITORY}/playgrounds/${name}:${CHANNEL}"
}

group "playgrounds" {
  targets = []
}
