###
### Site Management Tasks
###
.PHONY: init
init: ## Setup the local repository post-clone
	@echo "Cloning Submodules"
	@rm -rf ./themes/academic/
	@git submodule init
	@git submodule update
	@echo "DONE\n"

.PHONY: dev
dev: ## Start Hugo & watch for new changes to input files
	@echo "Starting Hugo Dev server & watching for changes"
	@hugo server -w
	@echo "DONE\n"

.PHONY: build
build: ## Build the static assets using hugo
	@echo "Building Static Assets"
	@hugo
	@echo "DONE\n"

###
### Common Tassks
###

.PHONY: prereq
prereq: ## Install the prereqs for this project
	@echo "Installing Prerequisites"
	@brew install hugo
	@echo "DONE\n"

#
# Self-Documenting Makefile using '##' descriptions
#
# Original Reference: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
#
help: Makefile
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help