# Makefile for nsynca-website

# Variables
IMAGE_NAME = nsynca-website
CONTAINER_NAME = nsynca-website-container
PORT = 8080


build: ## Build Docker image
	docker build -t $(IMAGE_NAME) .

run: ## Run container with hot reload
	docker run -d \
		--name $(CONTAINER_NAME) \
		-p $(PORT):$(PORT) \
		-v $(PWD):/usr/share/nginx/html \
		$(IMAGE_NAME)
	@echo "Container running at http://localhost:$(PORT)"

stop: ## Stop container
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

restart: stop run ## Restart container

list: # List files inside the image
	docker run --rm $(IMAGE_NAME) ls -la /usr/share/nginx/html

show-config: ## View nginx config
	docker run --rm $(IMAGE_NAME) cat /etc/nginx/conf.d/default.conf


shell: ## Interactive shell inside container
	docker run --rm -it $(IMAGE_NAME) /bin/sh

clean: stop # # Clean up (stop + remove image)
	docker rmi $(IMAGE_NAME) || true


# =====================================
# 📚 Documentation & Help
# =====================================

help: ## Show this help message
	@echo "Available commands:"
	@echo ""
	@python3 -c "import re; lines=open('Makefile', encoding='utf-8').readlines(); targets=[re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$',l) for l in lines]; [print(f'  make {m.group(1):<20} {m.group(2)}') for m in targets if m]"


# =======================
# 🎯 PHONY Targets
# =======================

# Auto-generate PHONY targets (cross-platform)
.PHONY: $(shell python3 -c "import re; print(' '.join(re.findall(r'^([a-zA-Z_-]+):\s*.*?##', open('Makefile', encoding='utf-8').read(), re.MULTILINE)))")

# Test the PHONY generation
# test-phony:
# 	@echo "$(shell python3 -c "import re; print(' '.join(sorted(set(re.findall(r'^([a-zA-Z0-9_-]+):', open('Makefile', encoding='utf-8').read(), re.MULTILINE)))))")"
