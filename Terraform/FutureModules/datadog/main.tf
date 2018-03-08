resource "datadog_user" "dd-user" {
  email  = "${var.corp-email}"
  handle = "${var.corp-email}"
  name   = "${var.ddname}"
  is_admin = "${var.isddadmin}"
}