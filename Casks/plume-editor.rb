cask "plume-editor" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.1"
  sha256 arm:          "434acfd6f60745b896988f2c254f7d555d209f5ab80ef60d3e96a4f15c1c15a7",
         intel:        "0574c2270e068a203499b929995fd0689a0e17fae51ceaeedcccab85e2558298",
         x86_64_linux: "09a1e903d94664ef0efad4b0c1d00e87f443fa58214396f2b70480c91c1795a0"

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
