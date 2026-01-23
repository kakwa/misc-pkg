# python3-ajsonrpc

This package provides ajsonrpc, an Async JSON-RPC 2.0 protocol + server powered by asyncio.

## Description

ajsonrpc is a Python library that implements the JSON-RPC 2.0 protocol with support for asyncio. It provides both client and server implementations with support for various async frameworks like Sanic and Quart.

## Upstream

- **URL**: https://github.com/pavlov99/ajsonrpc
- **Version**: 1.2.0
- **License**: MIT

## Features

- JSON-RPC 2.0 protocol implementation
- Async support via asyncio
- Server implementations for various frameworks
- Command-line server utility: `async-json-rpc-server`

## Building

### Building Debian packages

```bash
# Build with pbuilder/cowbuilder (recommended)
make deb_chroot DIST=trixie ARCH=amd64

# Or build locally (not recommended for production)
make deb
```

### Building RPM packages

```bash
# Build with mock (recommended)
make rpm_chroot DIST=el9 ARCH=x86_64

# Or build locally (not recommended for production)
make rpm
```

## Installing

### Debian/Ubuntu

```bash
dpkg -i python3-ajsonrpc_1.2.0-1_all.deb
```

### RPM-based systems

```bash
rpm -i python3-ajsonrpc-1.2.0-1.noarch.rpm
```

## Usage

The package installs the Python library and provides the `async-json-rpc-server` command-line utility.

```python
import ajsonrpc

# Use in your Python code
```

## Maintainer

@MAINTAINER@ <@MAINTAINER_EMAIL@>
