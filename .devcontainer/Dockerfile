# Update the VARIANT arg in docker-compose.yml to pick an Elixir version: 1.9, 1.10, 1.10.4
ARG VARIANT=latest
FROM elixir:${VARIANT}

ENV APP_NAME="akiocode-team-budget-elxpro4"
ENV SECRET_KEY_BASE="$(mix phx.gen.secret)"
ENV DATABASE_URL="postgresql://3e706ed6-6d73-4198-88b6-8a266b627c1b-user:pw-38d1aeec-6e0f-4f66-9ac1-77d14f15ff90@postgres-free-tier-v2020.gigalixir.com:5432/3e706ed6-6d73-4198-88b6-8a266b627c1b"

# This Dockerfile adds a non-root user with sudo access. Update the “remoteUser” property in
# devcontainer.json to use it. More info: https://aka.ms/vscode-remote/containers/non-root-user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Options for common package install script
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="true"
ARG COMMON_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/v0.177.0/script-library/common-debian.sh"
ARG COMMON_SCRIPT_SHA="b9a71d258921a0ac47dfcf551f8fde87e18d7d5844a10dd018d81587b2569f0b"

# Optional Settings for Phoenix
ARG PHOENIX_VERSION="1.5.4"

# [Optional] Settings for installing Node.js.
ARG INSTALL_NODE="true"
ARG NODE_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/script-library/node-debian.sh"
ARG NODE_SCRIPT_SHA="dev-mode"
ARG NODE_VERSION="lts/*"
ENV NVM_DIR=/usr/local/share/nvm
ENV NVM_SYMLINK_CURRENT=true
ENV PATH=${NVM_DIR}/current/bin:${PATH}

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
RUN apt-get update \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y install --no-install-recommends curl ca-certificates 2>&1 \
  && curl -sSL ${COMMON_SCRIPT_SOURCE} -o /tmp/common-setup.sh \
  && ([ "${COMMON_SCRIPT_SHA}" = "dev-mode" ] || (echo "${COMMON_SCRIPT_SHA} */tmp/common-setup.sh" | sha256sum -c -)) \
  && /bin/bash /tmp/common-setup.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
  #
  # [Optional] Install Node.js for use with web applications
  && if [ "$INSTALL_NODE" = "true" ]; then \
  curl -sSL ${NODE_SCRIPT_SOURCE} -o /tmp/node-setup.sh \
  && ([ "${NODE_SCRIPT_SHA}" = "dev-mode" ] || (echo "${COMMON_SCRIPT_SHA} */tmp/node-setup.sh" | sha256sum -c -)) \
  && /bin/bash /tmp/node-setup.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}"; \
  fi \
  #
  # Install dependencies
  && apt-get install -y build-essential \
  #
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/common-setup.sh /tmp/node-setup.sh

RUN su ${USERNAME} -c "mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install --force hex phx_new ${PHOENIX_VERSION}"

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update \
  && apt-get install -y python3 python3-pip git-core curl

#     && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir gigalixir

RUN echo 'export PATH=~/.local/bin:$PATH' >> ~/.bash_profile
RUN /bin/bash -c 'source ~/.bash_profile'

# [Optional] Uncomment this line to install additional pacPkage.
# RUN  mix ...