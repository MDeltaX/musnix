{ pkgs ? import <nixpkgs> {} }:

import ./os-specific/linux { inherit pkgs; }

