variable "owner" {
  type    = string
  default = "betabitplus-template-lab"
}

variable "repository_name" {
  type    = string
  default = "sandbox-ternforge-controlled-repository-20260718-r3"
}

variable "bootstrap_complete" {
  type    = bool
  default = false
}

variable "enable_rulesets" {
  type    = bool
  default = false
}

variable "required_check" {
  type    = string
  default = "repository-ci"
}
