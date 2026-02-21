#!/usr/bin/env bash
# =============================================================================
# GitHub Profile Deployment Script
# Eghosa Osemwegie (Ghost-tech-ng)
#
# What this does:
#   1. Uploads README.md to each of the 6 featured repos
#   2. Adds topic tags to each repo (for GitHub search visibility)
#   3. Makes the 'drain' repo private
#   4. Prints instructions for pinning repos (requires GitHub.com UI or GraphQL)
#
# Usage:
#   export GITHUB_TOKEN=your_personal_access_token
#   bash deploy.sh
#
# Token scopes needed: repo (full), user
# Create a token at: https://github.com/settings/tokens
# =============================================================================

set -euo pipefail

OWNER="Ghost-tech-ng"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Colours ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; }

# ─── Preflight ────────────────────────────────────────────────────────────────
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  error "GITHUB_TOKEN is not set."
  echo "  Run: export GITHUB_TOKEN=your_token_here"
  echo "  Then: bash deploy.sh"
  exit 1
fi

command -v curl  >/dev/null || { error "curl is required but not installed."; exit 1; }
command -v python3 >/dev/null || { error "python3 is required but not installed."; exit 1; }

info "Checking token validity..."
USER_CHECK=$(curl -sf -H "Authorization: token ${GITHUB_TOKEN}" \
  "https://api.github.com/user" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('login',''))" 2>/dev/null)

if [[ "$USER_CHECK" != "$OWNER" ]]; then
  error "Token is invalid or belongs to a different user (got: '$USER_CHECK', expected: '$OWNER')"
  exit 1
fi
success "Token valid for user: $USER_CHECK"

# ─── Helper: Upload README ─────────────────────────────────────────────────
upload_readme() {
  local repo="$1"
  local readme_file="$2"

  info "Uploading README to $repo..."

  local encoded
  encoded=$(python3 -c "import base64; print(base64.b64encode(open('$readme_file','rb').read()).decode())")

  # Check if README.md already exists (need its SHA to update)
  local sha=""
  sha=$(curl -sf \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${OWNER}/${repo}/contents/README.md" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sha',''))" 2>/dev/null || true)

  local payload
  if [[ -n "$sha" ]]; then
    payload=$(python3 -c "import json; print(json.dumps({'message': 'docs: add professional architecture README', 'content': '$encoded', 'sha': '$sha'}))")
  else
    payload=$(python3 -c "import json; print(json.dumps({'message': 'docs: add professional architecture README', 'content': '$encoded'}))")
  fi

  local response
  response=$(curl -sf -X PUT \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Content-Type: application/json" \
    -d "$payload" \
    "https://api.github.com/repos/${OWNER}/${repo}/contents/README.md" 2>&1) || {
    error "Failed to upload README to $repo"
    echo "$response"
    return 1
  }

  success "README uploaded to $repo"
}

# ─── Helper: Set Topics ────────────────────────────────────────────────────
set_topics() {
  local repo="$1"
  shift
  local topics=("$@")

  info "Setting topics on $repo..."

  local names_json
  names_json=$(python3 -c "import json; print(json.dumps({'names': $(python3 -c "import json, sys; print(json.dumps(sys.argv[1:]))" "${topics[@]}")}))")

  curl -sf -X PUT \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.mercy-preview+json" \
    -H "Content-Type: application/json" \
    -d "$names_json" \
    "https://api.github.com/repos/${OWNER}/${repo}/topics" > /dev/null && \
    success "Topics set on $repo" || \
    warn "Failed to set topics on $repo (non-fatal)"
}

# ─── Helper: Make Repo Private ────────────────────────────────────────────
make_private() {
  local repo="$1"
  info "Making $repo private..."
  curl -sf -X PATCH \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Content-Type: application/json" \
    -d '{"private": true}' \
    "https://api.github.com/repos/${OWNER}/${repo}" > /dev/null && \
    success "$repo is now private" || \
    warn "Failed to make $repo private"
}

echo ""
echo "======================================================================"
echo "  GitHub Profile Deployment — Ghost-tech-ng"
echo "======================================================================"
echo ""

# ─── Step 1: Upload READMEs ────────────────────────────────────────────────
echo ""
info "=== STEP 1: Uploading READMEs ==="

upload_readme "crime-prediction-explainable-ai" \
  "${SCRIPT_DIR}/crime-prediction-README.md"

upload_readme "Lendsqtr-backend-project" \
  "${SCRIPT_DIR}/lendsqr-README.md"

upload_readme "Anxiety-app" \
  "${SCRIPT_DIR}/anxiety-app-README.md"

upload_readme "Optimized-Histogram-Equalisation-with-OpenCL-for-Grayscale-and-Color-Images" \
  "${SCRIPT_DIR}/opencl-README.md"

upload_readme "football-performance-predictor" \
  "${SCRIPT_DIR}/football-predictor-README.md"

upload_readme "Telegram-Trading-Bot-" \
  "${SCRIPT_DIR}/telegram-bot-README.md"

