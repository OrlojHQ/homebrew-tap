# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.9.0/meridian_0.9.0_macOS_arm64.tar.gz"
      sha256 "2db7928f522eabc61bf8194307691bb07747e74984567b05fe190ef9959ca55c"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.9.0/meridian_0.9.0_macOS_amd64.tar.gz"
      sha256 "36e62028836ed84d2f118329b45fc94d680f41734719fe78c2332fbfbef5d461"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.9.0/meridian_0.9.0_linux_arm64.tar.gz"
      sha256 "8fd5245c4ecd5d54245f870479348627c0bea3df7cb1ed50300f02fbb846c1c7"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.9.0/meridian_0.9.0_linux_amd64.tar.gz"
      sha256 "fd3526c10a82563c001241af8a064daf26b01c853b8387b9d8ece8937a5ade49"
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
