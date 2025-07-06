#!/usr/bin/env bash
: <<DOCUMENTATION
Installs deps for local development if not present.
- Docker
- Supabase
- Terraform
- NPM
DOCUMENTATION

# IMPORTS ----------------------------------------------------------------------
source "$(dirname "$0")/utils.sh"

# DEPENDENCY CHECKING ----------------------------------------------------------

# Detect OS platform
detect_platform() {
    case "$(uname -s)" in
    Linux*) PLATFORM=Linux ;;
    Darwin*) PLATFORM=Mac ;;
    CYGWIN*) PLATFORM=Cygwin ;;
    MINGW*) PLATFORM=MinGw ;;
    MSYS*) PLATFORM=Git ;;
    *) PLATFORM="UNKNOWN:${unameOut}" ;;
    esac
    log "INFO" "Detected platform: $PLATFORM"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Docker based on platform
install_docker() {
    log "INFO" "Installing Docker..."

    case $PLATFORM in
    Mac)
        if command_exists brew; then
            brew install --cask docker
        else
            log "WARN" "Homebrew not found. Please install Docker Desktop manually from https://docker.com/products/docker-desktop"
            return 1
        fi
        ;;
    Linux)
        if command_exists apt-get; then
            sudo apt-get update
            sudo apt-get install -y docker.io docker-compose
            sudo systemctl start docker
            sudo systemctl enable docker
        elif command_exists yum; then
            sudo yum install -y docker docker-compose
            sudo systemctl start docker
            sudo systemctl enable docker
        elif command_exists pacman; then
            sudo pacman -S docker docker-compose
            sudo systemctl start docker
            sudo systemctl enable docker
        else
            log "WARN" "Unsupported Linux distribution. Please install Docker manually from https://docs.docker.com/engine/install/"
            return 1
        fi
        ;;
    *)
        log "WARN" "Unsupported platform for automatic Docker installation. Please install Docker manually from https://docker.com"
        return 1
        ;;
    esac

    log "SUCCESS" "Docker installation completed"
}

# Install Terraform based on platform
install_terraform() {
    log "INFO" "Installing Terraform..."

    case $PLATFORM in
    Mac)
        if command_exists brew; then
            brew tap hashicorp/tap
            brew install hashicorp/tap/terraform
        else
            log "WARN" "Homebrew not found. Please install Terraform manually from https://terraform.io"
            return 1
        fi
        ;;
    Linux)
        # Install using HashiCorp's official repository
        if command_exists curl && command_exists unzip; then
            TERRAFORM_VERSION="1.6.6"
            ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
            curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip"
            unzip "terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip"
            sudo mv terraform /usr/local/bin/
            rm "terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip"
        else
            log "WARN" "curl or unzip not found. Please install Terraform manually from https://terraform.io"
            return 1
        fi
        ;;
    *)
        log "WARN" "Unsupported platform for automatic Terraform installation. Please install Terraform manually from https://terraform.io"
        return 1
        ;;
    esac

    log "SUCCESS" "Terraform installation completed"
}

# Check and install dependencies
check_dependencies() {
    log "INFO" "Checking dependencies..."

    # Check Docker
    if command_exists docker; then
        log "SUCCESS" "Docker is already installed: $(docker --version)"
    else
        log "WARN" "Docker not found"
        if install_docker; then
            log "SUCCESS" "Docker installed successfully"
        else
            log "ERROR" "Failed to install Docker"
            exit 1
        fi
    fi

    # Check Terraform
    if command_exists terraform; then
        log "SUCCESS" "Terraform is already installed: $(terraform --version | head -n1)"
    else
        log "WARN" "Terraform not found"
        if install_terraform; then
            log "SUCCESS" "Terraform installed successfully"
        else
            log "ERROR" "Failed to install Terraform"
            exit 1
        fi
    fi

    # Check Node.js/NPM
    if command_exists node && command_exists npm; then
        log "SUCCESS" "Node.js and NPM are already installed: $(node --version) / $(npm --version)"
    else
        log "WARN" "Node.js/NPM not found. Please install Node.js from https://nodejs.org"
    fi

    log "SUCCESS" "All dependencies checked"
}

# MAIN -------------------------------------------------------------------------

detect_platform
check_dependencies

log "INFO" "Setup complete! You can now run './scripts/local.sh' to start the development environment."
