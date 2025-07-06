#!/usr/bin/env bash
: <<DOCUMENTATION
Runs app locally. 

Must run from repo root.
DOCUMENTATION

# IMPORTS ----------------------------------------------------------------------
source ./scripts/utils.sh

# UTILS ------------------------------------------------------------------------

cleanup_function() {
    log "INFO" "Stopping supabase..."
    npx supabase stop
    log "INFO" "...SUCCESS"
}

# MAIN ------------------------------------------------------------------------

trap cleanup_function EXIT
cd src
npx supabase start
npm ci
npm run dev
