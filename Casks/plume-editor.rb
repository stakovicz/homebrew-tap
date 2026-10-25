cask "plume-editor" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:          "2c416ec768870e2ed1ce9f2d518ac98bcc5e58360a839f117d36d6b16926945c",
         intel:        "ee00ae9e109d2282d9429e89eee3da2fb283b398cb4cadf6a5dc1bd9f81ba6e7",
         x86_64_linux: "0a5751161228e898ccdbfa0c37d8062165133d0d1292ec3afefd9e632354db86"

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
