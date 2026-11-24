# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.17.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.17.0/meridian_0.17.0_macOS_arm64.tar.gz"
      sha256 "cb07e94e9fca13bf041d24017bf9beaf89c75e554dc25c465a86fb5a871a574b"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.17.0/meridian_0.17.0_macOS_amd64.tar.gz"
      sha256 "b02add184b6e00eacf1ef31da7487b5e987edc385055e56845385e3da5ccfd0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.17.0/meridian_0.17.0_linux_arm64.tar.gz"
      sha256 "523e24651a0c7057ebe62c70e34170ec8b619ca824375e0fb6246a86dfdef0b8"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.17.0/meridian_0.17.0_linux_amd64.tar.gz"
      sha256 "94879c5933fcb793735b78941b120201dbd6d5f49ae917d6bdd059d473f6d87e"
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
