data "contabo_image" "debian_11" {
  id = "66abf39a-ba8b-425e-a385-8eb347ceac10"
}

resource "contabo_instance" "custom_instance" {
  display_name  = "Debian 11 instance"
  image_id      = data.contabo_image.debian_11.id
}