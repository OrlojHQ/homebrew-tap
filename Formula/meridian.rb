# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.18.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.0/meridian_0.18.0_macOS_arm64.tar.gz"
      sha256 "02663829593735970c923d099735da41820bd97242a2c77e9c45067b75c139be"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.0/meridian_0.18.0_macOS_amd64.tar.gz"
      sha256 "d4a8a51de7ecbf13706fad0b155770513de1e88e5884df9d222ea8a4a1c38b57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.0/meridian_0.18.0_linux_arm64.tar.gz"
      sha256 "825c5d3f57efd94e54f53014a305c66c996ac2aa8ef6273365365381c6455949"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.0/meridian_0.18.0_linux_amd64.tar.gz"
      sha256 "18c5257016e52202693080954e3e0178681f94b24c0bc19479c0c0d58b8fda05"
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
