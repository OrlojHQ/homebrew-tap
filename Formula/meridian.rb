# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.11.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.4/meridian_0.11.4_macOS_arm64.tar.gz"
      sha256 "cfb96f758cf0c52b2c8dbe924ebd281d930a8d4e19ba4f798ec87f63d1714cf3"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.4/meridian_0.11.4_macOS_amd64.tar.gz"
      sha256 "1853238591a1c4aa6e6ade705cfe8d6d4479df6d5efa6553854c1d2f311fa6ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.4/meridian_0.11.4_linux_arm64.tar.gz"
      sha256 "7cb642e2932504ae72fae62a559c68445644faed2e9feed4dbfe55c8277340ea"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.4/meridian_0.11.4_linux_amd64.tar.gz"
      sha256 "4ab6bbd7fd6f53d27429a0b067b13c5fa289d22b5bbd22de9d613af4b16a5777"
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
