# version·sha256은 Release를 게시하면 .github/workflows/update-casks.yml이 고친다.
# 첫 Release를 게시하기 전의 sha256은 자리 표시용이다
cask "mylocal" do
  version "0.4.1"
  sha256 "af0aadced02b480a74a5f833ae829579884fedcb1d85fd69c2c2c84e04c77b0f"

  url "https://github.com/my-locals/homebrew-mylocal/releases/download/app-v#{version}/MyLocal.dmg"
  name "MyLocal"
  desc "Menu bar app that cleans up dev servers left listening after work hours"
  homepage "https://github.com/my-locals/homebrew-mylocal"

  # 앱 Release 태그(app-v…)만 고른다
  livecheck do
    url :url
    regex(/^app-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # 앱이 Tauri updater로 스스로 업데이트한다. brew upgrade는 --greedy일 때만 바꾼다
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "MyLocal.app"
  # 명령줄 도구는 앱 안의 것을 연결한다. 공증된 앱 묶음 안에 있어 따로 격리되지 않고,
  # 앱과 늘 같은 버전이다
  binary "#{appdir}/MyLocal.app/Contents/MacOS/mylocal"

  # 앱이 SMAppService로 등록한 데몬(io.myiam.mylocal.daemon)을 내린다
  uninstall launchctl: "io.myiam.mylocal.daemon",
            quit:      "io.myiam.mylocal"

  # 앱의 "MyLocal 제거…"에서 설정·활동 로그까지 지울 때와 같은 범위다
  zap trash: [
    "~/Library/Application Support/MyLocal",
    "~/Library/Caches/io.myiam.mylocal",
    "~/Library/Caches/MyLocal",
    "~/Library/Logs/MyLocal",
    "~/Library/Preferences/io.myiam.mylocal.plist",
    "~/Library/Saved Application State/io.myiam.mylocal.savedState",
    "~/Library/WebKit/io.myiam.mylocal",
  ]
end
