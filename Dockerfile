FROM codercom/code-server:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    bash \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

ENV HOME=/home/coder
ENV PATH=/home/coder/.local/bin:$PATH
ENV CLAUDE_CONFIG_DIR=/home/coder/.claude
ENV XDG_CONFIG_HOME=/home/coder/.claude/config
ENV DISABLE_AUTOUPDATER=1

RUN mkdir -p /home/coder/.claude/project \
             /home/coder/.config/code-server \
             /home/coder/.claude/config \
 && curl -fsSL https://claude.ai/install.sh | bash

COPY --chown=coder:coder run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

WORKDIR /home/coder/.claude/project

ENTRYPOINT ["/usr/bin/env", "bash", "/usr/local/bin/run.sh"]
