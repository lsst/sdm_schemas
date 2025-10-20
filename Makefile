# Makefile for building the SDM Schemas browser site
.PHONY: help init run build clean

# Print help
help:
	@echo "Available targets for sdm_schemas:"
	@echo "  init  - Install the required Ruby gems"
	@echo "  site  - Build the schema browser site"
	@echo "  serve  - Serve the schema browser site"
	@echo "  clean - Clean the schema browser site"
	@echo "  check - Validate the schema files using Felis"

# Install required Ruby gems (Ruby must be installed externally.)
init:
	@command -v gem >/dev/null 2>&1 || { \
		echo >&2 "gem command not found. Please install Ruby using your package manager."; \
		echo >&2 "For more information, visit: https://jekyllrb.com/docs/installation"; \
		exit 1; \
	}
	gem install -q --silent --no-verbose jekyll bundler jekyll-theme-cayman
# Run the web server and watch for changes
serve:
	jekyll serve --watch

# Validate the schema files using Felis
check:
	@command -v felis >/dev/null 2>&1 || { \
		echo >&2 "felis command not found. Please install 'pip install lsst-felis'."; \
		exit 1; \
	}
	@command felis validate yml/*.yaml

# Build the site
site: check
	jekyll build

# Cleanup local config and remove the generated site
clean:
	jekyll clean && rm -rf _site &> /dev/null
