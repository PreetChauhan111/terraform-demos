locals {
  final_bucket_name_special_chars = replace(lower(var.bucket_name), " ", "-")

  final_bucket_name = join(
    "",
    regexall("[a-z0-9-]", local.final_bucket_name_special_chars)
  )
}