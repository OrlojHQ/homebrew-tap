# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.6.0/meridian_0.6.0_macOS_arm64.tar.gz"
      sha256 "317f591ba9a2c6c71c46b7a59b3a4b108b017f1166edbe0fca3acf313f073bc5"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.6.0/meridian_0.6.0_macOS_amd64.tar.gz"
      sha256 "741385e36a33287994de6601ccf088476ce347ba1d15989fde4c5c82b94ca638"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.6.0/meridian_0.6.0_linux_arm64.tar.gz"
      sha256 "26d400e86473c8eb2d6a34664d68f7acf62dc7c14041d052b1ae230e82a5bcdf"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.6.0/meridian_0.6.0_linux_amd64.tar.gz"
      sha256 "feef65d65e429bfeb3856325e296ca3f90dffbffcd8892c683b1c6a71bb1acb6"
    end
  end

  def install
    bin.install "meridian", "meridiand"
  end

  def caveats
    <<~EOS
      meridiand needs a running Docker engine (Docker Desktop, OrbStack, or
      the Docker service). Start it in the background with:
        brew services start meridian
      Then open http://127.0.0.1:8080/ui/
    EOS
  end

  service do
    run [opt_bin/"meridiand", "--provider=docker"]
    keep_alive true
    log_path var/"log/meridiand.log"
    error_log_path var/"log/meridiand.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/meridiand --version")
    assert_match version.to_s, shell_output("#{bin}/meridian --version")
  end
end
