How to

1. jsonresume to html
based on https://jsonresume.org
https://github.com/rbardini/resumed

npx resumed --theme jsonresume-theme-modern --output cv.html
npx jsonresume-theme-even < resume.json > cv.html

➜  rebeling git:(main) ✗ npx resumed --theme jsonresume-theme-elegant --output cv.html

2. for secret cover letter, check out
chmod +x encrypt.js
node js/encrypt.js "" ""

node js/encrypt.js encrypt "$(cat <<'HTML'
<div>11.05.2025</div>
<div class="aubject"></div><div class="text">
<p>x</p>
<p class="headline">y</p>
<p>z</p>
</div>
HTML
)" "Vm7o4DzxzuIwsKNk6"
