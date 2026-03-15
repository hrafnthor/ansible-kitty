# Default behavior when running 'just' without input.
default:
    @just --choose

# Lists the commands without prompting for selection.
list:
    @just -l

# Runs 'Molecule' test scenario for latest release installation
test-install-latest:
  @molecule  test --scenario-name install-latest -- -vv

# Runs molecule test scenario for nightly release installation
test-install-nightly:
  @molecule  test --scenario-name install-nightly -- -vv

# Runs molecule test scenario for specific version release installation
test-install-version:
  @molecule  test --scenario-name install-version -- -vv

# Runs molecule test scenario for multiple version release installation
test-multiple-installs:
  @molecule  test --scenario-name install-multiple-versions -- -vv

# Runs molecule test scenario for trimming undefined versions
test-trim:
  @molecule  test --scenario-name trim-versions -- -vv

# Runs molecule test scenario for removing specific versions
test-remove-version:
  @molecule  test --scenario-name remove-version -- -vv

# Runs molecule test scenario for removing all versions
test-remove:
  @molecule  test --scenario-name remove -- -vv
