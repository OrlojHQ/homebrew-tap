# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.10.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.10.1/meridian_0.10.1_macOS_arm64.tar.gz"
      sha256 "5724ddb1ce05a43458a8c232cfdf3942395dfd17b5a11881666a0e7042688229"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.10.1/meridian_0.10.1_macOS_amd64.tar.gz"
      sha256 "53e6256e657f866039a533fea6170171027b02bd52421efb2bde4f4d9b2963b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.10.1/meridian_0.10.1_linux_arm64.tar.gz"
      sha256 "0ccff78cabe63a46ec3f4511611496f7474269d58dd5d1051e2555763a6a9cb5"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.10.1/meridian_0.10.1_linux_amd64.tar.gz"
      sha256 "ef1f8e073f086a639460bc98cb95b6b45e66122aba163410a81e776150249271"
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
