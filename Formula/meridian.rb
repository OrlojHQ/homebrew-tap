# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.14.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.14.0/meridian_0.14.0_macOS_arm64.tar.gz"
      sha256 "bbdf8f04552311b7b01f862d20c2193fc9bebfd9df9431d465a9ec9d9927b6c0"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.14.0/meridian_0.14.0_macOS_amd64.tar.gz"
      sha256 "56d06431233a16026af8e330c34ce2d3988c917da775e6ccddb9c0b06815bc8b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.14.0/meridian_0.14.0_linux_arm64.tar.gz"
      sha256 "cb05e9edf8da4bbac863c7e3e7463e8e37215bcba2fcdd7821715952a25d0bb1"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.14.0/meridian_0.14.0_linux_amd64.tar.gz"
      sha256 "0474060aa6832b3e81e5531f3e1aad2585da70cd12521be96cef6d29899232f1"
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
