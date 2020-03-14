+++
title = "Self-Documenting Makefile"

# Add a summary to display on homepage (optional).
summary = "A gist for self-documenting Makefiles."

date = 2020-03-13T00:00:00-04:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["alexlapinski"]

# Is this a featured post? (true/false)
featured = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = [
    "Makefile",
    "Linux",
    "C"
]
categories = []
projects = ["ansible-home-server"]
+++

```Makefile
#
# Self-Documenting Makefile using '##' descriptions
#
# Original Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#

.PHONY
task: ## This awesome task does everything!
  @echo "Nope."

help: Makefile
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
```

[Gist](https://gist.github.com/alexlapinski/277b25c3ee567b3cae8219ccd153d261)