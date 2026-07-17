output "repository" {
  value = github_repository.controlled.full_name
}

output "branch_ruleset_id" {
  value = var.enable_rulesets ? github_repository_ruleset.branches[0].ruleset_id : null
}

output "tag_ruleset_id" {
  value = var.enable_rulesets ? github_repository_ruleset.tags[0].ruleset_id : null
}

output "rulesets_enabled" {
  value = var.enable_rulesets
}
