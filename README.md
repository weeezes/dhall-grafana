# dhall-grafana

Your [Grafana](http://www.grafana.org/) dashboards-as-code with [Dhall](https://dhall-lang.org/)!

# Usage

Install `dhall-to-json` by downloading it from [dhall-haskell/releases](https://github.com/dhall-lang/dhall-haskell/releases). When you have the binary in your `$PATH` it's as easy as running:

```
$ dhall-to-json --file all_dashboard.dhall
```

Import the output to Grafana and you're done!

Make sure you have a [TestData DB datasource](https://grafana.com/docs/features/datasources/testdata/) configured to see the [`all_dashboard.dhall`](./all_dashboard.dhall) graphs be populated.

![all_dashboard_sample.png](docs/screenshots/all_dashboard_sample.png)

# Getting started

First confirm that your tooling works by walking through [Usage](#usage). Open up a new file after you're done, and copy-paste in the following:

```
let Grafana =
        https://raw.githubusercontent.com/weeezes/dhall-grafana/master/package.dhall sha256:1f8a334cae4ab44ed444ec553a24630e6505236062d7b0ca01f0a82e25b6a9a6
      ? https://raw.githubusercontent.com/weeezes/dhall-grafana/master/package.dhall

in {=}
```

Compile it by running `dhall-to-json`:

```
$ dhall-to-json --file tutorial.dhall
{}
```

We have an empty object, it's something! Let's add in a dashboard:

```
let Grafana =
        https://raw.githubusercontent.com/weeezes/dhall-grafana/master/package.dhall sha256:1f8a334cae4ab44ed444ec553a24630e6505236062d7b0ca01f0a82e25b6a9a6
      ? https://raw.githubusercontent.com/weeezes/dhall-grafana/master/package.dhall

in Grafana.Dashboard::
	{ title = "Tutorial"
	}
```

Compile it and the output should be a bit more interesting. It's your first Grafana dashboard, built with Dhall!

Notice the `::` after `Grafana.Dashboard`? That's called *record completion*. We're filling in our own values on top of a default, which you can examine in [`defaults/Dashboard.dhall`](./default/Dashboard.dhall). You can find all other default values and overrideable parameters from [`defaults/`](./defaults)! To find an example of record completion, check out the [Dhall Cheatsheet](https://github.com/dhall-lang/dhall-lang/wiki/Cheatsheet#complex-types) *records* section to understand how `package.dhall` works.

Let's add in our first panel:

```
let Grafana =
        https://raw.githubusercontent.com/weeezes/dhall-grafana/master/package.dhall sha256:1f8a334cae4ab44ed444ec553a24630e6505236062d7b0ca01f0a82e25b6a9a6
      ? https://raw.githubusercontent.com/weeezes/dhall-grafana/master/package.dhall

in  Grafana.Dashboard::{
    , title = "test"
    , panels =
        Grafana.Utils.generateIds
          [ Grafana.Panels.mkGraphPanel
              Grafana.GraphPanel::{
              , title = "test"
              , gridPos = { x = 0, y = 0, w = 12, h = 6 }
              }
          ]
    }
```

Whoo, that looks a lot more exciting! There's a few things going on here. We're adding the panels by passing them in to the Dashboards `panels` field. The panels have to have unique IDs, so we can use the `generateIds` utility and the `mkGraphPanel` helper to get exactly that. `mkGraphPanel` eats a `GraphPanel`, also defined with record completion. The end result is a list of `Panels`, and `Dashboard` happily accepts that type.

Compile it, import it to Grafana, and let your eyes rest on that masterpiece!
