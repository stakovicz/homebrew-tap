cask "plume-editor" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.0"
  sha256 arm:          "63abe2b6e26d07d9b511f26e3953c591512a7d71158e1798aa9c176db4f34c18",
         intel:        "b43d04ba3a013bd9bd38fdd1ecc9fee4f220fe717d2aff12a891d85e8edf47c3",
         x86_64_linux: "5cbb5dd9557b7153bb65b8443a515c81e6a20692c6ee0713be4fcc83af765392"

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
