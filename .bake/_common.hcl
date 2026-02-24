variable "CHANNEL" {
  default = "dev"
  description = "The channel to build (and push) the image to"

  validation {
    condition = CHANNEL != ""
    error_message = "The variable 'CHANNEL' must not be empty."
  }

  validation {
    condition = CHANNEL == regex("dev|beta|live", CHANNEL)
    error_message = "The variable 'CHANNEL' must either be 'dev' or 'live'."
  }
}

variable "REPOSITORY" {
  default = "ghcr.io/YOURNAME/iximiuz-labs"
  description = "Base repository URL"
}

variable "default_root" {
  default = "docker-image://ghcr.io/iximiuz/labs/rootfs:ubuntu-24-04"
  description = "Default root image to use"
}

variable "root_path" {
  default = ".."
}

group "default" {
  targets = ["challenges", "courses", "playgrounds", "tutorials"]
}
