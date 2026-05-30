#!/bin/bash
# ─────────────────────────────────────────────
# Markquel Taylor — GitHub Pages Deploy Script
# ─────────────────────────────────────────────

TOKEN="${GITHUB_TOKEN:-}"  # Set via: export GITHUB_TOKEN=your_token_here (never hardcode)
USERNAME="TheLegendMac"
REPO="Portfolio"
REMOTE="https://$USERNAME:$TOKEN@github.com/$USERNAME/$REPO.git"

echo "🚀 Starting deploy..."

# Clean up any previous failed attempt
rm -rf _deploy_tmp

# Clone
git clone "$REMOTE" _deploy_tmp
if [ $? -ne 0 ]; then echo "❌ Clone failed. Check token permissions."; exit 1; fi

cd _deploy_tmp

# Copy files
cp ../index.html . && echo "✅ index.html copied"
mkdir -p assets
cp -R ../assets/images assets/ && echo "✅ assets/images copied"
[ -f "../APM_Resume_2026_2_0_Shortened.docx" ] && cp ../APM_Resume_2026_2_0_Shortened.docx . && echo "✅ Resume copied"

# Git config
git config user.email "suited_gain0y@icloud.com"
git config user.name "Markquel Taylor"

# Commit and push
git add .
git commit -m "Deploy portfolio v6 — split hero, modals, bridge CTA, favicon, responsive"
git push "$REMOTE" main
if [ $? -ne 0 ]; then echo "❌ Push failed. Token may need 'repo' scope."; exit 1; fi

cd ..
rm -rf _deploy_tmp

echo ""
echo "✅ Successfully deployed!"
echo ""
echo "⚠️  If GitHub Pages isn't enabled yet:"
echo "   → github.com/$USERNAME/$REPO/settings/pages"
echo "   → Source: Deploy from a branch"
echo "   → Branch: main | Folder: / (root)"
echo "   → Click Save"
echo ""
echo "🌐 Live at: https://$USERNAME.github.io/$REPO"
