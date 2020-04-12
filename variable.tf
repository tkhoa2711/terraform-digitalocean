variable "do_token" {
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
}

variable "private_key" {
}
