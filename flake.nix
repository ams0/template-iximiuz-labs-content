{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, self', ... }:
        {
          devenv.shells = {
            default = {
              packages = with pkgs; [
                just
                watchexec
                gnused

                optipng
                pngquant

                ascii-image-converter
                chafa

                lychee

                self'.packages.labctl
                self'.packages.labx
              ];

              # https://github.com/cachix/devenv/issues/528#issuecomment-1556108767
              containers = pkgs.lib.mkForce { };
            };
          };
          packages = {
            labctl = pkgs.buildGoModule rec {
              pname = "labctl";
              version = "0.1.58";

              src = pkgs.fetchFromGitHub {
                owner = "iximiuz";
                repo = "labctl";
                rev = "v${version}";
                sha256 = "sha256-kc3lypk32JOG0KQGeSyoL0PQed32Og/aZQy7aOaLH+c=";
              };

              vendorHash = "sha256-TruaquC6sGjLZ5HcaavxqcO9Gy2PK3gqLfUTtFGOAtw=";

              subPackages = [ "." ];

              ldflags = [
                "-w"
                "-s"
                "-X main.version=v${version}"
              ];
            };

            labx = pkgs.buildGoModule rec {
              pname = "labx";
              version = "0.0.0";

              src = pkgs.fetchFromGitHub {
                owner = "sagikazarmark";
                repo = "labx";
                rev = "c8930fdeb101bb208297df46291720ec532173f2";
                sha256 = "sha256-IASAocOonQ03nkS2unY7De97VpQDHhpa8WpcHIobAow=";
              };

              vendorHash = "sha256-Lu9Uifj2OFxzvlHN31bdhAoqo/ysEUwQJ3guC66K6Xs=";

              subPackages = [ "." ];

              ldflags = [
                "-w"
                "-s"
                "-X main.version=v${version}"
              ];
            };

          };
        };
    };
}
