# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.15.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.2/meridian_0.15.2_macOS_arm64.tar.gz"
      sha256 "e631b25f062f9f3a3e995dbf90f355ab338d78530d8e623cf50de92c5e9fe805"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.2/meridian_0.15.2_macOS_amd64.tar.gz"
      sha256 "9634c12d435884c1a5ae1fbde202a8cc54089be606a8ddf4c3fb19c116e8e0d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.2/meridian_0.15.2_linux_arm64.tar.gz"
      sha256 "2a9ac124961ff2998d11b74813be1cb6b8291e555850d8885724039b59d03e64"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.2/meridian_0.15.2_linux_amd64.tar.gz"
      sha256 "7691c7954ff3aed2e1e423d263a78665ae0cd2908099ccafd35a2116df836eea"
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
