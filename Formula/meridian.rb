# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.19.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.19.0/meridian_0.19.0_macOS_arm64.tar.gz"
      sha256 "d219a560f7194992693340d6e5a92cdc42e47b0a503255bafbc5ebaa03699c8d"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.19.0/meridian_0.19.0_macOS_amd64.tar.gz"
      sha256 "3fa40091c4758b639b7d43d727a105bad6df947d881494496d2eb60c17807cfc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.19.0/meridian_0.19.0_linux_arm64.tar.gz"
      sha256 "105edf41cb5d9fcdb942d55535138c7e3c25172a84afe3653541601e03b86fb0"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.19.0/meridian_0.19.0_linux_amd64.tar.gz"
      sha256 "76215c56fd0c56daa09de37518173bd53115b3a0386f2ab9a99aaf8c69e1fb65"
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
