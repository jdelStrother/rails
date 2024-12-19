{ pkgs, lib, ... }:

let ruby = pkgs.ruby_3_2;
in {
  packages = [
    ruby
    pkgs.git
    pkgs.cmake
    pkgs.ncurses
    pkgs.pkg-config
    pkgs.openssl
    pkgs.libcxx
    pkgs.libxml2
    pkgs.libxslt
    pkgs.libyaml
    pkgs.mysql80
    pkgs.readline
    pkgs.sqlite
    pkgs.postgresql
    pkgs.zlib
    pkgs.zstd
  ];

  env = {
    BUNDLE_BUILD__LIBXML___RUBY =
      "--with-xml2-lib=${pkgs.libxml2.out}/lib --with-xml2-include=${pkgs.libxml2.dev}/include/libxml2"
      + lib.optionals pkgs.stdenv.isDarwin
      " --with-iconv-dir=${pkgs.libiconv} --with-opt-include=${pkgs.libiconv}/include";

    # Make sure that the regular user's environment doesn't collide with our nix gems
    BUNDLE_PATH = "./.devenv/bundle";
    GEM_HOME = "./.devenv/bundle/${ruby.rubyEngine}/${ruby.version.libDir}";
    GEM_PATH = "./.devenv/bundle/${ruby.rubyEngine}/${ruby.version.libDir}";
    BUNDLE_FORGET_CLI_OPTIONS = "true";
  };
}
