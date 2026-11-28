# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.21.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.21.0/meridian_0.21.0_macOS_arm64.tar.gz"
      sha256 "ca2fe1813304a168fcaef761fe8dac9d892fe71094a928ddd6f525f103eac073"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.21.0/meridian_0.21.0_macOS_amd64.tar.gz"
      sha256 "08039870b20007aa3b7c4fa214a1a5c1e2aa6e5665629f916346bef615e525e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.21.0/meridian_0.21.0_linux_arm64.tar.gz"
      sha256 "f06cc9058e857656733b1422a10ee3b8aae6ca091a7e9f2fec99178f7abe54f6"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.21.0/meridian_0.21.0_linux_amd64.tar.gz"
      sha256 "123e1dbd2000f5ac7e3c8af46f6efffe3e75a6adf3eef5947ea363c963b11488"
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
