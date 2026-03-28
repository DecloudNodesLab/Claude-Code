FROM codercom/code-server:latest
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    bash \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*
RUN code-server --install-extension Anthropic.claude-code
ENV HOME=/home/.claude
ENV PATH=/home/.local/bin:$PATH
ENV CLAUDE_CONFIG_DIR=/home/.claude
ENV XDG_CONFIG_HOME=/home/.claude/config
ENV DISABLE_AUTOUPDATER=1

RUN mkdir -p /home/.claude/project \
             /home/.config/code-server \
             /home/.claude/config \
            && curl -fsSL https://claude.ai/install.sh | bash

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

WORKDIR /home/.claude/project

ENTRYPOINT ["/usr/bin/env", "bash", "/usr/local/bin/run.sh"]
