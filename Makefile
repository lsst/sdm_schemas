# Makefile for building the SDM Schemas browser site
.PHONY: help init run build clean

# Print help
help:
	@echo "Available targets for sdm_schemas:"
	@echo "  init  - Install the required Ruby gems"
	@echo "  build - Build the schema browser site"
	@echo "  run   - Serve the schema browser site"
	@echo "  clean - Clean the schema browser site"

# Install required Ruby gems (Ruby must be installed externally.)
init:
	@command -v gem >/dev/null 2>&1 || { \
		echo >&2 "gem command not found. Please install Ruby using your package manager."; \
		echo >&2 "For more information, visit: https://jekyllrb.com/docs/installation"; \
		exit 1; \
	}
	gem install -q --silent --no-verbose jekyll bundler jekyll-theme-cayman jekyll-last-modified-at

# Run the web server and watch for changes
run:
	jekyll serve --watch

# Build the site
build:
	jekyll build

# Cleanup local config and remove the generated site
clean:
	jekyll clean && rm -rf _site &> /dev/null
