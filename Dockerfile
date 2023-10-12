FROM mcr.microsoft.com/devcontainers/base:jammy

RUN sudo apt update
RUN sudo apt install -y cmake

WORKDIR /app

RUN chown -R vscode:vscode /app

USER vscode

RUN echo "export PROMPT_DIRTRIM=2" >> ~/.bashrc
RUN echo 'export PS1="\w$ "' >> ~/.bashrc

RUN echo "set editing-mode emacs" >> ~/.inputrc
RUN echo "set completion-ignore-case off" >> ~/.inputrc
RUN echo "set show-all-if-unmodified on" >> ~/.inputrc
RUN echo '"\\C-p": history-search-backward' >> ~/.inputrc
RUN echo '"\\C-n": history-search-forward' >> ~/.inputrc
RUN echo '"\\e[A": history-search-backward' >> ~/.inputrc
RUN echo '"\\e[B": history-search-forward' >> ~/.inputrc

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN ~/.cargo/bin/rustup target add wasm32-unknown-unknown
RUN curl -L https://foundry.paradigm.xyz | bash
RUN ~/.foundry/bin/foundryup