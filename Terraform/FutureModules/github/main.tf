# Add a user to the organization
resource "github_membership" "membership_github_user" {
  username = "${var.ghusername}"
  role     = "member"
}

#CORE
data "github_team" "core" {
  slug = "core"
}

resource "github_team_membership" "core" {
  team_id  = "${data.github_team.core.id}"
  username = "${var.ghusername}"
}


#DEVOPS
data "github_team" "devops" {
  slug = "devops"
}

resource "github_team_membership" "devops" {
  count = "${var.member_devops}"
  team_id  = "${data.github_team.devops.id}"
  username = "${var.ghusername}"
}


#DEVELOPERS
data "github_team" "developers" {
  slug = "developers"
}

resource "github_team_membership" "developers" {
  count = "${var.member_developers}"
  team_id  = "${data.github_team.developers.id}"
  username = "${var.ghusername}"
}
