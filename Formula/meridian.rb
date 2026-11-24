# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.16.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.16.0/meridian_0.16.0_macOS_arm64.tar.gz"
      sha256 "370dbfaceaef78dbeb6f0f3ebc2595c08979da1dc2b1f9f6813ecbf88001b09f"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.16.0/meridian_0.16.0_macOS_amd64.tar.gz"
      sha256 "980e042642df0ebb5da89766ac5d7fa419bbdbc04806b76a92650becb1997311"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.16.0/meridian_0.16.0_linux_arm64.tar.gz"
      sha256 "5313ecb82abcd5cb34c04b46355772a967a4b72225d9f5452f58de1ca9bd2a5f"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.16.0/meridian_0.16.0_linux_amd64.tar.gz"
      sha256 "d3ef5b5116cf49506c2894df87340940f6a7a12ee5f11862f55a12873559a767"
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
