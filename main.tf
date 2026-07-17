resource "github_repository" "controlled" {
  name                   = var.repository_name
  description            = "Ternforge r3 OpenTofu ruleset evidence target"
  visibility             = "public"
  auto_init              = false
  allow_auto_merge       = false
  allow_merge_commit     = true
  allow_rebase_merge     = true
  allow_squash_merge     = true
  delete_branch_on_merge = false
  has_issues             = true
}

resource "github_branch_default" "controlled" {
  count      = var.bootstrap_complete ? 1 : 0
  repository = github_repository.controlled.name
  branch     = "main"
}

resource "github_repository_ruleset" "branches" {
  count       = var.enable_rulesets ? 1 : 0
  name        = "protected-development-and-main-r3"
  repository  = github_repository.controlled.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/dev", "refs/heads/main"]
      exclude = []
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count   = 0
      dismiss_stale_reviews_on_push     = false
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_review_thread_resolution = false
    }

    required_status_checks {
      strict_required_status_checks_policy = true
      required_check {
        context = var.required_check
      }
    }
  }

  depends_on = [github_branch_default.controlled]
}

resource "github_repository_ruleset" "tags" {
  count       = var.enable_rulesets ? 1 : 0
  name        = "immutable-release-tags-r3"
  repository  = github_repository.controlled.name
  target      = "tag"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/tags/v*"]
      exclude = []
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true
    update           = true
  }
}
