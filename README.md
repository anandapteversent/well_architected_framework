## Getting Started

### Installation

Install Powerpipe (https://powerpipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/powerpipe
```

This mod also requires [Steampipe](https://steampipe.io) with the [AWS plugin](https://hub.steampipe.io/plugins/turbot/aws) as the data source. Install Steampipe (https://steampipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/steampipe
steampipe plugin install aws
```

Steampipe will automatically use your default AWS credentials. Optionally, you can [setup multiple accounts](https://hub.steampipe.io/plugins/turbot/aws#multi-account-connections) or [customize AWS credentials](https://hub.steampipe.io/plugins/turbot/aws#configuring-aws-credentials).

Finally, install the mod:

```sh
mkdir dashboards
cd dashboards
powerpipe mod init
git clone git@github.com:anandapteversent/well_architected_framework.git
powerpipe mod install
```

### Browsing Dashboards

Start Steampipe as the data source:

```sh
steampipe service start
```

Start the dashboard server:

```sh
powerpipe server
```

Browse and view your dashboards at **http://localhost:9033**.

### Running Checks in Your Terminal

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `powerpipe benchmark` command:

List available benchmarks:

```sh
powerpipe benchmark list
```

Run a benchmark:

```sh
powerpipe benchmark run well_architected_framework
```

Run a benchmark for a specific pillar:

```sh
powerpipe benchmark run well_architected_framework_security
```

Run a benchmark for a specific question:

```sh
powerpipe benchmark run well_architected_framework_sec01
```

Run a benchmark for a specific best practice:

```sh
powerpipe benchmark run well_architected_framework_sec01_bp01
```

Different output formats are also available, for more information please see
[Output Formats](https://powerpipe.io/docs/reference/cli/benchmark#output-formats).

### Common and Tag Dimensions

The benchmark queries use common properties (like `account_id`, `connection_name` and `region`) and tags that are defined in the dependent [AWS Compliance mod](https://github.com/turbot/steampipe-mod-aws-compliance) These properties can be executed in the following ways:

It's easiest to setup your vars file, starting with the sample:

```sh
cp steampipe.spvars.example steampipe.spvars
vi steampipe.spvars
```

Alternatively you can pass variables on the command line:

```sh
powerpipe benchmark run well_architected_framework_security --var 'common_dimensions=["account_id", "connection_name", "region"]'
```

Or through environment variables:

```sh
export PP_VAR_common_dimensions='["account_id", "connection_name", "region"]'
export PP_VAR_tag_dimensions='["Environment", "Owner"]'
powerpipe benchmark run well_architected_framework_security
```

Commands - 

powerpipe benchmark run aws_well_architected.benchmark.well_architected_framework --export csv

Well Architected Pillar IDs

