# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.0/meridian_0.4.0_macOS_arm64.tar.gz"
      sha256 "ddeaf571977209e976d844b430e6ad76cd85d7c65e13b679a86460d775f00f0c"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.0/meridian_0.4.0_macOS_amd64.tar.gz"
      sha256 "f397b344fa2cf6d065b2aaf7881a184ce2b241520f3327bf76f5e9712e946aef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.0/meridian_0.4.0_linux_arm64.tar.gz"
      sha256 "058dbc88090ab134ff9a5ee58fdee58d1344894f6eb53ec154352bc6769d48f3"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.0/meridian_0.4.0_linux_amd64.tar.gz"
      sha256 "de781bbdc0a18c0229ea92d9a43d048dec73b0eccd50d5bf30d9a9c054f9b893"
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
