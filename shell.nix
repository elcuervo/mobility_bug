let
  # A pinned recent revision of nixpkgs/unstable.
  pkgs = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/d1c3fea7ecbed758168787fe4e4a3157e52bc808.tar.gz";
      sha256 = "0ykm15a690v8lcqf2j899za3j6hak1rm3xixdxsx33nz7n3swsyy";
    })
    { };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    # runtime
    docker
    docker-compose
    heroku
    (builtins.currentSystem == "aarch64-darwin" ? colima)

    # ruby deps
    nodejs
    ruby_2_7
    bundler
    openssl

    postgresql_13

    libiconv
    libxml2
    libsass
  ];
}
