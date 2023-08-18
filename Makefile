#    Conftest - Write tests against your config files
#
#    Copyright (C) 2019 Gareth Rushgrove
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        https://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

include hack/commons.mk

# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

.PHONY: clean
clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(BANNER)] Cleanup$(NO_COLOR)"
	@find . -name "*-amd64" | xargs rm -f
	@find . -name "*-arm64" | xargs rm -f
	@find . -name "melange.rsa*" | xargs rm -f
	@find . -name "packages" | xargs rm -fr

.PHONY: check
check: check-docker ## Check requirements

.PHONY: init
init: ## Initialize environment
	$(VENV)/bin/pre-commit install

.PHONY: validate
validate: ## Execute git-hooks
	@pre-commit run -a


# ====================================
# C H A I N G U A R D
# ====================================

##@ Chainguard

.PHONY: build
build: ## Build the APK using Docker images
	@echo -e "$(OK_COLOR)[$(APP)] Build the Container image$(NO_COLOR)"
	@./build.sh
