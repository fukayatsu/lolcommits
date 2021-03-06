Feature: Bug regression testing
  As a developer
  I want to ensure fixed bugs stay fixed
  So that I don't have to fix them again!

  #
  # issue #58, https://github.com/mroth/lolcommits/issues/58
  #
  Scenario: handle git repos with spaces in directory name
    Given I am in a git repository named "test lolol" with lolcommits enabled
    And I successfully run `git commit --allow-empty -m 'can haz commit'`
    Then the output should contain "*** Preserving this moment in history."
    And a directory named "../.lolcommits/test-lolol" should exist

  #
  # issue #68, https://github.com/mroth/lolcommits/issues/68
  #
  @fake-interactive-rebase @slow_process
  Scenario: Don't trigger capture during a git rebase
    Given I am in a git repository named "yuh8history" with lolcommits enabled
      And I do 6 git commits
    When I successfully run `git rebase -i HEAD~5`
    # Then there should be 4 commit entries in the git log
    Then there should be exactly 6 jpgs in "../.lolcommits/yuh8history"

  #
  # issue #80, https://github.com/mroth/lolcommits/issues/80
  #
  Scenario: don't warn about system_timer (on MRI 1.8.7)
    When I successfully run `lolcommits`
    Then the output should not contain "Faraday: you may want to install system_timer for reliable timeouts"

  #
  # issue #81, https://github.com/mroth/lolcommits/issues/81
  #
  Scenario: don't want to see initialized constant warning from Faraday on CLI (on MRI 1.8.7)
    When I successfully run `lolcommits`
    Then the output should not contain "warning: already initialized constant DEFAULT_BOUNDARY"
  