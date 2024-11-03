# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /home/developer

# Install required packages for Yocto build (you can modify this list later)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    locales \
    sudo

# Set the locale (optional but recommended)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a non-root user (optional but recommended)
RUN useradd -m -s /bin/bash developer && echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER developer

# Expose SSH port (if you plan to use SSH later)
# EXPOSE 22

# Set the default command to bash
CMD ["/bin/bash"]
