variable "do_token" {
  description = "Personal access token for DigitalOcean"
}

variable "do_ssh_key_name" {
  type        = string
  description = "The SSH key to associate with the box"
}

variable "username" {
  description = "The username to login to the box after creation"
}

variable "user_public_key" {
  description = "The public key of the user to login"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key" {
  description = "The SSH private key to connect to the droplet"
  default     = "~/.ssh/id_rsa"
}
