@echo off
flutter build web --release --base-href="/scripts/" & scp -P 5420 -Cr build\web chris@backstreets.site:scripts