#!/bin/bash

# This script prepares the application for Netlify deployment
echo "Starting Netlify build process..."

# Install dependencies
echo "Installing dependencies..."
npm install

# Build client-side only
echo "Building project..."
npx vite build

# Apply post-build optimizations
echo "Applying post-build optimizations..."
# netlify-build.sh
echo "Running security headers injection..."
find dist/public -name '*.html' -exec \
  sed -i '' 's/<head>/<head>\n<meta http-equiv="Content-Security-Policy" content="default-src '\''self'\''; script-src '\''self'\'' '\''unsafe-inline'\''; style-src '\''self'\'' '\''unsafe-inline'\'';">/g' {} +
# Create _redirects file for SPA routing
echo "Creating SPA redirects..."
echo "/* /index.html 200" > dist/public/_redirects

# Create robots.txt file
echo "Generating robots.txt..."
echo -e "User-agent: *\nAllow: /" > dist/public/robots.txt

# Create a simple sitemap
echo "Generating sitemap.xml..."
echo '<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://homagama-maha-vidyalaya.netlify.app/</loc>
    <lastmod>'$(date +%Y-%m-%d)'</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>' > dist/public/sitemap.xml
# netlify-build.sh
echo "Running security headers injection..."
find dist/public -name '*.html' -exec \
  sed -i '' 's/<head>/<head>\n<meta http-equiv="Content-Security-Policy" content="default-src '\''self'\''; script-src '\''self'\'' '\''unsafe-inline'\''; style-src '\''self'\'' '\''unsafe-inline'\'';">/g' {} +

echo "Build completed successfully!"