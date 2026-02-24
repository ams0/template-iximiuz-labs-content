function "challenge_path" {
  params = [path]
  result = "${root_path}/challenges/${path}"
}

function "challenge_tag" {
  params = [name]
  result = "${REPOSITORY}/challenges/${name}:${CHANNEL}"
}

group "challenges" {
  targets = []
}
