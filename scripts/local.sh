#!usr/bin/env bash
: <<DOCUMENTATION
Runs app locally
DOCUMENTATION

cd src
npm run ci
npm run dev
