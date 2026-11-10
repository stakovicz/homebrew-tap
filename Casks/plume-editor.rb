cask "plume-editor" do
  arch arm: "aarch64", intel: "x64"

  version "0.5.0"
  sha256 arm:          "5104e99d016c2db65803e23009753e8a22fec556c38336f598f43cba5c9b3888",
         intel:        "a182a98c6d6b2ba402f61d5e3032f41db77a953ccead29a6e65ff039aa4e0668",
         x86_64_linux: "a2ac477da4268963c31ebb7a10b435da7c32521283cad2f48b83068920210fe8"

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
