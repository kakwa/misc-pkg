#!/usr/bin/perl
# debhelper sequence file for packaging Rust crates with cargo

use warnings;
use strict;
use Debian::Debhelper::Dh_Lib;

# See https://bugs.debian.org/1023413 
add_command_options('dh_clean', '-XCargo.toml.orig');

1;
