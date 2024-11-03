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
    openssh-server \
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
    && rm -rf /var/lib/apt/lists/*

# Generate locales
RUN locale-gen en_US.UTF-8

# Create a non-root user and add to sudoers
RUN useradd -m -s /bin/bash developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set up SSH directory and permissions
RUN mkdir -p /home/developer/.ssh && \
    chmod 700 /home/developer/.ssh && \
    chown -R developer:developer /home/developer/.ssh

# Install Repo tool and set permissions
RUN mkdir -p /home/developer/bin && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/developer/bin/repo && \
    chmod a+x /home/developer/bin/repo && \
    chown -R developer:developer /home/developer/bin

# Update PATH
ENV PATH="/home/developer/bin:${PATH}"

# Set environment variables
ENV YOCTO_DIR=/home/developer/workdir/bytedevkit-stm32mp1/5.0

# Expose SSH port (if needed)
EXPOSE 22

# Switch to developer user
USER developer
WORKDIR /home/developer

# Default command
CMD ["/bin/bash"]
