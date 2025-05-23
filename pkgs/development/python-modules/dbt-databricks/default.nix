{
  lib,
  buildPythonPackage,
  dbt-core,
  dbt-spark,
  fetchFromGitHub,
  databricks-sdk,
  databricks-sql-connector,
  pytestCheckHook,
  hatchling,
  keyring,
  pydantic,
  pyarrow,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "dbt-databricks";
  version = "1.10.2";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "databricks";
    repo = "dbt-databricks";
    tag = "v${version}";
    hash = "sha256-0xxizaqs2q85zvgl7815lyn06sfx6ckgm3607cjshs77id6c0797=";
  };

  build-system = [ hatchling ];

  dependencies = [
    databricks-sdk
    databricks-sql-connector
    dbt-core
    dbt-spark
    keyring
    pydantic
    pyarrow
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  # Most tests require database connections
  doCheck = false;

  pythonImportsCheck = [ "dbt.adapters.databricks" ];

  meta = {
    description = "Plugin enabling dbt to work with Databricks";
    homepage = "https://github.com/databricks/dbt-databricks";
    changelog = "https://github.com/databricks/dbt-databricks/blob/v${version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}