# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.11.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.3/meridian_0.11.3_macOS_arm64.tar.gz"
      sha256 "9bde6c6ab5ba74f568b7e179bd20cd9e4893676908b72fcb3e85269cf9ac76ca"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.3/meridian_0.11.3_macOS_amd64.tar.gz"
      sha256 "edc0fb607069537c244770c7c9dd66810117d654d25db35ea529e2a58423d36c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.3/meridian_0.11.3_linux_arm64.tar.gz"
      sha256 "7fffca256138864cd8e2435fc5505a15a78a8f5613fdb1e46863214c86dd01aa"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.3/meridian_0.11.3_linux_amd64.tar.gz"
      sha256 "ccf090f8f8392fcbee86d797e0f036a5f74dea5f74456d7fde1e8d73ba22e5b5"
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
