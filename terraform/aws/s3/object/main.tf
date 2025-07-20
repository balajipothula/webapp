# Resource  type : aws_s3_object
# Resource  name : generic
# Attribute name : bucket
# Argument       : var.bucket
resource "aws_s3_object" "generic" {

  bucket                         = var.bucket                         # 🔒 Required argument.
  key                            = var.key                            # 🔒 Required argument.
  acl                            = var.acl                            # ✅ Optional argument.
  bucket_key_enabled             = var.bucket_key_enabled             # ✅ Optional argument.
  cache_control                  = var.cache_control                  # ✅ Optional argument.
//checksum_algorithm             = var.checksum_algorithm             # ✅ Optional argument.
  content_base64                 = var.content_base64                 # ✅ Optional argument, 🤜💥🤛 conflicts with `content` and `source`.
  content_disposition            = var.content_disposition            # ✅ Optional argument.
  content_encoding               = var.content_encoding               # ✅ Optional argument.
  content_language               = var.content_language               # ✅ Optional argument.
  content_type                   = var.content_type                   # ✅ Optional argument.
  content                        = var.content                        # ✅ Optional argument, 🤜💥🤛 conflicts with `content_base64` and `source`.
  etag                           = var.etag                           # ✅ Optional argument.
  force_destroy                  = var.force_destroy                  # ✅ Optional argument.
  kms_key_id                     = var.kms_key_id                     # ✅ Optional argument.
  metadata                       = var.metadata                       # ✅ Optional argument.
//object_lock_legal_hold_status  = var.object_lock_legal_hold_status  # ✅ Optional argument.
//object_lock_mode               = var.object_lock_mode               # ✅ Optional argument.
  object_lock_retain_until_date  = var.object_lock_retain_until_date  # ✅ Optional argument.
  override_provider              = var.override_provider              # ✅ Optional argument.
//server_side_encryption         = var.server_side_encryption         # ✅ Optional argument.
  source_hash                    = var.source_hash                    # ✅ Optional argument.
  source                         = var.source_path                    # ✅ Optional argument, 🤜💥🤛 conflicts with `content_base64` and `content`
  storage_class                  = var.storage_class                  # ✅ Optional argument.
  tags                           = var.tags                           # ✅ Optional argument.
  website_redirect               = var.website_redirect               # ✅ Optional argument.

}
