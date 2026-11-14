# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.8.0/meridian_0.8.0_macOS_arm64.tar.gz"
      sha256 "4186c92382b05ec8cbaec34b820b1d3bc95e65d74d178e43c05f7e576d2624c8"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.8.0/meridian_0.8.0_macOS_amd64.tar.gz"
      sha256 "2e485d906c25104c28d2cce900ab02687bdf2ca2896c9503859181e651e69bae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.8.0/meridian_0.8.0_linux_arm64.tar.gz"
      sha256 "1276f3ce3883999f2b7b28a38ad38f4971a8d1ad68601b828222fa4ec4ebab5d"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.8.0/meridian_0.8.0_linux_amd64.tar.gz"
      sha256 "8c6ecf9796f19a33b0952e34fa92b634ff5470e2658543991e9974c6980f5a86"
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
