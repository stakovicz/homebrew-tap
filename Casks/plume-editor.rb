cask "plume-editor" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "2c416ec768870e2ed1ce9f2d518ac98bcc5e58360a839f117d36d6b16926945c",
         intel: "ee00ae9e109d2282d9429e89eee3da2fb283b398cb4cadf6a5dc1bd9f81ba6e7"

  url "https://github.com/stakovicz/plume/releases/download/v#{version}/Plume_#{version}_#{arch}.dmg"
  name "Plume"
  desc "Vector editor"
  homepage "https://stakovicz.github.io/plume/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Plume.app"

  # The app is not signed yet: without this, macOS refuses to open it the first time.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Plume.app"]
  end

  zap trash: [
    "~/Library/Caches/coop.les-tilleuls.plume",
    "~/Library/Caches/cz.stakovi.plume",
    "~/Library/Preferences/coop.les-tilleuls.plume.plist",
    "~/Library/Preferences/cz.stakovi.plume.plist",
    "~/Library/WebKit/coop.les-tilleuls.plume",
    "~/Library/WebKit/cz.stakovi.plume",
  ]
end
