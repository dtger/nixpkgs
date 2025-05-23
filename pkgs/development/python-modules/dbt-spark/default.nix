{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  dbt-core,
  dbt-adapters,
  dbt-common,
  sqlparams,
  pythonOlder,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "dbt-spark";
  version = "1.10.4";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "dbt-labs";
    repo = "dbt-adapters";
    tag = "v${version}";
    hash = "sha256-0chn9rz714zwy546cxblaagh1lvvfn9xm67gfc1s8pxwm9r920ld=";
  };

  sourceRoot = "${src.name}/dbt-spark";

  build-system = [ hatchling ];

  dependencies = [
    dbt-common
    dbt-adapters
    dbt-core
    sqlparams
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  # Many tests require database connections
  doCheck = false;

  pythonImportsCheck = [ "dbt.adapters.spark" ];

  meta = {
    description = "The Apache Spark adapter plugin for dbt";
    homepage = "https://github.com/dbt-labs/dbt-adapters/tree/main/dbt-spark";
    changelog = "https://github.com/dbt-labs/dbt-adapters/blob/main/dbt-spark/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}