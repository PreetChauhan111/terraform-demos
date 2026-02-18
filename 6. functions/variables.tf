variable "bucket_name" {
  type = string
}

variable "special_chars" {
  type    = list(string)
  default = ["!", "#", "$", "%", "&", "(", ")", "*", "+", ",", ".", "/", ":", ";", "<", "=", ">", "?", "@", "_", "{", "}", "~"]
}