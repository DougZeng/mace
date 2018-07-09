"""Repository rule for Git autoconfiguration, borrow from tensorflow
"""
def _git_version_conf_impl(repository_ctx):
  repository_ctx.template(
      "BUILD",
      Label("//repository/git:BUILD.tpl"))

  mace_root_path = str(repository_ctx.path(Label("@mace//:BUILD")))[:-len("BUILD")]

  generated_files_path = repository_ctx.path("gen")

  repository_ctx.execute([
      'bash', '%s/mace/tools/git/gen_version_source.sh' % mace_root_path
      , '%s/version' % generated_files_path
  ], quiet=False)


git_version_repository = repository_rule(
    implementation = _git_version_conf_impl,
    local=True,
)
