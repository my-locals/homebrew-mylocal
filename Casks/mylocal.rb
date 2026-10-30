# version·sha256은 Release를 게시하면 .github/workflows/update-casks.yml이 고친다.
# 첫 Release를 게시하기 전의 sha256은 자리 표시용이다
cask "mylocal" do
  version "0.4.6"
  sha256 "4958039ce6f8159bde953a864d879366e98c355adc87506a1493486468770c26"

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

  # 데몬(io.myiam.mylocal.daemon)과 로그인 항목은 앱이 SMAppService로 직접 해제한다.
  # 사용자 권한이라 관리자 암호를 묻지 않고, 로그인 항목에서 꺼짐으로 바뀐다(launchctl remove는
  # 작업만 내리고 켜짐으로 남겨, 다시 설치하면 데몬이 뜨지 않을 수 있다). 꺼진 기록은 공개 API로
  # 지울 수 없어 macOS가 정리할 때까지 목록에 남는다. 그 뒤 앱을 종료한다
  uninstall early_script: {
              executable:   "#{appdir}/MyLocal.app/Contents/MacOS/mylocal-app",
              args:         ["--unregister-daemon"],
              must_succeed: false,
            },
            quit:         "io.myiam.mylocal"

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
