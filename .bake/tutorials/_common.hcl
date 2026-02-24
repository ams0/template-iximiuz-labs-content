function "tutorial_path" {
  params = [path]
  result = "${root_path}/tutorials/${path}"
}

function "tutorial_tag" {
  params = [name]
  result = "${REPOSITORY}/tutorials/${name}:${CHANNEL}"
}

group "tutorials" {
  targets = []
}
