function "course_path" {
  params = [path]
  result = "${root_path}/courses/${path}"
}

function "course_tag" {
  params = [name]
  result = "${REPOSITORY}/courses/${name}:${CHANNEL}"
}

group "courses" {
  targets = []
}
