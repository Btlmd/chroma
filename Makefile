fetch_js_dev_dependencies:
	sh scripts/fetch_js_dev_dependencies.sh

rebuild_chroma_ui:
	cd chroma-ui/; yarn install && yarn build

fetch_deps_and_rebuild_chroma_ui: fetch_js_dev_dependencies rebuild_chroma_ui

install_dev_python_modules:
	python scripts/install_dev_python_modules.py -qqq

install_dev_python_modules_verbose:
	python scripts/install_dev_python_modules.py

dev_install: install_dev_python_modules_verbose rebuild_chroma_ui

dev_install_quiet: install_dev_python_modules rebuild_chroma_ui

black:
	black --fast chroma examples

check_black:
	black --check --fast chroma examples

# NOTE: We use `git ls-files` instead of isort's built-in recursive discovery
# because it is much faster. Note that we also need to skip files with `git
# ls-files` (the `:!:` directives are exclued patterns). Even isort
# `--skip`/`--filter-files` is very slow.
isort:
	isort \
    `git ls-files 'examples/*.py' 'chroma/*.py'`

check_isort:
	isort --check \
    `git ls-files 'examples/*.py' 'chroma/*.py'`

pytest:
	pytest