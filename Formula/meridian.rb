# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.15.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.0/meridian_0.15.0_macOS_arm64.tar.gz"
      sha256 "0b1fa97a5de3af545dab1c3bb1d383137c1bb3a997ff48b6e590790f89004c79"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.0/meridian_0.15.0_macOS_amd64.tar.gz"
      sha256 "e9257abc5cb02e1a646d689cf055465b65310f4780126d4cbb15eaa258ddf2d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.0/meridian_0.15.0_linux_arm64.tar.gz"
      sha256 "7107d9d70389ae31ed3b6094fea391144b1d5415db21e232ae5355944f2bd6ad"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.0/meridian_0.15.0_linux_amd64.tar.gz"
      sha256 "64db866361dc68a3238365dd62539e97678b2f21895a2dd75099bc95603d5018"
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
    # A service starts with a short PATH. Include the Homebrew prefix so
    # meridiand can find gh beside other tools installed the same way.
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    keep_alive true
    log_path var/"log/meridiand.log"
    error_log_path var/"log/meridiand.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/meridiand --version")
    assert_match version.to_s, shell_output("#{bin}/meridian --version")
  end
end
