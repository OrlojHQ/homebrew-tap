# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.15.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.1/meridian_0.15.1_macOS_arm64.tar.gz"
      sha256 "543bbcee25ccc01d499ec20676b031ac729dc5858200f9612c44f2b86f188b76"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.1/meridian_0.15.1_macOS_amd64.tar.gz"
      sha256 "48e72627cc6d978c650b4492bbad8cab93b211a03a36207ba28cfa4b37ee6413"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.1/meridian_0.15.1_linux_arm64.tar.gz"
      sha256 "6aeea44c3ac42cbfe98a8722522a27b741b06de21b36ead5b43783b3b7bb3148"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.15.1/meridian_0.15.1_linux_amd64.tar.gz"
      sha256 "93f32c9e9c273308bebdd7b672c2d545a46001d1796dcd3fc394b31d15b92340"
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
