# Vercel Deployment Setup Guide

## Prerequisites
1. A GitHub repository for your Flutter app
2. A Vercel account (sign up at https://vercel.com)

## Setup Steps

### 1. Create a Vercel Project
1. Go to https://vercel.com/dashboard
2. Click "Add New Project"
3. Import your GitHub repository
4. **Do NOT let Vercel auto-detect** - we'll handle the build via GitHub Actions
5. Click "Deploy" (this creates the project)

### 2. Get Vercel Credentials

#### Get Vercel Token:
1. Go to https://vercel.com/account/tokens
2. Click "Create Token"
3. Give it a name (e.g., "GitHub Actions")
4. Copy the token (you won't see it again!)

#### Get Project ID:
1. Go to your project settings: https://vercel.com/[your-username]/[project-name]/settings
2. Scroll to "Project ID"
3. Copy the value

#### Get Organization ID:
1. Go to your team/account settings: https://vercel.com/account
2. Click on your team or personal account
3. In Settings → General, find "Your ID" or "Team ID"
4. Copy the value

### 3. Add GitHub Secrets

1. Go to your GitHub repository
2. Navigate to: Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add these three secrets:

| Secret Name | Description |
|------------|-------------|
| `VERCEL_TOKEN` | Your Vercel API token |
| `VERCEL_PROJECT_ID` | Your Vercel project ID |
| `VERCEL_ORG_ID` | Your Vercel organization/user ID |

### 4. Push to GitHub

```bash
git add .
git commit -m "Add Vercel deployment workflow"
git push origin main
```

The GitHub Action will automatically trigger and deploy your app!

## Pipeline Overview

### The Workflow Runs When:
- ✅ You push to the `main` branch → **Production deployment**
- ✅ You create a Pull Request → **Preview deployment**
- ✅ You manually trigger it from GitHub Actions tab

### What Happens in the Pipeline:

```
┌─────────────────────────────────────────────────────────────┐
│  1. Checkout Code                                            │
│     - Clones your repository to the runner                   │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  2. Set up Flutter                                           │
│     - Installs Flutter SDK (version 3.27.0)                 │
│     - Sets up Dart environment                               │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  3. Verify Flutter                                           │
│     - Runs 'flutter doctor' to check installation           │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  4. Install Dependencies                                     │
│     - Runs 'flutter pub get'                                │
│     - Downloads all packages from pubspec.yaml              │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  5. Build Web App                                            │
│     - Runs 'flutter build web --release'                    │
│     - Creates optimized production build                     │
│     - Output: build/web/ directory                          │
│     - Uses CanvasKit renderer for better performance        │
└──────────────────────────┬───────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  6. Deploy to Vercel                                         │
│     - Production: if pushed to main branch                   │
│     - Preview: if pull request                              │
│     - Uploads build/web/ to Vercel                          │
│     - Returns deployment URL                                 │
└─────────────────────────────────────────────────────────────┘
```

## Deployment Types

### Production Deployment
- Triggered by: Push to `main` branch
- URL: https://your-project.vercel.app
- Command: `vercel --prod`

### Preview Deployment
- Triggered by: Pull requests
- URL: https://your-project-[hash].vercel.app
- Useful for: Testing changes before merging

### Manual Deployment
- Go to: Actions tab → Deploy to Vercel → Run workflow
- Choose branch and click "Run workflow"

## Monitoring Deployments

### In GitHub:
- Go to "Actions" tab in your repository
- Click on the workflow run to see logs
- Each step shows detailed output

### In Vercel:
- Go to your project dashboard
- View all deployments under "Deployments" tab
- See logs, preview, and analytics

## Common Issues & Solutions

### Build Fails - Flutter Version
- Update Flutter version in `.github/workflows/deploy.yml`
- Match it with your local Flutter version: `flutter --version`

### Assets Not Loading
- Ensure `vercel.json` is committed
- Check base href in web/index.html

### CORS Errors
- Headers are configured in `vercel.json`
- Required for Flutter web apps using CanvasKit

## Customization Options

### Change Flutter Version
Edit `.github/workflows/deploy.yml`:
```yaml
flutter-version: '3.27.0'  # Change this
```

### Use HTML Renderer Instead of CanvasKit
Edit the build command:
```yaml
run: flutter build web --release --web-renderer html
```

### Deploy from Different Branch
Edit the workflow triggers:
```yaml
on:
  push:
    branches:
      - develop  # Change from 'main'
```

## Environment Variables (Optional)

If your app needs environment variables:

1. Add to GitHub Secrets
2. Use in workflow:
```yaml
- name: Build web app
  env:
    API_URL: ${{ secrets.API_URL }}
  run: flutter build web --release --dart-define=API_URL=$API_URL
```

## Next Steps

1. ✅ Complete the setup steps above
2. ✅ Push your code to trigger the first deployment
3. ✅ Check the Actions tab for progress
4. ✅ Visit your Vercel URL once deployed!

## Useful Commands

```bash
# Test build locally
flutter build web --release

# Run local web server
flutter run -d web-server

# Check Flutter setup
flutter doctor -v
```
