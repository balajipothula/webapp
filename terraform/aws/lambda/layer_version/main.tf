# Resource  type : aws_lambda_function
# Resource  name : generic
# Attribute name : function_name
# Argument       : var.function_name
# Variable  name : function_name
resource "aws_lambda_layer_version" "generic" {

  layer_name               = var.layer_name               # Required argument.
  compatible_runtimes      = var.compatible_runtimes      # Optional argument, but keep it.
  description              = var.description              # Optional argument, but keep it.
  filename                 = var.filename                 # Optional argument, conflicts with s3_bucket, s3_key and s3_object_version.
  license_info             = var.license_info             # Optional argument, but keep it.
//s3_bucket                = var.s3_bucket                # Optional argument, conflicts with filename.
//s3_key                   = var.s3_key                   # Optional argument, conflicts with filename.
//s3_object_version        = var.s3_object_version        # Optional argument, conflicts with filename.
  source_code_hash         = var.source_code_hash         # Optional argument, but keep it.

}
