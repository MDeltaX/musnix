{ pkgs, optimize ? true, latencytop ? false, ... }:
with pkgs;
with lib;
let

  cfg = config.musnix;

  kernelConfigLatencyTOP = ''
    LATENCYTOP y
    SCHEDSTATS y
  '';

  kernelConfigOptimizeDeadline = ''
    IOSCHED_DEADLINE y
    DEFAULT_DEADLINE y
    DEFAULT_IOSCHED deadline
  '';

  kernelConfigOptimize = ''
    PREEMPT y
    HPET_TIMER y
    TREE_RCU_TRACE? n
  '';
  # RT_GROUP_SCHED? n

  kernelConfigRealtime = ''
    PREEMPT_RT_FULL y
    PREEMPT_VOLUNTARY n
    RT_GROUP_SCHED? n
  '';

  musnixRealtimeKernelExtraConfig =
    kernelConfigRealtime
    + optionalString optimize kernelConfigOptimize
    + optionalString latencytop kernelConfigLatencyTOP;

  musnixStandardKernelExtraConfig =
    if optimize
      then kernelConfigOptimize
           + optionalString latencytop kernelConfigLatencyTOP
      else if latencytop
        then kernelConfigLatencyTOP
        else "";

in {


      linux_3_18_rt = callPackage ./kernel/linux-3.18-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          realtimePatches.realtimePatch_3_18
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_1_rt = callPackage ./kernel/linux-4.1-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          realtimePatches.realtimePatch_4_1
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_4_rt = callPackage ./kernel/linux-4.4-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          realtimePatches.realtimePatch_4_4
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_9_rt = callPackage ./kernel/linux-4.9-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_9
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_11_rt = callPackage ./kernel/linux-4.11-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_11
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_13_rt = callPackage ./kernel/linux-4.13-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_13
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_14_rt = callPackage ./kernel/linux-4.14-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_14
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };

      linux_4_16_rt = callPackage ./kernel/linux-4.16-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_16
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };
      linux_4_18_rt = callPackage ./kernel/linux-4.18-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_18
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };
      linux_4_19_rt = callPackage ./kernel/linux-4.19-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_4_19
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig + optionalString optimize kernelConfigOptimizeDeadline;
      };
      linux_5_0_rt = callPackage ./kernel/linux-5.0-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_5_0
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig;
      };
      linux_5_2_rt = callPackage ./kernel/linux-5.2-rt.nix {
        kernelPatches = [ kernelPatches.bridge_stp_helper
                          kernelPatches.modinst_arg_list_too_long
                          realtimePatches.realtimePatch_5_2
                        ];
        extraConfig   = musnixRealtimeKernelExtraConfig;
      };



      linux_opt = linux.override {
        extraConfig = musnixStandardKernelExtraConfig;
      };

      linuxPackages_3_18_rt = recurseIntoAttrs (linuxPackagesFor linux_3_18_rt);
      linuxPackages_4_1_rt  = recurseIntoAttrs (linuxPackagesFor linux_4_1_rt);
      linuxPackages_4_4_rt  = recurseIntoAttrs (linuxPackagesFor linux_4_4_rt);
      linuxPackages_4_9_rt  = recurseIntoAttrs (linuxPackagesFor linux_4_9_rt);
      linuxPackages_4_11_rt = recurseIntoAttrs (linuxPackagesFor linux_4_11_rt);
      linuxPackages_4_13_rt = recurseIntoAttrs (linuxPackagesFor linux_4_13_rt);
      linuxPackages_4_14_rt = recurseIntoAttrs (linuxPackagesFor linux_4_14_rt);
      linuxPackages_4_16_rt = recurseIntoAttrs (linuxPackagesFor linux_4_16_rt);
      linuxPackages_4_18_rt = recurseIntoAttrs (linuxPackagesFor linux_4_18_rt);
      linuxPackages_4_19_rt = recurseIntoAttrs (linuxPackagesFor linux_4_19_rt);
      linuxPackages_5_0_rt  = recurseIntoAttrs (linuxPackagesFor linux_5_0_rt);
      linuxPackages_5_2_rt  = recurseIntoAttrs (linuxPackagesFor linux_5_2_rt);
      linuxPackages_opt     = recurseIntoAttrs (linuxPackagesFor linux_opt);

      linuxPackages_latest_rt = linuxPackages_5_2_rt;

      realtimePatches = callPackage ./kernel/patches.nix { };

      rtirq = pkgs.callPackage ./rtirq { };


}
