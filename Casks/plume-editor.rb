cask "plume-editor" do
  arch arm: "aarch64", intel: "x64"

  version "0.6.0"
  sha256 arm:          "5b7c81d27b386b25975902684fda2c2603b6650dcf5466813f42a5b202b73274",
         intel:        "cff2923b434bdde1663e727bd39ce573a3e6921579e30e73e80830cf7796aaab",
         x86_64_linux: "3022950715f8e8486e62360ebcc752228d0291e2b6a3e448bddc7d804b47bd08"

  on_macos do
    url "https://github.com/stakovicz/plume/releases/download/v#{version}/Plume_#{version}_#{arch}.dmg"

    app "Plume.app"

    zap trash: [
      "~/Library/Caches/coop.les-tilleuls.plume",
      "~/Library/Caches/cz.stakovi.plume",
      "~/Library/Preferences/coop.les-tilleuls.plume.plist",
      "~/Library/Preferences/cz.stakovi.plume.plist",
      "~/Library/WebKit/coop.les-tilleuls.plume",
      "~/Library/WebKit/cz.stakovi.plume",
    ]

    caveats <<~EOS
      Plume is not signed yet: macOS refuses to open it the first time. Run once:
        xattr -dr com.apple.quarantine #{appdir}/Plume.app
    EOS
  end
  on_linux do
    url "https://github.com/stakovicz/plume/releases/download/v#{version}/Plume_#{version}_amd64.AppImage"

    depends_on arch: :x86_64

    app_image "Plume_#{version}_amd64.AppImage", target: "Plume.AppImage"
  end

  name "Plume"
  desc "Vector editor"
  homepage "https://stakovicz.github.io/plume/"

  livecheck do
    url :url
    strategy :github_latest
  end
end
