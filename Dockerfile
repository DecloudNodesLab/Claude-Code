FROM codercom/code-server:latest
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    bash \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*
RUN code-server --install-extension Anthropic.claude-code
ENV HOME=/home/root/.claude
ENV PATH=/home/root/.local/bin:$PATH
ENV CLAUDE_CONFIG_DIR=/home/root/.claude
ENV XDG_CONFIG_HOME=/home/root/.claude/config
ENV DISABLE_AUTOUPDATER=1

RUN mkdir -p /home/root/.claude/project \
             /home/root/.config/code-server \
             /home/root/.claude/config \
            && curl -fsSL https://claude.ai/install.sh | bash

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

WORKDIR /home/root/.claude/project

ENTRYPOINT ["/usr/bin/env", "bash", "/usr/local/bin/run.sh"]
