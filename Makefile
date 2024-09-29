install:
	pip install --upgrade pip && pip install -r requirements.txt

format:
	black *.py

lint:
	pylint --disable=R,C --ignore-patterns=test_.*?py *.py

test:
	python -m pytest -cov=main test_main.py

all: install format lint test

generate:
	python main.py

	@if [ -n "$$(git status --porcelain)" ]; then \

		git config --local user.email "action@github.com"; \
		git config --local user.name "GitHub Action"; \
		git add .; \
		git commit -m "Test"; \
		git push; \

	else \
		echo "No changes to commit. Skipping commit and push."; \
	fi