# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.11.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.2/meridian_0.11.2_macOS_arm64.tar.gz"
      sha256 "45cf4742fe16b9ea77fc2a4c3a16ec39c1a2b0a9cd62f7789e903b67954a8777"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.2/meridian_0.11.2_macOS_amd64.tar.gz"
      sha256 "e1ccac2d8840062d645c186a794dac30d4dacb75b337a93e3bdce9b6afca096a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.2/meridian_0.11.2_linux_arm64.tar.gz"
      sha256 "1def5c99c99cf90668b0798f58c15ecb91cf0d09fa11a18a7e782d5216060fc6"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.2/meridian_0.11.2_linux_amd64.tar.gz"
      sha256 "4dfc319febf27e4c7abdabddf8679793be0b4cfcb815d59449561febcd7c1e4d"
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
