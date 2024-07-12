@echo off
flutter build web --release --base-href="/scripts/" & scp -Cr build\web chris@backstreets.site:scripts