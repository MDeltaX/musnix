{ stdenv, fetchurl, hostPlatform, buildPackages, perl, buildLinux, ... } @ args:

buildLinux (args // rec {
  kversion = "5.2.21";
  pversion = "rt13";
  version = "${kversion}-${pversion}";
  extraMeta.branch = "5.2";

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v5.x/linux-${kversion}.tar.xz";
    sha256 = "0f1mick15d0m7yhhhdwai03wmczvkm9cg38w2ivgmgysfpzy73ls";
  };
} // (args.argsOverride or {}))
