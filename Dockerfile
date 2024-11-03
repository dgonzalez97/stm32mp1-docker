# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Set the locale
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    build-essential \
    git \
    wget \
    curl \
    sudo \
    vim \
    tmux \
    nano \
    ca-certificates \
    openssh-client \
    python3 \
    python3-pip \
    python3-pexpect \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    diffstat \
    gawk \
    chrpath \
    socat \
    cpio \
    libsdl1.2-dev \
    xterm \
    bc \
    unzip \
    texinfo \
    libegl1-mesa \
    libsdl1.2-dev \
    pylint \
    xz-utils \
    debianutils \
    iputils-ping \
    libssl-dev \
    libsocketcan-dev \
    kmod \
    bmap-tools \
    gcc-multilib \
    screen \
    rsync \
    u-boot-tools \
    lz4 \
    zstd \
    file \
    && rm -rf /var/lib/apt/lists/*

    # Install zsh and oh-my-zsh
RUN sudo apt-get update && sudo apt-get install -y zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN chsh -s $(which zsh) developer



# Generate locales
RUN locale-gen en_US.UTF-8

# Create a non-root user and add to sudoers
RUN useradd -m -s /bin/bash developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install Repo tool and set permissions
RUN mkdir -p /home/developer/bin && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/developer/bin/repo && \
    chmod a+x /home/developer/bin/repo && \
    chown -R developer:developer /home/developer/bin

# Update PATH
ENV PATH="/home/developer/bin:${PATH}"

# Set environment variables
ENV YOCTO_DIR=/home/developer/workdir/bytedevkit-stm32mp1/5.0

# Create workdir and adjust permissions
RUN mkdir -p /home/developer/workdir && \
    chown -R developer:developer /home/developer/workdir

# Declare volume for workdir
VOLUME /home/developer/workdir

# ... [Previous content of your Dockerfile]

# Copy the initial-repo-setup.sh script into the image
COPY initial-repo-setup.sh /home/developer/

# Make sure the developer user owns the script
RUN chown developer:developer /home/developer/initial-repo-setup.sh  
RUN chmod +x initial-repo-setup.sh
# Switch to developer user
USER developer
WORKDIR /home/developer

## Enable color support and aliases
RUN echo 'export LS_OPTIONS="--color=auto"' >> /home/developer/.bashrc && \
echo 'eval "$(dircolors)"' >> /home/developer/.bashrc && \
echo 'alias ls="ls $LS_OPTIONS"' >> /home/developer/.bashrc && \
echo 'alias ll="ls $LS_OPTIONS -l"' >> /home/developer/.bashrc && \
echo 'alias l="ls $LS_OPTIONS -lA"' >> /home/developer/.bashrc && \
chown developer:developer /home/developer/.bashrc


# Default command
CMD ["/bin/bash"]