# ─── Step 2: Set Topics ────────────────────────────────────────────────────
echo ""
info "=== STEP 2: Setting repo topics ==="

set_topics "crime-prediction-explainable-ai" \
  "machine-learning" "explainable-ai" "python" "tensorflow" \
  "shap" "lime" "streamlit" "data-science" "deep-learning"

set_topics "Lendsqtr-backend-project" \
  "typescript" "nodejs" "fintech" "knexjs" "mysql" \
  "rest-api" "wallet" "backend" "lending" "unit-testing"

set_topics "Anxiety-app" \
  "react-native" "typescript" "mental-health" "expo" \
  "mobile-app" "haptics" "wellness" "accelerometer"

set_topics "Optimized-Histogram-Equalisation-with-OpenCL-for-Grayscale-and-Color-Images" \
  "opencl" "cpp" "gpu-computing" "image-processing" \
  "computer-vision" "high-performance" "parallel-computing"

set_topics "football-performance-predictor" \
  "machine-learning" "python" "football" "fpl" \
  "fantasy-premier-league" "data-science" "scikit-learn" "predictions"

set_topics "Telegram-Trading-Bot-" \
  "python" "telegram-bot" "crypto" "algorithmic-trading" \
  "automation" "trading-bot" "cryptocurrency"

set_topics "BeautyMailer" \
  "php" "phpmailer" "email" "smtp" "bulk-email" "full-stack"

# ─── Step 3: Make drain private ────────────────────────────────────────────
echo ""
info "=== STEP 3: Making 'drain' repo private ==="
make_private "drain"

# ─── Step 4: Pin repos (GraphQL) ───────────────────────────────────────────
echo ""
info "=== STEP 4: Pinning top 6 repos ==="
info "Fetching repo node IDs for GraphQL pinning..."

REPOS_TO_PIN=(
  "crime-prediction-explainable-ai"
  "Lendsqtr-backend-project"
  "Anxiety-app"
  "Optimized-Histogram-Equalisation-with-OpenCL-for-Grayscale-and-Color-Images"
  "football-performance-predictor"
  "Telegram-Trading-Bot-"
)

NODE_IDS=()
for repo in "${REPOS_TO_PIN[@]}"; do
  node_id=$(curl -sf \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${OWNER}/${repo}" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('node_id',''))" 2>/dev/null || true)

  if [[ -n "$node_id" ]]; then
    NODE_IDS+=("$node_id")
    success "Got node ID for $repo: $node_id"
  else
    warn "Could not get node ID for $repo"
  fi
done

if [[ ${#NODE_IDS[@]} -gt 0 ]]; then
  # Build the repositoryIds array for GraphQL
  IDS_JSON=$(python3 -c "import json, sys; print(json.dumps(sys.argv[1:]))" "${NODE_IDS[@]}")

  GRAPHQL_PAYLOAD=$(python3 -c "
import json
ids = json.loads('$IDS_JSON')
mutation = '''
mutation {
  updatePinnedRepositories(input: {
    clientMutationId: \"pin-repos\"
    pinnedRepositoryIds: ''' + json.dumps(ids) + '''
  }) {
    profileOwner {
      pinnedItems(first: 6) {
        nodes {
          ... on Repository {
            name
          }
        }
      }
    }
  }
}
'''
print(json.dumps({'query': mutation}))
")

  info "Running GraphQL pin mutation..."
  PIN_RESPONSE=$(curl -sf -X POST \
    -H "Authorization: bearer ${GITHUB_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "$GRAPHQL_PAYLOAD" \
    "https://api.github.com/graphql" 2>&1)

  if echo "$PIN_RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); exit(0 if 'errors' not in d else 1)" 2>/dev/null; then
    PINNED=$(echo "$PIN_RESPONSE" | python3 -c "
import sys, json
d = json.load(sys.stdin)
nodes = d.get('data',{}).get('updatePinnedRepositories',{}).get('profileOwner',{}).get('pinnedItems',{}).get('nodes',[])
for n in nodes: print(' -', n.get('name',''))
" 2>/dev/null)
    success "Repos pinned successfully!"
    echo "$PINNED"
  else
    warn "GraphQL pinning returned errors. You may need to pin manually:"
    echo ""
    echo "  Go to: https://github.com/${OWNER}"
    echo "  Click 'Customize your pins' and select these repos:"
    for repo in "${REPOS_TO_PIN[@]}"; do
      echo "    - $repo"
    done
  fi
fi

# ─── Summary ───────────────────────────────────────────────────────────────
echo ""
echo "======================================================================"
echo -e "${GREEN}  Deployment complete!${NC}"
echo "======================================================================"
echo ""
echo "  READMEs uploaded:  6 repos"
echo "  Topics set:        7 repos"
echo "  'drain' repo:      private"
echo ""
echo "  View your profile: https://github.com/${OWNER}"
echo ""
echo "  After running, you can delete the setup/ directory from your"
echo "  Ghost-tech-ng profile repo — it's no longer needed."
echo ""
