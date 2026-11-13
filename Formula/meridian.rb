# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.7.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.1/meridian_0.7.1_macOS_arm64.tar.gz"
      sha256 "081dbcf33ac3cd648bc66ed01b81c75def9505ba09c0aefe119ad4af439920a1"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.1/meridian_0.7.1_macOS_amd64.tar.gz"
      sha256 "baf90870a616993a1a4fb8ef2d976cff4b1d97533bae6bf3cca917ba5bb2f90d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.1/meridian_0.7.1_linux_arm64.tar.gz"
      sha256 "98bde643a370a16a2bc8e9ab0b910ca7070b8b4189089f889dd979063b7f838e"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.1/meridian_0.7.1_linux_amd64.tar.gz"
      sha256 "40affb3c2a20baf2ed79ec16fea8c031a1a956496485fe635cd39b3d6b8fea8a"
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
    keep_alive true
    log_path var/"log/meridiand.log"
    error_log_path var/"log/meridiand.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/meridiand --version")
    assert_match version.to_s, shell_output("#{bin}/meridian --version")
  end
end
